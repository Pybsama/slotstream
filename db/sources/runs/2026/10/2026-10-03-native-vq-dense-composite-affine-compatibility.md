---
type: run
created: 2026-10-03T12:49:57.106245+00:00
updated: 2026-10-03T12:49:57.106245+00:00
summary: Dense composite shared dispatch preserves existing affine acceptance
binary: 2ce253c1583b96921bf410ef4bfa8d0f6a0526567e46cf37041e35a534809076
captured_at: 2026-10-03
command: Exact sequential commands are preserved in the driver and supervision identities below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Dense composite shared dispatch preserves existing affine acceptance
tool: bounded VQ research diagnostics
---

The complete static suite passed against frozen-dense-overlay-v2. The full existing affine battery completed every gate, including memory-target equality, live governor shrink/cooldown/regrow, saved-ceiling lifecycle, conversation and persistent-prefix reuse, MTP state checks, behavioral quality, serving robustness and complete vision serving. It reported 31 passed and four failed because this temporary campaign driver resolved .venv/bin/python through its symlink to the base interpreter: both current-backend Python reference producers failed to import MLX, and their two dependent parity checks consequently had no fixture. The original failures remain below.

The targeted corrective campaign preserves the virtual environment path and reruns exactly the two independent MLX 0.32.2 reference producers and their two native comparisons. All four pass on the unchanged frozen executable. Together these runs close the existing affine compatibility gate. Historical MLX 0.31 reference differences remain diagnostic and were not regenerated or used to relax current reference checks. No code, golden or tolerance was changed to obtain these passes. The full battery's declared governor and image resource exceptions remain local to those existing tests; research candidates retain their ten-GB ceiling.

This evidence qualifies compatibility of the shared dense dispatch, not general VQ serving, held-out composite quality, larger contexts, MTP/vision for the composite, dynamic memory management, new Mac hardware or the 20-token target. No installed pack or Auto preference changed.

Local home prefixes are replaced with <HOME>. Original byte lengths and hashes identify the unmodified local files. For large transcripts, the normalized UTF-8 bytes are stored losslessly as zlib-compressed base64 inside this Markdown source. Decode with `zlib.decompress(base64.b64decode(block))` and verify the listed normalized byte length and SHA-256. Every encoded block was round-trip checked before writing. This changes storage only, not the captured evidence. Small transcripts remain plain text. Raw tensor fixtures and source-bound executables remain in the bounded research directory; manifests bind their hashes. No model is installed or activated.

### capture-vq-dense-acceptance-v1.py

Original bytes: 3386. SHA-256: `8971ccf504c1dbb088bc8cdbfef0a3c7024bbd92c43220371b55a1d723c2a1ba`.

Normalized bytes: 3386. SHA-256: `8971ccf504c1dbb088bc8cdbfef0a3c7024bbd92c43220371b55a1d723c2a1ba`.

````text
from pathlib import Path
import json,runpy,shutil,hashlib
r=Path('.build/quantization-research');h=runpy.run_path(str(r/'capture-vq-kernel-cache-v1.py'));capture=h['capture']
a='vq-dense-overlay-acceptance-v1';b='vq-dense-overlay-reference-repair-v1'
x=json.loads((r/a/'run.json').read_text());y=json.loads((r/b/'run.json').read_text());assert x['runs'][0]['returncode']==0 and x['runs'][1]['returncode']==1 and y['complete'] and len(y['runs'])==4
text=(r/a/'affine/stdout.txt').read_text();assert 'passed 31, failed 4' in text
files=['capture-vq-dense-acceptance-v1.py','run-vq-dense-overlay-acceptance-v1.py','run-vq-dense-overlay-reference-repair-v1.py',a+'.log',b+'.log']
manifest=[]
for name in (a,b):
 for p in sorted((r/name).rglob('*')):
  if not p.is_file():continue
  raw=p.read_bytes();relative=str(p.relative_to(r));istext=p.suffix in ('.txt','.log','.json','.ndjson','.jsonl')
  manifest.append({'path':relative,'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest(),'text_captured':istext})
  if istext:files.append(relative)
copy=r/'vq-dense-overlay-acceptance-tmp-v1';copy.mkdir(exist_ok=False)
for p in sorted(Path('/tmp').glob('ssv*')):
 if p.is_file() and p.suffix in ('.txt','.json','.err','.log'):
  dest=copy/p.name;shutil.copy2(p,dest);files.append(str(dest.relative_to(r)))
for name in ('verify.sh','static_gates.sh','current_backend_reference.py'):
 dest=copy/name;shutil.copy2(Path('Tools')/name,dest);files.append(str(dest.relative_to(r)))
(r/'vq-dense-overlay-acceptance-manifest-v1.json').write_text(json.dumps(manifest,indent=2)+'\n');files.append('vq-dense-overlay-acceptance-manifest-v1.json')
capture('native-vq-dense-composite-affine-compatibility','Dense composite shared dispatch preserves existing affine acceptance',
'''The complete static suite passed against frozen-dense-overlay-v2. The full existing affine battery completed every gate, including memory-target equality, live governor shrink/cooldown/regrow, saved-ceiling lifecycle, conversation and persistent-prefix reuse, MTP state checks, behavioral quality, serving robustness and complete vision serving. It reported 31 passed and four failed because this temporary campaign driver resolved .venv/bin/python through its symlink to the base interpreter: both current-backend Python reference producers failed to import MLX, and their two dependent parity checks consequently had no fixture. The original failures remain below.

The targeted corrective campaign preserves the virtual environment path and reruns exactly the two independent MLX 0.32.2 reference producers and their two native comparisons. All four pass on the unchanged frozen executable. Together these runs close the existing affine compatibility gate. Historical MLX 0.31 reference differences remain diagnostic and were not regenerated or used to relax current reference checks. No code, golden or tolerance was changed to obtain these passes. The full battery's declared governor and image resource exceptions remain local to those existing tests; research candidates retain their ten-GB ceiling.

This evidence qualifies compatibility of the shared dense dispatch, not general VQ serving, held-out composite quality, larger contexts, MTP/vision for the composite, dynamic memory management, new Mac hardware or the 20-token target. No installed pack or Auto preference changed.''',files,'frozen-dense-overlay-v2')
````

### run-vq-dense-overlay-acceptance-v1.py

Original bytes: 2193. SHA-256: `635f175f71c096d7d50739f2743f0118b79c41d3f379670f380c68fc6af70131`.

Normalized bytes: 2193. SHA-256: `635f175f71c096d7d50739f2743f0118b79c41d3f379670f380c68fc6af70131`.

````text
from pathlib import Path
from datetime import datetime,timezone
import json,sys,os,time
sys.path.insert(0,'Tools')
from context_qualification import quiet_preflight
from prefill_bench import run_child
from quantization_logit_run import digest
r=Path('.build/quantization-research').resolve();out=r/'vq-dense-overlay-acceptance-v1';out.mkdir()
f=r/'frozen-dense-overlay-v2';identity=json.loads((f/'build-identity.json').read_text())
assert json.loads((r/'vq-dense-overlay-stage2-v1/run.json').read_text())['complete']
record={'schema':1,'complete':False,'started_at':datetime.now(timezone.utc).isoformat(),'producer_sha256':identity['binary_sha256'],'scope':'Full existing affine compatibility plus static gates after shared dense dispatch change','maximum_seconds':14400,'resource_policy':'Use the unchanged verify.sh small targets and its declared governor/image exceptions; no external ten-GB cap on a multi-test driver','paid_compute':False,'runs':[]}
bound={str(p.resolve()):digest(p) for p in [Path(__file__),Path('Tools/static_gates.sh'),Path('Tools/verify.sh'),Path('Tools/prefill_bench.py'),Path('Tools/context_qualification.py')]};record['bound_files']=bound
started=time.monotonic();env=os.environ.copy();env['SLOTSTREAM_TEST_BINARY']=str(f/'slotstream');env['SLOTSTREAM_REFERENCE_PYTHON']=str(Path('.venv/bin/python').resolve());env['SLOTSTREAM_VERIFY_OUT']=str(out/'verify-results')
def save():(out/'run.json').write_text(json.dumps(record,indent=2)+'\n')
save()
try:
 for name,cmd in [('static',['bash','Tools/static_gates.sh']),('affine',['bash','Tools/verify.sh'])]:
  assert all(digest(Path(k))==v for k,v in bound.items());assert digest(f/'slotstream')==identity['binary_sha256']
  before=quiet_preflight(13);cell=out/name;cell.mkdir();timeout=int(14400-(time.monotonic()-started));assert timeout>0
  code=run_child(cmd,env,cell,timeout);record['runs'].append({'name':name,'command':cmd,'returncode':code,'before':before});save();print(json.dumps(record['runs'][-1]),flush=True)
  assert code==0,(name,code)
 record['complete']=True;record['finished_at']=datetime.now(timezone.utc).isoformat();save()
except BaseException as error:
 record['failure']=repr(error);save();raise
````

### run-vq-dense-overlay-reference-repair-v1.py

Original bytes: 2607. SHA-256: `3d073d77c4fa8046a9b597032ce8840891f44a9827938f0bfda64ba370598751`.

Normalized bytes: 2607. SHA-256: `3d073d77c4fa8046a9b597032ce8840891f44a9827938f0bfda64ba370598751`.

````text
from pathlib import Path
from datetime import datetime,timezone
import json,sys,time
sys.path.insert(0,'Tools')
from quantization_logit_run import supervise,digest
r=Path('.build/quantization-research').resolve();out=r/'vq-dense-overlay-reference-repair-v1';out.mkdir()
f=r/'frozen-dense-overlay-v2';identity=json.loads((f/'build-identity.json').read_text())
old=json.loads((r/'vq-dense-overlay-acceptance-v1/run.json').read_text());assert old['runs'][-1]['name']=='affine' and old['runs'][-1]['returncode']==1
failure_text=(r/'vq-dense-overlay-acceptance-v1/affine/stdout.txt').read_text();failures=[s for s in failure_text.splitlines() if s.startswith('FAIL  ')]
assert len(failures)==4,failures
for check in (4,13):assert "ModuleNotFoundError: No module named 'mlx'" in (r/f'vq-dense-overlay-acceptance-v1/verify-results/check-{check}.txt').read_text()
record={'schema':1,'complete':False,'started_at':datetime.now(timezone.utc).isoformat(),'producer_sha256':identity['binary_sha256'],'scope':'Repair only four current-backend checks whose temporary driver resolved the venv interpreter symlink; retain original failed campaign','maximum_seconds':3600,'original_failures':failures,'runs':[]}
inputs=[Path(__file__),Path('Tools/current_backend_reference.py'),Path('Tools/quantization_logit_run.py')];record['bound_files']={str(p.resolve()):digest(p) for p in inputs}
started=time.monotonic()
def save():(out/'run.json').write_text(json.dumps(record,indent=2)+'\n')
save()
try:
 for kind in ('layers','mtp'):
  cmds=[(kind+'-reference',[str(Path.cwd()/'.venv/bin/python'),'Tools/current_backend_reference.py','--kind',kind,'--out',str(out/(kind+'-reference'))])]
  if kind=='layers':cmds.append(('layers-native',[str(f/'slotstream'),'parity','--tokens','9707,11,1246,525,498,30','--layers','2','--compare',str(out/'layers-reference')]))
  else:cmds.append(('mtp-native',[str(f/'slotstream'),'mtp-parity','--fixture',str(out/'mtp-reference/comparison.safetensors')]))
  for name,cmd in cmds:
   assert digest(f/'slotstream')==identity['binary_sha256']
   assert all(digest(Path(p))==h for p,h in record['bound_files'].items())
   remaining=int(3600-(time.monotonic()-started));assert remaining>0
   result=supervise(cmd,out/(name+'-supervision'),min(900,remaining));record['runs'].append({'name':name,'command':cmd,**result});save();print(json.dumps({'name':name,'peak':result['sampled_peak_bytes'],'failure':result['failure']}),flush=True)
 record['complete']=True;record['finished_at']=datetime.now(timezone.utc).isoformat();save()
except BaseException as error:record['failure']=repr(error);save();raise
````

### vq-dense-overlay-acceptance-v1.log

Original bytes: 4381. SHA-256: `e6de33099642a5818a70dc1130fdb72e8053065c5bfe5949312ab9d8999e21c7`.

Normalized bytes: 4374. SHA-256: `1ec52d76ea6020cc5f4deeb703d80b531abb5775a6086330283824e6f5000ff5`.

````text
{"name": "static", "command": ["bash", "Tools/static_gates.sh"], "returncode": 0, "before": {"page_bytes": 16384, "reclaimable_bytes": 24641994752, "swapins": 20, "swapouts": 2908, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   312786.\nPages active:                                 864172.\nPages inactive:                               997598.\nPages speculative:                             61897.\nPages throttled:                                   0.\nPages wired down:                             178656.\nPages purgeable:                                4714.\n\"Translation faults\":                     1818934570.\nPages copy-on-write:                        89564506.\nPages zero filled:                        2764335955.\nPages reactivated:                         101204526.\nPages purged:                               11872428.\nFile-backed pages:                           1186528.\nAnonymous pages:                              737139.\nPages stored in compressor:                  1258060.\nPages occupied by compressor:                 669764.\nDecompressions:                             81311707.\nCompressions:                               93104093.\nPageins:                                  1787139753.\nPageouts:                                     426009.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127942.\nPages tagged resident:                         83700.\nPages tagged compressed:                       44242.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5190.\nPages tag-storage free:                          684.\nPages tag-storage non-tag pageable:            92422.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6710144.\nTagged compressions:                          568940.\nTagged decompressions:                        464989.\n"}}
{"name": "affine", "command": ["bash", "Tools/verify.sh"], "returncode": 1, "before": {"page_bytes": 16384, "reclaimable_bytes": 24300732416, "swapins": 20, "swapouts": 2908, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   449852.\nPages active:                                 882995.\nPages inactive:                               912469.\nPages speculative:                              3657.\nPages throttled:                                   0.\nPages wired down:                             178405.\nPages purgeable:                                2401.\n\"Translation faults\":                     1831588310.\nPages copy-on-write:                        90926039.\nPages zero filled:                        2769046318.\nPages reactivated:                         101207237.\nPages purged:                               11875927.\nFile-backed pages:                           1030946.\nAnonymous pages:                              768175.\nPages stored in compressor:                  1233752.\nPages occupied by compressor:                 657514.\nDecompressions:                             81334443.\nCompressions:                               93104093.\nPageins:                                  1787623446.\nPageouts:                                     426064.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 128721.\nPages tagged resident:                         84984.\nPages tagged compressed:                       43737.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5190.\nPages tag-storage free:                          775.\nPages tag-storage non-tag pageable:            92331.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6637312.\nTagged compressions:                          568940.\nTagged decompressions:                        465444.\n"}}
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-dense-overlay-acceptance-v1.py", line 21, in <module>
    assert code==0,(name,code)
           ^^^^^^^
AssertionError: ('affine', 1)
````

### vq-dense-overlay-reference-repair-v1.log

Original bytes: 252. SHA-256: `8515d3f4ca09f06f6d08e64031aab7842cce81a415a41bfce5fbb9889aaec3c4`.

Normalized bytes: 252. SHA-256: `8515d3f4ca09f06f6d08e64031aab7842cce81a415a41bfce5fbb9889aaec3c4`.

````text
{"name": "layers-reference", "peak": 3500936288, "failure": null}
{"name": "layers-native", "peak": 8386628608, "failure": null}
{"name": "mtp-reference", "peak": 1643005752, "failure": null}
{"name": "mtp-native", "peak": 1591199592, "failure": null}
````

### vq-dense-overlay-acceptance-v1/affine/stderr.txt

Original bytes: 32. SHA-256: `5f05e68a94141d9d526d58e8048518f9e3f4d313b9f478253e3c9219bc4ad091`.

Normalized bytes: 32. SHA-256: `5f05e68a94141d9d526d58e8048518f9e3f4d313b9f478253e3c9219bc4ad091`.

````text
16 content deltas for 16 tokens
````

### vq-dense-overlay-acceptance-v1/affine/stdout.txt

Original bytes: 21347. SHA-256: `7addccd78c1ed6b3162b05ea0c4094aa5948e99465431e04947593ea789e829c`.

Normalized bytes: 21312. SHA-256: `de05bdc75301c32746ba9f816f0145eb2d06bf8d4d5252ae598a1cb1ca8cf38f`.

````text
== frozen build: <HOME>/Projects/slotstream/.build/quantization-research/frozen-dense-overlay-v2/slotstream ==
== weights provenance (hashes all 105.3 GB vs the pinned revisions; the draft head is optional) ==
PASS  pull --verify: every pinned file matches
== goldens (need bench/parity31 from Tools/parity_ref.py under mlx==0.31.1) ==
PASS  ngram row ids == python reference
PASS  chat template == transformers
PASS  layer parity (historical reference, one-row projections)
FAIL  independent current-backend layer reference (details: <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/check-4.txt)
FAIL  production layer parity against current backend (details: <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/check-5.txt)
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
PASS  a big cache keeps the head's experts resident
PASS  MTP auto stays off on a 16GB machine
PASS  MTP auto on at --memory-gb 30 (137/layer after the charge)
PASS  MTP auto on at --memory-gb 22 (resident: 76/layer after the charge)
PASS  decode lookahead rides the head at --memory-gb 22
PASS  32 GB Mac: auto runs the head and the lookahead
PASS  24 GB Mac: auto streams the head's experts and runs the lookahead
PASS  32 GB Mac at 65,536 tokens keeps the head by streaming its experts
PASS  36 GB Mac at 65,536 tokens keeps the head and the lookahead
PASS  --memory-gb 16: below 76/layer the head streams its experts, with the lookahead
PASS  streamed head charge visible in json
PASS  --memory-gb 12: the streamed head reaches its 28/layer floor
PASS  --memory-gb 11: below the head's floor, plain decode with the lookahead
PASS  SLOTSTREAM_MTP_EXPERTS=resident keeps the resident head's floor
PASS  SLOTSTREAM_MTP_EXPERTS gibberish refused
PASS  SLOTSTREAM_OPT_EXPERT_PREFETCH=0 keeps the head without the lookahead
PASS  decode lookahead charge visible in json
PASS  --mtp on forces the head onto a small machine
PASS  a head forced below the floor runs without the lookahead
PASS  --mtp off suppresses it everywhere
PASS  --mtp off runs the lookahead in plain decode
PASS  --mtp on without mtp.safetensors is a clean error
PASS  --mtp on cannot squeeze under the minimum target plus the streamed head
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
PASS  32 GB Mac: automatic window is 32,768 (65,536 would stream the head)
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
planner: passed 97, failed 0
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
PASS  elastic governor policy (38 branches)
sampler + governor: passed 17, failed 0
PASS  sampler + governor gates
== golden equivalence: streaming must not change the math ==
PASS  8.1 GB cache output == 10 GB cache output
== elastic pool: live resizes must not change the math ==
PASS  grow/shrink/regrow byte-identical (elastic-check)
== elastic governor: shrinks, honors the cooldown, grows back ==
PASS  ELASTIC DRILL PASS: governor shrank under simulated pressure, honored the grow cooldown, grew back when memory returned, and every generation was byte-identical
== small adaptive cache: pressure recovery below the normal growth band ==
PASS  small adaptive cache recovery
== adaptive server: saved ceiling survives startup and the live timer ==
{
  "passed": true,
  "binary_sha256": "2ce253c1583b96921bf410ef4bfa8d0f6a0526567e46cf37041e35a534809076",
  "limit_gb": 10,
  "no_elastic": false,
  "preflight_available_gb": 24.007032832,
  "command": [
    "slotstream",
    "serve",
    "--memory-limit-gb",
    "10",
    "--max-context",
    "32768",
    "--max-prefill-wait",
    "17",
    "--mtp",
    "off",
    "--vision",
    "off",
    "--port",
    "51020"
  ],
  "completion": {
    "finish_reason": "stop",
    "message": {
      "role": "assistant",
      "content": "The Nile."
    },
    "index": 0
  },
  "server_reaped": true
}
PASS  adaptive server lifecycle
== conversation prefix cache: live determinism and exact scheduled reuse ==
PASS  prefix reuse, invalidation and live reply equality (prefix-check)
PASS  a continued conversation equals a cold one (prefix-exact-check)
== prefill sweep: matches the pool path, deterministic, blind to the pool ==
PASS  sweep within the prefill-rechunk control, identical cold and warm (sweep-check)
== decode overlap: direct demand reads and the GPU keepalive leave output exact ==
PASS  direct reads and keepalive equal the staged path on a cold cache (decode-overlap-check)
PASS  streamed draft experts and the plain-decode lookahead leave output exact (draft-stream-check)
== MTP draft head: parity with the Python reference + speculative gates ==
FAIL  independent current-backend draft-head reference (details: <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/check-13.txt)
FAIL  mtp head parity vs current Python reference (mtp-parity) (details: <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/check-14.txt)
DIAGNOSTIC  historical MLX 0.31 draft-head reference differs (retained in mtp-legacy-reference.txt)
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
{"name": "plain-cap", "finish": "length", "usage": {"prompt_tokens_details": {"cached_tokens": 0}, "total_tokens": 164, "prompt_tokens": 36, "completion_tokens": 128}, "data_events": 130}
{"name": "tools-unused-cap", "finish": "length", "usage": {"completion_tokens": 128, "total_tokens": 403, "prompt_tokens_details": {"cached_tokens": 0}, "prompt_tokens": 275}, "data_events": 130}
{"name": "large-allowance-unused-tools", "finish": "stop", "usage": {"prompt_tokens_details": {"cached_tokens": 0}, "total_tokens": 270, "prompt_tokens": 269, "completion_tokens": 1}, "data_events": 3}
{"name": "long-truncated-argument", "finish": "length", "usage": {"completion_tokens": 256, "total_tokens": 545, "prompt_tokens_details": {"cached_tokens": 0}, "prompt_tokens": 289}, "data_events": 242}
{"name": "nullable-truncated-argument", "finish": "length", "usage": {"prompt_tokens_details": {"cached_tokens": 0}, "total_tokens": 548, "prompt_tokens": 292, "completion_tokens": 256}, "data_events": 242}
{"name": "branch-alpha-seed", "finish": "stop", "usage": {"completion_tokens": 49, "total_tokens": 1575, "prompt_tokens_details": {"cached_tokens": 0}, "prompt_tokens": 1526}, "data_events": 49}
{"name": "branch-beta-seed", "finish": "stop", "usage": {"prompt_tokens_details": {"cached_tokens": 768}, "total_tokens": 2030, "prompt_tokens": 1976, "completion_tokens": 54}, "data_events": 54}
{"name": "branch-alpha-followup", "finish": "stop", "usage": {"completion_tokens": 24, "total_tokens": 1621, "prompt_tokens_details": {"cached_tokens": 1280}, "prompt_tokens": 1597}, "data_events": 24}
{"name": "cache-turn-1", "finish": "stop", "usage": {"prompt_tokens_details": {"cached_tokens": 0}, "total_tokens": 1058, "prompt_tokens": 1029, "completion_tokens": 29}, "data_events": 29}
{"name": "cache-turn-2", "finish": "stop", "usage": {"completion_tokens": 29, "total_tokens": 1632, "prompt_tokens_details": {"cached_tokens": 1024}, "prompt_tokens": 1603}, "data_events": 29}
{"name": "cache-turn-3", "finish": "stop", "usage": {"prompt_tokens_details": {"cached_tokens": 1536}, "total_tokens": 1683, "prompt_tokens": 1654, "completion_tokens": 29}, "data_events": 29}
PASS stream reset leaves the server able to complete another request
PASS issue 21 streaming, length termination, three-turn reasoning reuse and server survival
PASS runtime context discovery agrees
PASS nonstream returns executable OpenAI function
PASS nonstream preserves function and typed arguments
PASS nonstream includes call identity and usage
PASS nonstream completes tool-result round trip
PASS stream returns executable OpenAI function
PASS stream preserves function and typed arguments
PASS stream includes call identity and usage
PASS stream completes tool-result round trip
PASS parallel false returns one complete call
PASS parallel stream has distinct complete calls
PASS parallel results match by call ID
PASS tool choice none remains text-only
PASS multiple initial instructions survive rendering
PASS reasoning separated from answer
PASS orphan-result rejected before inference
PASS missing-result rejected before inference
PASS context-inflation rejected before inference
PASS reasoning-conflict rejected before inference
PASS unknown-function rejected before inference
PASS unsupported structured output has actionable rejection
PASS budget exhaustion reports length False
PASS budget exhaustion reports length True
PASS request context limit is enforced before inference
{"passed": 24, "context": 32768, "model": "qwen3.8-flash-next:4bit"}
server reaped 94523 0
PASS exact conversation replay after restart {'prompt_tokens': 1654, 'completion_tokens': 29, 'total_tokens': 1683, 'prompt_tokens_details': {'cached_tokens': 1536}}
server reaped 95781 0
PASS  issue 21 streaming, branched reuse and exact restart
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
PASS  /api/version (0.2.27) matches the binary
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
  swift        vs mlx  f32:  cosine 0.99846047  worst token 0.905454
  swift        vs mlx  bf16:  cosine 0.99866360  worst token 0.921946
  mlx bf16     vs numpy f32:  cosine 0.99840382  worst token 0.839186
  mlx f32      vs numpy f32:  cosine 0.99996241  worst token 0.997329
  float32 implementations agree      True
  slotstream inside the dtype band   True
  slotstream matches bf16 reference  True
VISION PARITY PASS
PASS  vision tower matches the float32 reference within the bf16 band
PASS  ollama /api/chat answers an image request
PASS  and it recognises the dog
      -> 'Dog nose close-up.' in 7.7s, 725 prompt tokens
PASS  the picture is worth its 702 placeholder tokens, plus the two sentinels
PASS  /v1/chat/completions answers an image_url part
PASS  and it sees the fruit on the tree
      -> 'Green citrus fruit'
PASS  /api/generate answers an image request
PASS  and it recognises the dog there too
PASS  the fx gateway accepts an image file part
PASS  and answers about the dog
PASS  and still refuses a file part that is not an image
PASS  two pictures in one turn are accepted
PASS  and they arrive in the order they were sent
      -> 'dog, pomelo'
PASS  a follow-up turn on the same picture succeeds
PASS  and reuses the state instead of re-running the tower
      -> first 12.6s, follow-up 3.1s
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

25 passed, 0 failed
VISION SERVING PASS
PASS  vision serving suite

passed 31, failed 4
````

### vq-dense-overlay-acceptance-v1/run.json

Original bytes: 5628. SHA-256: `25253e206b8478a22997ddafc00eba7dfe166ad1aabbccdda20d513be01982c4`.

Normalized bytes: 5593. SHA-256: `7e9f9b724a26e57e05bffe301b34c76867932cf07f7bd12fd0e5bc96a29a2295`.

````text
{
  "schema": 1,
  "complete": false,
  "started_at": "2026-10-03T12:06:55.654117+00:00",
  "producer_sha256": "2ce253c1583b96921bf410ef4bfa8d0f6a0526567e46cf37041e35a534809076",
  "scope": "Full existing affine compatibility plus static gates after shared dense dispatch change",
  "maximum_seconds": 14400,
  "resource_policy": "Use the unchanged verify.sh small targets and its declared governor/image exceptions; no external ten-GB cap on a multi-test driver",
  "paid_compute": false,
  "runs": [
    {
      "name": "static",
      "command": [
        "bash",
        "Tools/static_gates.sh"
      ],
      "returncode": 0,
      "before": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24641994752,
        "swapins": 20,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   312786.\nPages active:                                 864172.\nPages inactive:                               997598.\nPages speculative:                             61897.\nPages throttled:                                   0.\nPages wired down:                             178656.\nPages purgeable:                                4714.\n\"Translation faults\":                     1818934570.\nPages copy-on-write:                        89564506.\nPages zero filled:                        2764335955.\nPages reactivated:                         101204526.\nPages purged:                               11872428.\nFile-backed pages:                           1186528.\nAnonymous pages:                              737139.\nPages stored in compressor:                  1258060.\nPages occupied by compressor:                 669764.\nDecompressions:                             81311707.\nCompressions:                               93104093.\nPageins:                                  1787139753.\nPageouts:                                     426009.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127942.\nPages tagged resident:                         83700.\nPages tagged compressed:                       44242.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5190.\nPages tag-storage free:                          684.\nPages tag-storage non-tag pageable:            92422.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6710144.\nTagged compressions:                          568940.\nTagged decompressions:                        464989.\n"
      }
    },
    {
      "name": "affine",
      "command": [
        "bash",
        "Tools/verify.sh"
      ],
      "returncode": 1,
      "before": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24300732416,
        "swapins": 20,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   449852.\nPages active:                                 882995.\nPages inactive:                               912469.\nPages speculative:                              3657.\nPages throttled:                                   0.\nPages wired down:                             178405.\nPages purgeable:                                2401.\n\"Translation faults\":                     1831588310.\nPages copy-on-write:                        90926039.\nPages zero filled:                        2769046318.\nPages reactivated:                         101207237.\nPages purged:                               11875927.\nFile-backed pages:                           1030946.\nAnonymous pages:                              768175.\nPages stored in compressor:                  1233752.\nPages occupied by compressor:                 657514.\nDecompressions:                             81334443.\nCompressions:                               93104093.\nPageins:                                  1787623446.\nPageouts:                                     426064.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 128721.\nPages tagged resident:                         84984.\nPages tagged compressed:                       43737.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5190.\nPages tag-storage free:                          775.\nPages tag-storage non-tag pageable:            92331.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6637312.\nTagged compressions:                          568940.\nTagged decompressions:                        465444.\n"
      }
    }
  ],
  "bound_files": {
    "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-dense-overlay-acceptance-v1.py": "635f175f71c096d7d50739f2743f0118b79c41d3f379670f380c68fc6af70131",
    "<HOME>/Projects/slotstream/Tools/static_gates.sh": "d8c95b03010acfbe2a9a9e523155ae07ffeb962c6adfea9703091cb34f2de2c6",
    "<HOME>/Projects/slotstream/Tools/verify.sh": "cca70929c85234342d3cac25489be6a30db6886f39f0bb0375ebeb4d423dabd8",
    "<HOME>/Projects/slotstream/Tools/prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472",
    "<HOME>/Projects/slotstream/Tools/context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34"
  },
  "failure": "AssertionError(('affine', 1))"
}
````

### vq-dense-overlay-acceptance-v1/static/stderr.txt

Original bytes: 5367. SHA-256: `5dd0d0aeb7906030d8d985a5367a75e36957b62a3da1870048ab7eee7c3af52e`.

Normalized bytes: 5367. SHA-256: `5dd0d0aeb7906030d8d985a5367a75e36957b62a3da1870048ab7eee7c3af52e`.

````text
..............................
----------------------------------------------------------------------
Ran 30 tests in 20.698s

OK
..........
----------------------------------------------------------------------
Ran 10 tests in 6.752s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.985s

OK
........................
----------------------------------------------------------------------
Ran 24 tests in 8.216s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.640s

OK
........
----------------------------------------------------------------------
Ran 8 tests in 7.678s

OK
.......
----------------------------------------------------------------------
Ran 7 tests in 4.268s

OK
.........
----------------------------------------------------------------------
Ran 9 tests in 7.174s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.832s

OK
............................
----------------------------------------------------------------------
Ran 28 tests in 34.271s

OK
.........
----------------------------------------------------------------------
Ran 9 tests in 0.026s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 3.121s

OK
test_fast_response_remains_complete (__main__.RequestDeadlines) ... ok
test_idle_peer_returns_no_answer (__main__.RequestDeadlines) ... ok
test_incomplete_body_is_not_reported_as_success (__main__.RequestDeadlines) ... ok
test_redirect_remains_supported (__main__.RequestDeadlines) ... ok
test_slow_progress_cannot_extend_the_total_deadline (__main__.RequestDeadlines) ... ok
test_successful_empty_response_is_preserved (__main__.RequestDeadlines) ... ok

----------------------------------------------------------------------
Ran 6 tests in 2.619s

OK
test_gaps_overlaps_and_wrong_spans_stay_rejected (__main__.EmptyTensors) ... ok
test_valid_empty_layouts_are_independent_of_dictionary_order (__main__.EmptyTensors) ... ok

----------------------------------------------------------------------
Ran 2 tests in 0.541s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.472s

OK
......
----------------------------------------------------------------------
Ran 6 tests in 0.004s

OK
..............
----------------------------------------------------------------------
Ran 14 tests in 1.324s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.000s

OK
........
----------------------------------------------------------------------
Ran 8 tests in 0.001s

OK
...................................................
----------------------------------------------------------------------
Ran 51 tests in 0.015s

OK
......
----------------------------------------------------------------------
Ran 6 tests in 0.018s

OK
......
----------------------------------------------------------------------
Ran 6 tests in 0.004s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.000s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.002s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.009s

OK
..............................
----------------------------------------------------------------------
Ran 30 tests in 2.081s

OK
...........
----------------------------------------------------------------------
Ran 11 tests in 0.080s

OK
.............
----------------------------------------------------------------------
Ran 13 tests in 0.981s

OK
...........
----------------------------------------------------------------------
Ran 11 tests in 0.076s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.001s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.000s

OK
..
----------------------------------------------------------------------
Ran 2 tests in 0.132s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.003s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.001s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.003s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.004s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.002s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.006s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.001s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.001s

OK
..
----------------------------------------------------------------------
Ran 2 tests in 0.005s

OK
.......
----------------------------------------------------------------------
Ran 7 tests in 0.007s

OK
######################################################################## 100.0%
######################################################################## 100.0%
######################################################################## 100.0%
````

### vq-dense-overlay-acceptance-v1/static/stdout.txt

Original bytes: 28250. SHA-256: `6366897c338b4e42d402c8a560972e9760515bbf4dd44033987bb7f94a0b1131`.

Normalized bytes: 28250. SHA-256: `6366897c338b4e42d402c8a560972e9760515bbf4dd44033987bb7f94a0b1131`.

````text
coverage comparison and report failure checks pass
{"phase": "starting", "prompt_tokens": 16, "reclaimable_gb": 20.0}
{"prompt_tokens": 16, "passed": false, "error": "ValueError: capacity rung was incomplete, aborted or over its plan"}
{"phase": "waiting for build reservation", "seconds": 0.0}
{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
{"starting": "paired/unique-prose"}
{"starting": "native/combined-plain"}
{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
{"starting": "paired/unique-prose"}
{"starting": "paired/sampled-short"}
{"starting": "paired/mtp-resource"}
{"starting": "paired/distinct-tail"}
{"starting": "paired/complete-repeat"}
{"starting": "paired/unique-with-retention"}
{"starting": "paired/actual-default-one-token"}
{"starting": "soak/off"}
{"starting": "soak/on"}
{"starting": "native/combined-plain"}
{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "native/combined-plain"}
{"starting": "native/combined-plain"}
{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
{"verified_overlay": "tensor.safetensors"}
llms-full.txt is current
0 issue(s): 0 error(s), 0 warning(s), 0 info
MEASUREMENTS.md is current
PLAN.md is current
claims gate: 349 needle checks, 0 failures
BRAIN GATES PASS
dequant_row.txt: OK
layer_0.bin: OK
layer_1.bin: OK
layer_2.bin: OK
layer_3.bin: OK
ngram_ids.txt: OK
tokens.txt: OK
PASS  request VM counters are monotonic
PASS  request VM reclaimable bytes are available
PASS  process physical footprint is readable
PASS  process compatibility high-water is readable
PASS  lifetime RSS is separately readable
PASS  kernel lifetime footprint includes current allocation
PASS  statistics publish current and lifetime observations
PASS  statistics predating the lifetime footprint field still decode
PASS  disk tier statistics round trip
PASS  disk tier statistics from 0.2.18 to 0.2.20, without shared prefixes, still decode
PASS  monotonic duration is nonnegative
PASS  footprint sampler includes endpoints
PASS  automatic platform-qualified optimization defaults
PASS  qualified platform adds independently qualified fused prefill
PASS  unqualified platform 0 keeps portable work and original rotation
PASS  unqualified platform 1 keeps portable work and original rotation
PASS  unqualified platform 2 keeps portable work and original rotation
PASS  unqualified platform 3 keeps portable work and original rotation
PASS  unqualified platform 4 keeps portable work and original rotation
PASS  unqualified platform 5 keeps portable work and original rotation
PASS  unqualified platform 6 keeps portable work and original rotation
PASS  unqualified platform 7 keeps portable work and original rotation
PASS  unqualified platform 8 keeps portable work and original rotation
PASS  unqualified platform 9 keeps portable work and original rotation
PASS  unqualified platform 10 keeps portable work and original rotation
PASS  unqualified platform 11 keeps portable work and original rotation
PASS  unqualified platform 12 keeps portable work and original rotation
PASS  platform selection is deterministic
PASS  explicit kernel qualification remains available
PASS  explicit kernel fallback remains available
PASS  explicit fused attention fallback remains available
PASS  explicit fused attention qualification remains available
PASS  fused capability applegpu_g17s/26.2
PASS  fused capability applegpu_g17s/26.1
PASS  fused capability applegpu_g17p/26.2
PASS  fused capability applegpu_g18p/26.2
PASS  fused capability applegpu_g16s/26.3
PASS  fused capability applegpu_g17s/15.9
PASS  fused capability Unknown/26.2
PASS  fused capability applegpu_g17x/26.2
PASS  backend arithmetic overrides separate cache identity
PASS  unrelated environment does not invalidate arithmetic
PASS  legacy control encoding omits unset fused prefill
PASS  reference control encoding omits unset automatic policy
PASS  old control JSON remains decodable
PASS  automatic policy survives saved control round trip
PASS  absent overrides preserve an inherited automatic policy
PASS  explicit automatic zero restores the chronological policy
PASS  explicit automatic one enables only that policy
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_READ_SCOPE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_LAYER_WORKSPACE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_INDEXER_TILES
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_PLE_TILES
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_WORKSPACE_TILE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_SCOPE_FRONTIER
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_WORKSPACE_PIECES
PASS  malformed automatic policy refuses/true
PASS  malformed automatic policy refuses/-1
PASS  malformed automatic policy refuses/2
PASS  malformed automatic policy refuses/
PASS  absent vision overrides retain inherited tiling
PASS  explicit zero padding leaves inherited tiling enabled
PASS  explicit zero query tile selects original vision attention
PASS  explicit padding overrides inherited tiling/80
PASS  explicit tiling overrides inherited padding/80
PASS  explicit query zero retains inherited padding/80
PASS  explicit padding with query zero remains valid/80
PASS  explicit query tile with padding zero remains valid/80
PASS  two explicit vision alternatives refuse/80
PASS  two explicit vision alternatives refuse/80
PASS  two explicit vision alternatives refuse/80
PASS  explicit padding overrides inherited tiling/128
PASS  explicit tiling overrides inherited padding/128
PASS  explicit query zero retains inherited padding/128
PASS  explicit padding with query zero remains valid/128
PASS  explicit query tile with padding zero remains valid/128
PASS  two explicit vision alternatives refuse/128
PASS  two explicit vision alternatives refuse/128
PASS  two explicit vision alternatives refuse/128
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_PADDING/bad
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_PADDING/256
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_QUERY_TILE/bad
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_QUERY_TILE/128
PASS  combined candidate preserves the original MTP verification shape
PASS  absent overrides retain the selected default family
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPACT_STATE
PASS  explicit one restores only SLOTSTREAM_OPT_COMPACT_STATE
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPACT_MTP
PASS  explicit one restores only SLOTSTREAM_OPT_COMPACT_MTP
PASS  explicit zero disables only SLOTSTREAM_OPT_NGRAM_ROWS
PASS  explicit one restores only SLOTSTREAM_OPT_NGRAM_ROWS
PASS  explicit zero disables only SLOTSTREAM_OPT_FINAL_FORWARD
PASS  explicit one restores only SLOTSTREAM_OPT_FINAL_FORWARD
PASS  explicit zero disables only SLOTSTREAM_OPT_SAMPLER_THRESHOLD
PASS  explicit one restores only SLOTSTREAM_OPT_SAMPLER_THRESHOLD
PASS  explicit zero disables only SLOTSTREAM_OPT_SAMPLER_DRAW
PASS  explicit one restores only SLOTSTREAM_OPT_SAMPLER_DRAW
PASS  explicit zero disables only SLOTSTREAM_OPT_OUTPUT_QUEUE
PASS  explicit one restores only SLOTSTREAM_OPT_OUTPUT_QUEUE
PASS  explicit zero disables only SLOTSTREAM_OPT_RESPONSIVE_GOVERNOR
PASS  explicit one restores only SLOTSTREAM_OPT_RESPONSIVE_GOVERNOR
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPLETE_PROMPT
PASS  explicit one restores only SLOTSTREAM_OPT_COMPLETE_PROMPT
PASS  explicit zero disables only SLOTSTREAM_OPT_SHARED_ROPE
PASS  explicit one restores only SLOTSTREAM_OPT_SHARED_ROPE
PASS  explicit zero disables only SLOTSTREAM_OPT_FUSED_ROPE
PASS  explicit one restores only SLOTSTREAM_OPT_FUSED_ROPE
PASS  explicit zero keeps demand reads staged
PASS  explicit one restores direct demand reads
PASS  explicit zeros restore the complete reference inference family
PASS  explicit numeric zero disables inherited prefix retention
PASS  non-optimization environment leaves the family intact
PASS  selected defaults still reject invalid override ["SLOTSTREAM_OPT_COMPLETE_PROMPT": "false"]
PASS  selected defaults still reject invalid override ["SLOTSTREAM_OPT_TYPO": "0"]
PASS  valid inherited read scope retains its prerequisites
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_COMPACT_STATE
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_COMPACT_MTP
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_LAYER_WORKSPACE
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_INDEXER_TILES
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_PLE_TILES
PASS  scope can be disabled while retaining its other independent work
PASS  public environment function value keeps its signature and automatic default
PASS  typed override enables compaction
PASS  combined candidate splits the speculative verify attention
PASS  explicit zero disables only SLOTSTREAM_OPT_VERIFY_SPLIT
PASS  explicit one restores only SLOTSTREAM_OPT_VERIFY_SPLIT
PASS  the verify split threshold override leaves the family intact
PASS  reference leaves the verify-pass controls unset
PASS  explicit verify split threshold is read
PASS  verify split threshold rejects -1
PASS  verify split threshold rejects x
PASS  verify split threshold rejects 1.5
PASS  verify split threshold rejects an empty value
PASS  explicit one enables row-invariant projections
PASS  explicit zero returns row-invariant projections to unset
PASS  row-invariant projections stay off unless selected
PASS  verify split engages from 6,144 keys by default
PASS  exact mode promises passes of up to five rows
PASS  no split control selects the stock verify attention
PASS  the split control alone selects the split
PASS  the split with row-invariant projections selects the exact mode
PASS  stock never engages
PASS  the split engages for three to eight rows from its threshold
PASS  the exact mode engages from two rows, never for one
PASS  malformed override refused
PASS  unknown optimization refused
PASS  invalid read scope -1 refused
PASS  invalid read scope 1 refused
PASS  invalid read scope 16384 refused
PASS  invalid read scope bad refused
PASS  unbounded read scope refused
PASS  explicit workspace tile is recorded
PASS  unbounded workspace tile refused
PASS  terminal output needs no speculative draft
PASS  draft count fits remaining output
PASS  public depth cannot exceed recording cap
PASS  negative remaining output cannot underflow
PASS  prefix cache reaches its four-entry bound
PASS  an identical history replaces instead of duplicating an entry
PASS  a miss evicts before allocating a fifth state
PASS  a smaller live token ceiling evicts immediately
PASS  held GB includes fixed recurrent state
PASS  growing hit still reuses its state
PASS  growing hit reserves future state before allocation
PASS  huge reservation safely misses
PASS  huge reservation releases held state
PASS  capacity reservation still hits
PASS  capacity growth reserves bytes before reuse
PASS  saturated byte reservation evicts safely
PASS  identical bytes hash alike
PASS  different bytes do not
PASS  the same image at the same offset matches
PASS  a swapped image does not
PASS  an entry ending inside a run still matches that run
PASS  a text-only entry rejects a prompt with an image inside its range
PASS  an image beyond the entry's range is irrelevant to the match
PASS  a vision conversation is held, not discarded
PASS  the same ids with a different picture miss
PASS  the text-only splice never sees a vision entry
PASS  prefix splice chooses the longest retained extension
PASS  prefix splice is strict, not an identical-history match
PASS  prefix splice lookup does not consume the retained state
PASS  a disabled prefix cache offers no splice
PASS  shard listing works through a symlinked model dir
PASS  8.1 GB plan stays inside its target
PASS  10.0 GB plan stays inside its target
PASS  16.0 GB plan stays inside its target
PASS  30.0 GB plan stays inside its target
RUNTIME CHECK PASS
{
  "device": "Apple M5 Pro",
  "exit_code": 0,
  "failures": [],
  "maximum_live_gpu_buffer_bytes": 201326592,
  "model_loaded": false,
  "observations": [
    {
      "lifetime_rss_peak_bytes": 12894208,
      "phase": "baseline",
      "physical_footprint_bytes": 4080120,
      "reported_peak_bytes": 12877824,
      "sampled_peak_bytes": 4080120
    },
    {
      "lifetime_rss_peak_bytes": 18546688,
      "phase": "transient_128_mib",
      "physical_footprint_bytes": 202375792,
      "reported_peak_bytes": 202375792,
      "sampled_peak_bytes": 202375792
    },
    {
      "lifetime_rss_peak_bytes": 18546688,
      "phase": "transient_freed",
      "physical_footprint_bytes": 68158064,
      "reported_peak_bytes": 202375792,
      "sampled_peak_bytes": 202375792
    },
    {
      "lifetime_rss_peak_bytes": 18628608,
      "phase": "persistent_64_mib",
      "physical_footprint_bytes": 135348848,
      "reported_peak_bytes": 202375792,
      "sampled_peak_bytes": 202375792
    },
    {
      "lifetime_rss_peak_bytes": 18628608,
      "phase": "persistent_plus_transient",
      "physical_footprint_bytes": 269566576,
      "reported_peak_bytes": 269566576,
      "sampled_peak_bytes": 269566576
    },
    {
      "lifetime_rss_peak_bytes": 18628608,
      "phase": "persistent_after_transient_freed",
      "physical_footprint_bytes": 135348848,
      "reported_peak_bytes": 269566576,
      "sampled_peak_bytes": 269566576
    },
    {
      "lifetime_rss_peak_bytes": 18628608,
      "phase": "all_gpu_buffers_freed",
      "physical_footprint_bytes": 68239984,
      "reported_peak_bytes": 269566576,
      "sampled_peak_bytes": 269566576
    },
    {
      "lifetime_rss_peak_bytes": 27017216,
      "phase": "cpu_allocation_after_gpu_peak",
      "physical_footprint_bytes": 76645000,
      "reported_peak_bytes": 269566576,
      "sampled_peak_bytes": 269566576
    },
    {
      "lifetime_rss_peak_bytes": 27017216,
      "phase": "after_concurrent_reads",
      "physical_footprint_bytes": 68338312,
      "reported_peak_bytes": 269566576,
      "sampled_peak_bytes": 269566576
    }
  ],
  "passed": true,
  "source_sha256": {
    "Sources/Slotstream/Checkpoint.swift": "361b54ab482ab1b08debf846148d16fb811ee3550cb8ca1ae7526dc9b825e04b",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/ProcessMemory.swift": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5",
    "Tools/process_memory_check.swift": "17c4ee5dfdff19b1bc467ad896047f6cc8c35d27850d1a62b88f39ea59ff704b",
    "Tools/process_memory_gate.py": "4c53de73f03cbd0a9483eab0a089cdd7e661db96300ade8ae1ca218d9c29d88a"
  }
}
PASS  matching file is accepted
PASS  same-size corruption is rejected
PASS  exact Content-Range is accepted
PASS  wrong range start is rejected
PASS  wrong range total is rejected
PASS  unknown range total is rejected
PASS  every pinned file has a digest
PASS  the draft head is pinned as the one optional file
PASS  an absent optional file is not a repair; an absent required one is
PASS  an empty directory reads as missing
PASS  missing needs the required model
PASS  status carries free disk
PASS  bytesToFetch agrees with required files
PASS  a missing copy is not ready
PULL CHECK PASS
[
  {
    "case": "success",
    "passed": true,
    "exit": 0,
    "output": "READY_SUCCESS\n"
  },
  {
    "case": "failure",
    "passed": true,
    "exit": 1,
    "output": "ORDINARY_FAILURE\n"
  },
  {
    "case": "cancel-throw",
    "passed": true,
    "exit": 130,
    "output": "download interrupted; rerun to resume verified chunks\n"
  },
  {
    "case": "cancel-return",
    "passed": true,
    "exit": 130,
    "output": "download interrupted; rerun to resume verified chunks\n"
  },
  {
    "case": "SIGINT",
    "passed": true,
    "exit": 130,
    "output": "WAITING\ndownload interrupted; rerun to resume verified chunks\n"
  },
  {
    "case": "SIGTERM",
    "passed": true,
    "exit": 130,
    "output": "WAITING\ndownload interrupted; rerun to resume verified chunks\n"
  }
]
{"bf16_predictions":16711680,"centers":1000000,"roundtrips":60,"malformed_inputs":39583,"pass":true}
MANIFEST CHECKS PASS
{"name": "normal", "pass_": true, "seconds": 0.25, "returncode": 0}
{"name": "cache-miss-reporting", "pass_": true, "seconds": 0.031, "returncode": 0}
{"name": "redirect", "pass_": true, "seconds": 0.03, "returncode": 0}
{"name": "bad-object-fallback", "pass_": true, "seconds": 0.029, "returncode": 0}
{"name": "missing-object-raw-fallback", "pass_": true, "seconds": 0.03, "returncode": 0}
{"name": "raw-wrong-range-fails", "pass_": true, "seconds": 0.014, "returncode": 1}
{"name": "raw-ignored-range-fails", "pass_": true, "seconds": 0.014, "returncode": 1}
{"name": "optional-absent", "pass_": true, "seconds": 0.026, "returncode": 0}
{"name": "optional-corrupt-and-unavailable", "pass_": true, "seconds": 0.026, "returncode": 0}
{"name": "bad-object-fails", "pass_": true, "seconds": 0.012, "returncode": 1}
{"name": "retry-after", "pass_": true, "seconds": 0.03, "returncode": 0}
{"name": "hugging-face-rate-limit", "pass_": true, "seconds": 5.612, "returncode": 0}
{"name": "cancel-during-hugging-face-rate-limit", "pass_": true, "seconds": 0.522, "returncode": 1}
{"name": "transient-retry", "pass_": true, "seconds": 5.693, "returncode": 0}
{"name": "wrong-length-fallback", "pass_": true, "seconds": 11.445, "returncode": 0}
{"name": "short-body-fallback", "pass_": true, "seconds": 36.706, "returncode": 0}
{"name": "content-encoding-fallback", "pass_": true, "seconds": 36.455, "returncode": 0}
{"name": "cancel-preserves-progress", "pass_": true, "seconds": 1.471, "returncode": 1}
{"name": "damaged-resumed-chunk-rejected", "pass_": true, "seconds": 0.036, "returncode": 1}
{"name": "damaged-resumed-chunk-repair", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "resume", "pass_": true, "seconds": 0.026, "returncode": 0}
{"name": "already-installed", "pass_": true, "seconds": 0.014, "returncode": 0}
{"name": "valid-symlinks-reused", "pass_": true, "seconds": 0.013, "returncode": 0}
{"name": "corruption-seed", "pass_": true, "seconds": 0.026, "returncode": 0}
{"name": "same-size-final-repair", "pass_": true, "seconds": 0.018, "returncode": 0}
{"name": "invalid-resume-map", "pass_": true, "seconds": 0.031, "returncode": 0}
{"name": "forged-complete-map-without-parts", "pass_": true, "seconds": 0.027, "returncode": 0}
{"name": "oversized-map-is-discarded", "pass_": true, "seconds": 0.027, "returncode": 0}
{"name": "part-symlink-rejected", "pass_": true, "seconds": 0.005, "returncode": 1}
{"name": "part-hardlink-rejected", "pass_": true, "seconds": 0.004, "returncode": 1}
{"name": "part-fifo-rejected", "pass_": true, "seconds": 0.004, "returncode": 1}
{"name": "concurrent-writer-rejected", "pass_": true, "seconds": 0.013, "returncode": 1}
ALL HTTP CHECKS PASS
{"name": "raw-inflight-peer-failure", "pass_": true, "seconds": 0.536, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 1}
{"name": "raw-inflight-peer-hash-failure", "pass_": true, "seconds": 0.123, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 1}
{"name": "raw-inflight-user-cancel", "pass_": true, "seconds": 0.343, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 1}
{"name": "raw-inflight-success", "pass_": true, "seconds": 0.331, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 0}
{"name": "raw-inflight-optional-failure", "pass_": true, "seconds": 0.338, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 0}
{"name": "raw-retry-after-429", "pass_": true, "seconds": 3.113, "request_offsets": [0.0, 3.083], "returncode": 0}
{"name": "raw-retry-after-503", "pass_": true, "seconds": 3.099, "request_offsets": [0.0, 3.071], "returncode": 0}
{"name": "raw-ratelimit-429", "pass_": true, "seconds": 3.135, "request_offsets": [0.0, 3.107], "returncode": 0}
{"name": "raw-headerless-429-cancel", "pass_": true, "seconds": 3.424, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-long-retry-cancel", "pass_": true, "seconds": 3.442, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-short-retry-cancel", "pass_": true, "seconds": 0.342, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-404-retry-header-fallback", "pass_": true, "seconds": 0.024, "request_offsets": [0.0], "returncode": 0, "fallback_request_offsets": [0.002]}
{"name": "raw-protocol-retry-header-fallback", "pass_": true, "seconds": 0.018, "request_offsets": [0.0], "returncode": 0, "fallback_request_offsets": [0.002]}
{"name": "raw-retry-peer-failure", "pass_": true, "seconds": 0.335, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-retry-optional-skip", "pass_": true, "seconds": 0.345, "request_offsets": [0.0], "returncode": 0, "optional_request_counts": [1, 1]}
{"name": "raw-multichunk", "pass_": true, "seconds": 0.325, "returncode": 0}
{"name": "raw-installed-no-http", "pass_": true, "seconds": 0.25, "returncode": 0}
{"name": "raw-source-fallback-missing", "pass_": true, "seconds": 0.325, "returncode": 0}
{"name": "raw-source-fallback-wrong-range", "pass_": true, "seconds": 0.325, "returncode": 0}
{"name": "raw-source-fallback-encoding", "pass_": true, "seconds": 40.766, "returncode": 0}
{"name": "raw-source-fallback-ignore-range", "pass_": true, "seconds": 0.331, "returncode": 0}
{"name": "raw-wrong-range-fails", "pass_": true, "seconds": 0.024, "returncode": 1}
{"name": "raw-corrupt-final-rejected", "pass_": true, "seconds": 0.164, "returncode": 1}
{"name": "raw-optional-inflight-writers", "pass_": true, "seconds": 0.206, "returncode": 0}
{"name": "raw-cancel", "pass_": true, "seconds": 3.272, "returncode": 1}
{"name": "raw-resume", "pass_": true, "seconds": 0.326, "returncode": 0}
{"name": "raw-same-size-repair", "pass_": true, "seconds": 0.445, "returncode": 0}
ALL RAW HTTP CHECKS PASS
SUSTAINED MEMORY PASS 268845056 bytes peak RSS
SLOTPACK GATES PASS
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
PASS  a big cache keeps the head's experts resident
PASS  MTP auto stays off on a 16GB machine
PASS  MTP auto on at --memory-gb 30 (137/layer after the charge)
PASS  MTP auto on at --memory-gb 22 (resident: 76/layer after the charge)
PASS  decode lookahead rides the head at --memory-gb 22
PASS  32 GB Mac: auto runs the head and the lookahead
PASS  24 GB Mac: auto streams the head's experts and runs the lookahead
PASS  32 GB Mac at 65,536 tokens keeps the head by streaming its experts
PASS  36 GB Mac at 65,536 tokens keeps the head and the lookahead
PASS  --memory-gb 16: below 76/layer the head streams its experts, with the lookahead
PASS  streamed head charge visible in json
PASS  --memory-gb 12: the streamed head reaches its 28/layer floor
PASS  --memory-gb 11: below the head's floor, plain decode with the lookahead
PASS  SLOTSTREAM_MTP_EXPERTS=resident keeps the resident head's floor
PASS  SLOTSTREAM_MTP_EXPERTS gibberish refused
PASS  SLOTSTREAM_OPT_EXPERT_PREFETCH=0 keeps the head without the lookahead
PASS  decode lookahead charge visible in json
PASS  --mtp on forces the head onto a small machine
PASS  a head forced below the floor runs without the lookahead
PASS  --mtp off suppresses it everywhere
PASS  --mtp off runs the lookahead in plain decode
PASS  --mtp on without mtp.safetensors is a clean error
PASS  --mtp on cannot squeeze under the minimum target plus the streamed head
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
PASS  32 GB Mac: automatic window is 32,768 (65,536 would stream the head)
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
planner: passed 97, failed 0
{
  "passed": true,
  "model_loaded": false,
  "hardware_qualified": false,
  "binary_sha256": "2ce253c1583b96921bf410ef4bfa8d0f6a0526567e46cf37041e35a534809076",
  "cases": 420,
  "failures": []
}
INSTALLER GATES PASS
STATIC GATES PASS
````

### vq-dense-overlay-acceptance-v1/verify-results/adaptive-server/report.json

Original bytes: 5700. SHA-256: `cd76953332300e07cb8afa258f269704230aa4b2fb2dc4d07cfe6e74b1e2b4ef`.

Normalized bytes: 5700. SHA-256: `cd76953332300e07cb8afa258f269704230aa4b2fb2dc4d07cfe6e74b1e2b4ef`.

````text
{
  "passed": true,
  "binary_sha256": "2ce253c1583b96921bf410ef4bfa8d0f6a0526567e46cf37041e35a534809076",
  "limit_gb": 10,
  "no_elastic": false,
  "observations": [
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    },
    {
      "memory_limit_gb": 10,
      "target_gb": 10,
      "pool_slots": 821,
      "max_prefill_wait_minutes": 17
    }
  ],
  "preflight_available_gb": 24.007032832,
  "command": [
    "slotstream",
    "serve",
    "--memory-limit-gb",
    "10",
    "--max-context",
    "32768",
    "--max-prefill-wait",
    "17",
    "--mtp",
    "off",
    "--vision",
    "off",
    "--port",
    "51020"
  ],
  "completion": {
    "finish_reason": "stop",
    "message": {
      "role": "assistant",
      "content": "The Nile."
    },
    "index": 0
  },
  "server_reaped": true
}
````

### vq-dense-overlay-acceptance-v1/verify-results/adaptive-server/server.log

Original bytes: 2152. SHA-256: `6d236e9df892ef14ec9463a0fb4ed89506ee2fb873df637e498f368cc594f048`.

Normalized bytes: 2152. SHA-256: `6d236e9df892ef14ec9463a0fb4ed89506ee2fb873df637e498f368cc594f048`.

````text
slotstream memory plan (auto)
  device: 52 GB RAM (24.1 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal   (adaptive limit: --memory-limit-gb N; fixed cache: --memory-gb N)
  limit:  10.0 GB; cache adapts to available memory
  cache:  ~17 of 512 experts per layer  (821 global slots = 2.3 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.3 GB expert cache at load; 6.7 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 11831 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch in plain decode, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.8s: expert cache ~17/512 per layer (821 global slots = 2.3 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
slotstream listening on http://127.0.0.1:51020
try it:
  curl localhost:51020/api/chat -d '{"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "hello"}]}'
or point any Ollama or OpenAI client at http://localhost:51020
[7:21:08 AM] request E6067999 /v1/chat/completions: accepted
prefix cache: miss: no retained state (0 prior evictions)
[7:21:09 AM] request E6067999 /v1/chat/completions: ended after 1.5 s
[7:21:09 AM] stopping: asked to stop (SIGTERM)
````

### vq-dense-overlay-acceptance-v1/verify-results/check-1.txt

Original bytes: 87. SHA-256: `47e135e10a066f5ae8612148e92bddbc9ed3b585f467dad9261307f96c311234`.

Normalized bytes: 87. SHA-256: `47e135e10a066f5ae8612148e92bddbc9ed3b585f467dad9261307f96c311234`.

````text
ngram row ids == python reference
diff /tmp/ssv_ngram.txt bench/parity31/ngram_ids.txt
````

### vq-dense-overlay-acceptance-v1/verify-results/check-10.txt

Original bytes: 802. SHA-256: `f86ac4f52c95a2655417ca3df6a0fae57276d457cf5d6cc91a3d263597fe729c`.

Normalized bytes: 802. SHA-256: `f86ac4f52c95a2655417ca3df6a0fae57276d457cf5d6cc91a3d263597fe729c`.

````text
sweep within the prefill-rechunk control, identical cold and warm (sweep-check)
run_binary sweep-check
engine ready in 1.2s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  sweep on a cold pool, run twice: identical
  sweep vs pool path: 3.820% of logit spread (prefill-rechunk control 5.198%, bound 15.593%), top-1 same
  sweep whole vs sweep in 256-token passes: 4.339% of spread
  sweep on the warm pool (636 experts copied out of it): identical to the cold sweep
  after a generate that admitted the prompt's hot experts (prefill 549 tokens): pool path identical, sweep identical
SWEEP CHECK PASS: deterministic; 3.820% of spread vs the pool path inside the 15.593% prefill-rechunk bound; identical on a cold and a warm pool; admission leaves the pool consistent
````

### vq-dense-overlay-acceptance-v1/verify-results/check-11.txt

Original bytes: 210727. SHA-256: `eaf56146fa63b75fd04d30ba27d9274b8006f466d517366ea94fa9ebd63a6c40`.

Normalized bytes: 210727. SHA-256: `eaf56146fa63b75fd04d30ba27d9274b8006f466d517366ea94fa9ebd63a6c40`.

````zlib-base64
eNrlnV2PIllyhu/nV3BnW9rWdJ7P0Ei+WM2OZMm2duWV9mZlWTSV3YWHAgao7un99U5I6KaoyiQh
I877Sr7r6qqK54Ek3yDr5Ake5pt6tpts6unDdjJdPkx+rev1dDH/XE/q356ni8nusZ5sd9NP9cNk
Pd09TlbLyXQyWy0eJrPprPnePz/Us9VD/W71ud4sput3zf/Nfv2XHzbPy//5MF9ON18nb/3AD3/5
41//Orn41k+T9WI6X/40qZuvv06aEpPt82xW1w/b/p8/+u1/4VO9rDfTXfNVW2S3+rVe9v/2w/lT
sKinzUPfP+h589XzcvY4XTa1+yvsf/z783Yosb2nxtnj2M6mu129ab6a77aTp/l2W2+vFzg9lKbA
/uGc/e5kvtz/4KzuL/Jh1Rzi5te37e8fpKZPdfPVbLXpPAzbdT17Xkx3zaO/4eC9+K07D+GLGiMO
5Is6ow7nq0r3HdRXZe4/tC9KKRzgg81m+nE3edyXaH5m/nH+7flYrXfzp/k/mp9dLd/tGe/2pfcH
8l37EJrjVC+39b9+nC629R+a0tPN968e6u1sM1/vVptt+18/TT7ON9vduw/T3exx8nE6XzxvmgOx
1989b5bG2G/ATb1tvtk81+vNfLWZrOfLrRV4uTpQ9y+ZwzFpwvZ5uT8bZqun9aLe1YbgZf1l8jRd
Nw/v06Q5wPXmpNI+G4eDYIVfLRdfD6+tI/IA+6ft5PN81pD2h/x5uXezO+SbpuM1x7lhP+7Pru3z
5vP8mCHH14EVeXp60MezvH21Nw95udqdjr/Z876Zf2oa9WLyMN1Nz45683Cbp2T1ZTt5/4fmBV/P
6sn7Sf37dLYjMKloTByNiacxCTQmkcYk0ZhkGhNBmwhNsglNsglNsglNsglNsglNsglNsglNsglN
slWJJtq+q1Q8Ko5HxfOoBB6VyKOSeFQyjwo84lygibjvKhWPiuNR8TwqgUcl8qgkHpXMowKPOO9o
Iu67SsWj4nhUPI9K4FGJPCqJRyXzqBhH3GLawMsv3h2wiMW7wyLWaaHutKhqvYJz4h3XzE4reIen
eTo3fJqb7+/mzevsAjv9sK2XO/tVuvZwHtbqlvtbBSb1fq3Q7uG2tyOsnz8s5tvHhv96pbT8mtld
ThWhkyN08oROgdApEjolQqdM6CQ8TkKYmUKYmUKYmUKYmUKYmUKYmUKYmUKYmUKYmcXW+e6Tqhil
HKOUZ5QKjFKRUSoxSmVGKaLwLLaCeJ9UxSjlGKU8o1RglIqMUolRKjNKEYVnsbXJ+6QqRinHKOUZ
pQKjVGSUSoxSmVHKODw39W6/8fWw+/TbZrbdl9V+y+jq6Wm+233b07e1djgueD4v57891+dLZvNl
uxppu23y4Xm9mM+mhyXQ/RLkdjJdzKdbu+Xe8szD5ubt9uPzon3SC6/7XcNXWLzD4j0WH7D4iMUn
LD5j8QLBCzZ2BBs7go0dwcaOYGNHsLEj2NgRbOwINnaKrT5d5VdgvgPzPZgfwPwI5icwP4P5mPwp
toBzlV+B+Q7M92B+APMjmJ/A/AzmY/Kn2BrIVX4F5jsw34P5AcyPYH4C8zOYb5w/+6WE7+sLxzFx
i6+T+XK3OoyC3C5WO8NVhe38H/VxdeVUq/AfvAc5VAQOjsDBEzgEAodI4JAIHDKBg1VC7jbPgCmx
Z9Si+0xbbvkZsd+4kBGxLR04IbYVAAyIbcGQ+bDHJx0/HvZmkYpFxLGIeBaRwCISWUQSi0hmERGw
iLAEmrAEmrAEmrAEmrAEmrAEmrAEmrAEmrAEmv0y/e0mFY2JozHxNCaBxiTSmCQak0xjgk42+xsA
bjepaEwcjYmnMQk0JpHGJNGYZBoTdLLZ31pwu0lFY+JoTDyNSaAxiTQmicYk05jYJlvpia9nVMBC
XNl5ry2z/LjXllt22uvliluxYa8tmGrW6wilik/J8Sl5PqXApxT5lBKfUuZTEhol4YtK4YtK4YtK
4YtK4YtK4YtK4YtK4YtK4YvKUot2XINdxzg5QidP6BQInSKhUyJ0yoROPJlZajmQa57rGCdH6OQJ
nQKhUyR0SoROmdCJJzNLLTRyjXEd4+QInTyhUyB0ioROidApEzrZZiZ0fOtLhfLTW8+3M5YapHpa
uS2ORI1uHUavoHQHpXsoPUDpEUpPUHqG0gVBF2jaCDRtBJo2Ak0bgaaNQNNGoGkj0LQRaNqUWkyC
zWkdiHdYvMfiAxYfsfiExWcsHhI7pdZjYONZB+IdFu+x+IDFRyw+YfEZi4fETqklDdhU1oF4h8V7
LD5g8RGLT1h8xuJtYwc0jfW0SAAcxnqDQoVXcHgFj1cIeIWIV0h4hYxXUMnFPa/7wx+t9n72U+32
fnZyjYew9nHth7B20ksNYe0UsB7C2gm2H8La/aQXHsKqIVKxiDgWEc8iElhEIotIYhHJLCICFhGW
QBOWQBOWQBOWQBOWQBOWQBOWQBOWQBOWQFNeglcxqWhMHI2JpzEJNCaRxiTRmGQaE3SyKa/yq5hU
NCaOxsTTmAQak0hjkmhMMo0JOtmUbyRQMaloTByNiacxCTQmkcYk0ZhkGhPbZDMdwtpPBSzEGQ5h
7WQaD2Ht5BoOYR2w4mYzhLUTjBvCqqtU8Sk5PiXPpxT4lCKfUuJTynxKQqMkfFEpfFEpfFEpfFEp
fFEpfFEpfFEpfFEpfFFZatEOOIRV2ckROnlCp0DoFAmdEqFTJnTiycxSy4HAIazKTo7QyRM6BUKn
SOiUCJ0yoRNPZpZaaAQOYVV2coROntApEDpFQqdE6JQJnWwzs9wQ1qsKxkNYr2xnNJmI2rNyWxxZ
ZAjr3fQKSndQuofSA5QeofQEpWcoXRB0gaaNQNNGoGkj0LQRaNoING0EmjYCTRuBpk2pxaQyQ1jv
xzss3mPxAYuPWHzC4jMWD4mdUusxZYaw3o93WLzH4gMWH7H4hMVnLB4SO6WWNMoMYb0f77B4j8UH
LD5i8QmLz1i8beyUGMLas0hQagjrOIUKr+DwCh6vEPAKEa+Q8AoZr2CUi2ef4Vhu6+f5B0cW3PnZ
YotPYP2GRQxgbeG4+aunMcOlx6+2XMT01eMzDh++erNHReLhSDw8iUcg8YgkHonEI5N4CNZDSHJM
SHJMSHJMSHJMSHJMSHJMSHJMSHJMSHLMfKH9dpGKRcSxiHgWkcAiEllEEotIZhEBB5r5Ev7tIhWL
iGMR8SwigUUksogkFpHMIgIONPObA24XqVhEHIuIZxEJLCKRRSSxiGQWEdNAKzxP9QxaflGt6DTV
Fll8mGqLLTpL9XL1rNQo1ZbLNEl1hFFFZ+TojDydUaAzinRGic4o0xkJi5HQJaTQJaTQJaTQJaTQ
JaTQJaTQJaTQJaTQJWShFTiqsaljlByfkudTCnxKkU8p8SllPiWaqCy0tkc1LXWMkuNT8nxKgU8p
8iklPqXMp0QTlYVWDamGpI5RcnxKnk8p8ClFPqXEp5T5lEyjEjkc9aVB8dmo59sMC80pPS3CliaC
BqMOg1dIuEPCPRIekPCIhCckPCPhAoALMmQEGTKCDBlBhowgQ0aQISPIkBFkyAgyZAqtDaGmoA6k
OyjdQ+kBSo9QeoLSM5SOSJtCyyuo4acD6Q5K91B6gNIjlJ6g9AylI9Km0AoFaubpQLqD0j2UHqD0
CKUnKD1D6aZpg5l1evqbP27U6Q0GFdzAwQ083CDADSLcIMENMtzgzjRsmUeBo07XRyTqbce8haq5
H3MgV33K6XCuxZjTgXS7OacDBfQHnQ4EW0w6Hfqkm4861RepWEQci4hnEQksIpFFJLGIZBYRAYsI
S6AJS6AJS6AJS6AJS6AJS6AJS6AJS6AJS6CNXl43MKloTByNiacxCTQmkcYk0ZhkGhN0so1eyjcw
qWhMHI2JpzEJNCaRxiTRmGQaE3Syjb5twMCkojFxNCaexiTQmEQak0RjkmlMbJNNeS7qLVTAQpzq
ZNSBTPXRqAO5qrNRb15x0xqOOhBccjqqpVLFp+T4lDyfUuBTinxKiU8p8ykJjZLwRaXwRaXwRaXw
RaXwRaXwRaXwRaXwRaXwRWWpRbuiA1NNnRyhkyd0CoROkdApETplQieezCy1HFh0cqqpkyN08oRO
gdApEjolQqdM6MSTmaUWGouOUDV1coROntApEDpFQqdE6JQJnWwz03KU6o0K6rNUb9rOqDTadPDK
bXGk0ThVJXoFpTso3UPpAUqPUHqC0jOULgi6QNNGoGkj0LQRaNoING0EmjYCTRuBpo1A06bUYpLV
hFUtvMPiPRYfsPiIxScsPmPxkNgptR5jNWpVC++weI/FByw+YvEJi89YPCR2Si1pWM1c1cI7LN5j
8QGLj1h8wuIzFm8bOzazVwcvEtgNX9VUqPAKDq/g8QoBrxDxCgmvkPEKRrl49lmM5bZ+nn8AZMGd
ny22+ATWb1jEANYWjpu/ehozXHr8astFTF89PuPw4as3e1QkHo7Ew5N4BBKPSOKRSDwyiYdgPYQk
x4Qkx4Qkx4Qkx4Qkx4Qkx4Qkx4Qkx4Qkx8wX2m8XqVhEHIuIZxEJLCKRRSSxiGQWEXCgmS/h3y5S
sYg4FhHPIhJYRCKLSGIRySwi4EAzvzngdpGKRcSxiHgWkcAiEllEEotIZhExDbTC81TPoOUX1YpO
U22RxYepttiis1QvV89KjVJtuUyTVEcYVXRGjs7I0xkFOqNIZ5TojDKdkbAYCV1CCl1CCl1CCl1C
Cl1CCl1CCl1CCl1CCl1CFlqBoxqbOkbJ8Sl5PqXApxT5lBKfUuZToonKQmt7VNNSxyg5PiXPpxT4
lCKfUuJTynxKNFFZaNWQakjqGCXHp+T5lAKfUuRTSnxKmU/JNCqRw1FfGhSfjXq+zbDQnNLTImxp
Imgw6jB4hYQ7JNwj4QEJj0h4QsIzEi4AuCBDRpAhI8iQEWTICDJkBBkyggwZQYaMIEOm0NoQagrq
QLqD0j2UHqD0CKUnKD1D6Yi0KbS8ghp+OpDuoHQPpQcoPULpCUrPUDoibQqtUKBmng6kOyjdQ+kB
So9QeoLSM5RumjaYWaenv/njRp3eYFDBDRzcwMMNAtwgwg0S3CDDDTTSsP2i6xMSjXZj9kPNdmN2
Ym1HnPZhzUecdsILjTjt5BuPOO3kmo847X7Gy4441fCoSDwciYcn8QgkHpHEI5F4ZBIPwXoISY4J
SY4JSY4JSY4JSY4JSY4JSY4JSY4JSY7pLqKriFQsIo5FxLOIBBaRyCKSWEQyiwg40HTX6VVEKhYR
xyLiWUQCi0hkEUksIplFBBxourcCqIhULCKORcSziAQWkcgiklhEMouIaaBZjjjth5ZfVLMbcdqJ
tB1x2om1G3E6YPXMZMRpJxc24lTXqKIzcnRGns4o0BlFOqNEZ5TpjITFSOgSUugSUugSUugSUugS
UugSUugSUugSUugSstAKHG7EqbKS41PyfEqBTynyKSU+pcynRBOVhdb2cCNOlZUcn5LnUwp8SpFP
KfEpZT4lmqgstGqIG3GqrOT4lDyfUuBTinxKiU8p8ymZRmWxEadXDWxHnF7ZZmgxcLRnEbY0scSI
07vhFRLukHCPhAckPCLhCQnPSLgA4IIMGUGGjCBDRpAhI8iQEWTICDJkBBkyggyZQmtDRUac3k93
ULqH0gOUHqH0BKVnKB2RNoWWV4qMOL2f7qB0D6UHKD1C6QlKz1A6Im0KrVAUGXF6P91B6R5KD1B6
hNITlJ6hdNO0KTDitOdv/oVGnI4zqOAGDm7g4QYBbhDhBglukOEGNml49kGHxTZjnn+4Yrm9mC21
9HzTb1TAeNOWDZtuehrfW3i4aYsFzDY9Pt3o0aY3a1QcGo5Dw3NoBA6NyKGRODQyh4ZANYQjvoQj
voQjvoQjvoQjvoQjvoQjvoQjvoQjvqyXym/3qEg8HImHJ/EIJB6RxCOReGQSD2yOWS/C3+5RkXg4
Eg9P4hFIPCKJRyLxyCQe2ByzXt6/3aMi8XAkHp7EI5B4RBKPROKRSTwsc6zstNIzZvEFspKzSlti
6VGlLbXkpNLLlbBCg0pbLNGc0hFCFZuQYxPybEKBTSiyCSU2ocwmJCRCwhaMwhaMwhaMwhaMwhaM
whaMwhaMwhaMwhaMZZbTmIaSjjFydEaezijQGUU6o0RnlOmMWBKyzEId0yzSMUaOzsjTGQU6o0hn
lOiMMp0RS0KWWQJkGkE6xsjRGXk6o0BnFOmMEp1RpjOyTEjg6NGXAqUnj55v/yszBvS0nloYiBk7
OoxdAdkOyPZAdgCyI5CdgOwMZEt5tgCzRYDZIsBsEWC2CDBbBJgtAswWAWaLALOlzFIPaMboQLhD
wj0SHpDwiIQnJDwj4YCQKbNaAhotOhDukHCPhAckPCLhCQnPSDggZMosOIAmig6EOyTcI+EBCY9I
eELCMxJuGTKQSaKnP+HDBoneIFChBRxawKMFAlogogUSWiCjBW7OwM3zctvA1rvHyfufzjYi3rrn
8WWdfVTOD/sY6229+VxPmu+uNrv64ceztbnVl8l7a0BlDXDWAG8NCNaAaA1I1oBsDZC7AJXSCVtZ
n7CV9QlbWZ+wlfUJW1mfsJX1CVtZn7CV9QlbWZ+w3imdsftCtqfsLYTKnODMCd6cEMwJ0ZyQzAnZ
nHBnr3Wi1W33lYz77S2Iyh7h7BHeHhHsEdEekewR2R5xw0k8X36eLuYPLepd9ePf3/93g/nf+rZh
LC+qBNGo8v7Hv7+rNKrEymmUuadG/bTefZ1spl+OM3but2h//9f662T+UC9384/z/z9VDndjd1Rb
r1aL/enwcb5Y7M+Pj/WmXs7q9s/hdddt48MrzpftEWv/sD2d7Z6ni8XXQ6vbjrdtStabzWrTDtJa
H07lsVXbgseJUs0vj623XDX/Xn2eb5tfnC4mq+fd+nmnXHTWPKkfprNfxx+t9rW13e2TcH6aLTWb
zh7HP7GN42lrwGH2WPPFop5uFQo/PM23+2di/0fMeqfguWo6QfMiWDQFdqftDaM1X4xFe5jMHjer
5Wqx+tS0neanptttfWVI2nBUe8Dar3/fnyf7c25TPys82WdvUg97H9aPX7eHR7D6sG+ph4Jbbcjf
/nO/FLYvvxgfGvtlNq14a6s9rJpDN20O3uM+PfevmA/P88WDTvHH6bb9q/tZOuuEyOWSZ/OyWU4+
1Hef7stPm+mTbjO5KKnbTV756rSTi7Lj+8lFQaWG0l/1/o7y6pCptpSL6oo95bLy2Kby2lSpq1wU
Nm0rFyzVvnJR+/hha/uv6/0729NGy+3hpXkctbm/OOv5nLsbcQZ97AplVCN7lVfjOtmb5dRa2ZvV
NXvZBUC7mW2/1PVat5ldlNRtZq98dZrZRdnxzeyioFIz6696fzN7dchUm9lFdcVmdll5bDN7barU
zC4KmzazC5ZqM7uobdRdrlBGdZdXATKuu7xZTq27vFlds7tcALS7S/t7746vvf1H5y4fdJrM25W3
TbHJ6svy+AQdR0U0Gfm03mkxdPtZ1zOk09berj6+u71dV6nJDSp+f6/rOqqqLe9tiGLn6wCMbYCd
3kp98O36pu3wbaRqV3wbYdQch8FG9ciuUBrXKvuqqnXMPohm4+zoP9pXZ81/LN86IZSu1LrLK1+1
9T0OpSu4boTC1Vx3ca0ru8GEEVd5fYdb94qvm6R59ddDGX0l2PsItK4KuyG2V4jdXN2rxW6O1ZXj
cOK4q8i+QBt5RXmttN7V5TWS6pVmN0y7ax7+dztbrevJbjNdbpsH0PySTsvsqq3bL7sfgU6z7Ko/
vlN2VVZqkwPL398ju4+vaoPswih2x07E2NbY467UF7sIpk2xC6raEbsgx1XB9jvqD8Go2Q7Fjeq0
3VE4rs3211Xrsf0YzQbbRbK5/cWyx/YTLG6Ose63/RStW2eMe+9NkLE31hTqw/0w9dtuzHry1ceh
elMOpD/3ow1u2bHt1YMYxncJFX6/cBtU4R4iq/cOQ6or32FU7n1EP0/73UT9+7re7CYPzf8/1D8d
23nbd48viNE12/b6cb5sTqDxxX7fb6BqMvRQdXy546cXHHPrtGFr/BN56r/N6+K3/TP6/YMS7n1d
XADOcqjtxUqvgJF99vL1NLaxXtQbmxyvXk3tOdsUvfdEVT1zXpYcd+Jc1Bp53lxUUzttXtbVP2te
1lc7aV6WVXlvqnbKvCyn02tHnTBPu7XBRsDuqjpXqH3W465KuyvffyXaXXPk1efgwrdfcfYdQZWr
zG6AwpVlT/F7z+Be35FXkN21Ta4au3EqV4rd5ZWvnYaD7rpe6guZ+3L7WsXR10XXABrXQt0Mreuf
HsK6nj0vmt/9XE+aH51/3M9r2J/MX1ab5o3Jy8mF9wEVdzD2lNVvg8o7GXtK6zRC3R2NwyuPa4U2
Oxt7CMrNUGuHY7+xYjsssdOxh6feEAvteLyCNGrCFjsfezNufBu22QF5laDdiI12QvYh7Fux4v7L
nrL6rVh5H2ZPaZ1WrLsfc3jlca3YZl9mD0G5FWvtz+w3VmzFJfZp9vDUW7Htfs0bSKP7otK+zasl
Vfui2f7NHohFX7xE2PdF/Z2j16vr7B69ztHvxja7SK8TdHqzyW7SmwHjOrXprtLrIOW+rby7dJC/
YhcvuMv0Ola9pxfZbXo7cHSH1911OrSyar+33n06oIcZdP8OUoGLY5vtrwMRBhfNdttgB2KULqbN
tsPeRxl5kW2+LXYgTfvi22B77PBHonlRXnib7EC2/sV6se2yd1LHX8Trb5u9qbzuxX2J7bMDgSYX
/T04+95vscFoSH39rm+1uWgIQ6ffG20sugMxrtMbbyoaglLu8eobigY+BsXuXnQz0RCwel+32Ug0
lGD0tsF0G8+w+Bz/hsF4C89wlPZbBevtO4NYpW5ks36rUGI/8i2PSvuuN9s3D6Z7k+8GadwiV/Dt
hPk+5RtgevfTlXmDAdizPBxvdPOd/VsOzP7l2wxMbwEs9gbIZi/zrQSD+wXLviUqs6/5BqL926Pj
btNXpK8jt4sOZNy3f3Ro8Ts3lA4tP3qH6UCQ3pbTgcDRe1AHchTeiPS9fjXehfTU14jV3lfvyH2s
PbUfNk12NO+h5p+WT21St++emrc6zTvRL+1RH5NopnnSjRgfJz21FdKkp7pqmHRzbLKkm6caJd0Y
tUsasyDpLq/39swkRrpLD0uRP/3y85//9Mvkz3/75b/+449/mfz8b7/8/O+TvckP/wf65UMr
````

### vq-dense-overlay-acceptance-v1/verify-results/check-12.txt

Original bytes: 2201. SHA-256: `3f5a8793c1d9ab54de0862541e2737728b5149baaef5209ca3f31e678aa15221`.

Normalized bytes: 2201. SHA-256: `3f5a8793c1d9ab54de0862541e2737728b5149baaef5209ca3f31e678aa15221`.

````text
streamed draft experts and the plain-decode lookahead leave output exact (draft-stream-check)
run_binary draft-stream-check
engine ready in 0.8s: expert cache ~23/512 per layer (1091 global slots = 3.0 GB), mtp draft head on, eos [248044, 248046]
engine ready in 0.7s: expert cache ~28/512 per layer (1365 global slots = 3.8 GB), mtp draft head on, eos [248044, 248046]
engine ready in 0.6s: expert cache ~20/512 per layer (961 global slots = 2.7 GB), eos [248044, 248046]
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.6s: expert cache ~17/512 per layer (821 global slots = 2.3 GB), eos [248044, 248046]
PASS  draft-stream-head: the resident plan keeps the experts resident
PASS  draft-stream-head: resident run succeeds
PASS  draft-stream-head: resident run verified drafts
PASS  draft-stream-head: resident run reports no draft cache
PASS  draft-stream-head: resident run generated every token
PASS  draft-stream-head: the streamed plan streams the experts
PASS  draft-stream-head: streamed run succeeds
PASS  draft-stream-head: streamed experts leave the ids unchanged
PASS  draft-stream-head: streamed run generated every token
PASS  draft-stream-head: the streamed head read experts on demand
PASS  draft-stream-head: the streamed head reused cached experts
PASS  draft-stream-head: a failed draft read ends the request with an error
PASS  draft-stream-head: the failure was consumed
PASS  draft-stream-head: the next request succeeds
PASS  draft-stream-head: the next request decodes the same ids
PASS  draft-stream-plain-lookahead: the reference plan runs no lookahead
PASS  draft-stream-plain-lookahead: plain run succeeds
PASS  draft-stream-plain-lookahead: plain run generated every token
PASS  draft-stream-plain-lookahead: the plan runs the lookahead without the head
PASS  draft-stream-plain-lookahead: lookahead run succeeds
PASS  draft-stream-plain-lookahead: the lookahead leaves plain decode's ids unchanged
PASS  draft-stream-plain-lookahead: plain decode passes were forecast
PASS  draft-stream-plain-lookahead: the lookahead issued reads
DRAFT STREAM CHECK PASS
````

### vq-dense-overlay-acceptance-v1/verify-results/check-13.txt

Original bytes: 340. SHA-256: `2053707d6bddb7c8f0c9789157f41595d0eb58744f0e7a07a0c7c3e5374f7e05`.

Normalized bytes: 333. SHA-256: `06e95aa67256369d5c013204b85e49552192625048088a8105a67f7950795eba`.

````text
independent current-backend draft-head reference
"$REFERENCE_PYTHON" Tools/current_backend_reference.py --kind mtp --out "$CURRENT_MTP"
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/current_backend_reference.py", line 35, in <module>
    import mlx.core as mx
ModuleNotFoundError: No module named 'mlx'
````

### vq-dense-overlay-acceptance-v1/verify-results/check-14.txt

Original bytes: 426. SHA-256: `08e5e1d17e3bcd3a1dee2c02a0d61c89eb5eb7b28cfc1ee61faef6aeaf5ed293`.

Normalized bytes: 412. SHA-256: `cdc18ea226cd07bf73f1a2cf6b8d90500f699658caea98806018acf5f5fd02e1`.

````text
mtp head parity vs current Python reference (mtp-parity)
run_binary mtp-parity --fixture "$CURRENT_MTP/comparison.safetensors"
Error: MLX Error: [load_safetensors] Failed to open file <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/current-mtp/comparison.safetensors at <HOME>/Projects/slotstream/.build/checkouts/mlx-swift/Source/Cmlx/mlx-c/mlx/c/io.cpp:76
````

### vq-dense-overlay-acceptance-v1/verify-results/check-15.txt

Original bytes: 3526. SHA-256: `748445613b9ab2fe42bbac973c5e6ee1d9533336775534ecc78024f14120279b`.

Normalized bytes: 3526. SHA-256: `748445613b9ab2fe42bbac973c5e6ee1d9533336775534ecc78024f14120279b`.

````text
verify pass rows equal plain decode bit for bit (mtp-rowcheck)
run_binary mtp-rowcheck --memory-gb 10
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (27.6 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~17 of 512 experts per layer  (834 global slots = 2.3 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.3 GB expert cache at load; 6.7 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  mtp:    draft head on — speculative decode; its experts stream through a 64-expert cache (0.4 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 11975 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.8s: expert cache ~17/512 per layer (834 global slots = 2.3 GB), mtp draft head on, eos [248044, 248046]
prompt: 973-token prompt, below the indexer budget, rows across 1024 keys (2048); positions from 1019 every 1 tokens; context window 32768
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: exact verify attention engaged (180 layer passes)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: row-invariant projections engaged (11040 matmuls)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: k=2, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0141, 0 flips)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: k=3, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0173, 0 flips)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: the state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.0156, 0 flips)
prompt: 2826-token prompt, above the indexer budget (2048); positions from 2826 every 4 tokens; context window 32768
PASS  2826-token prompt, above the indexer budget: exact verify attention engaged (180 layer passes)
PASS  2826-token prompt, above the indexer budget: row-invariant projections engaged (11040 matmuls)
PASS  2826-token prompt, above the indexer budget: k=2, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0208, 0 flips)
PASS  2826-token prompt, above the indexer budget: k=3, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0241, 0 flips)
PASS  2826-token prompt, above the indexer budget: the state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.0253, 0 flips)
MTP ROWCHECK PASS
````

### vq-dense-overlay-acceptance-v1/verify-results/check-16.txt

Original bytes: 468. SHA-256: `15b77310031fbfb2ef8438c7ba9bfc9c19c8cecf2526f1331b9bbd8f9c635f39`.

Normalized bytes: 468. SHA-256: `15b77310031fbfb2ef8438c7ba9bfc9c19c8cecf2526f1331b9bbd8f9c635f39`.

````text
--memory-gb 10 process footprint and RSS stay under target
python3 Tools/memory_gate.py /tmp/ssv_mem.json --limit-gb 10
{"passed": true, "maximum_observed_bytes": 5779591944, "sampled_footprint_bytes": 5779591944, "image_preparation_peak_bytes": 0, "lifetime_rss_bytes": 5143101440, "physical_footprint_end_bytes": 5779591944, "lifetime_footprint_peak_bytes": 5779591944, "sampling_interval_ms": 20, "global_swap_deltas": {"generator": {"swapins": 0, "swapouts": 0}}}
````

### vq-dense-overlay-acceptance-v1/verify-results/check-17.txt

Original bytes: 71. SHA-256: `29c9a3eb030bd06f358d49a86ee2a5f435b93ad3a3710b689ecdc9afb4af0f00`.

Normalized bytes: 71. SHA-256: `29c9a3eb030bd06f358d49a86ee2a5f435b93ad3a3710b689ecdc9afb4af0f00`.

````text
--memory-gb 10 output is stable
diff /tmp/ssv_mem.txt /tmp/ssv_big.txt
````

### vq-dense-overlay-acceptance-v1/verify-results/check-18.txt

Original bytes: 486. SHA-256: `909e2b0dfc90282efdda2c593b80452470a63cc4f55de676df2d382b704c0649`.

Normalized bytes: 486. SHA-256: `909e2b0dfc90282efdda2c593b80452470a63cc4f55de676df2d382b704c0649`.

````text
--memory-gb 10 process footprint and RSS under target on the long prompt
python3 Tools/memory_gate.py /tmp/ssv_longmem.json --limit-gb 10
{"passed": true, "maximum_observed_bytes": 8059669672, "sampled_footprint_bytes": 7998147752, "image_preparation_peak_bytes": 0, "lifetime_rss_bytes": 3050242048, "physical_footprint_end_bytes": 6317380384, "lifetime_footprint_peak_bytes": 8059669672, "sampling_interval_ms": 20, "global_swap_deltas": {"generator": {"swapins": 0, "swapouts": 0}}}
````

### vq-dense-overlay-acceptance-v1/verify-results/check-19.txt

Original bytes: 292. SHA-256: `4c4914bb3dcec6b643d6db1274eb322f10e2c2a19a5d02eb15779b0ad7e5bb15`.

Normalized bytes: 292. SHA-256: `4c4914bb3dcec6b643d6db1274eb322f10e2c2a19a5d02eb15779b0ad7e5bb15`.

````text
long-context answer still correct (sparse indexer active)
python3 Tools/long_context_gate.py /tmp/ssv_longmem.json /tmp/ssv_longmem.txt --expected SEVENTEEN --minimum-prompt-tokens 7000 --maximum-output-tokens 16
{"passed": true, "prompt_tokens": 7972, "output_tokens": 4, "completed": true}
````

### vq-dense-overlay-acceptance-v1/verify-results/check-2.txt

Original bytes: 202. SHA-256: `41d318695c0502e1ca324367f323bf4c936119ecba79f9fe78dddd3cafe25fb6`.

Normalized bytes: 202. SHA-256: `41d318695c0502e1ca324367f323bf4c936119ecba79f9fe78dddd3cafe25fb6`.

````text
chat template == transformers
[ "$(run_binary template-check 2>/dev/null)" = '248045,8678,198,2523,513,10631,13,248046,198,248045,846,198,12675,1017,248046,198,248045,74455,198,248068,271,248069,271' ]
````

### vq-dense-overlay-acceptance-v1/verify-results/check-20.txt

Original bytes: 265. SHA-256: `7acff6429e179baad49cf31a8f9ac3c44bbba0aca91eb97fd240ad734d70a1da`.

Normalized bytes: 265. SHA-256: `7acff6429e179baad49cf31a8f9ac3c44bbba0aca91eb97fd240ad734d70a1da`.

````text
context-check: 2k rung reads inside the plan and reports it
[ "$CONTEXT_STATUS" -eq 0 ] && python3 -c 'import json; d=json.loads(open("/tmp/ssv_ctx.json").read().strip().splitlines()[-1]); assert d["fits"] and d["aborted"] is None and d["prefill_tokens"]==2048, d'
````

### vq-dense-overlay-acceptance-v1/verify-results/check-21.txt

Original bytes: 460. SHA-256: `40b8ebc249c92001005b1b45f1422f478e982e3feb1d02fbe762d10a930bfd3d`.

Normalized bytes: 460. SHA-256: `40b8ebc249c92001005b1b45f1422f478e982e3feb1d02fbe762d10a930bfd3d`.

````text
context-check: process memory remains under target
python3 Tools/memory_gate.py /tmp/ssv_ctx.json --limit-gb 10
{"passed": true, "maximum_observed_bytes": 8331824320, "sampled_footprint_bytes": 8314784960, "image_preparation_peak_bytes": 0, "lifetime_rss_bytes": 3370008576, "physical_footprint_end_bytes": 7330289016, "lifetime_footprint_peak_bytes": 8331824320, "sampling_interval_ms": 20, "global_swap_deltas": {"generator": {"swapins": 0, "swapouts": 0}}}
````

### vq-dense-overlay-acceptance-v1/verify-results/check-22.txt

Original bytes: 2133. SHA-256: `81a6a2f026b13a602f103e5396201bda9eb5c9428872b3f46669b08dcc53fc73`.

Normalized bytes: 2133. SHA-256: `81a6a2f026b13a602f103e5396201bda9eb5c9428872b3f46669b08dcc53fc73`.

````text
run through a symlinked model dir
run_binary run --model "$SYM" --memory-gb 8.1 --max-tokens 1 --greedy --prompt hi
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (26.4 GB reclaimable now), 40.2 GB Metal working set
  target: 8.1 GB total process budget, not a RAM usage goal
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  plan:   ~7.9 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 1.8 GB expert cache at load; 6.2 GB allowed for runtime, context and workspace; 0.2 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 6510 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
  window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to the estimated request time without an unmeasured cache tradeoff; --max-context N chooses another window up to 262144
engine ready in 0.7s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
prompt tokens: 13 (~0 s to the first token at this plan)
Hello
-- prefill 13 tok in 0.64s (20.2 tok/s)
-- prefill split: io 0.47s + scatter 0.00s | 2185 records (6.0 GB, 13.0 GB/s)
-- decode 1 tok in 0.00s (3016.59 tok/s)
-- decode split: io 0.00s + scatter 0.00s | 0 records
-- expert cache ~13/512 experts per layer, hit rate 0.000 | ngram rows 0h/0m | lifetime footprint peak 4.763 GB, current footprint 4.763 GB | total 0.6s

````

### vq-dense-overlay-acceptance-v1/verify-results/check-23.txt

Original bytes: 308. SHA-256: `0692dbe990720c42b9a649e0ee5c8fc7947cf0f4010b8d7c69960485e03f9464`.

Normalized bytes: 301. SHA-256: `a89f5a0f4df2d545ea83b009a73f3fe9c265c3469b6f1385412706550144ad25`.

````text
vision tower dumps its pixels and embeddings
run_binary vision-parity --out "$VP"
loading the vision tower (0.898 GB resident)
wrote 2808 patches -> 702 tokens (832x864, grid 52x54) to <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/vision-parity
````

### vq-dense-overlay-acceptance-v1/verify-results/check-3.txt

Original bytes: 260. SHA-256: `fcfaedd51d025cbf44a9d614286b0393963d979add8bbe925a6ff2cb60f580c0`.

Normalized bytes: 260. SHA-256: `fcfaedd51d025cbf44a9d614286b0393963d979add8bbe925a6ff2cb60f580c0`.

````text
layer parity (historical reference, one-row projections)
run_binary parity --tokens '9707,11,1246,525,498,30' --layers 2 --compare bench/parity31 --row-invariant
layer  0: max abs 0.00098, rel 0.00225  OK
layer  1: max abs 0.00293, rel 0.00679  OK
PARITY PASS
````

### vq-dense-overlay-acceptance-v1/verify-results/check-4.txt

Original bytes: 341. SHA-256: `9f6543c19000242a654b481cee7c2cd4d860e03315bf88c6d30a1f521993d785`.

Normalized bytes: 334. SHA-256: `edb9834687fc7f6f5ac221dec90c1d89f350dd9aca6e74efd7f3b3b5af50e224`.

````text
independent current-backend layer reference
"$REFERENCE_PYTHON" Tools/current_backend_reference.py --kind layers --out "$CURRENT_LAYERS"
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/current_backend_reference.py", line 35, in <module>
    import mlx.core as mx
ModuleNotFoundError: No module named 'mlx'
````

### vq-dense-overlay-acceptance-v1/verify-results/check-5.txt

Original bytes: 224. SHA-256: `a99239e5bab2b1aa6624f1b97fc25ff4cb218e0e8ab903b4d6229c38e21b99a0`.

Normalized bytes: 224. SHA-256: `a99239e5bab2b1aa6624f1b97fc25ff4cb218e0e8ab903b4d6229c38e21b99a0`.

````text
production layer parity against current backend
run_binary parity --tokens 9707,11,1246,525,498,30 --layers 2 --compare "$CURRENT_LAYERS"
Error: The file “layer_0.bin” couldn’t be opened because there is no such file.
````

### vq-dense-overlay-acceptance-v1/verify-results/check-6.txt

Original bytes: 83. SHA-256: `f004e9fdfdc5f1a7ecb88d5c2cbe6963c972bc4a07427b162e62bfa5808f68c1`.

Normalized bytes: 83. SHA-256: `f004e9fdfdc5f1a7ecb88d5c2cbe6963c972bc4a07427b162e62bfa5808f68c1`.

````text
8.1 GB cache output == 10 GB cache output
diff /tmp/ssv_big.txt /tmp/ssv_small.txt
````

### vq-dense-overlay-acceptance-v1/verify-results/check-7.txt

Original bytes: 414. SHA-256: `1d70f1b280e24ed34eae26d045d8fa3b10982e38f8b82f543a8d801d57e5a769`.

Normalized bytes: 414. SHA-256: `1d70f1b280e24ed34eae26d045d8fa3b10982e38f8b82f543a8d801d57e5a769`.

````text
grow/shrink/regrow byte-identical (elastic-check)
run_binary elastic-check --big-slots 960
engine ready in 0.6s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  baseline     (640 slots): 4.1s
  after grow   (960 slots): 2.8s
  after shrink (640 slots): 3.2s
  after regrow (800 slots): 2.9s
ELASTIC CHECK PASS: 4 generations byte-identical across 13→20→13→16 experts/layer
````

### vq-dense-overlay-acceptance-v1/verify-results/check-8.txt

Original bytes: 1145. SHA-256: `88166adaa38e3b27c4921f352b07e97b51c29226cc18ecf4cb0fa0083e895765`.

Normalized bytes: 1145. SHA-256: `88166adaa38e3b27c4921f352b07e97b51c29226cc18ecf4cb0fa0083e895765`.

````text
prefix reuse, invalidation and live reply equality (prefix-check)
run_binary prefix-check
engine ready in 0.6s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  equivalence at 28 tokens: reuse 1.557% vs prefill-rechunk control 1.698% of logit spread, top-1 same
  equivalence at 100 tokens: reuse 3.808% vs prefill-rechunk control 3.649% of logit spread, top-1 same
  equivalence at 196 tokens: reuse 5.669% vs prefill-rechunk control 3.741% of logit spread, top-1 differs
  shed: retained 1411 tokens, dropped, next turn rebuilt 1436
  turn 1: 1409 prompt tok, 0 reused, prefill 13.48s -> Mars
  turn 2: 1436 prompt tok, 1280 reused, prefill 3.12s -> No
  turn 3: 1457 prompt tok, 1280 reused, prefill 3.35s -> Mars has a smaller diameter and mass than Ea
  historical rechunk bounds: diagnostic only; prefix-exact-check gates identical cold/warm logits
PREFIX CHECK PASS: historical cross-schedule drift 5.67% vs 3.74% for the rechunk control, top-1 2/3; 2 of 2 turns reused a prefix; cached and edited-history runs deterministic; follow-up prefill 25.74s -> 6.47s (0 of 3 replies differ from a cold rebuild)
````

### vq-dense-overlay-acceptance-v1/verify-results/check-9.txt

Original bytes: 1295. SHA-256: `373cd84a9ca60a94c2acd57c88f72daff423c8e6e383b0b2b53d90d751d29539`.

Normalized bytes: 1295. SHA-256: `373cd84a9ca60a94c2acd57c88f72daff423c8e6e383b0b2b53d90d751d29539`.

````text
a continued conversation equals a cold one (prefix-exact-check)
run_binary prefix-exact-check
engine ready in 0.7s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  pass size 256 tokens, aligned resume on
  long turn 1: 1521 prompt tok, reused 0, logit delta 0.000000%
  long turn 2: 1548 prompt tok, reused 1280, logit delta 0.000000%
  long turn 3: 1576 prompt tok, reused 1536, logit delta 0.000000%
  long turn 1 prefill: 13.93s cold, 13.33s continued (1521 of 1521 tokens read)
  long turn 2 prefill: 11.40s cold, 4.07s continued (268 of 1548 tokens read)
  long turn 3 prefill: 12.04s cold, 1.37s continued (40 of 1576 tokens read)
  repeat turn 1: 1521 prompt tok, reused 1521, logit delta 0.000000%
  short turn 1: 22 prompt tok, reused 0, logit delta 0.000000%
  short turn 2: 49 prompt tok, reused 0, logit delta 0.000000%
  short turn 3: 70 prompt tok, reused 0, logit delta 0.000000%
  shared prefix turn 1: 1520 prompt tok, reused 1280, logit delta 0.000000%
PREFIX EXACT CHECK PASS: every continued turn produced the same tokens and the same prompt logits as a cold read, 2 of 2 follow-up turns resumed a boundary state, an identical prompt reused its complete state, an edited history rebuilt, and a second conversation resumed the shared prefix
````

### vq-dense-overlay-acceptance-v1/verify-results/context-check.exit-status.txt

Original bytes: 2. SHA-256: `9a271f2a916b0b6ee6cecb2426f0b3206ef074578be55d9bc94f6f3fe3ab86aa`.

Normalized bytes: 2. SHA-256: `9a271f2a916b0b6ee6cecb2426f0b3206ef074578be55d9bc94f6f3fe3ab86aa`.

````text
0
````

### vq-dense-overlay-acceptance-v1/verify-results/context-check.stderr.txt

Original bytes: 1775. SHA-256: `b01135afa31220bb3867a520472e248e623bfc8c5f76dd4332d1e8ab78f05770`.

Normalized bytes: 1775. SHA-256: `b01135afa31220bb3867a520472e248e623bfc8c5f76dd4332d1e8ab78f05770`.

````text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (29.0 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~22 of 512 experts per layer  (1062 global slots = 2.9 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~4 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.9 GB expert cache at load; 6.1 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 2064 tokens per request (prompt + reply); a full-length prompt takes ~24 s before its first token here, follow-up turns read only what is new
  lookahead: on, expert prefetch in plain decode, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
  note:   prefill and prefix retention reservations match the explicit runtime controls
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.8s: expert cache ~22/512 per layer (1062 global slots = 2.9 GB), eos [248044, 248046]
  prefill: reading 2048 prompt tokens, ~24 s to the first token at this plan (follow-up turns read only what is new)
  prefill: 1792/2048 tokens (88%), 153 tok/s recently, ~2 s left at this rate
  prefill: done, 2048 tokens in 15 s (134 tok/s)
````

### vq-dense-overlay-acceptance-v1/verify-results/elastic-drill-small.txt

Original bytes: 1479. SHA-256: `be5954cfadf01978500dd7c7efb8a89fffba234e83976860ec68e0c873b6e24a`.

Normalized bytes: 1479. SHA-256: `be5954cfadf01978500dd7c7efb8a89fffba234e83976860ec68e0c873b6e24a`.

````text
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.7s: expert cache ~17/512 per layer (833 global slots = 2.3 GB), eos [248044, 248046]
  (machine has 16.4 GB reclaimable; drill capped at a 2.3 GB pool)
  start:  833 slots (~17/layer) -> Nile, Amazon, Mississippi
elastic: memory pressure (warning) — cache ~17 → ~13 experts/layer (2.3 → 1.8 GB pool, cold — refills from SSD)
  squeeze: 640 slots (~13/layer) -> Nile, Amazon, Mississippi
  recovery stimulus: 5.1 GB available -> 833 desired slots (0.5 GB growth)
  cooldown: held at 640 slots, as designed
  waiting out the 60 s grow cooldown...
elastic: memory freed — cache ~13 → ~17 experts/layer (1.8 → 2.3 GB pool, contents kept)
  recover: 833 slots (~17/layer) -> Nile, Amazon, Mississippi
ELASTIC DRILL MEMORY {"ceiling_gb":10,"complete":true,"lifetime_physical_footprint_peak_bytes":6755489264,"lifetime_rss_peak_bytes":6173458432,"output_ids":[[45,448,11,7919,11,27509],[45,448,11,7919,11,27509],[45,448,11,7919,11,27509]],"physical_footprint_end_bytes":5912253312,"sampled_peak_bytes":6755489264,"samples":3433,"swap_clean":true,"swapins_after":20,"swapins_before":20,"swapouts_after":2908,"swapouts_before":2908,"target_gb":10}
ELASTIC DRILL PASS: governor shrank under simulated pressure, honored the grow cooldown, grew back when memory returned, and every generation was byte-identical
````

### vq-dense-overlay-acceptance-v1/verify-results/elastic-drill.txt

Original bytes: 1478. SHA-256: `575b8de21399b81e284933cc6a72e6b13170560da281b320e8403299b76a3bd3`.

Normalized bytes: 1478. SHA-256: `575b8de21399b81e284933cc6a72e6b13170560da281b320e8403299b76a3bd3`.

````text
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.7s: expert cache ~35/512 per layer (1690 global slots = 4.7 GB), eos [248044, 248046]
  (machine has 19.2 GB reclaimable; drill capped at a 4.7 GB pool)
  start:  1690 slots (~35/layer) -> Nile, Amazon, Mississippi
elastic: availability dropped — cache ~35 → ~16 experts/layer (4.7 → 2.1 GB pool, cold — refills from SSD)
  squeeze: 764 slots (~16/layer) -> Nile, Amazon, Mississippi
  recovery stimulus: 7.8 GB available -> 1690 desired slots (2.6 GB growth)
  cooldown: held at 764 slots, as designed
  waiting out the 60 s grow cooldown...
elastic: memory freed — cache ~16 → ~35 experts/layer (2.1 → 4.7 GB pool, contents kept)
  recover: 1690 slots (~35/layer) -> Nile, Amazon, Mississippi
ELASTIC DRILL MEMORY {"ceiling_gb":13,"complete":true,"lifetime_physical_footprint_peak_bytes":9585380592,"lifetime_rss_peak_bytes":7067680768,"output_ids":[[45,448,11,7919,11,27509],[45,448,11,7919,11,27509],[45,448,11,7919,11,27509]],"physical_footprint_end_bytes":8362646032,"sampled_peak_bytes":9502707408,"samples":3503,"swap_clean":true,"swapins_after":20,"swapins_before":20,"swapouts_after":2908,"swapouts_before":2908,"target_gb":13}
ELASTIC DRILL PASS: governor shrank under simulated pressure, honored the grow cooldown, grew back when memory returned, and every generation was byte-identical
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/first-command.json

Original bytes: 431. SHA-256: `b2bea1f783701e91c6d0b2650e23140364a146ee706d66785ed4f26db2c2a3b1`.

Normalized bytes: 417. SHA-256: `45bce9a94cc529520a216bf37f0c795c500b812253f6b77c4fda8906eea4328c`.

````text
[
  "<HOME>/Projects/slotstream/.build/quantization-research/frozen-dense-overlay-v2/slotstream",
  "serve",
  "--memory-gb",
  "8.1",
  "--max-context",
  "32768",
  "--vision",
  "off",
  "--mtp",
  "off",
  "--port",
  "51176",
  "--prefix-cache-dir",
  "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix",
  "--prefix-cache-min-tokens",
  "512"
]
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/first-server.log

Original bytes: 12296. SHA-256: `a631da7e1cb6f0689d36e3b0057de8ef1747e3623f1cd4380ff2e94f3347e995`.

Normalized bytes: 12289. SHA-256: `d9d36bbd3b751fd7d8f9ebd9896ad738343ee445624c09d4a517ea13f98e9d5f`.

````text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (28.4 GB reclaimable now), 40.2 GB Metal working set
  target: 8.1 GB total process budget, not a RAM usage goal
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  plan:   ~7.9 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 1.8 GB expert cache at load; 6.2 GB allowed for runtime, context and workspace; 0.2 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 6510 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.8s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
prefix cache disk: <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix holds 0 states (0.00 GB of 20.00 GB); writes states of 512 tokens or more; forgets states unused for 30 days
elastic: off — an explicit size is pinned; omit the size flag for elastic auto
slotstream listening on http://127.0.0.1:51176
try it:
  curl localhost:51176/api/chat -d '{"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "hello"}]}'
or point any Ollama or OpenAI client at http://localhost:51176
[7:38:27 AM] request 5C60FC4C /v1/chat/completions: accepted
prefix cache: miss: no retained state (0 prior evictions)
[7:38:42 AM] request 5C60FC4C /v1/chat/completions: 15 s elapsed, decode cache growth
[7:38:47 AM] request 5C60FC4C /v1/chat/completions: ended after 19.5 s
[7:38:47 AM] request DF0043AE /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:38:52 AM] prefill: reading 275 prompt tokens, ~3 s to the first token at this plan (follow-up turns read only what is new)
[7:38:52 AM] prefill: done, 275 tokens in 5 s (51 tok/s)
[7:39:02 AM] request DF0043AE /v1/chat/completions: 15 s elapsed, decode cache growth
[7:39:10 AM] request DF0043AE /v1/chat/completions: ended after 23.2 s
[7:39:10 AM] request 150811D2 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:39:15 AM] prefill: reading 269 prompt tokens, ~3 s to the first token at this plan (follow-up turns read only what is new)
[7:39:15 AM] prefill: done, 269 tokens in 5 s (53 tok/s)
[7:39:15 AM] request 150811D2 /v1/chat/completions: ended after 5.2 s
[7:39:15 AM] request 2021B4BE /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:39:20 AM] prefill: reading 289 prompt tokens, ~3 s to the first token at this plan (follow-up turns read only what is new)
[7:39:20 AM] prefill: done, 289 tokens in 5 s (55 tok/s)
[7:39:30 AM] request 2021B4BE /v1/chat/completions: 15 s elapsed, decode cache growth
[7:39:45 AM] request 2021B4BE /v1/chat/completions: 30 s elapsed, decode cache growth
[7:39:53 AM] request 2021B4BE /v1/chat/completions: ended after 37.6 s
[7:39:53 AM] request FC2CBF3F /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:39:58 AM] prefill: reading 292 prompt tokens, ~3 s to the first token at this plan (follow-up turns read only what is new)
[7:39:58 AM] prefill: done, 292 tokens in 5 s (55 tok/s)
[7:40:08 AM] request FC2CBF3F /v1/chat/completions: 15 s elapsed, decode cache growth
[7:40:23 AM] request FC2CBF3F /v1/chat/completions: 30 s elapsed, decode cache growth
[7:40:31 AM] request FC2CBF3F /v1/chat/completions: ended after 38.0 s
[7:40:31 AM] request 5DB82391 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:40:36 AM] prefill: reading 1526 prompt tokens, ~18 s to the first token at this plan (follow-up turns read only what is new)
[7:40:36 AM] prefill: 512/1526 tokens (34%), 94 tok/s recently, ~11 s left at this rate
[7:40:39 AM] prefix cache disk: saved shared 768-token prefix (136.9 MB written) in 0.05 s
[7:40:41 AM] prefill: 1024/1526 tokens (67%), 99 tok/s recently, ~5 s left at this rate
[7:40:44 AM] prefix cache disk: saved 1280 tokens (129.8 MB written, 21.2 MB of rows reused) in 0.05 s
[7:40:46 AM] request 5DB82391 /v1/chat/completions: 15 s elapsed, prefill pass
[7:40:47 AM] prefill: done, 1526 tokens in 17 s (91 tok/s)
[7:40:54 AM] request 5DB82391 /v1/chat/completions: ended after 23.1 s
[7:40:54 AM] request DEB50CEA /v1/chat/completions: accepted
prefix cache: reusing 768/1976 tokens from memory
[7:40:56 AM] prefix cache disk: saved shared 1024-token prefix (122.8 MB written, 21.2 MB of rows reused) in 0.05 s
[7:40:59 AM] prefill: reading 1208 prompt tokens, ~14 s to the first token at this plan (follow-up turns read only what is new)
[7:40:59 AM] prefill: 512/1208 tokens (42%), 93 tok/s recently, ~7 s left at this rate
[7:41:04 AM] prefix cache disk: saved 1792 tokens (136.9 MB written, 28.3 MB of rows reused) in 0.04 s
[7:41:06 AM] prefill: done, 1208 tokens in 13 s (95 tok/s)
[7:41:09 AM] request DEB50CEA /v1/chat/completions: 15 s elapsed, decode cache growth
[7:41:14 AM] request DEB50CEA /v1/chat/completions: ended after 19.8 s
[7:41:14 AM] request 4F6C48CA /v1/chat/completions: accepted
[7:41:14 AM] prefix cache disk: restored 1280 tokens (151.0 MB) in 0.03 s
prefix cache: reusing 1280/1597 tokens from disk
[7:41:16 AM] prefix cache disk: saved 1536 tokens (122.8 MB written, 35.4 MB of rows reused) in 0.03 s
[7:41:22 AM] request 4F6C48CA /v1/chat/completions: ended after 7.9 s
[7:41:22 AM] request 45079377 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:41:28 AM] prefill: reading 1029 prompt tokens, ~12 s to the first token at this plan (follow-up turns read only what is new)
[7:41:28 AM] prefill: 512/1029 tokens (50%), 85 tok/s recently, ~6 s left at this rate
[7:41:30 AM] prefix cache disk: saved shared 768-token prefix (136.9 MB written) in 0.03 s
[7:41:33 AM] prefix cache disk: saved 1024 tokens (122.8 MB written, 21.2 MB of rows reused) in 0.03 s
[7:41:33 AM] prefill: 1024/1029 tokens (100%), 93 tok/s recently, ~0 s left at this rate
[7:41:34 AM] prefill: done, 1029 tokens in 12 s (86 tok/s)
[7:41:37 AM] request 45079377 /v1/chat/completions: 15 s elapsed, decode cache growth
[7:41:37 AM] request 45079377 /v1/chat/completions: ended after 15.8 s
[7:41:37 AM] request 79624E14 /v1/chat/completions: accepted
[7:41:37 AM] prefix cache disk: restored 1024 tokens (144.0 MB) in 0.02 s
prefix cache: reusing 1024/1603 tokens from disk
[7:41:43 AM] prefix cache disk: saved 1536 tokens (129.8 MB written, 28.3 MB of rows reused) in 0.03 s
[7:41:43 AM] prefill: reading 579 prompt tokens, ~7 s to the first token at this plan (follow-up turns read only what is new)
[7:41:43 AM] prefill: 512/579 tokens (88%), 95 tok/s recently, ~1 s left at this rate
[7:41:45 AM] prefill: done, 579 tokens in 7 s (81 tok/s)
[7:41:48 AM] request 79624E14 /v1/chat/completions: ended after 11.1 s
[7:41:48 AM] request 4F3537F6 /v1/chat/completions: accepted
[7:41:49 AM] prefix cache disk: restored 1536 tokens (158.1 MB) in 0.03 s
prefix cache: reusing 1536/1654 tokens from disk
[7:41:55 AM] request 4F3537F6 /v1/chat/completions: ended after 6.5 s
[7:41:55 AM] request C6C27E3A /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:41:56 AM] request F93899F5 /v1/chat/completions: accepted
[7:41:56 AM] stream ended: socket write failed or timed out; 244/388 accepted bytes written
[7:41:56 AM] request C6C27E3A /v1/chat/completions: ended after 1.1 s, client_cancelled
prefix cache: miss: no retained state (20 prior evictions)
[7:41:57 AM] request F93899F5 /v1/chat/completions: ended after 1.1 s
[7:41:57 AM] request B9C2BC12 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:42:02 AM] prefill: reading 292 prompt tokens, ~3 s to the first token at this plan (follow-up turns read only what is new)
[7:42:02 AM] prefill: done, 292 tokens in 5 s (55 tok/s)
[7:42:07 AM] request B9C2BC12 /v1/chat/completions: ended after 10.4 s
[7:42:07 AM] request 31C37EF4 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:42:13 AM] prefill: reading 365 prompt tokens, ~4 s to the first token at this plan (follow-up turns read only what is new)
[7:42:13 AM] prefill: done, 365 tokens in 6 s (62 tok/s)
[7:42:14 AM] request 31C37EF4 /v1/chat/completions: ended after 7.0 s
[7:42:14 AM] request F15FE0F7 /v1/chat/completions: accepted
prefix cache: reusing 256/292 tokens from memory
[7:42:21 AM] request F15FE0F7 /v1/chat/completions: ended after 6.4 s
[7:42:21 AM] request AAD5B03A /v1/chat/completions: accepted
prefix cache: reusing 256/365 tokens from memory
[7:42:24 AM] request AAD5B03A /v1/chat/completions: ended after 3.5 s
[7:42:24 AM] request 36798866 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:42:30 AM] prefill: reading 303 prompt tokens, ~4 s to the first token at this plan (follow-up turns read only what is new)
[7:42:30 AM] prefill: done, 303 tokens in 6 s (55 tok/s)
[7:42:35 AM] request 36798866 /v1/chat/completions: ended after 10.5 s
[7:42:35 AM] request 69241BC8 /v1/chat/completions: accepted
prefix cache: reusing 256/309 tokens from memory
[7:42:49 AM] request 69241BC8 /v1/chat/completions: ended after 13.7 s
[7:42:49 AM] request 972CF902 /v1/chat/completions: accepted
prefix cache: reusing 256/457 tokens from memory
[7:42:55 AM] request 972CF902 /v1/chat/completions: ended after 6.4 s
[7:42:55 AM] request 4BAD19E2 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:42:56 AM] request 4BAD19E2 /v1/chat/completions: ended after 0.9 s
[7:42:56 AM] request BAF72332 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:42:58 AM] request BAF72332 /v1/chat/completions: ended after 2.2 s
[7:42:58 AM] request 29E44340 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:03 AM] request 29E44340 /v1/chat/completions: ended after 5.3 s
[7:43:03 AM] request 230EE6A9 /v1/chat/completions: accepted
[7:43:03 AM] request 230EE6A9 /v1/chat/completions: ended after 0.0 s
[7:43:03 AM] request BDEB0D0C /v1/chat/completions: accepted
[7:43:03 AM] request BDEB0D0C /v1/chat/completions: ended after 0.0 s
[7:43:03 AM] request E7D459BB /v1/chat/completions: accepted
[7:43:03 AM] request E7D459BB /v1/chat/completions: ended after 0.0 s
[7:43:03 AM] request B66655C1 /v1/chat/completions: accepted
[7:43:03 AM] request B66655C1 /v1/chat/completions: ended after 0.0 s
[7:43:03 AM] request 79FDCFCD /v1/chat/completions: accepted
[7:43:03 AM] request 79FDCFCD /v1/chat/completions: ended after 0.0 s
[7:43:03 AM] request F8267285 /v1/chat/completions: accepted
[7:43:03 AM] request F8267285 /v1/chat/completions: ended after 0.0 s
[7:43:03 AM] request AEC21486 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:08 AM] request AEC21486 /v1/chat/completions: ended after 4.9 s
[7:43:08 AM] request 58B8F263 /v1/chat/completions: accepted
prefix cache: reusing 256/293 tokens from memory
[7:43:10 AM] request 58B8F263 /v1/chat/completions: ended after 1.4 s
[7:43:10 AM] request F93DA657 /v1/chat/completions: accepted
[7:43:10 AM] request F93DA657 /v1/chat/completions: ended after 0.0 s
[7:43:10 AM] stopping: asked to stop (SIGTERM)
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/after-disconnect.json

Original bytes: 471. SHA-256: `3dbc74fa85935fcd37e23e55a628519ae06ad3b34f700319fb76cf0c1c3b28dc`.

Normalized bytes: 471. SHA-256: `3dbc74fa85935fcd37e23e55a628519ae06ad3b34f700319fb76cf0c1c3b28dc`.

````text
{
  "model": "qwen3.8-flash-next:4bit",
  "choices": [
    {
      "message": {
        "content": "OK",
        "role": "assistant"
      },
      "index": 0,
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "completion_tokens": 1,
    "total_tokens": 16,
    "prompt_tokens_details": {
      "cached_tokens": 0
    },
    "prompt_tokens": 15
  },
  "id": "chatcmpl-8B2F1F3F-005F-4DBE-91B6-B7A3BF655C8E",
  "object": "chat.completion",
  "created": 1791031316
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/branch-alpha-followup.json

Original bytes: 15839. SHA-256: `6e2e7657663b5d714b9cae54cab9d3afca2d1bc920e3208bf826a59276c2c3db`.

Normalized bytes: 15839. SHA-256: `6e2e7657663b5d714b9cae54cab9d3afca2d1bc920e3208bf826a59276c2c3db`.

````text
{
  "name": "branch-alpha-followup",
  "request": {
    "model": "qwen3.8-flash-next:4bit",
    "temperature": 0,
    "seed": 42,
    "stream": true,
    "stream_options": {
      "include_usage": true
    },
    "max_tokens": 256,
    "messages": [
      {
        "role": "system",
        "content": "Reference: Station 0 records tides and wind. Station 1 records tides and wind. Station 2 records tides and wind. Station 3 records tides and wind. Station 4 records tides and wind. Station 5 records tides and wind. Station 6 records tides and wind. Station 7 records tides and wind. Station 8 records tides and wind. Station 9 records tides and wind. Station 10 records tides and wind. Station 11 records tides and wind. Station 12 records tides and wind. Station 13 records tides and wind. Station 14 records tides and wind. Station 15 records tides and wind. Station 16 records tides and wind. Station 17 records tides and wind. Station 18 records tides and wind. Station 19 records tides and wind. Station 20 records tides and wind. Station 21 records tides and wind. Station 22 records tides and wind. Station 23 records tides and wind. Station 24 records tides and wind. Station 25 records tides and wind. Station 26 records tides and wind. Station 27 records tides and wind. Station 28 records tides and wind. Station 29 records tides and wind. Station 30 records tides and wind. Station 31 records tides and wind. Station 32 records tides and wind. Station 33 records tides and wind. Station 34 records tides and wind. Station 35 records tides and wind. Station 36 records tides and wind. Station 37 records tides and wind. Station 38 records tides and wind. Station 39 records tides and wind. Station 40 records tides and wind. Station 41 records tides and wind. Station 42 records tides and wind. Station 43 records tides and wind. Station 44 records tides and wind. Station 45 records tides and wind. Station 46 records tides and wind. Station 47 records tides and wind. Station 48 records tides and wind. Station 49 records tides and wind. Station 50 records tides and wind. Station 51 records tides and wind. Station 52 records tides and wind. Station 53 records tides and wind. Station 54 records tides and wind. Station 55 records tides and wind. Station 56 records tides and wind. Station 57 records tides and wind. Station 58 records tides and wind. Station 59 records tides and wind. Station 60 records tides and wind. Station 61 records tides and wind. Station 62 records tides and wind. Station 63 records tides and wind. Station 64 records tides and wind. Station 65 records tides and wind. Station 66 records tides and wind. Station 67 records tides and wind. Station 68 records tides and wind. Station 69 records tides and wind. Station 70 records tides and wind. Station 71 records tides and wind. Station 72 records tides and wind. Station 73 records tides and wind. Station 74 records tides and wind. Station 75 records tides and wind. Station 76 records tides and wind. Station 77 records tides and wind. Station 78 records tides and wind. Station 79 records tides and wind. Station 80 records tides and wind. Station 81 records tides and wind. Station 82 records tides and wind. Station 83 records tides and wind. Station 84 records tides and wind. Station 85 records tides and wind. Station 86 records tides and wind. Station 87 records tides and wind. Station 88 records tides and wind. Station 89 records tides and wind. Station 90 records tides and wind. Station 91 records tides and wind. Station 92 records tides and wind. Station 93 records tides and wind. Station 94 records tides and wind. Station 95 records tides and wind. Station 96 records tides and wind. Station 97 records tides and wind. Station 98 records tides and wind. Station 99 records tides and wind."
      },
      {
        "role": "user",
        "content": "Name a color."
      },
      {
        "role": "assistant",
        "content": "Blue."
      },
      {
        "role": "user",
        "content": "Additional reference: The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. What is 2+2? Answer briefly."
      },
      {
        "role": "assistant",
        "content": "4"
      },
      {
        "role": "user",
        "content": "What is 4+4? Answer briefly."
      }
    ],
    "reasoning_effort": "low"
  },
  "status": 200,
  "seconds": 7.914701415999986,
  "arrivals": [
    4.8366795000000025,
    4.9595256659999905,
    5.069914249999982,
    5.1939394579999885,
    5.322874790999975,
    5.444460874999976,
    5.5823477909999895,
    5.7143401659999995,
    5.856507124999979,
    5.999001332999995,
    6.133261540999996,
    6.259475915999985,
    6.382272374999985,
    6.525748374999978,
    6.662990957999995,
    6.818701874999988,
    6.950695040999989,
    7.093947790999977,
    7.243886082999978,
    7.382170540999994,
    7.513343124999977,
    7.763399124999978,
    7.914663540999982,
    7.914682583000001
  ],
  "events": [
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "T",
            "role": "assistant"
          },
          "index": 0
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "he "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "user is"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": " a"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "sking a"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": " simp"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "le math q"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "u"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "e"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "s"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "t"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "i"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "o"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "n: 4"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "+4. The"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": " an"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "s"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "w"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "e"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "r"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": " is 8.\n"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "8"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031274
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-B4BA8C40-2E50-4807-903C-63AA6CF41EB4",
      "choices": [
        {
          "index": 0,
          "delta": {},
          "finish_reason": "stop"
        }
      ],
      "object": "chat.completion.chunk",
      "usage": {
        "completion_tokens": 24,
        "total_tokens": 1621,
        "prompt_tokens_details": {
          "cached_tokens": 1280
        },
        "prompt_tokens": 1597
      },
      "created": 1791031274
    },
    "[DONE]"
  ]
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/branch-alpha-seed.json

Original bytes: 25383. SHA-256: `a0554c5beb1b5586700b31efabc0f08f11e1ca9c26c080577b0e4c193c99ea40`.

Normalized bytes: 25383. SHA-256: `a0554c5beb1b5586700b31efabc0f08f11e1ca9c26c080577b0e4c193c99ea40`.

````text
{
  "name": "branch-alpha-seed",
  "request": {
    "model": "qwen3.8-flash-next:4bit",
    "temperature": 0,
    "seed": 42,
    "stream": true,
    "stream_options": {
      "include_usage": true
    },
    "max_tokens": 256,
    "messages": [
      {
        "role": "system",
        "content": "Reference: Station 0 records tides and wind. Station 1 records tides and wind. Station 2 records tides and wind. Station 3 records tides and wind. Station 4 records tides and wind. Station 5 records tides and wind. Station 6 records tides and wind. Station 7 records tides and wind. Station 8 records tides and wind. Station 9 records tides and wind. Station 10 records tides and wind. Station 11 records tides and wind. Station 12 records tides and wind. Station 13 records tides and wind. Station 14 records tides and wind. Station 15 records tides and wind. Station 16 records tides and wind. Station 17 records tides and wind. Station 18 records tides and wind. Station 19 records tides and wind. Station 20 records tides and wind. Station 21 records tides and wind. Station 22 records tides and wind. Station 23 records tides and wind. Station 24 records tides and wind. Station 25 records tides and wind. Station 26 records tides and wind. Station 27 records tides and wind. Station 28 records tides and wind. Station 29 records tides and wind. Station 30 records tides and wind. Station 31 records tides and wind. Station 32 records tides and wind. Station 33 records tides and wind. Station 34 records tides and wind. Station 35 records tides and wind. Station 36 records tides and wind. Station 37 records tides and wind. Station 38 records tides and wind. Station 39 records tides and wind. Station 40 records tides and wind. Station 41 records tides and wind. Station 42 records tides and wind. Station 43 records tides and wind. Station 44 records tides and wind. Station 45 records tides and wind. Station 46 records tides and wind. Station 47 records tides and wind. Station 48 records tides and wind. Station 49 records tides and wind. Station 50 records tides and wind. Station 51 records tides and wind. Station 52 records tides and wind. Station 53 records tides and wind. Station 54 records tides and wind. Station 55 records tides and wind. Station 56 records tides and wind. Station 57 records tides and wind. Station 58 records tides and wind. Station 59 records tides and wind. Station 60 records tides and wind. Station 61 records tides and wind. Station 62 records tides and wind. Station 63 records tides and wind. Station 64 records tides and wind. Station 65 records tides and wind. Station 66 records tides and wind. Station 67 records tides and wind. Station 68 records tides and wind. Station 69 records tides and wind. Station 70 records tides and wind. Station 71 records tides and wind. Station 72 records tides and wind. Station 73 records tides and wind. Station 74 records tides and wind. Station 75 records tides and wind. Station 76 records tides and wind. Station 77 records tides and wind. Station 78 records tides and wind. Station 79 records tides and wind. Station 80 records tides and wind. Station 81 records tides and wind. Station 82 records tides and wind. Station 83 records tides and wind. Station 84 records tides and wind. Station 85 records tides and wind. Station 86 records tides and wind. Station 87 records tides and wind. Station 88 records tides and wind. Station 89 records tides and wind. Station 90 records tides and wind. Station 91 records tides and wind. Station 92 records tides and wind. Station 93 records tides and wind. Station 94 records tides and wind. Station 95 records tides and wind. Station 96 records tides and wind. Station 97 records tides and wind. Station 98 records tides and wind. Station 99 records tides and wind."
      },
      {
        "role": "user",
        "content": "Name a color."
      },
      {
        "role": "assistant",
        "content": "Blue.",
        "reasoning_content": "I will select blue from the available colors."
      },
      {
        "role": "user",
        "content": "Additional reference: The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. The coastal station monitors tides and rainfall. What is 2+2? Answer briefly."
      }
    ],
    "reasoning_effort": "low"
  },
  "status": 200,
  "seconds": 23.088180709,
  "arrivals": [
    16.937390459,
    17.06341258399999,
    17.173986584000005,
    17.299911250000008,
    17.432441041999994,
    17.557571833999987,
    17.680593834000007,
    17.804343625,
    17.938111666999987,
    18.054691125000005,
    18.16885829199998,
    18.301723834,
    18.432490959000006,
    18.56198920899999,
    18.681585624999997,
    18.80972458400001,
    18.942796834000006,
    19.071350625000008,
    19.203257750000006,
    19.331953416999994,
    19.440479417000006,
    19.578371250000004,
    19.715944334,
    19.846683749999983,
    19.99203912499999,
    20.12417099999999,
    20.259530334000004,
    20.389632208999984,
    20.524187541999993,
    20.664602874999986,
    20.810692375000002,
    20.94348391699998,
    21.071728000000007,
    21.208387999999985,
    21.340687124999988,
    21.478750542,
    21.609467209,
    21.716830666999982,
    21.820732083999985,
    21.944945292,
    22.073324541999995,
    22.201903834000007,
    22.331772916999995,
    22.450814250000008,
    22.588862833999997,
    22.707499374999998,
    22.946210334,
    23.08814162499999,
    23.088161041999996
  ],
  "events": [
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "role": "assistant",
            "reasoning_content": "T"
          },
          "index": 0
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "he "
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "user is"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " a"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "skin"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "g \""
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "W"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "h"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "a"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "t"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " i"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "s 2+"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "2?\" an"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "d "
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "wants "
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "a brief"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " "
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "answ"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "er. The re"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "feren"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "ce tex"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "t about "
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "coastal s"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "tations mon"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "it"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "orin"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "g ti"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "des and r"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "ain"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "fall is irr"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "ele"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "vant"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " to t"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "he math q"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "u"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "es"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "tio"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "n. I'"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "ll just"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " ans"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "wer t"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "he math q"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "uestion d"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "i"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "r"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "ectly.\n"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "4"
          }
        }
      ],
      "created": 1791031231
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-2A240F1A-4666-4914-84B9-C235D297052B",
      "choices": [
        {
          "index": 0,
          "finish_reason": "stop",
          "delta": {}
        }
      ],
      "object": "chat.completion.chunk",
      "usage": {
        "completion_tokens": 49,
        "total_tokens": 1575,
        "prompt_tokens_details": {
          "cached_tokens": 0
        },
        "prompt_tokens": 1526
      },
      "created": 1791031231
    },
    "[DONE]"
  ]
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/branch-beta-seed.json

Original bytes: 29755. SHA-256: `dbb79737f6b0221615406f87cac4ec611724827eda4601bedf03440361869162`.

Normalized bytes: 29755. SHA-256: `dbb79737f6b0221615406f87cac4ec611724827eda4601bedf03440361869162`.

````text
{
  "name": "branch-beta-seed",
  "request": {
    "model": "qwen3.8-flash-next:4bit",
    "temperature": 0,
    "seed": 42,
    "stream": true,
    "stream_options": {
      "include_usage": true
    },
    "max_tokens": 256,
    "messages": [
      {
        "role": "system",
        "content": "Reference: Station 0 records tides and wind. Station 1 records tides and wind. Station 2 records tides and wind. Station 3 records tides and wind. Station 4 records tides and wind. Station 5 records tides and wind. Station 6 records tides and wind. Station 7 records tides and wind. Station 8 records tides and wind. Station 9 records tides and wind. Station 10 records tides and wind. Station 11 records tides and wind. Station 12 records tides and wind. Station 13 records tides and wind. Station 14 records tides and wind. Station 15 records tides and wind. Station 16 records tides and wind. Station 17 records tides and wind. Station 18 records tides and wind. Station 19 records tides and wind. Station 20 records tides and wind. Station 21 records tides and wind. Station 22 records tides and wind. Station 23 records tides and wind. Station 24 records tides and wind. Station 25 records tides and wind. Station 26 records tides and wind. Station 27 records tides and wind. Station 28 records tides and wind. Station 29 records tides and wind. Station 30 records tides and wind. Station 31 records tides and wind. Station 32 records tides and wind. Station 33 records tides and wind. Station 34 records tides and wind. Station 35 records tides and wind. Station 36 records tides and wind. Station 37 records tides and wind. Station 38 records tides and wind. Station 39 records tides and wind. Station 40 records tides and wind. Station 41 records tides and wind. Station 42 records tides and wind. Station 43 records tides and wind. Station 44 records tides and wind. Station 45 records tides and wind. Station 46 records tides and wind. Station 47 records tides and wind. Station 48 records tides and wind. Station 49 records tides and wind. Station 50 records tides and wind. Station 51 records tides and wind. Station 52 records tides and wind. Station 53 records tides and wind. Station 54 records tides and wind. Station 55 records tides and wind. Station 56 records tides and wind. Station 57 records tides and wind. Station 58 records tides and wind. Station 59 records tides and wind. Station 60 records tides and wind. Station 61 records tides and wind. Station 62 records tides and wind. Station 63 records tides and wind. Station 64 records tides and wind. Station 65 records tides and wind. Station 66 records tides and wind. Station 67 records tides and wind. Station 68 records tides and wind. Station 69 records tides and wind. Station 70 records tides and wind. Station 71 records tides and wind. Station 72 records tides and wind. Station 73 records tides and wind. Station 74 records tides and wind. Station 75 records tides and wind. Station 76 records tides and wind. Station 77 records tides and wind. Station 78 records tides and wind. Station 79 records tides and wind. Station 80 records tides and wind. Station 81 records tides and wind. Station 82 records tides and wind. Station 83 records tides and wind. Station 84 records tides and wind. Station 85 records tides and wind. Station 86 records tides and wind. Station 87 records tides and wind. Station 88 records tides and wind. Station 89 records tides and wind. Station 90 records tides and wind. Station 91 records tides and wind. Station 92 records tides and wind. Station 93 records tides and wind. Station 94 records tides and wind. Station 95 records tides and wind. Station 96 records tides and wind. Station 97 records tides and wind. Station 98 records tides and wind. Station 99 records tides and wind."
      },
      {
        "role": "user",
        "content": "Name a color."
      },
      {
        "role": "assistant",
        "content": "Green.",
        "reasoning_content": "I will select green from the available colors."
      },
      {
        "role": "user",
        "content": "Additional reference: The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. The coastal station monitors tides, rainfall and wind direction. What is 3+3? Answer briefly."
      }
    ],
    "reasoning_effort": "low"
  },
  "status": 200,
  "seconds": 19.800352750000002,
  "arrivals": [
    12.856013667000013,
    12.984015625000012,
    13.092648416999992,
    13.209652000000006,
    13.349173707999995,
    13.476829083000013,
    13.602015375000008,
    13.730920832999999,
    13.870982457999986,
    13.99405333300001,
    14.111930666999996,
    14.247860542000012,
    14.378643833000012,
    14.508775332999988,
    14.631840957999998,
    14.759006707999987,
    14.891975666999997,
    15.023438207999988,
    15.156113041999987,
    15.286142417000008,
    15.410933957999987,
    15.521154416999991,
    15.679525541999993,
    15.816256750000008,
    15.950101292,
    16.114041625,
    16.24617325,
    16.381062625,
    16.515743958,
    16.651368917000013,
    16.800295457999994,
    16.929826875000003,
    17.065091792000004,
    17.188321333000005,
    17.323092000000003,
    17.465025458000014,
    17.59033875,
    17.720129625,
    17.855782041999987,
    17.987706250000002,
    18.127540874999994,
    18.261021457999988,
    18.367892541999993,
    18.471808917000004,
    18.595506999999998,
    18.728185792000005,
    18.850353291999994,
    18.98510091700001,
    19.118449707999986,
    19.262056916999995,
    19.387697417,
    19.643528583000005,
    19.800314458000003,
    19.80033445800001
  ],
  "events": [
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "T",
            "role": "assistant"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "he "
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "user is"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": " a"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "skin"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "g \""
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "W"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "h"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "a"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "t"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": " i"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "s 3+"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "3?\" an"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "d "
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "wants "
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": "a brief"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "reasoning_content": " "
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "answ"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "er. The r"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "epeated re"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "feren"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "ce tex"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "t about "
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "coastal s"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "tations mon"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "it"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "orin"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "g"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": " tides, r"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "a"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "infa"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "ll, a"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "nd wind di"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "rec"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "tion is irr"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "ele"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "vant"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": " to t"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "he math q"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "u"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "es"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "tio"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "n. I'"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "ll just"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": " ans"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "wer the"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": " simple ari"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "thmetic q"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "u"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "e"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "reasoning_content": "stion.\n"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "choices": [
        {
          "delta": {
            "content": "6"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031254
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-E66B7C6D-AB91-4D54-90D3-3982551CC3DA",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "delta": {},
          "index": 0,
          "finish_reason": "stop"
        }
      ],
      "created": 1791031254,
      "usage": {
        "prompt_tokens_details": {
          "cached_tokens": 768
        },
        "total_tokens": 2030,
        "prompt_tokens": 1976,
        "completion_tokens": 54
      }
    },
    "[DONE]"
  ]
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/cache-turn-1.json

Original bytes: 15421. SHA-256: `93661b14ff92abe7741b874e212830fe559d73c58d83ef816b1d03a1fb03ad2e`.

Normalized bytes: 15421. SHA-256: `93661b14ff92abe7741b874e212830fe559d73c58d83ef816b1d03a1fb03ad2e`.

````text
{
  "name": "cache-turn-1",
  "request": {
    "model": "qwen3.8-flash-next:4bit",
    "temperature": 0,
    "seed": 42,
    "stream": true,
    "stream_options": {
      "include_usage": true
    },
    "max_tokens": 256,
    "messages": [
      {
        "role": "system",
        "content": "Retain this document for the conversation. Record 0: the coastal station measures tides and wind. Record 1: the coastal station measures tides and wind. Record 2: the coastal station measures tides and wind. Record 3: the coastal station measures tides and wind. Record 4: the coastal station measures tides and wind. Record 5: the coastal station measures tides and wind. Record 6: the coastal station measures tides and wind. Record 7: the coastal station measures tides and wind. Record 8: the coastal station measures tides and wind. Record 9: the coastal station measures tides and wind. Record 10: the coastal station measures tides and wind. Record 11: the coastal station measures tides and wind. Record 12: the coastal station measures tides and wind. Record 13: the coastal station measures tides and wind. Record 14: the coastal station measures tides and wind. Record 15: the coastal station measures tides and wind. Record 16: the coastal station measures tides and wind. Record 17: the coastal station measures tides and wind. Record 18: the coastal station measures tides and wind. Record 19: the coastal station measures tides and wind. Record 20: the coastal station measures tides and wind. Record 21: the coastal station measures tides and wind. Record 22: the coastal station measures tides and wind. Record 23: the coastal station measures tides and wind. Record 24: the coastal station measures tides and wind. Record 25: the coastal station measures tides and wind. Record 26: the coastal station measures tides and wind. Record 27: the coastal station measures tides and wind. Record 28: the coastal station measures tides and wind. Record 29: the coastal station measures tides and wind. Record 30: the coastal station measures tides and wind. Record 31: the coastal station measures tides and wind. Record 32: the coastal station measures tides and wind. Record 33: the coastal station measures tides and wind. Record 34: the coastal station measures tides and wind. Record 35: the coastal station measures tides and wind. Record 36: the coastal station measures tides and wind. Record 37: the coastal station measures tides and wind. Record 38: the coastal station measures tides and wind. Record 39: the coastal station measures tides and wind. Record 40: the coastal station measures tides and wind. Record 41: the coastal station measures tides and wind. Record 42: the coastal station measures tides and wind. Record 43: the coastal station measures tides and wind. Record 44: the coastal station measures tides and wind. Record 45: the coastal station measures tides and wind. Record 46: the coastal station measures tides and wind. Record 47: the coastal station measures tides and wind. Record 48: the coastal station measures tides and wind. Record 49: the coastal station measures tides and wind. Record 50: the coastal station measures tides and wind. Record 51: the coastal station measures tides and wind. Record 52: the coastal station measures tides and wind. Record 53: the coastal station measures tides and wind. Record 54: the coastal station measures tides and wind. Record 55: the coastal station measures tides and wind. Record 56: the coastal station measures tides and wind. Record 57: the coastal station measures tides and wind. Record 58: the coastal station measures tides and wind. Record 59: the coastal station measures tides and wind. Record 60: the coastal station measures tides and wind. Record 61: the coastal station measures tides and wind. Record 62: the coastal station measures tides and wind. Record 63: the coastal station measures tides and wind. Record 64: the coastal station measures tides and wind. Record 65: the coastal station measures tides and wind. Record 66: the coastal station measures tides and wind. Record 67: the coastal station measures tides and wind. Record 68: the coastal station measures tides and wind. Record 69: the coastal station measures tides and wind."
      },
      {
        "role": "user",
        "content": "What is 2+2? Answer briefly."
      }
    ],
    "reasoning_effort": "low"
  },
  "status": 200,
  "seconds": 15.837544374999993,
  "arrivals": [
    12.129905499999978,
    12.257398832999996,
    12.378920874999977,
    12.501576,
    12.620839875000001,
    12.760709624999976,
    12.894146207999995,
    13.034133541999978,
    13.17134254199999,
    13.315863291999989,
    13.437682707999983,
    13.557262582999982,
    13.703530957999988,
    13.83866008299998,
    13.973170082999985,
    14.101796457999995,
    14.246898125000001,
    14.378353041999986,
    14.518887041999989,
    14.658979041999999,
    14.790195458,
    14.919945708,
    15.043592832999991,
    15.179355958000002,
    15.317143416999983,
    15.444821416999986,
    15.685907249999985,
    15.837502666999995,
    15.837521582999983
  ],
  "events": [
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "role": "assistant",
            "reasoning_content": "T"
          },
          "index": 0
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "he us"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "er"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " asks a"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " simp"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "le math q"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "u"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "e"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "s"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "t"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "i"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "o"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "n: 2"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "+2. The"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " an"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "s"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "w"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "e"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "r is "
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "4. Th"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "ey"
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " want "
          }
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "a brief"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": " "
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "a"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "nswer.\n"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "4"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031282
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-798D72C1-C834-4702-B3B1-E5DF66136308",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {},
          "finish_reason": "stop"
        }
      ],
      "created": 1791031282,
      "usage": {
        "prompt_tokens_details": {
          "cached_tokens": 0
        },
        "total_tokens": 1058,
        "prompt_tokens": 1029,
        "completion_tokens": 29
      }
    },
    "[DONE]"
  ]
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/cache-turn-2.json

Original bytes: 18192. SHA-256: `f0d9d1289863cb40cc60c71e2c3488b19a3a5e80f01c05c2e9c1212622d55f0a`.

Normalized bytes: 18192. SHA-256: `f0d9d1289863cb40cc60c71e2c3488b19a3a5e80f01c05c2e9c1212622d55f0a`.

````text
{
  "name": "cache-turn-2",
  "request": {
    "model": "qwen3.8-flash-next:4bit",
    "temperature": 0,
    "seed": 42,
    "stream": true,
    "stream_options": {
      "include_usage": true
    },
    "max_tokens": 256,
    "messages": [
      {
        "role": "system",
        "content": "Retain this document for the conversation. Record 0: the coastal station measures tides and wind. Record 1: the coastal station measures tides and wind. Record 2: the coastal station measures tides and wind. Record 3: the coastal station measures tides and wind. Record 4: the coastal station measures tides and wind. Record 5: the coastal station measures tides and wind. Record 6: the coastal station measures tides and wind. Record 7: the coastal station measures tides and wind. Record 8: the coastal station measures tides and wind. Record 9: the coastal station measures tides and wind. Record 10: the coastal station measures tides and wind. Record 11: the coastal station measures tides and wind. Record 12: the coastal station measures tides and wind. Record 13: the coastal station measures tides and wind. Record 14: the coastal station measures tides and wind. Record 15: the coastal station measures tides and wind. Record 16: the coastal station measures tides and wind. Record 17: the coastal station measures tides and wind. Record 18: the coastal station measures tides and wind. Record 19: the coastal station measures tides and wind. Record 20: the coastal station measures tides and wind. Record 21: the coastal station measures tides and wind. Record 22: the coastal station measures tides and wind. Record 23: the coastal station measures tides and wind. Record 24: the coastal station measures tides and wind. Record 25: the coastal station measures tides and wind. Record 26: the coastal station measures tides and wind. Record 27: the coastal station measures tides and wind. Record 28: the coastal station measures tides and wind. Record 29: the coastal station measures tides and wind. Record 30: the coastal station measures tides and wind. Record 31: the coastal station measures tides and wind. Record 32: the coastal station measures tides and wind. Record 33: the coastal station measures tides and wind. Record 34: the coastal station measures tides and wind. Record 35: the coastal station measures tides and wind. Record 36: the coastal station measures tides and wind. Record 37: the coastal station measures tides and wind. Record 38: the coastal station measures tides and wind. Record 39: the coastal station measures tides and wind. Record 40: the coastal station measures tides and wind. Record 41: the coastal station measures tides and wind. Record 42: the coastal station measures tides and wind. Record 43: the coastal station measures tides and wind. Record 44: the coastal station measures tides and wind. Record 45: the coastal station measures tides and wind. Record 46: the coastal station measures tides and wind. Record 47: the coastal station measures tides and wind. Record 48: the coastal station measures tides and wind. Record 49: the coastal station measures tides and wind. Record 50: the coastal station measures tides and wind. Record 51: the coastal station measures tides and wind. Record 52: the coastal station measures tides and wind. Record 53: the coastal station measures tides and wind. Record 54: the coastal station measures tides and wind. Record 55: the coastal station measures tides and wind. Record 56: the coastal station measures tides and wind. Record 57: the coastal station measures tides and wind. Record 58: the coastal station measures tides and wind. Record 59: the coastal station measures tides and wind. Record 60: the coastal station measures tides and wind. Record 61: the coastal station measures tides and wind. Record 62: the coastal station measures tides and wind. Record 63: the coastal station measures tides and wind. Record 64: the coastal station measures tides and wind. Record 65: the coastal station measures tides and wind. Record 66: the coastal station measures tides and wind. Record 67: the coastal station measures tides and wind. Record 68: the coastal station measures tides and wind. Record 69: the coastal station measures tides and wind."
      },
      {
        "role": "user",
        "content": "What is 2+2? Answer briefly."
      },
      {
        "role": "assistant",
        "content": "4"
      },
      {
        "role": "user",
        "content": "Additional background: The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. What is 3+3? Answer briefly."
      }
    ],
    "reasoning_effort": "low"
  },
  "status": 200,
  "seconds": 11.106037250000014,
  "arrivals": [
    7.37924320800002,
    7.502990333000014,
    7.622523333000004,
    7.740949792000009,
    7.855490833000005,
    7.986470292000007,
    8.112989458000015,
    8.258393958,
    8.400626541999998,
    8.54626916700002,
    8.673656875000006,
    8.797287124999997,
    8.939416417000018,
    9.07385854200001,
    9.206907000000001,
    9.337541167000012,
    9.482987625000021,
    9.61416433300002,
    9.749161958000002,
    9.88578158300001,
    10.009699624999996,
    10.146306875000022,
    10.282336041999997,
    10.445913625000003,
    10.575109125000012,
    10.70185466700002,
    10.954620917,
    11.105986083000005,
    11.106003958000002
  ],
  "events": [
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "role": "assistant",
            "reasoning_content": "T"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "he us"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "er"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " asks a"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " simp"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "le math q"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "u"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "e"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "s"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "t"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "i"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "o"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "n: 3"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "+3. The"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " an"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "s"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "w"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "e"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "r is "
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "6. Th"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "ey"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " want "
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "a brief"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": " "
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "a"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "reasoning_content": "nswer.\n"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "6"
          }
        }
      ],
      "created": 1791031297
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-66497F76-3CBE-4C71-B9CC-81AF856BA50A",
      "choices": [
        {
          "index": 0,
          "finish_reason": "stop",
          "delta": {}
        }
      ],
      "object": "chat.completion.chunk",
      "usage": {
        "completion_tokens": 29,
        "total_tokens": 1632,
        "prompt_tokens_details": {
          "cached_tokens": 1024
        },
        "prompt_tokens": 1603
      },
      "created": 1791031297
    },
    "[DONE]"
  ]
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/cache-turn-3.json

Original bytes: 18369. SHA-256: `5ceddf6bb66278a2019a54d30688b3f01cd0d3e653a6635daecb677fa981b21e`.

Normalized bytes: 18369. SHA-256: `5ceddf6bb66278a2019a54d30688b3f01cd0d3e653a6635daecb677fa981b21e`.

````text
{
  "name": "cache-turn-3",
  "request": {
    "model": "qwen3.8-flash-next:4bit",
    "temperature": 0,
    "seed": 42,
    "stream": true,
    "stream_options": {
      "include_usage": true
    },
    "max_tokens": 256,
    "messages": [
      {
        "role": "system",
        "content": "Retain this document for the conversation. Record 0: the coastal station measures tides and wind. Record 1: the coastal station measures tides and wind. Record 2: the coastal station measures tides and wind. Record 3: the coastal station measures tides and wind. Record 4: the coastal station measures tides and wind. Record 5: the coastal station measures tides and wind. Record 6: the coastal station measures tides and wind. Record 7: the coastal station measures tides and wind. Record 8: the coastal station measures tides and wind. Record 9: the coastal station measures tides and wind. Record 10: the coastal station measures tides and wind. Record 11: the coastal station measures tides and wind. Record 12: the coastal station measures tides and wind. Record 13: the coastal station measures tides and wind. Record 14: the coastal station measures tides and wind. Record 15: the coastal station measures tides and wind. Record 16: the coastal station measures tides and wind. Record 17: the coastal station measures tides and wind. Record 18: the coastal station measures tides and wind. Record 19: the coastal station measures tides and wind. Record 20: the coastal station measures tides and wind. Record 21: the coastal station measures tides and wind. Record 22: the coastal station measures tides and wind. Record 23: the coastal station measures tides and wind. Record 24: the coastal station measures tides and wind. Record 25: the coastal station measures tides and wind. Record 26: the coastal station measures tides and wind. Record 27: the coastal station measures tides and wind. Record 28: the coastal station measures tides and wind. Record 29: the coastal station measures tides and wind. Record 30: the coastal station measures tides and wind. Record 31: the coastal station measures tides and wind. Record 32: the coastal station measures tides and wind. Record 33: the coastal station measures tides and wind. Record 34: the coastal station measures tides and wind. Record 35: the coastal station measures tides and wind. Record 36: the coastal station measures tides and wind. Record 37: the coastal station measures tides and wind. Record 38: the coastal station measures tides and wind. Record 39: the coastal station measures tides and wind. Record 40: the coastal station measures tides and wind. Record 41: the coastal station measures tides and wind. Record 42: the coastal station measures tides and wind. Record 43: the coastal station measures tides and wind. Record 44: the coastal station measures tides and wind. Record 45: the coastal station measures tides and wind. Record 46: the coastal station measures tides and wind. Record 47: the coastal station measures tides and wind. Record 48: the coastal station measures tides and wind. Record 49: the coastal station measures tides and wind. Record 50: the coastal station measures tides and wind. Record 51: the coastal station measures tides and wind. Record 52: the coastal station measures tides and wind. Record 53: the coastal station measures tides and wind. Record 54: the coastal station measures tides and wind. Record 55: the coastal station measures tides and wind. Record 56: the coastal station measures tides and wind. Record 57: the coastal station measures tides and wind. Record 58: the coastal station measures tides and wind. Record 59: the coastal station measures tides and wind. Record 60: the coastal station measures tides and wind. Record 61: the coastal station measures tides and wind. Record 62: the coastal station measures tides and wind. Record 63: the coastal station measures tides and wind. Record 64: the coastal station measures tides and wind. Record 65: the coastal station measures tides and wind. Record 66: the coastal station measures tides and wind. Record 67: the coastal station measures tides and wind. Record 68: the coastal station measures tides and wind. Record 69: the coastal station measures tides and wind."
      },
      {
        "role": "user",
        "content": "What is 2+2? Answer briefly."
      },
      {
        "role": "assistant",
        "content": "4"
      },
      {
        "role": "user",
        "content": "Additional background: The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. The coastal station monitors tides, currents, wind and rainfall. What is 3+3? Answer briefly."
      },
      {
        "role": "assistant",
        "content": "6"
      },
      {
        "role": "user",
        "content": "What is 4+4? Answer briefly."
      }
    ],
    "reasoning_effort": "low"
  },
  "status": 200,
  "seconds": 6.502317125000019,
  "arrivals": [
    2.7216446250000104,
    2.844930459000011,
    2.9689938749999953,
    3.0956474170000092,
    3.2255768750000016,
    3.355839792000012,
    3.487721334000014,
    3.6165285419999975,
    3.755873500000007,
    3.8989015420000044,
    4.0350518749999935,
    4.172566958999994,
    4.314186917000001,
    4.4537645000000055,
    4.589882334000009,
    4.719876875000011,
    4.864491458999993,
    5.008663417000008,
    5.147211792000007,
    5.283464334000001,
    5.412638708999992,
    5.564761625000017,
    5.705170084000002,
    5.837100417000016,
    5.975636624999993,
    6.1014274169999965,
    6.3476969170000075,
    6.502278667000013,
    6.50229679200001
  ],
  "events": [
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "role": "assistant",
            "reasoning_content": "T"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "he us"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "er"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": " asks a"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": " simp"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "le math q"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "u"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "e"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "s"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "t"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "i"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "o"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "n: 4"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "+4. The"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": " an"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "s"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "w"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "e"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "r is "
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "8. Th"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "ey"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": " want "
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "a brief"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": " "
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "a"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "reasoning_content": "nswer.\n"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "8"
          },
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031308
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-7C765243-5935-4CA4-AA8A-6A7B186C8953",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {},
          "finish_reason": "stop"
        }
      ],
      "created": 1791031308,
      "usage": {
        "prompt_tokens_details": {
          "cached_tokens": 1536
        },
        "total_tokens": 1683,
        "prompt_tokens": 1654,
        "completion_tokens": 29
      }
    },
    "[DONE]"
  ]
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/large-allowance-unused-tools.json

Original bytes: 1865. SHA-256: `7dfd37c1d6511cee43cbbd7492eb28b47a4b5286e6cf73fe481ee25293ac0072`.

Normalized bytes: 1865. SHA-256: `7dfd37c1d6511cee43cbbd7492eb28b47a4b5286e6cf73fe481ee25293ac0072`.

````text
{
  "name": "large-allowance-unused-tools",
  "request": {
    "model": "qwen3.8-flash-next:4bit",
    "temperature": 0,
    "seed": 42,
    "stream": true,
    "stream_options": {
      "include_usage": true
    },
    "max_tokens": 16000,
    "messages": [
      {
        "role": "user",
        "content": "What is 2+2? Reply with just the number. Do not call tools."
      }
    ],
    "tools": [
      {
        "type": "function",
        "function": {
          "name": "save_page",
          "description": "Save text.",
          "parameters": {
            "type": "object",
            "properties": {
              "content": {
                "type": "string"
              }
            },
            "required": [
              "content"
            ]
          }
        }
      }
    ]
  },
  "status": 200,
  "seconds": 5.210595791000003,
  "arrivals": [
    5.0576117499999995,
    5.210541415999998,
    5.210559041000003
  ],
  "events": [
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-DA2E74A6-663C-403C-ADCA-9775E28E3D65",
      "choices": [
        {
          "delta": {
            "role": "assistant",
            "content": "4"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031150
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-DA2E74A6-663C-403C-ADCA-9775E28E3D65",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "finish_reason": "stop",
          "delta": {},
          "index": 0
        }
      ],
      "created": 1791031150,
      "usage": {
        "prompt_tokens_details": {
          "cached_tokens": 0
        },
        "total_tokens": 270,
        "prompt_tokens": 269,
        "completion_tokens": 1
      }
    },
    "[DONE]"
  ]
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/long-truncated-argument.json

Original bytes: 129533. SHA-256: `893e2c7168d117597f82f22b5cb033856fcd07e1d1b47fa458dae940f1bc02a1`.

Normalized bytes: 129533. SHA-256: `893e2c7168d117597f82f22b5cb033856fcd07e1d1b47fa458dae940f1bc02a1`.

````zlib-base64
eNrtXVuP3DaaffevIDqv7oJ4E6nMU5w4mH3YzQJjYB+mDUOuYncpUUk1kqrt3sD/fQ+rJaqk7mSy
QGMmxvcZRuI6RVEkz3flrX59JcRVUx7C1bfiqm6bu+uhOzXbcgi767K7Ox1CM1y9joW68I9T6AeU
+xUfARzaXajjY//4FBq98de3ddnvr5vwefjWfKweH0O5IRyOoSuHUxdfko1oH8IOH42aPg9dKA9A
8P6wwD60x6Fqmz69Gd9UzbY+7cKHU1/ehfGh83dfxkcP5ecPQ/tLOD+mbD7BoY9PRPDvY11TnbGL
bX0eh1MfurH1Z3zbNkMcB3z1fVnXoi/vw4cj6hFN+0l8qoa9KMW2PRzrMAShsiy7/tR2OxFf9iDK
j+1pEMM+iHYbykaUvRgr3Ij/6So8Eb/Dx6oL4yNV01e7iJeDmFjYXI0N+nL+//tpdNu2/o3uDA/H
c3duQWgcwcsuJezbiycuRCF18eIhfL0L/barjuOTV39DKTGA8M2y2LHsUM8Qun5V/0Wr2o8/h+2w
eC4+2bUQlqEKT59cELH+6qJiSE3V3F2tCnxZfP6yem0Ubgz/7mIgn7x0gb9/9VzVX36Tog/bfVtt
w6UM/yY9z5PzDDWLt8X/nruFAYCyneU+yx6BgD7sIqLdJpeZ0aYY/9hzgbLrqvvyQo7yjZI2K2zm
dRb/yMe2uU1mM5XrPLePj0+wK7ySucrcRa0RL5SSmbVjLeYR9ptMO1VkgCdAqsI77fVjOTvByhSx
oJFnWE2wzo0CZuQEoDtS5VO59Jpc+UwVLvMT4PCgdlPfiwkuMuetnN4+vqbYZMYXVq9qLTbSYmRk
IfMzrCcYRkZqj5ctK9HO57rI8/yyZwVabLWVdqw7wWixN34qnep2uc4KtRr1IrYbf6WylxzJDCTp
3GXTH5Nw6bRSGJG5pHJO5xo1JEQX2jq3GgvgVoJ4jIe/bDDwXJlM21VHgDuDBks7tkEn3LtCgzrr
Lrsi5SaTDkJk5GKcgEurvVdjF1N75EZ5ZaWc5Ngn3OBl3k8SN5e3kERXqLni3GjrlV6KHHCHHqEp
Y0PmCjwENpPemcUL1SZTWuUO9SREaltAGO1cRjkD/lbiDdxkucmzdefUxmo0Qau5YG6lygo3AxBY
BdrGbs7vLrS2upikcCqvN1nuM6/W9OmNLLSzZhoFmXCtJL7IJg0FYjRGoJhqMAm3RaaVXhkK4E5D
USwGc0E04gQwBCrMkji9KXJtcoNxHxEDMQZFWq9E0UCMjRqbscAxwNG0rUTIQKRtEcfPJwRDZDOr
xlGSCc/xerR5qX7APQQZbXnyxgKmwHi7UjS7gX3wFpZLrnCF1nkorUyIBlWxcXZVEs3zTq3VxMJ6
2zyLrVzhTuMBPGIXLbdQNydh3ZLk5Bu030CjLoDC56gqDTxsv3LQ3fQxqreNpub8yrmYgT3wk0TM
xTF4HvZnfgEMu0QnV6OUo215UuyZL/gYoxzYWY2eA+95AYohxpftcBvYLx/b/8iaT7iBtYvS/VjP
XN7CICu71nB4Ru+1MXM7PEweBGVyMzK6M2NgoUeJdCMOf2bgVcy6h3BreItLTtQnXDkPdzfJ31wP
mgoXYuzChwCPxsuaNKTRs8FuJ2XUCXc2UntREP4BgzPJ14QXUbeksZNHcQmXzkNTkmsFoiPk1pIF
DwYjVehZbIrNWQDTp7zIvMxnK1hELUIvpiBhfq5QCCiMWdomBTd2HuzCLsqr6MZyKPmkAzOuCgNP
q51d1WNi9WvWgFs4kMw8rT93Jjrt0UTNOEjzWZGrueZCSgz3JMNTzXBmNjYujSIQJaWTk4zOsNZQ
NTmZa59wUGNH+VzgoLcw+cT7jKNuDNYUqsy4t7mXxhUL7wy8gAL4FAhN5eG6YJ5kJpVZ4dAjtHLq
qE04bCL4nIx5nnADryDhndRlOAgcRtH41J65fkQr8JjJiQKBybB5kcQHSIFwLDdu6SwVXBt0CWJu
E4ABVeBltFczrmGHoHlLDw4cbh3u1i3lEjjiWejopDsz7iCrUMCxEy7hPtqP8RO8lz67o9Ql+K0c
LrSYnssTrgpYAr0eXANroKKKLnUUeHy5jiFaQhwaCilX87NeSzC/ijhU9FhGZ/kUN0w4PBZiPlA8
A+g43l9IuxhEOCzj4qtWjbIb42IkM3XCJBwSmystl/EvcAd2lJdP6vEKuqrSR5CexYxFXlofBacF
aUTRpd9UMW2BDXBrXYcPM7Hoykeo6MMQK/spjJzL22gv9NS8uXyMoN2kHxfloy9z2j5pJ56FE1/F
Kgq+DIxD4sbhyhOuNGLg2aoC0WgD3OnS+wK3cVzWqQLw6NxMsTYRSNFcfGDC53qKGGYZtZLK6NNy
aZL0+4RLeAPl1/XDp/kc8mJXJsjHhMLAnWfZqn4L9s4xcUJyeEqXRMsmHA7R+WIVqQP3iD8QeY/6
7BKOZ7U067EtonHLTZbSQRVzNohKiiRdwo2Mhtb6pfmCh4MTxvAuIxMVfR0ckpuUZa7fIwF1MkUQ
QIocZi2fahjlQcPX+RgU50ufBhx2HS9KngQINB2DoCdVBYLAA25v1JG5YBRhr1cDDxxqjoRl9Dlz
cYSxWhZuKdnA4fAcvMKUCWikZJmEN0OrLkdHRx8XjQ4kMiEacdGsFSbh8K/WuhQH6+jY4oRDspZA
oDQ+dnxhOCIO5VDp7T7hhUQa4vOlxmoVYzOI8SpvAR57kOu5X3Bm6FYKH9KARWfmDRLFcWhswmOE
j1zT2VV5F2VhjrmBnIOE3BTFqgakiXm0TCMQ07SsiEnmjEhvkBSNaigTjJhXRgerl7CREpHwShT0
OdKBgC2zQuB5dHs6yScQhLGw71PEmiccMRrs26oZ5xStOAv/onhM0ZzS88wLEC2jIS/sjBiLgGgO
koBAvbKYaMjlSxCPFUhalvEhcBezATnLDLxbFn3CqpVwbhqhQ2YWiQpgyFERjZZNCAwSpGJuNtya
Qgqa7H2ecHgNCdOztMrAMaI5RtTr5asQ+iJ0yZazJMCLOIeRr0Uoh4pZBAUp+gGC9D960uwCidNz
fiUC8HQQfjllNzOMsrD+bhkUAc8VRF6ugg/gDl4HsJlr8Of4ZiqBNA0h5FkyE4KEHxqfPqqYTs8Z
ABBdRKXOLx7Be5XLVgHq4ywlmF2P7xnXfk5Wx/nMbD0MjzAimDx/NU7EXoX70AzzFGeah/2D6xhx
1SHOD19t9+WwPRzra5W9MeZ7++Y6f/uDujbZD2+uv0Mgdu3kG1e8dT/qtz/o+eHHCeB+McO8mHqv
ml34PK+QpBn3eiifzqJPSxVl31f9UDZPJtIfJ53Luu6fmdN+ZvZ87Bse+KB/dDr7vpBv3hbfGf0d
xA4hyTknehNnMt+sXvV76wl/cF0hFZsWO2Kjr66elPjyzJufHbbfmmL/3UWBxZz+goTbqqn6/Ycu
lP25i82prp9M+r9PVI9LG6OsbMaVIbx/s92fml8uZAI1DudVBxlVAA7I2stlrH+1jP7xhr+oMP+/
ZfV3KP9ngriQsF9vptWdm6tvb54TuH+NwLAc/Hvl4Bvxbs/kEyU/iJ+2oWT6idLffCveMflEyd8H
wdwT5f6voeyYfKLkDx8x/qJl/onyf8t2nyr1P53Y7FPlXvx3XTaB6afq9W9uGvxl/ony/47zPbrk
P56+qZh/ovz3rPpk53jbQRyYfaoLPB1H/FS5rx9EKT4y/VRjPmaeKPO7Bw73yGo9z+6T5f4TRp/J
J0p+9xdRDaLq440qLARU13hQeldyuk823V/f1cPck+G+rEXg5T2q7N9VzD3dXfzI+mqmnyj9vKxL
dicnZ3pkM722EW+ZfaqxfjfwoU2q5L8Wpbgve870ydr+stmJ3QPzT3VLV3motsw+Ve3vH/ohHARH
AHTDv0HwOS6ys313pxoE9CwAVB0AM091c9epExz4kd3PXR34qiayx3fDa9Gf+qGsGj7MRVYK+DQH
2UXedsfrvFTJvw9dXw084Ut4xafZsdcne3p/Xx5DL/anQ9mwFFCVAk78ycZ+91Vd/S/TT3a1hyN/
sjO+zUZ8z+xTZR+JH+s+2W0+d+LQdnxrH905/z3yvT7cswBQ3erBx3nJcv8gjny6h+xlHlv8i3+i
gX+igamnF/QFcaxLPs1PNuhj5l+c+ecG4k/+aw0nlcniJbd6pbaxBHwNEtCfuttyy/QTpT+8ZtUn
a/wRAras+mRVP/5USy/aW5YAqgbgJS/yY+6/Ku7FS/5iB3P/VXF/G7qOyafq9ndMPVWbP7Sc7VEl
v3zhK/uZ/q9L95l5oszf3NxcfayZfqL0n4LYh5LpJ0o/J3p013Zh+Jl9qvFeeyvevuz9zSwBX5UE
xPubD8w+1Wm+oTzu204MLAFEJQD95aSfKvnb8jicOPYna/17UbHlJ7unU9wz90S5r4ayFl1bB1Hx
5h6yyf+hrJh8ouQ38fLeqrkTPPdDN/4T27bZVSjPIkDVDPSCAwCy+o/u9Mw+1a1ezDzV1f4Hccsu
nyz7oua0j+6hjg0v91Al/0de6qFKfXtgtSd8gp+5pzrH35+aaz7LRzbHPx6Ze6Lc13yGl7DZ3+Ot
TD/VaP8T39hDWfu3PLtLdna3rDnTJ0t+CLc9399B/LbGbXfqeVMX2a29zR1zTzXw25W8xEOV/F+a
0HPaR/riNqae6ineIP6T9/Px7T3MPLFgv2xY7cn6+3ddaPiXGcj6fP5RFsLTfEw92UOb7ZZv6qR7
YFPw4Q26N7aUAq2t+b4+yvd1Hjue46W7s+vU8K5Ouhf2PPRD6B5YAKgKQNnsOP4jSz/HfWSZD03P
h/jImv1j+ynwIh9V+jfi3b7qReCrmshO/JQPvNZDdsL/87Fu+XeYCc/6MvWET3Mw+VRzvlM9VLfl
Ngxs+6nKAM/2Edb/Y8s5P1nPXzZb9v10l3mZeaoXtIoY9PMWP8pb/F4Ljvipkv+5PDz+Lg//Mh/h
Gb+wbev2rtryZT6EpYCZp3qq867haR+yCQCsPnJ/PtxH+MdZe8HHesle5sCBP13N3z7+LDMLANnD
vVUjtnV1KNkIkJUBZp7qPu8u8N2dVMk/1WUsy3kf6bwvcOLHa/7MPLEF3/bA871Uyd+Ke97qQfY3
2k7htSgb5p/s/u642+vE+3ypCsBdYOUnu8cbys/nOun+Nu/AO3zIzvRWA8/zkd3hU6I/fLCP8BW+
fH03r+4y8+Ru72TqqS7t8J29ZO1913CkT5d8Xtohe2vjzU2Dv998I95xtE93P+/bLe/rILu6y0d4
aQvA3yrez0t2lq+65Slespu6+Pou0vM9/ANdZGd5eW2HcLb3E9/bRjjie5zxYf6J8v+Ob2t/MfKf
JeXPF+fB3DeiesF9fM8JPQvAnznaC6IGFFgEiIpA/5I7OZn7r4r7sG37B7b+VOkfmHmqin8QbSPe
liwARAWgY92nSv3+tdi3p75q7lgEqKZ9Jcf8VLnfVfcv+VvczP7Xle1XwwPrPtn53lvmnir3dXUb
BEf9ZKP+chBVL3iyj+xkX1Uz91Rtf1zjY/aJsn8XWPOpcv/AzFOd4zs1zD3V5b3PR+aeaqzXdmG3
Ef/B23rIigDy/MCJPt1E/8DcE+U+Dj7bfbKaHyd5PwWxZwmgqv/3QfBWfqrsfz4i+Gf2qSb9O1GH
nuN+wme5ykYMn1gAqBqAhrd3kF3nEUeO+8ge5tjiX5z2E97VOexZ+8nGfcw8VcU/X99xy7t7yApA
271m9afK/iGUvMWH7Bp/cyfO6z0sAWRX+zjmJxvzH8qf265i/qnq/oNA1n/g+1vITvlVTRA97/Kl
e3NbFXqO/ciqfziUVcP8U+X/xMwTZb7ZVf2W2ac64Xsfzqd73u0r9v5kpeBj1TL3RLmP17cx+VTD
/nh9G7NPddKX53vJXtsomnYQPzP/VPP9nrd2E76suW9P3TYIjvqpysCt6LcVPlS3LAJUN/ww80SZ
3wqe8CUb+PEmH7qT/XyWm6yzHx7+IqqBZ3wIz/iUYttVQ8W+n+xlPjUv8ZKN+dHBtonHultO+V+K
298fjKs6NHfDxd1pTwfkD0vhqS/vwoLoq7nwh6H9JTSxG8rmc5MgbENZz19aYy++PHZ4fhi//bAL
Q1mdhXLR/2253YfdXEX26hk5WFYVW+GLV6tS/5T6q7//8NN/vX0fB+v9qy//B324qz8=
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/nullable-truncated-argument.json

Original bytes: 129655. SHA-256: `8805c8693f1278a73d74a8edc973fc9e1867fa6d03a00392f49ea7713b3ea819`.

Normalized bytes: 129655. SHA-256: `8805c8693f1278a73d74a8edc973fc9e1867fa6d03a00392f49ea7713b3ea819`.

````zlib-base64
eNrtXV2P2za6vs+vIKYXvZkxJFL8UO6SbHpOL3ZToAH2ogkCjUyPtZUlryTPZFDkv+9Dj0VZipO2
i273HLxv0Db1Y4oi+bzfFOVfnglx1RQ7f/Ucfx/qurit/c3QHZqyGPz6pujuDjvfDFfXoWHn/3nw
/YC2v+AjgF279nW49J8PvlErd7Opi3570/iPw/Pstnq6DO0Gv9v7rhgOXbhRckJ779f4mMnx89D5
YgcE9/cz7EO7H6q26eOd8U3VlPVh7T8c+uLOny46fvfpdOmu+PhhaH/2x8ukNiPs+3BFAH869TX2
GabY1se1OPS+O43+iJdtM4R1wFeviroWfXHvP+zRj2jaB/FQDVtRiLLd7Ws/eCGTJLl5aLu1CDd7
FMVtexjEsPWiLX3RiKIXpw5X4u9dhSvCd/hYdf50SdX01TrgxSBGFlZXpwF9Ov79flzdtq2/MJ3h
cX+czgaEhhU8n1LEnp9dcSYOcYpnF+Hrte/Lrtqfrrz6Ea3EAMJX82b7okM/g+/6Rf9no2pv/+HL
YXZduLJrISxD5T+/ckbE8qup458+++ZJkqrmbnGzccqQ/KvPvni/QD7NPn9aDDsoB+hbX7h/HPSz
L3U/df3pixR/KLdtVfpzHfgivZfJvUDt7G7hv8dpYbGgrEe9SZInwGMO64Aot0qkMtboLD1+VXRd
dV+cSaBZSasSnSqb5eFP9jQqu0plYqSTT2huRthpl+SJ1cnxjxzh3GWJy2xij62tfsLdKk2kPfU8
dQ44z5QaO0nUCKtU51mSZMmx9YhmGTrO5Kl1OsLaaSnNeMvYh03zxKU5eprBThtppFLyrOt8lSQ6
V2l6muWIphrXx6lnIyytVMk4ldhY4WbKjfczI6wTa5TJTrAdYSMx8TQ1etaHzRxm4U6DUyPs8kQZ
Y8aBPMFpskqUVc6C0vMFAZ7aTCVuXBEXcZU6a+w4xKmfTBktU+3Uoh+NtUrMuFYy4sZhqTRGFBGb
g4VEnu4Y4Tz0ao08iUGarhIDKdDjQmcRx4pmKh0FZGqv8nBzc1qnqb1WLnOZTFxEsD46H+X7iNhc
KcjG1FmOUScucfP5SKhGrqxdiDhwNM9xl9OgVMQhPsqmC4kDHlYq02M/OuKZAdNpNhcN4Dp/YjA7
lw3gEN0sT/RJ/POIO2OweCNP433VKklNHoY0X1S1So1RWfY5LsFV5kb1MhFX+JDJUc5cxANfk2hP
/Rhpc5PbPFm0h0hm1mXaLtpjTkpbsyA/gxzDOuhxvjriqcb483F9IiyDwZDxY4ZerXV2uk5Dt5J0
VFAbcaOt09EMpRHHUuD6cT2m9rnSuY78jOukIcSwiNGYqYjLNMWQx/WYcJW5NIvyZSOeOaw3xjrX
Ow25sNZASpPZOmnIRTC5ubaL/p2ULpejHZARz0GmjnJ3gg2Gn5rMuYVam1Xq0iRVi+U2sBqwgWpa
X7MCs84qIxcNoX6ZUTbqpIE9gyEy44BNxJ3O4Gnm1g8wnIc1qZ2bOXggQOBtblzsChNWgWk5kxq7
gjDYJNoiFfEMS6Si9NmIQzkhr+NymIhDylIX+5/6cXAV2i61B64vdwb/xnVyYeBhptEkOVgOcJIs
NQAOT8tEu1RO12ZWZTYfhcxE3KQwoVBsM+Ma7i5IknRKRcTBc8kzgxi8nMOSazefKfxcFlzrKIcy
4tKiqR4FwkU8SzGJPA4WTg48mHw0rDbiJnhatTR88HOgM0+ymQdNg5+DpYR/OjWUSQhaEMzYuSYA
h1uB5ZkHCIDhRJzSaq6wwDE9N/qcOBHgWPI8mE4578am8ETJqH8RhjAgSBiXXkUcXUhnFuon4euC
WOaREiASK5eohWGUwctBa/TCAMng5RAJyXTu/WTwdZCCZFxXF3FIPkz+uFw64nnwri6dC42E44P1
TszC6wKXGeIsDElFBCGM0W70wzbiWQgF8ihkMji1XGaRg6lPC321chGUAHdawc3afOohtw7rNsZ5
4xjgzlI442SUsgjLDHFtlEYAiJUguOOqTdeDUyz/crZwYzCIEOBTGDq1txIKJBfuH7hD7JHGtZj6
ySE3iEjm7lxmQQ4UTNU8yAWOZQqdzCNU4CrEomdyAxcXFinKqYm4wYQw05khBmyh9nk2LoCLuNPB
GsW4DQi4ymGN5tGp1Ih8oKJmtMQy4jI48AvtFZoHCyYXuE4d0KUw6JXJ4IbhmeYCCQ+XwT7pcaIu
4rAXJlUL6uHJ4OURuZ/0SUc8TbHgbqHXyHBgBswylQGOKFFLE60vEJ0i8nDLBTdHg4Y8aeYiAUPj
4IHNQuLg0KTEbEaZH7u3CHiUNm4xHTg6ZRzUfOavAUuDNYTgphFBu1Smn12f5SFMW3g44Bg04oO5
u5XBweX6szADeJ4kOQY3Xz0XokzkgUu1hJdDWhEcwtyouaCXMFJq9IcyeDmH+HKkK8IZInfl5MIy
ILGD2cJaRHcA54dw3C4DV+AYq0vtPD8CnCMxREQznwjcYDAX6GVur/MQvhnlFl4MuMqCUmdIeOft
Q1QHu+8W3RsJ6bOfN7fQkNTNnZ4MTi8kqW6uIiq4PpAeM0QZ8RQKbBdBMWB4oMmSjyyokNslx4w3
OxdNFVwfkuaYarqIW5hIl0aDDgSaDSVL5lEDcERrJksW0qZSpPoqKOt8gPB96AU+YLZagOEN4YER
ZUQEYoMEJZo/IFgdBJyLuBc4wkLnskV4ARxLarSe+gwZngspwWj5gCDmAa+jcAKAWmdaL4J94MhA
McBFEUAFz5eDzei3gMAaw3gt/ELAc2hfPg9rAYd6AdLCmVYCznVICu0s+FDI8ZDtwn/G28Edghgb
oraIBKpDYjMfgAoygCA+2jcgSKwQmdq5zgJHWIvYOZtnesCxyhBfd3YvmBl3bHpC4OYc8kEzj5oA
B7cwJQs64iqUS9zcygDOVAoXrbNFLxrxRzbZAiAGi4EIMJKchSKEnsokEcZt4A/MfJ2RxCHjlHIS
CTg9KKdZmEnAMG/wJjGtAYI4MCSm6XQphmchTWdtbIJsSE1rDh8GZ5fLxfCQpOUw5WbqDN5LHg3t
LN8BLJEkwA0uxMuEcEEmapIM5GfwctkiPwOMREem9rwhRN7BgsXPwefDX521yJ1EtjFGGOMYQ1Uw
mOJJxYKXyoOWzkcNnwTDYc9Wxq7CDYychgH/hKACJsNM3VsMA65i7qmBY5mQ644UjfixuImgbKFi
TzVPmH89A7RaTueEWxidZ6fy7ZW/980wlUdj9fY37p6EvY5QVb4qt8VQ7vb1zXc6xPI2uXHqL+4m
S9V3N/mLxN28eC31S2Nfv8rUi+niU5X91MHqtElRtc2q3B6an6eGT/XlflbA/mVe+q+H4kI5/1ic
Luq6v1D7vlClP80GF3x4IRVcaKpfZi9hRV+ol0GApXkpzevk1SutLpTrv7Rv8Rv3L2KzcVMlDPrq
8+L/pwt3rpq1/zhtYF3c04ij++rmwfvl5sFp26no+6ofivlWwWwolwdxtamaqt9+6HzRH1cm7Gh8
tqfwfqIaDYfjXkVIkoNJz9X55tmfLaN/luj9muzMhOKXd+PGzbur5+9+r4x8nf//LL2/XeVZDn5d
Dr4Rb7dMPlHyvXhT+oLpJ0p/81y8ZfKJkr/1grknyv3/+qJj8omSP9xikUTL/BPlf8N2nyr1bw5s
9qlyL36oi8Yz/VS9/rt3Df5h/ony/5bzPbrkHw/mMPtUPX/VH49g7VgCqOp/P4h1u6tYAKhW+tn8
0438xYbTPqrkH4+lc7GXbrGXmaca9beHTuxrdvx0n+4ZrkXJ7FPN+e59xwkf2YTvTuzajku+dLO+
bdGI3t+zAFD1/stXMjH3ZLh/FHsu+VAlvyvxf+z4ycb9XPIhW/IJu7yv+dFuwkH/tz2TT1X7+0O3
KUoO/MgKQNGsxbat11VzJ/hUJ1Ux2O+79mPFD3vR3fL39SPnf2Qr/1Xjh8cbjgPJFn7vOQQkq/xc
+OXCL9PPhV+mnlzh94Hpp6r5zDxVl1+vmXui3H/bc6xHlfsHLu+T3eP13YoVnyr73zPzZI/xVr0o
xH3RD9ei4lNdhO1/yQkf2QI/v8KNLPclVogjP6rs37ZrfqqD8OaO6Dnnp8p+PTxgkfi5fsL7e6z8
dBP/flvsPT/QR1b7mXmqUd+h4zf4/J9g//Ly/FG/GfqVn978fXFitbsUJ/ybIsHk/78if/DXomf2
ibJ/YOaJMt8PRcXkEyW/6UXN5BMlv9rA5R8PfXPUR9b6i33XbtpDs2Y7QFUGHkXVbJh+sqG/b0oP
J8ACQFUAdhff8s7kUyBfbKt+aLtHFgCqAsDME2U+pH4ls0/V69cDF32pkt/5Fdt9quR/1zH1RKlv
d8d3fTD/VMu9h+ZmzepPlX7fcLxPlfutXzP3VGs8/RZ3ZfqpRn0Pvbj4ej+mn4T2Xzzwz9yTKPQU
NWd7dKt8ftOLoWUJIPtQ/9aLsjv0/HAH2Yc8mzvmnmrgty641keV/J8b33PaR1n7B6aebK1X/JXP
dJBN+5h5qsF+0bDak/X3bzve3yXs86+5zEe3zMfUU32kR7SlZ6dP9gUOgl/eQffsfiGwsvWOJYBq
yN9uOOgj6/k/Dp3feX5nG5/cZebpndx9YPapPs6Ljjo2+1TpX4m326oX7PjpJn7FI/t+umH/vm47
z/yTrfow9YSf5mbyiZK/O9RDteGdHqr8l56f5yQb860Fv6GTbLFvOHTs9+lW+5h5osxvju/q4sd7
KD/ecy240kOV/I/FDoQ1d+z7yZ7nGHqx3z72FW4uSv6ZHj7SxcxTy/7KgSMAsmpf9UNV9tei4tof
3f0+X7Z1e3eMAVgKqEoBM081B7hr+IgP2RIgrD7v/NDd8r1m7qke7gi1n66tPR/wJHy4l5/zJEv+
3aEuhoqdP1n+j7u/d/yrDfzgBzNPi/lbrvQRTvrqil/oQfdZT38tuOJDlv/1Meg78HY/2ajfs/KT
Pd4H5eeCD2Hfz5u8hKv9nPGR3eQtMAne5iG8zcPvb6Z7tJeZp+rzucxHdmtnzdRTtfddI3xXrN69
40IPVRkA9998I34YD/a94oN9hH+fveSjPXR9wdP5LsH6Tzb350iQbP73P5z7k00A77piz0U/qvQ/
IgPgBJAu/2/5Rb6EbX/pC/7ZPn6BO1NPL9trB7Hz/HQn2YJP/ci1HroJf89On6zlv6u9uGX6yW74
8y920SWff6SZLPcPWNRO3B5YAMge6qk44ad7nrO6r3iHl/DPNlUNP95DNu4TG074qZJ/zzt8dH+q
k5mneob7Hy3v7pCt798WfdX0z1kAqAoAM0/4l9l/KMpqwxJA9WcamHmqL2y8Fi+Gmh/rILu1z8xT
9foVdP/7Zs22n2y+z8z/4cz/QRz/3t/Z/vEClddfEZ1/k+bLcs3k/xfJbw9I37qG+SfK/7Vg6olS
XzRr8YLZJ8p+x8wTZR4tSyafKPniTTiB269YAKgKQDh//wPTTzXoKyvmnij3m6rkbI8q+W+e3rzR
swBQdfzD1jP5VMmv8dH3AwsAVQFg5gmXedfe79n4U5WAfrhm7qna/bK9Z80nu8lTNXeXf1KZ+Seh
/QVWidknnPQx+UTJv/PMPeFSX9Fwxk8246+ZeqLU1+LyC/eYfQrsvy46rvBTJX/7LVNPtcCLTK9Z
7wre3CcrAcw8UeZ9L/hpbrKn93a3VePXKw75qUpAeJr7BQf9ZPN9Zp7sYz18jIv2MS4mn6zqX4uH
atiKauC8j6wFWDP1RKmv+Dl+utw3HPRR5Z61nqzW33vx402/LfYsAlTr/NeCg32y5O+LDqvUc52f
rO8PdX5mnyj7O99VJT/eQbfYs+laJp+q8ovXh67lyJ9s8MfMkz2+GV7Ru+GDXGTrPiWf3uU3szP1
1J7m9t398c0NXPCh+5CH2Fb90LLvJ+z7+elOspH/trrbPhSPYsMWgK4Q+I9c9SH7ZH/bFQO/q53s
yS5mnurPMfIL++iSvxZDV6y54k+V/9Xx53mYfqL0f8/MU/X666poxBt+uJ/sLj9HfYS3+m7bQ8MH
+sjq/lrcPoYHPXi//08Rgt8+8F+TluWKXdW+uRu2V9cXReoLHHxliS+tXPzy0Bd3fiZgV/sOcxk+
DO3Pvuk/rP1QVEeJnQ26LMqtX58azQcwDRASPxT11Ehn7voL98G3Mpdn304LetZCm2fnszzd6uqn
v7z52+v3QerfP/v0L42ltJ0=
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/plain-cap.json

Original bytes: 48050. SHA-256: `019c0bf36bf05e914a774062ee8c66fb69f54cb2127890a97a4f42a8b5e583c3`.

Normalized bytes: 48050. SHA-256: `019c0bf36bf05e914a774062ee8c66fb69f54cb2127890a97a4f42a8b5e583c3`.

````text
{
  "name": "plain-cap",
  "request": {
    "model": "qwen3.8-flash-next:4bit",
    "temperature": 0,
    "seed": 42,
    "stream": true,
    "stream_options": {
      "include_usage": true
    },
    "max_tokens": 128,
    "messages": [
      {
        "role": "user",
        "content": "Count from 1 to 1000, writing every number separated by commas. Do not call any tools."
      }
    ]
  },
  "status": 200,
  "seconds": 19.516680375,
  "arrivals": [
    1.395611041,
    1.5720237080000001,
    1.6902814160000001,
    1.837116541,
    1.9887475,
    2.1347191249999997,
    2.273560083,
    2.4288341659999997,
    2.560168541,
    2.702928583,
    2.8562999159999998,
    2.9909134579999996,
    3.1208765,
    3.2744185,
    3.421475708,
    3.572787291,
    3.7257255409999996,
    3.88299875,
    4.013910958,
    4.182977,
    4.327150583,
    4.460685708000001,
    4.610456625,
    4.746688625,
    4.89224975,
    5.047124416,
    5.171924291000001,
    5.3223934580000005,
    5.476976291000001,
    5.635508583,
    5.7668764580000005,
    5.906775958,
    6.039693458,
    6.183254750000001,
    6.317203875000001,
    6.466301916,
    6.6061635,
    6.7553666660000005,
    6.8908038750000005,
    7.033740291,
    7.17276225,
    7.3239585830000005,
    7.466948791,
    7.622610750000001,
    7.740813666,
    7.893208708,
    8.037385916,
    8.1901555,
    8.319722791,
    8.474674333,
    8.601125583,
    8.747382,
    8.881319666,
    9.024350875,
    9.166196458,
    9.319208791,
    9.444360541,
    9.59261725,
    9.730063083,
    9.878314915999999,
    10.013209999999999,
    10.164010041,
    10.305410083,
    10.461847707999999,
    10.602461291,
    10.755048208,
    10.884245,
    11.030108083,
    11.177917291,
    11.299262040999999,
    11.432169791,
    11.575333624999999,
    11.715354041,
    11.862646166,
    11.990275833,
    12.145221541,
    12.283478541,
    12.426613208,
    12.564031041,
    12.711397208,
    12.846719916,
    12.996564541,
    13.128012625,
    13.280933,
    13.414391208,
    13.560122541,
    13.68623925,
    13.830546833,
    13.949515916,
    14.098977374999999,
    14.227285166,
    14.375966,
    14.508003416,
    14.651916041,
    14.782813874999999,
    14.943241833,
    15.089785625,
    15.237274333,
    15.366821332999999,
    15.512079041,
    15.6466665,
    15.797092165999999,
    15.921224749999999,
    16.067957625000002,
    16.196396,
    16.343120666,
    16.469977833,
    16.609612583,
    16.75422925,
    16.873638708,
    17.018973291000002,
    17.177664833,
    17.327642,
    17.468534375,
    17.604734541000003,
    17.76111025,
    17.914804458000003,
    18.069726416,
    18.209736041000003,
    18.366352083000002,
    18.512516,
    18.661028833,
    18.7970545,
    18.936765958000002,
    19.083418083,
    19.236954583000003,
    19.367790333000002,
    19.51617475,
    19.516644125000003,
    19.516658833
  ],
  "events": [
    {
      "choices": [
        {
          "finish_reason": null,
          "delta": {
            "role": "assistant",
            "content": "1"
          },
          "index": 0
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "3"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "4"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "5"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "6"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "7"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "8"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "9"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "0"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "3"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "4"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "5"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "6"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "7"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "8"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "9"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "0"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "3"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "4"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "5"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "6"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "created": 1791031107,
      "model": "qwen3.8-flash-next:4bit",
      "object": "chat.completion.chunk"
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "7"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": ","
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": " "
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "2"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "8"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": ","
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": " "
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "2"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "9"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": ","
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": " "
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "3"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "0"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": ","
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": " "
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "3"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "1"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": ","
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": " "
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "3"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "2"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": ","
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": " "
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "3"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "3"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": ","
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": " "
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "3"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "4"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": ","
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": " "
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "choices": [
        {
          "delta": {
            "content": "3"
          },
          "index": 0,
          "finish_reason": null
        }
      ],
      "object": "chat.completion.chunk",
      "created": 1791031107
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-BC175554-4744-4516-A7AE-01A7F6DB5488",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "delta": {},
          "index": 0,
          "finish_reason": "length"
        }
      ],
      "created": 1791031107,
      "usage": {
        "prompt_tokens_details": {
          "cached_tokens": 0
        },
        "total_tokens": 164,
        "prompt_tokens": 36,
        "completion_tokens": 128
      }
    },
    "[DONE]"
  ]
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/results.json

Original bytes: 2926. SHA-256: `a81697fb8203ac1e2d24a86101013ea8eb5e2a2247205544fe5fa4a0481f026f`.

Normalized bytes: 2926. SHA-256: `a81697fb8203ac1e2d24a86101013ea8eb5e2a2247205544fe5fa4a0481f026f`.

````text
[
  {
    "name": "plain-cap",
    "finish": "length",
    "usage": {
      "prompt_tokens_details": {
        "cached_tokens": 0
      },
      "total_tokens": 164,
      "prompt_tokens": 36,
      "completion_tokens": 128
    },
    "data_events": 130
  },
  {
    "name": "tools-unused-cap",
    "finish": "length",
    "usage": {
      "completion_tokens": 128,
      "total_tokens": 403,
      "prompt_tokens_details": {
        "cached_tokens": 0
      },
      "prompt_tokens": 275
    },
    "data_events": 130
  },
  {
    "name": "large-allowance-unused-tools",
    "finish": "stop",
    "usage": {
      "prompt_tokens_details": {
        "cached_tokens": 0
      },
      "total_tokens": 270,
      "prompt_tokens": 269,
      "completion_tokens": 1
    },
    "data_events": 3
  },
  {
    "name": "long-truncated-argument",
    "finish": "length",
    "usage": {
      "completion_tokens": 256,
      "total_tokens": 545,
      "prompt_tokens_details": {
        "cached_tokens": 0
      },
      "prompt_tokens": 289
    },
    "data_events": 242
  },
  {
    "name": "nullable-truncated-argument",
    "finish": "length",
    "usage": {
      "prompt_tokens_details": {
        "cached_tokens": 0
      },
      "total_tokens": 548,
      "prompt_tokens": 292,
      "completion_tokens": 256
    },
    "data_events": 242
  },
  {
    "name": "branch-alpha-seed",
    "finish": "stop",
    "usage": {
      "completion_tokens": 49,
      "total_tokens": 1575,
      "prompt_tokens_details": {
        "cached_tokens": 0
      },
      "prompt_tokens": 1526
    },
    "data_events": 49
  },
  {
    "name": "branch-beta-seed",
    "finish": "stop",
    "usage": {
      "prompt_tokens_details": {
        "cached_tokens": 768
      },
      "total_tokens": 2030,
      "prompt_tokens": 1976,
      "completion_tokens": 54
    },
    "data_events": 54
  },
  {
    "name": "branch-alpha-followup",
    "finish": "stop",
    "usage": {
      "completion_tokens": 24,
      "total_tokens": 1621,
      "prompt_tokens_details": {
        "cached_tokens": 1280
      },
      "prompt_tokens": 1597
    },
    "data_events": 24
  },
  {
    "name": "cache-turn-1",
    "finish": "stop",
    "usage": {
      "prompt_tokens_details": {
        "cached_tokens": 0
      },
      "total_tokens": 1058,
      "prompt_tokens": 1029,
      "completion_tokens": 29
    },
    "data_events": 29
  },
  {
    "name": "cache-turn-2",
    "finish": "stop",
    "usage": {
      "completion_tokens": 29,
      "total_tokens": 1632,
      "prompt_tokens_details": {
        "cached_tokens": 1024
      },
      "prompt_tokens": 1603
    },
    "data_events": 29
  },
  {
    "name": "cache-turn-3",
    "finish": "stop",
    "usage": {
      "prompt_tokens_details": {
        "cached_tokens": 1536
      },
      "total_tokens": 1683,
      "prompt_tokens": 1654,
      "completion_tokens": 29
    },
    "data_events": 29
  }
]
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/tools-unused-cap.json

Original bytes: 48744. SHA-256: `5b3f2cec77a104c6d3c8ff021af0a2231c40352ee1c513088cc15ca123596dfb`.

Normalized bytes: 48744. SHA-256: `5b3f2cec77a104c6d3c8ff021af0a2231c40352ee1c513088cc15ca123596dfb`.

````text
{
  "name": "tools-unused-cap",
  "request": {
    "model": "qwen3.8-flash-next:4bit",
    "temperature": 0,
    "seed": 42,
    "stream": true,
    "stream_options": {
      "include_usage": true
    },
    "max_tokens": 128,
    "messages": [
      {
        "role": "user",
        "content": "Count from 1 to 1000, writing every number separated by commas. Do not call any tools."
      }
    ],
    "tools": [
      {
        "type": "function",
        "function": {
          "name": "save_page",
          "description": "Save text.",
          "parameters": {
            "type": "object",
            "properties": {
              "content": {
                "type": "string"
              }
            },
            "required": [
              "content"
            ]
          }
        }
      }
    ]
  },
  "status": 200,
  "seconds": 23.185037083,
  "arrivals": [
    5.4491190419999995,
    5.603224333,
    5.710670792000002,
    5.8201810420000015,
    5.937856083,
    6.043375292,
    6.167625292,
    6.308220542000001,
    6.4484924580000005,
    6.578564083,
    6.702997,
    6.826501624999999,
    6.956002832999999,
    7.068596917000001,
    7.195670166999999,
    7.344610625000001,
    7.462042292,
    7.593531125000002,
    7.734694167000001,
    7.872467499999999,
    8.011584124999999,
    8.145022,
    8.2730535,
    8.418747,
    8.562508375,
    8.7028875,
    8.847437042,
    8.979383958,
    9.125138750000001,
    9.269306,
    9.380820667000002,
    9.5045015,
    9.628800625,
    9.750681499999999,
    9.893764083,
    10.040620624999999,
    10.157382917,
    10.293554417,
    10.429103208,
    10.551474542000001,
    10.694371417,
    10.837056292,
    10.976978625000001,
    11.120929792000002,
    11.267732917,
    11.410730917000002,
    11.552670917,
    11.700453542000002,
    11.840108208,
    11.970501417000001,
    12.108687291999999,
    12.247963917,
    12.384266167,
    12.511807958000002,
    12.656664625000001,
    12.799512375000003,
    12.952136042000003,
    13.080337125000003,
    13.224102124999998,
    13.357847083,
    13.501400583000002,
    13.629771958000003,
    13.781354750000002,
    13.910083791999998,
    14.063103833000003,
    14.195245707999998,
    14.352364792,
    14.485789083000004,
    14.637425375000003,
    14.766924833000001,
    14.926190583000004,
    15.061654083000004,
    15.208885499999997,
    15.346962875,
    15.536542458000003,
    15.666296499999998,
    15.820728458000001,
    15.94873625,
    16.097493957999998,
    16.235905374999998,
    16.38661575,
    16.522548708,
    16.678453082999997,
    16.814321208,
    16.962182625,
    17.091395582999997,
    17.255720583000002,
    17.406733667,
    17.522875375,
    17.653760125,
    17.808440958000002,
    17.951509333,
    18.096828624999997,
    18.230649791999998,
    18.385478541999998,
    18.523317332999998,
    18.671568750000002,
    18.814070042,
    18.974190250000003,
    19.110858458,
    19.265322583000003,
    19.397194083,
    19.55539475,
    19.686485708000003,
    19.841868125,
    19.993898667,
    20.148192917,
    20.277374750000003,
    20.426532249999998,
    20.559818916999998,
    20.717648292000003,
    20.854792458000002,
    21.003945333,
    21.139364667,
    21.283967875,
    21.427422125000003,
    21.582661625000004,
    21.710908,
    21.864685208,
    22.002351958000002,
    22.154897166999998,
    22.2916985,
    22.445286375,
    22.583720417,
    22.733372,
    22.863612125,
    23.019515416999997,
    23.184794833,
    23.184957375,
    23.184969042000002
  ],
  "events": [
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "I",
            "role": "assistant"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " don"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "'t"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " need"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " to"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " call"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " any"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " tools"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " for"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " this"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " task"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "."
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "\n\n"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "1"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "2"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "3"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "4"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "5"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "4"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "5"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "6"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "7"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "8"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "9"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "1"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "0"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "1"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "1"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "1"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "2"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "1"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "3"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "1"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "4"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "1"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "5"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": ","
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": " "
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "finish_reason": null,
          "delta": {
            "content": "1"
          }
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "6"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "7"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "8"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "9"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "0"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "1"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "3"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "4"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "5"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "6"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "7"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "8"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "2"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "9"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": ","
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": " "
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "3"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "object": "chat.completion.chunk",
      "choices": [
        {
          "index": 0,
          "delta": {
            "content": "0"
          },
          "finish_reason": null
        }
      ],
      "created": 1791031127
    },
    {
      "model": "qwen3.8-flash-next:4bit",
      "id": "chatcmpl-80EA42EE-0F16-4776-BFA7-8A781D7F6EC7",
      "choices": [
        {
          "index": 0,
          "delta": {},
          "finish_reason": "length"
        }
      ],
      "object": "chat.completion.chunk",
      "usage": {
        "completion_tokens": 128,
        "total_tokens": 403,
        "prompt_tokens_details": {
          "cached_tokens": 0
        },
        "prompt_tokens": 275
      },
      "created": 1791031127
    },
    "[DONE]"
  ]
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/openai-tools.jsonl

Original bytes: 44450. SHA-256: `5d393346fa2f90cb5b721be00599bd4ce1cfc3d99ee3d519c3e257df423761b5`.

Normalized bytes: 44450. SHA-256: `5d393346fa2f90cb5b721be00599bd4ce1cfc3d99ee3d519c3e257df423761b5`.

````text
{"case": "catalog", "path": "/v1/models", "request": null, "status": 200, "response": "{\"object\":\"list\",\"data\":[{\"owned_by\":\"slotstream\",\"object\":\"model\",\"context_policy\":{\"vision_limit\":65536,\"max_prefill_wait_minutes\":30,\"configured_window\":32768,\"wait_scope\":\"accepted_request_to_first_model_token\",\"allocation_available\":true,\"estimate_scope\":\"measured M5 Pro anchors; unknown for unqualified pass sizes\",\"implementation_limit\":262144,\"mtp_limit\":262144,\"qualification\":false,\"model_limit\":262144},\"context_window\":32768,\"max_output_tokens\":8192,\"context_length\":32768,\"id\":\"qwen3.8-flash-next:4bit\",\"created\":1791031106}]}"}
{"case": "show", "path": "/api/show", "request": {"model": "qwen3.8-flash-next:4bit"}, "status": 200, "response": "{\"template\":\"{{ .Prompt }}\",\"parameters\":\"num_ctx 32768\",\"context_policy\":{\"mtp_limit\":262144,\"implementation_limit\":262144,\"vision_limit\":65536,\"allocation_available\":true,\"max_prefill_wait_minutes\":30,\"estimate_scope\":\"measured M5 Pro anchors; unknown for unqualified pass sizes\",\"wait_scope\":\"accepted_request_to_first_model_token\",\"model_limit\":262144,\"configured_window\":32768,\"qualification\":false},\"details\":{\"family\":\"qwen4_exp\",\"experts_per_layer\":512,\"expert_cache_per_layer\":13,\"format\":\"safetensors\",\"parameter_size\":\"176B-A6B\",\"quantization_level\":\"4bit\",\"memory_plan\":{\"prefill_wait_scope\":\"accepted_request_to_first_model_token\",\"source\":\"--memory-gb\",\"runtime_prefix_cache_enabled\":true,\"decode_estimate_cache_in_measured_range\":true,\"context_qualification\":false,\"est_prefill_s_at_max_context\":385.50588235294038,\"mtp_streamed_experts\":false,\"vision\":false,\"pool_slots\":640,\"device_working_set_gb\":40.200000000000003,\"vision_charged_gb\":0,\"pool_gb\":1.8,\"availability_clamped\":false,\"vision_context_limit\":65536,\"lookahead_reserve_bytes\":0,\"non_cache_allowance_bytes\":6152527104,\"vision_resident_reserved\":false,\"device_available_gb\":28.399999999999999,\"planned_headroom_gb\":0.20000000000000001,\"device_ram_gb\":51.5,\"est_prefill_tok_s\":85,\"mtp_context_limit\":262144,\"mtp\":false,\"max_prefill_wait_minutes\":30,\"prefill_chunk\":256,\"est_warm_tok_s\":2.666666666666667,\"expected_peak_gb\":7.9000000000000004,\"experts_per_layer_cached\":13,\"expected_peak_semantics\":\"planned_full_workload_envelope_not_measured_usage\",\"prefix_cache_max_tokens\":6510,\"max_context_tokens\":32768,\"model_context_limit\":262144,\"memory_target_semantics\":\"process_budget_not_allocation_goal\",\"max_ram_percent\":70,\"vision_resident_gb\":0,\"memory_ledger\":{\"active_capacity_bytes\":905969664,\"fixed_bytes\":5300000000,\"expected_peak_bytes\":7921999104,\"long_context_reserve_bytes\":0,\"lookahead_reserve_bytes\":0,\"prefill_bytes\":332800000,\"additional_active_bytes\":0,\"retained_recurrent_bytes\":339738624,\"retained_capacity_bytes\":179988480,\"vision_resident_bytes\":0,\"pool_bytes\":1769472000,\"planning_margin_bytes\":1000000000,\"version\":1,\"mtp_resident_bytes\":0},\"decode_lookahead\":false,\"target_gb\":8.0999999999999996,\"fully_resident\":false,\"implementation_context_limit\":262144},\"prefix_cache\":{\"held_images\":0,\"persistent\":{\"shared\":2,\"restored_bytes\":453110784,\"skipped_saves\":0,\"compactions\":0,\"rejected_files\":0,\"conversations\":3,\"segments\":8,\"failed_saves\":0,\"evictions\":0,\"replaced_states\":0,\"held_tokens\":9728,\"directory\":\"\\/Users\\/carlos\\/Projects\\/slotstream\\/.build\\/quantization-research\\/vq-dense-overlay-acceptance-v1\\/verify-results\\/issue21\\/prefix\",\"segment_bytes\":113291378,\"bytes\":1038688577,\"restores\":3,\"written_bytes\":1038843070,\"restored_tokens\":3840,\"minimum_tokens\":512,\"deleted_states\":0,\"shared_saves\":3,\"max_age_seconds\":2592000,\"states\":8,\"shared_prefixes\":3,\"delta_saves\":6,\"restore_failures\":0,\"one_off\":0,\"reused_bytes\":155713536,\"opened\":{\"removed_expired\":0,\"removed_other_builds\":0,\"removed_over_quota\":0,\"removed_unreadable\":0,\"removed_orphan_segments\":0,\"removed_incomplete\":0,\"removed_bytes\":0},\"parents\":3,\"max_bytes\":20000000000,\"head_bytes\":925397199,\"saves\":8,\"expired_states\":0,\"removed_segments\":0},\"max_tokens\":6510,\"evictions\":20,\"enabled\":true,\"allocated_sequence_bytes\":56623104,\"checkpoint_fork_failures\":0,\"held_gb\":0.28000000000000003,\"checkpoint_stores\":10,\"held_tokens\":31,\"hits\":4,\"conversations\":2,\"max_conversations\":4,\"persistent_hits\":3,\"misses\":9,\"checkpoint_hits\":1,\"charged_token_capacity\":2067,\"reusable_checkpoints\":1}},\"capabilities\":[\"completion\"],\"model_info\":{\"general.parameter_count\":176000000000,\"general.architecture\":\"qwen4_exp\",\"qwen4_exp.context_length\":32768},\"modelfile\":\"# slotstream: SSD-streamed qwen4_exp\"}"}
{"case": "nonstream-call", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 192, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "stream": false, "tool_choice": {"type": "function", "function": {"name": "read_file"}}}, "status": 200, "response": "{\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-EEF6B130-F4BE-48A7-907C-24B517A55B02\",\"object\":\"chat.completion\",\"choices\":[{\"index\":0,\"finish_reason\":\"tool_calls\",\"message\":{\"content\":null,\"role\":\"assistant\",\"tool_calls\":[{\"id\":\"call_2B7D466FA5E64AA0854DDE81FBB154A7\",\"type\":\"function\",\"function\":{\"name\":\"read_file\",\"arguments\":\"{\\\"path\\\":\\\"diagnostic.txt\\\",\\\"start_line\\\":1}\"}}]}}],\"created\":1791031317,\"usage\":{\"total_tokens\":330,\"completion_tokens\":38,\"prompt_tokens\":292,\"prompt_tokens_details\":{\"cached_tokens\":0}}}"}
{"case": "nonstream-result", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}, {"content": null, "role": "assistant", "tool_calls": [{"id": "call_2B7D466FA5E64AA0854DDE81FBB154A7", "type": "function", "function": {"name": "read_file", "arguments": "{\"path\":\"diagnostic.txt\",\"start_line\":1}"}}]}, {"role": "tool", "tool_call_id": "call_2B7D466FA5E64AA0854DDE81FBB154A7", "content": "OPENAI_TOOL_FIXTURE_42"}, {"role": "user", "content": "Reply with only the exact file contents. Do not call a tool."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 48, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "stream": false}, "status": 200, "response": "{\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"finish_reason\":\"stop\",\"message\":{\"content\":\"OPENAI_TOOL_FIXTURE_42\",\"role\":\"assistant\"}}],\"usage\":{\"completion_tokens\":8,\"total_tokens\":373,\"prompt_tokens_details\":{\"cached_tokens\":0},\"prompt_tokens\":365},\"id\":\"chatcmpl-C758CD01-EAA1-42EC-B1C6-044C8A746B01\",\"object\":\"chat.completion\",\"created\":1791031327}"}
{"case": "stream-call", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 192, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "stream": true, "tool_choice": {"type": "function", "function": {"name": "read_file"}}, "stream_options": {"include_usage": true}}, "status": 200, "response": "data: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-5992E275-3600-45B6-8306-82533964091B\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"index\":0,\"delta\":{\"role\":\"assistant\",\"tool_calls\":[{\"function\":{\"name\":\"read_file\",\"arguments\":\"\"},\"index\":0,\"type\":\"function\",\"id\":\"call_C6BAF7E498764D7FB698B566E1D84356\"}]}}],\"created\":1791031334}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":null,\"index\":0,\"delta\":{\"tool_calls\":[{\"function\":{\"arguments\":\"{\\\"path\\\":\\\"\"},\"index\":0}]}}],\"id\":\"chatcmpl-5992E275-3600-45B6-8306-82533964091B\",\"object\":\"chat.completion.chunk\",\"created\":1791031334}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":null,\"index\":0,\"delta\":{\"tool_calls\":[{\"function\":{\"arguments\":\"di\"},\"index\":0}]}}],\"id\":\"chatcmpl-5992E275-3600-45B6-8306-82533964091B\",\"object\":\"chat.completion.chunk\",\"created\":1791031334}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":null,\"index\":0,\"delta\":{\"tool_calls\":[{\"function\":{\"arguments\":\"a\"},\"index\":0}]}}],\"id\":\"chatcmpl-5992E275-3600-45B6-8306-82533964091B\",\"object\":\"chat.completion.chunk\",\"created\":1791031334}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":null,\"index\":0,\"delta\":{\"tool_calls\":[{\"function\":{\"arguments\":\"gn\"},\"index\":0}]}}],\"id\":\"chatcmpl-5992E275-3600-45B6-8306-82533964091B\",\"object\":\"chat.completion.chunk\",\"created\":1791031334}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":null,\"index\":0,\"delta\":{\"tool_calls\":[{\"function\":{\"arguments\":\"ostic.txt\"},\"index\":0}]}}],\"id\":\"chatcmpl-5992E275-3600-45B6-8306-82533964091B\",\"object\":\"chat.completion.chunk\",\"created\":1791031334}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":null,\"index\":0,\"delta\":{\"tool_calls\":[{\"function\":{\"arguments\":\"\\\"\"},\"index\":0}]}}],\"id\":\"chatcmpl-5992E275-3600-45B6-8306-82533964091B\",\"object\":\"chat.completion.chunk\",\"created\":1791031334}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":null,\"index\":0,\"delta\":{\"tool_calls\":[{\"function\":{\"arguments\":\",\\\"start_line\\\":1\"},\"index\":0}]}}],\"id\":\"chatcmpl-5992E275-3600-45B6-8306-82533964091B\",\"object\":\"chat.completion.chunk\",\"created\":1791031334}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":null,\"index\":0,\"delta\":{\"tool_calls\":[{\"function\":{\"arguments\":\"}\"},\"index\":0}]}}],\"id\":\"chatcmpl-5992E275-3600-45B6-8306-82533964091B\",\"object\":\"chat.completion.chunk\",\"created\":1791031334}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-5992E275-3600-45B6-8306-82533964091B\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":\"tool_calls\",\"index\":0,\"delta\":{}}],\"created\":1791031334,\"usage\":{\"total_tokens\":330,\"completion_tokens\":38,\"prompt_tokens\":292,\"prompt_tokens_details\":{\"cached_tokens\":256}}}\n\ndata: [DONE]\n\n"}
{"case": "stream-result", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}, {"role": "assistant", "content": "", "tool_calls": [{"id": "call_C6BAF7E498764D7FB698B566E1D84356", "type": "function", "function": {"name": "read_file", "arguments": "{\"path\":\"diagnostic.txt\",\"start_line\":1}"}}]}, {"role": "tool", "tool_call_id": "call_C6BAF7E498764D7FB698B566E1D84356", "content": "OPENAI_TOOL_FIXTURE_42"}, {"role": "user", "content": "Reply with only the exact file contents. Do not call a tool."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 48, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "stream": true}, "status": 200, "response": "data: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-953C3CB8-2140-47AA-9A8D-8D1B80BC4215\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"content\":\"OPEN\",\"role\":\"assistant\"},\"index\":0}],\"created\":1791031341}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-953C3CB8-2140-47AA-9A8D-8D1B80BC4215\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"AI\"}}],\"created\":1791031341}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-953C3CB8-2140-47AA-9A8D-8D1B80BC4215\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"_TOOL\"}}],\"created\":1791031341}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-953C3CB8-2140-47AA-9A8D-8D1B80BC4215\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"_FIX\"}}],\"created\":1791031341}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-953C3CB8-2140-47AA-9A8D-8D1B80BC4215\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"TURE\"}}],\"created\":1791031341}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-953C3CB8-2140-47AA-9A8D-8D1B80BC4215\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"_\"}}],\"created\":1791031341}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-953C3CB8-2140-47AA-9A8D-8D1B80BC4215\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"4\"}}],\"created\":1791031341}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-953C3CB8-2140-47AA-9A8D-8D1B80BC4215\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"2\"}}],\"created\":1791031341}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"finish_reason\":\"stop\",\"delta\":{}}],\"id\":\"chatcmpl-953C3CB8-2140-47AA-9A8D-8D1B80BC4215\",\"object\":\"chat.completion.chunk\",\"created\":1791031341}\n\ndata: [DONE]\n\n"}
{"case": "single-call", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 192, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "parallel_tool_calls": false, "tool_choice": "required"}, "status": 200, "response": "{\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-B72D2035-9712-4486-B183-7CF618D8B2C5\",\"object\":\"chat.completion\",\"choices\":[{\"finish_reason\":\"tool_calls\",\"message\":{\"role\":\"assistant\",\"content\":null,\"tool_calls\":[{\"function\":{\"name\":\"read_file\",\"arguments\":\"{\\\"path\\\":\\\"diagnostic.txt\\\",\\\"start_line\\\":1}\"},\"type\":\"function\",\"id\":\"call_0E6BF12EE00B4652ABD238BC7EF7F0BC\"}]},\"index\":0}],\"created\":1791031344,\"usage\":{\"total_tokens\":341,\"completion_tokens\":38,\"prompt_tokens\":303,\"prompt_tokens_details\":{\"cached_tokens\":0}}}"}
{"case": "parallel-calls", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file twice now: once for alpha.txt and once for beta.txt. Use start_line 1 in each call. Emit both calls before waiting for results."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 256, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "parallel_tool_calls": true, "tool_choice": "required", "stream": true}, "status": 200, "response": "data: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"content\":\"I\",\"role\":\"assistant\"},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"'ll\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\" make\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\" both\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\" calls\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\" in\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\" parallel\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\" since\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\" they\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"'re\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\" independent\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\".\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"\\n\\n\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"id\":\"call_725E88F4A71E44BEBE1189AFDD1543BE\",\"function\":{\"name\":\"read_file\",\"arguments\":\"\"},\"index\":0,\"type\":\"function\"}]}}],\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"index\":0,\"function\":{\"arguments\":\"{\\\"path\\\":\\\"\"}}]},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"index\":0,\"function\":{\"arguments\":\"alpha.txt\"}}]},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"index\":0,\"function\":{\"arguments\":\"\\\"\"}}]},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"index\":0,\"function\":{\"arguments\":\",\\\"start_line\\\":1\"}}]},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"index\":0,\"function\":{\"arguments\":\"}\"}}]},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"content\":\"\\n\"}}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"id\":\"call_987080C7E6D446B181ECF52B900E2FA0\",\"function\":{\"name\":\"read_file\",\"arguments\":\"\"},\"index\":1,\"type\":\"function\"}]}}],\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"created\":1791031355}\n\n: keepalive\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"index\":1,\"function\":{\"arguments\":\"{\\\"path\\\":\\\"\"}}]},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"index\":1,\"function\":{\"arguments\":\"beta.txt\"}}]},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"index\":1,\"function\":{\"arguments\":\"\\\"\"}}]},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"index\":1,\"function\":{\"arguments\":\",\\\"start_line\\\":1\"}}]},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"finish_reason\":null,\"delta\":{\"tool_calls\":[{\"index\":1,\"function\":{\"arguments\":\"}\"}}]},\"index\":0}],\"created\":1791031355}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"finish_reason\":\"tool_calls\",\"delta\":{}}],\"id\":\"chatcmpl-3CCF19B3-06E8-4EE1-850C-30D217364D16\",\"object\":\"chat.completion.chunk\",\"created\":1791031355}\n\ndata: [DONE]\n\n"}
{"case": "parallel-results", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file twice now: once for alpha.txt and once for beta.txt. Use start_line 1 in each call. Emit both calls before waiting for results."}, {"role": "assistant", "content": "I'll make both calls in parallel since they're independent.\n\n\n", "tool_calls": [{"id": "call_725E88F4A71E44BEBE1189AFDD1543BE", "type": "function", "function": {"name": "read_file", "arguments": "{\"path\":\"alpha.txt\",\"start_line\":1}"}}, {"id": "call_987080C7E6D446B181ECF52B900E2FA0", "type": "function", "function": {"name": "read_file", "arguments": "{\"path\":\"beta.txt\",\"start_line\":1}"}}]}, {"role": "tool", "tool_call_id": "call_987080C7E6D446B181ECF52B900E2FA0", "content": "SECOND_FIXTURE_29"}, {"role": "tool", "tool_call_id": "call_725E88F4A71E44BEBE1189AFDD1543BE", "content": "FIRST_FIXTURE_17"}, {"role": "user", "content": "Report each filename and its exact contents without a tool. Use exactly two lines in this format: alpha.txt=CONTENTS then beta.txt=CONTENTS."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 64, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}}, "status": 200, "response": "{\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-D7104082-A35D-408A-A53F-ED1919B1BF6C\",\"object\":\"chat.completion\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"alpha.txt=FIRST_FIXTURE_17\\nbeta.txt=SECOND_FIXTURE_29\"},\"finish_reason\":\"stop\"}],\"created\":1791031369,\"usage\":{\"total_tokens\":476,\"completion_tokens\":19,\"prompt_tokens\":457,\"prompt_tokens_details\":{\"cached_tokens\":256}}}"}
{"case": "disabled-tools", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Reply with only OK."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 32, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "tool_choice": "none"}, "status": 200, "response": "{\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":\"stop\",\"message\":{\"role\":\"assistant\",\"content\":\"OK\"},\"index\":0}],\"usage\":{\"completion_tokens\":1,\"total_tokens\":18,\"prompt_tokens_details\":{\"cached_tokens\":0},\"prompt_tokens\":17},\"id\":\"chatcmpl-E66493B4-9477-452E-9156-179C7B05B47C\",\"object\":\"chat.completion\",\"created\":1791031375}"}
{"case": "multiple-system-instructions", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "temperature": 0, "max_tokens": 32, "messages": [{"role": "system", "content": "The first half of the diagnostic code is ALPHA."}, {"role": "system", "content": "The second half of the diagnostic code is BETA."}, {"role": "user", "content": "Return only the two halves of the diagnostic code joined by a hyphen."}]}, "status": 200, "response": "{\"usage\":{\"completion_tokens\":4,\"total_tokens\":58,\"prompt_tokens_details\":{\"cached_tokens\":0},\"prompt_tokens\":54},\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"message\":{\"role\":\"assistant\",\"content\":\"ALPHA-BETA\"},\"index\":0,\"finish_reason\":\"stop\"}],\"object\":\"chat.completion\",\"created\":1791031376,\"id\":\"chatcmpl-20C46A1C-E26A-444F-96A9-4343CAEF2746\"}"}
{"case": "reasoning-stream", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "stream": true, "reasoning_effort": "low", "messages": [{"role": "user", "content": "What is 2+2? Answer briefly."}], "max_tokens": 384, "temperature": 0}, "status": 200, "response": "data: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":null,\"index\":0,\"delta\":{\"reasoning_content\":\"T\",\"role\":\"assistant\"}}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"he us\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"er\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\" asks a\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\" simple ari\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"thmetic q\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"u\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"e\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"s\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"t\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"i\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"on\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\".\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\" \"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"2\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"+2 = \"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"4. Th\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"ey\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\" want \"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"a brief\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\" \"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"a\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"reasoning_content\":\"nswer.\\n\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"index\":0,\"delta\":{\"content\":\"4\"},\"finish_reason\":null}],\"object\":\"chat.completion.chunk\",\"created\":1791031378,\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\"}\n\ndata: {\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-26F32AD7-0C10-4C40-88D0-F05404607980\",\"object\":\"chat.completion.chunk\",\"choices\":[{\"index\":0,\"delta\":{},\"finish_reason\":\"stop\"}],\"created\":1791031378}\n\ndata: [DONE]\n\n"}
{"case": "orphan-result", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "tool", "tool_call_id": "orphan", "content": "bad"}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 192, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}}, "status": 400, "response": "{\"error\":{\"type\":\"invalid_request_error\",\"message\":\"tool result must reference an outstanding tool_call_id exactly once\",\"code\":\"invalid_request_error\"}}"}
{"case": "missing-result", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}, {"role": "assistant", "content": null, "tool_calls": [{"function": {"name": "read_file", "arguments": "{\"path\":\"diagnostic.txt\",\"start_line\":1}"}, "type": "function", "id": "call_0E6BF12EE00B4652ABD238BC7EF7F0BC"}]}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 192, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}}, "status": 400, "response": "{\"error\":{\"type\":\"invalid_request_error\",\"message\":\"messages are missing tool results\",\"code\":\"invalid_request_error\"}}"}
{"case": "context-inflation", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 192, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32769}}, "status": 400, "response": "{\"error\":{\"type\":\"invalid_request_error\",\"message\":\"options.num_ctx must be between 1 and the served context limit 32768\",\"code\":\"invalid_request_error\"}}"}
{"case": "reasoning-conflict", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 192, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": true, "store": false, "options": {"num_ctx": 32768}}, "status": 400, "response": "{\"error\":{\"type\":\"invalid_request_error\",\"message\":\"think conflicts with reasoning_effort\",\"code\":\"invalid_request_error\"}}"}
{"case": "unknown-function", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 192, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "tool_choice": {"type": "function", "function": {"name": "absent"}}}, "status": 400, "response": "{\"error\":{\"type\":\"invalid_request_error\",\"message\":\"tool_choice must be auto, none, required, or a declared function\",\"code\":\"invalid_request_error\"}}"}
{"case": "structured-output", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 192, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "response_format": {"type": "json_schema", "json_schema": {"name": "title", "schema": {"type": "object"}}}}, "status": 400, "response": "{\"error\":{\"type\":\"invalid_request_error\",\"message\":\"response_format is not supported for constrained output; only {\\\"type\\\": \\\"text\\\"} is supported\",\"code\":\"invalid_request_error\"}}"}
{"case": "truncated-tool-False", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 1, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "tool_choice": "required", "stream": false, "stream_options": {"include_usage": true}}, "status": 200, "response": "{\"model\":\"qwen3.8-flash-next:4bit\",\"id\":\"chatcmpl-906049FA-807A-48AF-AAC1-A77A0FECF052\",\"object\":\"chat.completion\",\"choices\":[{\"finish_reason\":\"length\",\"message\":{\"role\":\"assistant\",\"content\":\"\"},\"index\":0}],\"created\":1791031383,\"usage\":{\"total_tokens\":294,\"completion_tokens\":1,\"prompt_tokens\":293,\"prompt_tokens_details\":{\"cached_tokens\":0}}}"}
{"case": "truncated-tool-True", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 1, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 32768}, "tool_choice": "required", "stream": true, "stream_options": {"include_usage": true}}, "status": 200, "response": "data: {\"model\":\"qwen3.8-flash-next:4bit\",\"choices\":[{\"finish_reason\":\"length\",\"index\":0,\"delta\":{}}],\"usage\":{\"completion_tokens\":1,\"total_tokens\":294,\"prompt_tokens_details\":{\"cached_tokens\":256},\"prompt_tokens\":293},\"id\":\"chatcmpl-5975C3DB-1D0E-434B-B5B7-AA577075DFC4\",\"object\":\"chat.completion.chunk\",\"created\":1791031388}\n\ndata: [DONE]\n\n"}
{"case": "smaller-request-context", "path": "/v1/chat/completions", "request": {"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "Call read_file for diagnostic.txt with start_line 1. Wait for its result."}], "tools": [{"type": "function", "function": {"name": "read_file", "description": "Read a named diagnostic file.", "strict": false, "parameters": {"type": "object", "properties": {"path": {"type": "string"}, "start_line": {"type": "integer", "default": null}}, "required": ["path"]}}}], "max_tokens": 192, "temperature": 0, "seed": 42, "reasoning_effort": "none", "think": false, "store": false, "options": {"num_ctx": 1}}, "status": 400, "response": "{\"error\":{\"type\":\"context_length_exceeded\",\"message\":\"prompt is 282 tokens, leaving no reply room in the requested context limit 1\",\"code\":\"context_length_exceeded\"}}"}
{"case": "survives-errors", "path": "/api/version", "request": null, "status": 200, "response": "{\"version\":\"0.2.27\"}"}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/restart-command.json

Original bytes: 431. SHA-256: `4211ae028ee2717d821b5d130f650c19a862ef3f295686bf6685a1f86c6f2aa5`.

Normalized bytes: 417. SHA-256: `a899fe76e3e858c57d0c219d5fe47ec912ffe66cebfac2745226e359649a2625`.

````text
[
  "<HOME>/Projects/slotstream/.build/quantization-research/frozen-dense-overlay-v2/slotstream",
  "serve",
  "--memory-gb",
  "8.1",
  "--max-context",
  "32768",
  "--vision",
  "off",
  "--mtp",
  "off",
  "--port",
  "51267",
  "--prefix-cache-dir",
  "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix",
  "--prefix-cache-min-tokens",
  "512"
]
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/restart-result.json

Original bytes: 191. SHA-256: `48b4f9f0fa90468740f6af41ce27282149de9e242e8b47cdf49183efabe407ef`.

Normalized bytes: 191. SHA-256: `48b4f9f0fa90468740f6af41ce27282149de9e242e8b47cdf49183efabe407ef`.

````text
{
  "same_message": true,
  "usage": {
    "prompt_tokens": 1654,
    "completion_tokens": 29,
    "total_tokens": 1683,
    "prompt_tokens_details": {
      "cached_tokens": 1536
    }
  }
}
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/restart-server.log

Original bytes: 2070. SHA-256: `8605f06bde8a716885ee9fd29897a7396ff3c9b9f5c38228ab84a080a5d15d53`.

Normalized bytes: 2063. SHA-256: `95af353ce563aa8c36087020d78ab110e2ed0a0819c0a7886c72f4df5cdd01b8`.

````text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (27.3 GB reclaimable now), 40.2 GB Metal working set
  target: 8.1 GB total process budget, not a RAM usage goal
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  plan:   ~7.9 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 1.8 GB expert cache at load; 6.2 GB allowed for runtime, context and workspace; 0.2 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 6510 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.8s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
prefix cache disk: <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix holds 8 states (1.04 GB of 20.00 GB); writes states of 512 tokens or more; forgets states unused for 30 days
elastic: off — an explicit size is pinned; omit the size flag for elastic auto
slotstream listening on http://127.0.0.1:51267
try it:
  curl localhost:51267/api/chat -d '{"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "hello"}]}'
or point any Ollama or OpenAI client at http://localhost:51267
[7:43:19 AM] request 2DCCDC7A /v1/chat/completions: accepted
[7:43:19 AM] prefix cache disk: restored 1536 tokens (158.1 MB) in 0.03 s
prefix cache: reusing 1536/1654 tokens from disk
[7:43:25 AM] request 2DCCDC7A /v1/chat/completions: ended after 6.9 s
[7:43:25 AM] stopping: asked to stop (SIGTERM)
````

### vq-dense-overlay-acceptance-v1/verify-results/issue21/result.json

Original bytes: 36962. SHA-256: `114fa0c70bed26c24eb0baf595833d0f6b1c15ad3a394c3fdb6adb46b366735f`.

Normalized bytes: 36955. SHA-256: `bb9e722ca39f98c6f828a67424facd493eae5881b99847e328dc9c8c6066f47f`.

````text
{
  "passed": true,
  "build": {
    "binary": "<HOME>/Projects/slotstream/.build/quantization-research/frozen-dense-overlay-v2/slotstream",
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
        "Sources/Slotstream/VQCheckpoint.swift": "5b6d5877b28ea19ad3624dfe1d660db3a2dab7da19212e060c097da1712b7c17",
        "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
        "Sources/Slotstream/VQDenseOverlay.swift": "0102f31346cb84048b551265696cd4bcf4dd7f2a73c60be6840d654f9c4a2978",
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
        "Sources/Slotstream/VQResidentText.swift": "4ac08a39de539afef273d7925779a9ce175319d21bf6c44b3205ef20393c9592",
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
        "Sources/SlotstreamDiagnostics/Diagnostics+Quantization.swift": "10c55f4cdae07ee3616899d3c80c7e0d34186e00eb71512a1385ad15bacef6cd",
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
        "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "747654d88e344d45b3cc0c8c1d3796343186d247065fd66f6377d72d7051bf7a",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "d6aaa6d637b8e0a6ebbb709fa2eaf8b223ebd6f95854b596347b3da5fce1aa04",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "169fa926a8ed7dc630ab5ac6a6d11d684194c944cfa68607583ccada8a19bcda",
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
        "Sources/slotstream-cli/QuantizationCommands.swift": "4c8f6db56c024cc1dec2205e92f89c13dfc57314d0561b9493cc60c1c6700be8",
        "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
        "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
        "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
        "Sources/slotstream-cli/main.swift": "1539fa20986c554865714a5b17d23c5563917419fd044ec2ab3972b8608f9355",
        "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
        "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
        "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
      },
      "source_archive_sha256": "34322a2ae7f1e0c8d281ee2177281a19c1e8266debf2f64a1d6969fd85c07dfc",
      "binary_sha256": "2ce253c1583b96921bf410ef4bfa8d0f6a0526567e46cf37041e35a534809076",
      "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
    }
  },
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 28871655424,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   433850.\nPages active:                                 745064.\nPages inactive:                               648008.\nPages speculative:                            104216.\nPages throttled:                                   0.\nPages wired down:                             178925.\nPages purgeable:                                  48.\n\"Translation faults\":                     1851726133.\nPages copy-on-write:                        91181421.\nPages zero filled:                        3054768570.\nPages reactivated:                         142801229.\nPages purged:                               12037280.\nFile-backed pages:                           1328288.\nAnonymous pages:                              169000.\nPages stored in compressor:                  1800608.\nPages occupied by compressor:                 974588.\nDecompressions:                             89720305.\nCompressions:                              102615877.\nPageins:                                  1880807691.\nPageouts:                                     456031.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 128257.\nPages tagged resident:                         74638.\nPages tagged compressed:                       53619.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5189.\nPages tag-storage free:                          587.\nPages tag-storage non-tag pageable:            92520.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8624896.\nTagged compressions:                          648476.\nTagged decompressions:                        529091.\n"
  },
  "servers": [
    {
      "pid": 94523,
      "exit_code": 0
    },
    {
      "pid": 95781,
      "exit_code": 0
    }
  ],
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 27205255168,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   326072.\nPages active:                                 549681.\nPages inactive:                              1145527.\nPages speculative:                             43727.\nPages throttled:                                   0.\nPages wired down:                             178815.\nPages purgeable:                                  78.\n\"Translation faults\":                     1854855380.\nPages copy-on-write:                        91298545.\nPages zero filled:                        3060955573.\nPages reactivated:                         155369354.\nPages purged:                               12063773.\nFile-backed pages:                           1334327.\nAnonymous pages:                              404608.\nPages stored in compressor:                  1564922.\nPages occupied by compressor:                 841333.\nDecompressions:                             90936999.\nCompressions:                              103656877.\nPageins:                                  1903360324.\nPageouts:                                     457315.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 128072.\nPages tagged resident:                         75308.\nPages tagged compressed:                       52764.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          707.\nPages tag-storage non-tag pageable:            92402.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8503360.\nTagged compressions:                          658501.\nTagged decompressions:                        539936.\n"
  }
}
````

### vq-dense-overlay-acceptance-v1/verify-results/model-verification/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-dense-overlay-acceptance-v1/verify-results/model-verification/stdout.txt

Original bytes: 1031. SHA-256: `d88a51de9d4b5b8d81b48e3b969141655075e37063b5b8d0e0fd2a886cb368c9`.

Normalized bytes: 1024. SHA-256: `d9b11dfe0c1d77914e82d15cf5cfdaa80ecb5cb048b2073c276a6511da1f0efe`.

````text
verifying 25 files at <HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit against pipenetwork/Qwen3.8-Flash-Next-MLX-4bit @ aa7c790e804b
  ok    config.json
  ok    generation_config.json
  ok    chat_template.jinja
  ok    LICENSE
  ok    README.md
  ok    model.safetensors.index.json
  ok    preprocessor_config.json
  ok    merges.txt
  ok    video_preprocessor_config.json
  ok    qwen4_exp.py
  ok    tokenizer_config.json
  ok    vocab.json
  ok    tokenizer.json
  ok    mtp.safetensors
  ok    model-00011.safetensors
  ok    model-00003.safetensors
  ok    model-00002.safetensors
  ok    model-00001.safetensors
  ok    model-00004.safetensors
  ok    model-00007.safetensors
  ok    model-00005.safetensors
  ok    model-00009.safetensors
  ok    model-00008.safetensors
  ok    model-00006.safetensors
  ok    model-00010.safetensors
VERIFY PASS: all 25 files match the pinned revision by sha256 (105.3 GB)
lookahead/tap-correction-attention-rank128-v1.safetensors: present, digest verified (optional sidecar)
````

### vq-dense-overlay-acceptance-v1/verify-results/mtp-legacy-reference.txt

Original bytes: 216. SHA-256: `c0f4555eac5e1d29a189fb5f19faa160761a76eec8054a5cc645d7dcbcea5c06`.

Normalized bytes: 216. SHA-256: `c0f4555eac5e1d29a189fb5f19faa160761a76eec8054a5cc645d7dcbcea5c06`.

````text
prefill sample: max abs 5.62500  rel 0.15625  FAIL
prefill multi: max abs 1.22070  rel 0.09527  FAIL
decode sample: max abs 1.90625  rel 0.05117  FAIL
decode multi: max abs 0.33545  rel 0.05650  FAIL
MTP PARITY FAIL
````

### vq-dense-overlay-acceptance-v1/verify-results/mtp.txt

Original bytes: 3599. SHA-256: `022eab299fcb70473a9c40a4985af4501017c7ff0955e4093d8639c60c120f91`.

Normalized bytes: 3599. SHA-256: `022eab299fcb70473a9c40a4985af4501017c7ff0955e4093d8639c60c120f91`.

````text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (26.0 GB reclaimable now), 40.2 GB Metal working set
  target: 12.0 GB total process budget, not a RAM usage goal
  cache:  ~26 of 512 experts per layer  (1225 global slots = 3.4 GB pool)
  plan:   ~11.0 GB full-workload envelope, ~5 tok/s warm decode (est. from M5 Pro anchors)
  memory: 3.4 GB expert cache at load; 7.6 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode; its experts stream through a 64-expert cache (0.4 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~4.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 17658 tokens across 4 conversations (~0.8 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.9s: expert cache ~26/512 per layer (1225 global slots = 3.4 GB), mtp draft head on, eos [248044, 248046]
PASS  determinism p1 (48 tokens)
PASS  speculation ran p1
  info  p1: plain vs spec shared prefix 48/48 (identical)
PASS  determinism p2 (48 tokens)
PASS  speculation ran p2
  info  p2: plain vs spec shared prefix 48/48 (identical)
PASS  determinism p3 (48 tokens)
PASS  speculation ran p3
  info  p3: plain vs spec shared prefix 6/48
  info  vision+mtp prompt: 721 tokens, 1 image(s), placeholder id 248056
PASS  vision speculation deterministic (48 tokens)
PASS  vision speculation ran
  info  vision plain vs spec shared prefix 48/48 (identical)
  info  overall accept rate 81.2%
PASS  accept rate is not degenerate (>5%)
  info  recording pass vs batched: 0.0000% of spread (top-1 same); rollback state vs plain: ssm 2.09e-02, conv 3.10e-02, ple 4.48e-03 relative (re-chunk control: ssm 9.11e-02, conv 6.83e-02, ple 1.79e-02); one more step: 1.270% vs control 2.312% (bound 6.935%, top-1 same)
PASS  recording verify pass matches the batched pass (<= 0.1% of spread)
PASS  rollback state stays inside 3x the re-chunk band (ssm, conv, ple)
PASS  rollback then one step stays inside the prefill-rechunk band
PASS  turn-2 reused the speculative turn-1 state
  info  turn-2 logits from the reused speculative state: 4.333% of spread vs a cold rebuild (prefill-rechunk control 4.655%, bound 13.964%), top-1 same; reused 64 of 71 tokens after a 48-token turn 1 (20 verify passes)
PASS  reused speculative state stays inside the prefill-rechunk band
PASS  turn-1 speculation ran
PASS  whole MTP check process memory fits the priced target
MTP CHECK PASS
MTP CHECK MEMORY {"lifetime_physical_footprint_peak_bytes":9819526568,"lifetime_rss_peak_bytes":6556565504,"memory_validated":true,"physical_footprint_end_bytes":9474054960,"sampled_peak_bytes":9819460936,"samples":6130,"swap_clean":true,"swapins_after":20,"swapins_before":20,"swapouts_after":2908,"swapouts_before":2908,"target_gb":12}
````

### vq-dense-overlay-acceptance-v1/verify-results/vision-parity/manifest.json

Original bytes: 475. SHA-256: `133c1a1478935c19fe10083706e98e0697d5de77f84a644cf2f05108a6fc35e4`.

Normalized bytes: 475. SHA-256: `133c1a1478935c19fe10083706e98e0697d5de77f84a644cf2f05108a6fc35e4`.

````text
{
  "attention_padding" : 0,
  "attention_query_tile" : 256,
  "depth" : 27,
  "features_per_patch" : 1536,
  "grid_h" : 54,
  "grid_w" : 52,
  "height" : 864,
  "hidden_size" : 1152,
  "image" : ".\/Tools\/assets\/vision_test\/secret1.jpg",
  "merged_tokens" : 702,
  "model_dir" : "\/Users\/carlos\/.slotstream\/models\/qwen38-flash-next-mlx-4bit",
  "num_heads" : 16,
  "out_hidden_size" : 2560,
  "patches" : 2808,
  "resident_gb" : 0.89786211199999999,
  "width" : 832
}
````

### vq-dense-overlay-reference-repair-v1/layers-native-supervision/identity.json

Original bytes: 2469. SHA-256: `28a8336b5e6b3790faff711322900882eeb24949bceb6043add35eef2cc7ac12`.

Normalized bytes: 2455. SHA-256: `5db8d9fd81fa104fca07a76f9e6fcfa2b79e1f01396e700770edf4e912004f8b`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-dense-overlay-v2/slotstream",
    "parity",
    "--tokens",
    "9707,11,1246,525,498,30",
    "--layers",
    "2",
    "--compare",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/layers-reference"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 27153367040,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   329235.\nPages active:                                 761227.\nPages inactive:                               695433.\nPages speculative:                            254985.\nPages throttled:                                   0.\nPages wired down:                             179534.\nPages purgeable:                                 879.\n\"Translation faults\":                     1859291309.\nPages copy-on-write:                        91489191.\nPages zero filled:                        3087760540.\nPages reactivated:                         170801198.\nPages purged:                               12088228.\nFile-backed pages:                           1327196.\nAnonymous pages:                              384449.\nPages stored in compressor:                  1586815.\nPages occupied by compressor:                 863633.\nDecompressions:                             91948596.\nCompressions:                              104795263.\nPageins:                                  1938218923.\nPageouts:                                     458539.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127527.\nPages tagged resident:                         75345.\nPages tagged compressed:                       52182.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                         1687.\nPages tag-storage non-tag pageable:            91422.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8339520.\nTagged compressions:                          670984.\nTagged decompressions:                        551705.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-dense-overlay-reference-repair-v1/layers-native-supervision/receipt.json

Original bytes: 2139. SHA-256: `7d41254121b56e44a3fb4fba2590e55ff44f0310bb004cdf2f52b33dc7f69acb`.

Normalized bytes: 2139. SHA-256: `7d41254121b56e44a3fb4fba2590e55ff44f0310bb004cdf2f52b33dc7f69acb`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 8386628608,
  "samples": 13,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24751570944,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   328322.\nPages active:                                 812794.\nPages inactive:                               589715.\nPages speculative:                            151031.\nPages throttled:                                   0.\nPages wired down:                             296326.\nPages purgeable:                                 385.\n\"Translation faults\":                     1859473435.\nPages copy-on-write:                        91489664.\nPages zero filled:                        3088273108.\nPages reactivated:                         170975139.\nPages purged:                               12088232.\nFile-backed pages:                           1182009.\nAnonymous pages:                              371529.\nPages stored in compressor:                  1668124.\nPages occupied by compressor:                 907012.\nDecompressions:                             91949283.\nCompressions:                              104877279.\nPageins:                                  1938339392.\nPageouts:                                     458776.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127587.\nPages tagged resident:                         74789.\nPages tagged compressed:                       52798.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          415.\nPages tag-storage non-tag pageable:            92694.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8471744.\nTagged compressions:                          671606.\nTagged decompressions:                        551711.\n"
  },
  "seconds": 0.7417475419933908
}
````

### vq-dense-overlay-reference-repair-v1/layers-native-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-dense-overlay-reference-repair-v1/layers-native-supervision/stdout.txt

Original bytes: 98. SHA-256: `f85b350626ae650fae0218889496b1fdf21f5aa75f76668edd4f58730f222389`.

Normalized bytes: 98. SHA-256: `f85b350626ae650fae0218889496b1fdf21f5aa75f76668edd4f58730f222389`.

````text
layer  0: max abs 0.00000, rel 0.00000  OK
layer  1: max abs 0.00049, rel 0.00114  OK
PARITY PASS
````

### vq-dense-overlay-reference-repair-v1/layers-reference/receipt.json

Original bytes: 4845. SHA-256: `c677d2c3f96b8bcd2a430d739d9b0a2a7392b8849843e619f403e67681657f8d`.

Normalized bytes: 4845. SHA-256: `c677d2c3f96b8bcd2a430d739d9b0a2a7392b8849843e619f403e67681657f8d`.

````text
{
  "mlx": "0.32.2",
  "kind": "layers",
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 27148910592,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   523118.\nPages active:                                 759624.\nPages inactive:                               503076.\nPages speculative:                            256024.\nPages throttled:                                   0.\nPages wired down:                             178445.\nPages purgeable:                                 871.\n\"Translation faults\":                     1859071059.\nPages copy-on-write:                        91488281.\nPages zero filled:                        3087543720.\nPages reactivated:                         170801173.\nPages purged:                               12088228.\nFile-backed pages:                           1133049.\nAnonymous pages:                              385675.\nPages stored in compressor:                  1587432.\nPages occupied by compressor:                 863846.\nDecompressions:                             91947979.\nCompressions:                              104795263.\nPageins:                                  1938031626.\nPageouts:                                     458539.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127567.\nPages tagged resident:                         75382.\nPages tagged compressed:                       52185.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                         1679.\nPages tag-storage non-tag pageable:            91430.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8340032.\nTagged compressions:                          670984.\nTagged decompressions:                        551702.\n"
  },
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23643013120,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   114987.\nPages active:                                 767117.\nPages inactive:                               695924.\nPages speculative:                            255003.\nPages throttled:                                   0.\nPages wired down:                             387522.\nPages purgeable:                                 879.\n\"Translation faults\":                     1859284729.\nPages copy-on-write:                        91488672.\nPages zero filled:                        3087759362.\nPages reactivated:                         170801198.\nPages purged:                               12088228.\nFile-backed pages:                           1327189.\nAnonymous pages:                              390855.\nPages stored in compressor:                  1586830.\nPages occupied by compressor:                 863636.\nDecompressions:                             91948581.\nCompressions:                              104795263.\nPageins:                                  1938218919.\nPageouts:                                     458539.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127616.\nPages tagged resident:                         75433.\nPages tagged compressed:                       52183.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                         1686.\nPages tag-storage non-tag pageable:            91423.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8339584.\nTagged compressions:                          670984.\nTagged decompressions:                        551704.\n"
  },
  "mlx_peak_bytes": 3320284982,
  "process_memory": {
    "current_bytes": 3500887136,
    "lifetime_peak_bytes": 3500887136,
    "rss_peak_bytes": 3437740032
  },
  "method": "Run the independent Python model implementation on MLX 0.32.2.\n\nWrite live comparison outputs to an explicitly new experiment directory.\nNever update the historical parity or MTP golden fixtures. These comparisons\ncheck the Swift port; the float64 component oracles check the shared kernels.\n",
  "script_sha256": "42d0ae3c09f97514f0599c82c890aaf6c3214415584631af806b51bae2d70b95",
  "reference_sources": {
    "qwen4_exp.py": "6fae4ec0decbf77ca4a4571de683bc5580ec75e84325ecb432dfcd2fc81df75e",
    "Tools/parity_ref.py": "cb938f6215f1433bbc6eef2b8cc04a8a9cf9d5953f487347649637fa911abab6"
  }
}
````

### vq-dense-overlay-reference-repair-v1/layers-reference-supervision/identity.json

Original bytes: 2402. SHA-256: `d6c226c1bf93cc7a02d5d3c89bb440f8463251856185fce23f6334ca82526402`.

Normalized bytes: 2388. SHA-256: `3ccdd14d3b89ba3621d25c06be36c3ecdca5c83c1158d3073305d10132f780ef`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "Tools/current_backend_reference.py",
    "--kind",
    "layers",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/layers-reference"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 27162918912,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   523982.\nPages active:                                 758837.\nPages inactive:                               502946.\nPages speculative:                            256148.\nPages throttled:                                   0.\nPages wired down:                             178424.\nPages purgeable:                                 871.\n\"Translation faults\":                     1859067183.\nPages copy-on-write:                        91487724.\nPages zero filled:                        3087542880.\nPages reactivated:                         170801173.\nPages purged:                               12088228.\nFile-backed pages:                           1133040.\nAnonymous pages:                              384891.\nPages stored in compressor:                  1587434.\nPages occupied by compressor:                 863847.\nDecompressions:                             91947977.\nCompressions:                              104795263.\nPageins:                                  1938031616.\nPageouts:                                     458539.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127568.\nPages tagged resident:                         75382.\nPages tagged compressed:                       52186.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                         1679.\nPages tag-storage non-tag pageable:            91430.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8340096.\nTagged compressions:                          670984.\nTagged decompressions:                        551701.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-dense-overlay-reference-repair-v1/layers-reference-supervision/receipt.json

Original bytes: 2139. SHA-256: `5a8b1cba8a4cb22c5f3d99897240c61d27516e7be70bbd4b4cae6e547d610932`.

Normalized bytes: 2139. SHA-256: `5a8b1cba8a4cb22c5f3d99897240c61d27516e7be70bbd4b4cae6e547d610932`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 3500936288,
  "samples": 23,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 27154284544,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   329293.\nPages active:                                 761181.\nPages inactive:                               695410.\nPages speculative:                            255006.\nPages throttled:                                   0.\nPages wired down:                             179534.\nPages purgeable:                                 879.\n\"Translation faults\":                     1859288653.\nPages copy-on-write:                        91488803.\nPages zero filled:                        3087759419.\nPages reactivated:                         170801198.\nPages purged:                               12088228.\nFile-backed pages:                           1327194.\nAnonymous pages:                              384403.\nPages stored in compressor:                  1586828.\nPages occupied by compressor:                 863635.\nDecompressions:                             91948583.\nCompressions:                              104795263.\nPageins:                                  1938218920.\nPageouts:                                     458539.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127527.\nPages tagged resident:                         75345.\nPages tagged compressed:                       52182.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                         1687.\nPages tag-storage non-tag pageable:            91422.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8339520.\nTagged compressions:                          670984.\nTagged decompressions:                        551705.\n"
  },
  "seconds": 1.3643968749966007
}
````

### vq-dense-overlay-reference-repair-v1/layers-reference-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-dense-overlay-reference-repair-v1/layers-reference-supervision/stdout.txt

Original bytes: 60. SHA-256: `b4b19fa128ae1d7f77e49fb1f0818dc9e42caa8ab82b8f34d675abfcca3852af`.

Normalized bytes: 60. SHA-256: `b4b19fa128ae1d7f77e49fb1f0818dc9e42caa8ab82b8f34d675abfcca3852af`.

````text
completed independent layer 0
completed independent layer 1
````

### vq-dense-overlay-reference-repair-v1/mtp-native-supervision/identity.json

Original bytes: 2421. SHA-256: `149e259ec610ce0e59c57e708dd789cb65ca6aa3e83d1fd0afd537da39dabf60`.

Normalized bytes: 2407. SHA-256: `ebf7568033f19a42d085be783c1607113b65c92439f4f74ba879a9613f639367`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-dense-overlay-v2/slotstream",
    "mtp-parity",
    "--fixture",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/mtp-reference/comparison.safetensors"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 27811676160,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   423966.\nPages active:                                 745257.\nPages inactive:                               677350.\nPages speculative:                            153678.\nPages throttled:                                   0.\nPages wired down:                             178538.\nPages purgeable:                                 387.\n\"Translation faults\":                     1859587399.\nPages copy-on-write:                        91491418.\nPages zero filled:                        3088378315.\nPages reactivated:                         170975139.\nPages purged:                               12088232.\nFile-backed pages:                           1273137.\nAnonymous pages:                              303148.\nPages stored in compressor:                  1666132.\nPages occupied by compressor:                 906502.\nDecompressions:                             91951261.\nCompressions:                              104877279.\nPageins:                                  1938428041.\nPageouts:                                     458776.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127474.\nPages tagged resident:                         74958.\nPages tagged compressed:                       52516.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          454.\nPages tag-storage non-tag pageable:            92655.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8407040.\nTagged compressions:                          671606.\nTagged decompressions:                        551993.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-dense-overlay-reference-repair-v1/mtp-native-supervision/receipt.json

Original bytes: 2139. SHA-256: `67b7f3e573d456851b0d9834f4adf85673f663b57d44a646c3e5eb9e2997257d`.

Normalized bytes: 2139. SHA-256: `67b7f3e573d456851b0d9834f4adf85673f663b57d44a646c3e5eb9e2997257d`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 1591199592,
  "samples": 3,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 27811938304,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   423703.\nPages active:                                 745327.\nPages inactive:                               678653.\nPages speculative:                            152622.\nPages throttled:                                   0.\nPages wired down:                             178538.\nPages purgeable:                                 387.\n\"Translation faults\":                     1859683021.\nPages copy-on-write:                        91491895.\nPages zero filled:                        3088475977.\nPages reactivated:                         170975139.\nPages purged:                               12088232.\nFile-backed pages:                           1273416.\nAnonymous pages:                              303186.\nPages stored in compressor:                  1666100.\nPages occupied by compressor:                 906498.\nDecompressions:                             91951293.\nCompressions:                              104877279.\nPageins:                                  1938428342.\nPageouts:                                     458776.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127508.\nPages tagged resident:                         75000.\nPages tagged compressed:                       52508.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          486.\nPages tag-storage non-tag pageable:            92623.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8405824.\nTagged compressions:                          671606.\nTagged decompressions:                        552001.\n"
  },
  "seconds": 0.18482191700604744
}
````

### vq-dense-overlay-reference-repair-v1/mtp-native-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-dense-overlay-reference-repair-v1/mtp-native-supervision/stdout.txt

Original bytes: 208. SHA-256: `6baff6abfec4abcd9c1eef27f79e5c7faa4128be16bf78fc4b1a590a47329f7f`.

Normalized bytes: 208. SHA-256: `6baff6abfec4abcd9c1eef27f79e5c7faa4128be16bf78fc4b1a590a47329f7f`.

````text
prefill sample: max abs 0.00000  rel 0.00000  OK
prefill multi: max abs 0.00000  rel 0.00000  OK
decode sample: max abs 0.00000  rel 0.00000  OK
decode multi: max abs 0.00000  rel 0.00000  OK
MTP PARITY PASS
````

### vq-dense-overlay-reference-repair-v1/mtp-reference/receipt.json

Original bytes: 4995. SHA-256: `2fca217ce15434acecbe36d59fe3327f7213e636253e0f978be8511d01d3912c`.

Normalized bytes: 4995. SHA-256: `2fca217ce15434acecbe36d59fe3327f7213e636253e0f978be8511d01d3912c`.

````text
{
  "mlx": "0.32.2",
  "kind": "mtp",
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 27829026816,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   516041.\nPages active:                                 741995.\nPages inactive:                               589741.\nPages speculative:                            151133.\nPages throttled:                                   0.\nPages wired down:                             179621.\nPages purgeable:                                 385.\n\"Translation faults\":                     1859479359.\nPages copy-on-write:                        91490622.\nPages zero filled:                        3088274946.\nPages reactivated:                         170975139.\nPages purged:                               12088232.\nFile-backed pages:                           1182123.\nAnonymous pages:                              300746.\nPages stored in compressor:                  1668079.\nPages occupied by compressor:                 906995.\nDecompressions:                             91949328.\nCompressions:                              104877279.\nPageins:                                  1938339491.\nPageouts:                                     458776.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127502.\nPages tagged resident:                         74730.\nPages tagged compressed:                       52772.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          387.\nPages tag-storage non-tag pageable:            92722.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8465920.\nTagged compressions:                          671606.\nTagged decompressions:                        551737.\n"
  },
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 26161315840,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   323252.\nPages active:                                 746292.\nPages inactive:                               680170.\nPages speculative:                            153686.\nPages throttled:                                   0.\nPages wired down:                             275203.\nPages purgeable:                                 377.\n\"Translation faults\":                     1859580332.\nPages copy-on-write:                        91490893.\nPages zero filled:                        3088377158.\nPages reactivated:                         170975139.\nPages purged:                               12088232.\nFile-backed pages:                           1273131.\nAnonymous pages:                              307017.\nPages stored in compressor:                  1666523.\nPages occupied by compressor:                 906628.\nDecompressions:                             91950870.\nCompressions:                              104877279.\nPageins:                                  1938428037.\nPageouts:                                     458776.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127485.\nPages tagged resident:                         74741.\nPages tagged compressed:                       52744.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          420.\nPages tag-storage non-tag pageable:            92689.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8460864.\nTagged compressions:                          671606.\nTagged decompressions:                        551765.\n"
  },
  "mlx_peak_bytes": 1481402066,
  "process_memory": {
    "current_bytes": 1642972984,
    "lifetime_peak_bytes": 1642972984,
    "rss_peak_bytes": 1586085888
  },
  "method": "Run the independent Python model implementation on MLX 0.32.2.\n\nWrite live comparison outputs to an explicitly new experiment directory.\nNever update the historical parity or MTP golden fixtures. These comparisons\ncheck the Swift port; the float64 component oracles check the shared kernels.\n",
  "script_sha256": "42d0ae3c09f97514f0599c82c890aaf6c3214415584631af806b51bae2d70b95",
  "reference_sources": {
    "Tools/reference/mtp_ref.py": "f28827ac0409fe58b9c255f16add5ecb00b17a2310a3521d75a677f2d4a84f24",
    "Tools/reference/qwen4_exp.py": "6fae4ec0decbf77ca4a4571de683bc5580ec75e84325ecb432dfcd2fc81df75e",
    "Tools/reference/fixtures/mtp_parity_inputs.safetensors": "1ffbf5d7d280e27cd0b63752607afed7a0febb1ea7e6fa1858297dea5517decb"
  }
}
````

### vq-dense-overlay-reference-repair-v1/mtp-reference-supervision/identity.json

Original bytes: 2396. SHA-256: `d8fc6c5012a5d5fe3399c6dae502a6718ea272e9ebefc646b3cb7960a2f29e7a`.

Normalized bytes: 2382. SHA-256: `ace4fa77ec069f6cc674aa8c6cd8adcf5c9543881997bffaa2fed2791740cc3a`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "Tools/current_backend_reference.py",
    "--kind",
    "mtp",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/mtp-reference"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 27841003520,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   516834.\nPages active:                                 741433.\nPages inactive:                               589505.\nPages speculative:                            151064.\nPages throttled:                                   0.\nPages wired down:                             179600.\nPages purgeable:                                 385.\n\"Translation faults\":                     1859476155.\nPages copy-on-write:                        91490059.\nPages zero filled:                        3088274201.\nPages reactivated:                         170975139.\nPages purged:                               12088232.\nFile-backed pages:                           1182061.\nAnonymous pages:                              299941.\nPages stored in compressor:                  1668088.\nPages occupied by compressor:                 906996.\nDecompressions:                             91949319.\nCompressions:                              104877279.\nPageins:                                  1938339436.\nPageouts:                                     458776.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127510.\nPages tagged resident:                         74730.\nPages tagged compressed:                       52780.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          403.\nPages tag-storage non-tag pageable:            92706.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8467136.\nTagged compressions:                          671606.\nTagged decompressions:                        551729.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-dense-overlay-reference-repair-v1/mtp-reference-supervision/receipt.json

Original bytes: 2139. SHA-256: `8c97fbbd9ca812640a7d0a175c675312ef698b2b869115b421cc18021db3b563`.

Normalized bytes: 2139. SHA-256: `8c97fbbd9ca812640a7d0a175c675312ef698b2b869115b421cc18021db3b563`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 1643005752,
  "samples": 14,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 27812577280,
    "swapins": 20,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   424022.\nPages active:                                 744824.\nPages inactive:                               677376.\nPages speculative:                            153683.\nPages throttled:                                   0.\nPages wired down:                             178538.\nPages purgeable:                                 387.\n\"Translation faults\":                     1859584092.\nPages copy-on-write:                        91491023.\nPages zero filled:                        3088377216.\nPages reactivated:                         170975139.\nPages purged:                               12088232.\nFile-backed pages:                           1273136.\nAnonymous pages:                              302747.\nPages stored in compressor:                  1666522.\nPages occupied by compressor:                 906627.\nDecompressions:                             91950871.\nCompressions:                              104877279.\nPageins:                                  1938428038.\nPageouts:                                     458776.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127446.\nPages tagged resident:                         74702.\nPages tagged compressed:                       52744.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          449.\nPages tag-storage non-tag pageable:            92660.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8460864.\nTagged compressions:                          671606.\nTagged decompressions:                        551765.\n"
  },
  "seconds": 0.8379339169769082
}
````

### vq-dense-overlay-reference-repair-v1/mtp-reference-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-dense-overlay-reference-repair-v1/mtp-reference-supervision/stdout.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-dense-overlay-reference-repair-v1/run.json

Original bytes: 11974. SHA-256: `cefc3212f35f93adaaca64909d02843e45e40724b7fdbbb060089eeac22636c2`.

Normalized bytes: 11869. SHA-256: `44392301a2095b479ad43fd135b923d7d0606cdb47999c8f958e0dd77f0dc529`.

````text
{
  "schema": 1,
  "complete": true,
  "started_at": "2026-10-03T12:48:31.415996+00:00",
  "producer_sha256": "2ce253c1583b96921bf410ef4bfa8d0f6a0526567e46cf37041e35a534809076",
  "scope": "Repair only four current-backend checks whose temporary driver resolved the venv interpreter symlink; retain original failed campaign",
  "maximum_seconds": 3600,
  "original_failures": [
    "FAIL  independent current-backend layer reference (details: <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/check-4.txt)",
    "FAIL  production layer parity against current backend (details: <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/check-5.txt)",
    "FAIL  independent current-backend draft-head reference (details: <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/check-13.txt)",
    "FAIL  mtp head parity vs current Python reference (mtp-parity) (details: <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-acceptance-v1/verify-results/check-14.txt)"
  ],
  "runs": [
    {
      "name": "layers-reference",
      "command": [
        "<HOME>/Projects/slotstream/.venv/bin/python",
        "Tools/current_backend_reference.py",
        "--kind",
        "layers",
        "--out",
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/layers-reference"
      ],
      "exit_code": 0,
      "failure": null,
      "sampled_peak_bytes": 3500936288,
      "samples": 23,
      "after": {
        "page_bytes": 16384,
        "reclaimable_bytes": 27154284544,
        "swapins": 20,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   329293.\nPages active:                                 761181.\nPages inactive:                               695410.\nPages speculative:                            255006.\nPages throttled:                                   0.\nPages wired down:                             179534.\nPages purgeable:                                 879.\n\"Translation faults\":                     1859288653.\nPages copy-on-write:                        91488803.\nPages zero filled:                        3087759419.\nPages reactivated:                         170801198.\nPages purged:                               12088228.\nFile-backed pages:                           1327194.\nAnonymous pages:                              384403.\nPages stored in compressor:                  1586828.\nPages occupied by compressor:                 863635.\nDecompressions:                             91948583.\nCompressions:                              104795263.\nPageins:                                  1938218920.\nPageouts:                                     458539.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127527.\nPages tagged resident:                         75345.\nPages tagged compressed:                       52182.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                         1687.\nPages tag-storage non-tag pageable:            91422.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8339520.\nTagged compressions:                          670984.\nTagged decompressions:                        551705.\n"
      },
      "seconds": 1.3643968749966007
    },
    {
      "name": "layers-native",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/frozen-dense-overlay-v2/slotstream",
        "parity",
        "--tokens",
        "9707,11,1246,525,498,30",
        "--layers",
        "2",
        "--compare",
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/layers-reference"
      ],
      "exit_code": 0,
      "failure": null,
      "sampled_peak_bytes": 8386628608,
      "samples": 13,
      "after": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24751570944,
        "swapins": 20,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   328322.\nPages active:                                 812794.\nPages inactive:                               589715.\nPages speculative:                            151031.\nPages throttled:                                   0.\nPages wired down:                             296326.\nPages purgeable:                                 385.\n\"Translation faults\":                     1859473435.\nPages copy-on-write:                        91489664.\nPages zero filled:                        3088273108.\nPages reactivated:                         170975139.\nPages purged:                               12088232.\nFile-backed pages:                           1182009.\nAnonymous pages:                              371529.\nPages stored in compressor:                  1668124.\nPages occupied by compressor:                 907012.\nDecompressions:                             91949283.\nCompressions:                              104877279.\nPageins:                                  1938339392.\nPageouts:                                     458776.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127587.\nPages tagged resident:                         74789.\nPages tagged compressed:                       52798.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          415.\nPages tag-storage non-tag pageable:            92694.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8471744.\nTagged compressions:                          671606.\nTagged decompressions:                        551711.\n"
      },
      "seconds": 0.7417475419933908
    },
    {
      "name": "mtp-reference",
      "command": [
        "<HOME>/Projects/slotstream/.venv/bin/python",
        "Tools/current_backend_reference.py",
        "--kind",
        "mtp",
        "--out",
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/mtp-reference"
      ],
      "exit_code": 0,
      "failure": null,
      "sampled_peak_bytes": 1643005752,
      "samples": 14,
      "after": {
        "page_bytes": 16384,
        "reclaimable_bytes": 27812577280,
        "swapins": 20,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   424022.\nPages active:                                 744824.\nPages inactive:                               677376.\nPages speculative:                            153683.\nPages throttled:                                   0.\nPages wired down:                             178538.\nPages purgeable:                                 387.\n\"Translation faults\":                     1859584092.\nPages copy-on-write:                        91491023.\nPages zero filled:                        3088377216.\nPages reactivated:                         170975139.\nPages purged:                               12088232.\nFile-backed pages:                           1273136.\nAnonymous pages:                              302747.\nPages stored in compressor:                  1666522.\nPages occupied by compressor:                 906627.\nDecompressions:                             91950871.\nCompressions:                              104877279.\nPageins:                                  1938428038.\nPageouts:                                     458776.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127446.\nPages tagged resident:                         74702.\nPages tagged compressed:                       52744.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          449.\nPages tag-storage non-tag pageable:            92660.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8460864.\nTagged compressions:                          671606.\nTagged decompressions:                        551765.\n"
      },
      "seconds": 0.8379339169769082
    },
    {
      "name": "mtp-native",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/frozen-dense-overlay-v2/slotstream",
        "mtp-parity",
        "--fixture",
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/mtp-reference/comparison.safetensors"
      ],
      "exit_code": 0,
      "failure": null,
      "sampled_peak_bytes": 1591199592,
      "samples": 3,
      "after": {
        "page_bytes": 16384,
        "reclaimable_bytes": 27811938304,
        "swapins": 20,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   423703.\nPages active:                                 745327.\nPages inactive:                               678653.\nPages speculative:                            152622.\nPages throttled:                                   0.\nPages wired down:                             178538.\nPages purgeable:                                 387.\n\"Translation faults\":                     1859683021.\nPages copy-on-write:                        91491895.\nPages zero filled:                        3088475977.\nPages reactivated:                         170975139.\nPages purged:                               12088232.\nFile-backed pages:                           1273416.\nAnonymous pages:                              303186.\nPages stored in compressor:                  1666100.\nPages occupied by compressor:                 906498.\nDecompressions:                             91951293.\nCompressions:                              104877279.\nPageins:                                  1938428342.\nPageouts:                                     458776.\nSwapins:                                          20.\nSwapouts:                                       2908.\nPages tagged:                                 127508.\nPages tagged resident:                         75000.\nPages tagged compressed:                       52508.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          486.\nPages tag-storage non-tag pageable:            92623.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    8405824.\nTagged compressions:                          671606.\nTagged decompressions:                        552001.\n"
      },
      "seconds": 0.18482191700604744
    }
  ],
  "bound_files": {
    "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-dense-overlay-reference-repair-v1.py": "3d073d77c4fa8046a9b597032ce8840891f44a9827938f0bfda64ba370598751",
    "<HOME>/Projects/slotstream/Tools/current_backend_reference.py": "42d0ae3c09f97514f0599c82c890aaf6c3214415584631af806b51bae2d70b95",
    "<HOME>/Projects/slotstream/Tools/quantization_logit_run.py": "2caeb49d8b008a31ca981db7eedcd1eaa374c0b7cd106139895519d4528e2f88"
  },
  "finished_at": "2026-10-03T12:48:34.751864+00:00"
}
````

### vq-dense-overlay-acceptance-tmp-v1/ssv-vision-serve.log

Original bytes: 6271. SHA-256: `7a82e47ddeff251c749aecb17eeba069a65f57b060b8e5c860b917bc80de78f7`.

Normalized bytes: 6271. SHA-256: `7a82e47ddeff251c749aecb17eeba069a65f57b060b8e5c860b917bc80de78f7`.

````text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (25.4 GB reclaimable now), 40.2 GB Metal working set
  target: 14.5 GB total process budget, not a RAM usage goal
  cache:  ~20 of 512 experts per layer  (962 global slots = 2.7 GB pool)
  plan:   ~13.5 GB full-workload envelope, ~4 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.7 GB expert cache at load; 10.8 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 3072 tokens per pass (~205 tok/s here; costs ~4.0 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.5 min before its first token here, follow-up turns read only what is new
  reuse:  up to 28107 tokens across 4 conversations (~1.1 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch in plain decode, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
  note:   prefill and prefix retention reservations match the explicit runtime controls
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.8s: expert cache ~20/512 per layer (962 global slots = 2.7 GB), eos [248044, 248046]
elastic: off (--no-elastic); the cache stays at its startup size
slotstream listening on http://127.0.0.1:11468
try it:
  curl localhost:11468/api/chat -d '{"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "hello"}]}'
or point any Ollama or OpenAI client at http://localhost:11468
[7:46:38 AM] request D49EEADB /api/chat: accepted
prefix cache: miss: no retained state (0 prior evictions)
[7:46:45 AM] prefill: reading 725 prompt tokens, ~4 s to the first token at this plan (follow-up turns read only what is new)
[7:46:45 AM] prefill: done, 725 tokens in 6 s (113 tok/s)
[7:46:46 AM] request D49EEADB /api/chat: ended after 7.7 s
[7:46:46 AM] request AE9CA58C /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:46:47 AM] request AE9CA58C /api/chat: ended after 1.6 s
[7:46:47 AM] request 55E23E03 /v1/chat/completions: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:46:57 AM] prefill: reading 1885 prompt tokens, ~9 s to the first token at this plan (follow-up turns read only what is new)
[7:46:57 AM] prefill: done, 1885 tokens in 8 s (240 tok/s)
[7:46:57 AM] request 55E23E03 /v1/chat/completions: ended after 10.1 s
[7:46:57 AM] request B68DC13E /api/generate: accepted
prefix cache: reusing 725/725 tokens from memory
[7:46:58 AM] request B68DC13E /api/generate: ended after 0.6 s
[7:46:58 AM] request 590DC365 /v3/ai/language-model: accepted
prefix cache: reusing 725/725 tokens from memory
[7:46:59 AM] request 590DC365 /v3/ai/language-model: ended after 0.6 s
[7:46:59 AM] request 1B37758A /v3/ai/language-model: accepted
[7:46:59 AM] request 1B37758A /v3/ai/language-model: ended after 0.0 s
[7:46:59 AM] request 75969649 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:47:01 AM] prefill: reading 2602 prompt tokens, ~13 s to the first token at this plan (follow-up turns read only what is new)
[7:47:10 AM] prefill: done, 2602 tokens in 9 s (279 tok/s)
[7:47:11 AM] request 75969649 /api/chat: ended after 12.4 s
[7:47:11 AM] request 1DDB878B /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:47:11 AM] prefill: reading 3526 prompt tokens, ~17 s to the first token at this plan (follow-up turns read only what is new)
[7:47:21 AM] prefill: 3072/3526 tokens (87%), 332 tok/s recently, ~1 s left at this rate
[7:47:23 AM] prefill: done, 3526 tokens in 12 s (294 tok/s)
[7:47:24 AM] request 1DDB878B /api/chat: ended after 12.6 s
[7:47:24 AM] request 36C1C315 /api/chat: accepted
prefix cache: reusing 3072/3547 tokens from memory
[7:47:27 AM] request 36C1C315 /api/chat: ended after 3.1 s
[7:47:27 AM] request 455F0346 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:47:33 AM] prefill: reading 724 prompt tokens, ~4 s to the first token at this plan (follow-up turns read only what is new)
[7:47:33 AM] prefill: done, 724 tokens in 6 s (128 tok/s)
[7:47:33 AM] request 455F0346 /api/chat: ended after 6.4 s
[7:47:33 AM] request D41D317B /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:47:43 AM] prefill: reading 1884 prompt tokens, ~9 s to the first token at this plan (follow-up turns read only what is new)
[7:47:43 AM] prefill: done, 1884 tokens in 8 s (232 tok/s)
[7:47:44 AM] request D41D317B /api/chat: ended after 10.7 s
[7:47:44 AM] request 63E26376 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:47:52 AM] prefill: reading 1433 prompt tokens, ~7 s to the first token at this plan (follow-up turns read only what is new)
[7:47:52 AM] prefill: done, 1433 tokens in 7 s (200 tok/s)
[7:47:52 AM] request 63E26376 /api/chat: ended after 8.3 s
[7:47:52 AM] request 9B299DB8 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:47:55 AM] request 9B299DB8 /api/chat: ended after 2.5 s
[7:47:55 AM] request 5651BE41 /api/chat: accepted
prefix cache: miss: image content changed
[7:47:57 AM] request 5651BE41 /api/chat: ended after 2.9 s
[7:47:57 AM] request 720870FB /api/chat: accepted
[7:47:57 AM] request 720870FB /api/chat: ended after 0.0 s
[7:47:57 AM] request DA954AC1 /api/chat: accepted
[7:47:57 AM] request DA954AC1 /api/chat: ended after 0.0 s
[7:47:57 AM] request 05EBB49C /api/chat: accepted
[7:47:57 AM] request 05EBB49C /api/chat: ended after 0.0 s
[7:47:57 AM] stopping: asked to stop (SIGTERM)
````

### vq-dense-overlay-acceptance-tmp-v1/ssv_big.txt

Original bytes: 116. SHA-256: `ba700ec9e65fd4d42c732f0b0d3c03d65d4199e977604fa4a74f90ad45e179e1`.

Normalized bytes: 116. SHA-256: `ba700ec9e65fd4d42c732f0b0d3c03d65d4199e977604fa4a74f90ad45e179e1`.

````text
The sky appears blue primarily due to a phenomenon called **Rayleigh scattering**.

### Step-by-Step Explanation:


````

### vq-dense-overlay-acceptance-tmp-v1/ssv_ctx.json

Original bytes: 16328. SHA-256: `2c3919aa5d85ee9c1d615c58198dce2958d879a649b00872531c0258de48bd4b`.

Normalized bytes: 16328. SHA-256: `2c3919aa5d85ee9c1d615c58198dce2958d879a649b00872531c0258de48bd4b`.

````text
{"aborted":null,"compute_key_extents":[256,512,768,1024,1280,1536,1792,2048],"compute_passes":[256,256,256,256,256,256,256,256],"compute_query_rows":[256,256,256,256,256,256,256,256],"configured_context":2064,"fits":true,"memory_ledger":{"active_capacity_bytes":84934656,"additional_active_bytes":0,"expected_peak_bytes":8997885184,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":428867584,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2936217600,"prefill_bytes":332800000,"retained_capacity_bytes":0,"retained_recurrent_bytes":0,"version":1,"vision_resident_bytes":0},"model_revision":"aa7c790e804bbf9d491ddb109c3d61bc4a555f7c","optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":true,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directDemandReads":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedPrefillAttention":true,"fusedPrefillWorkspace":true,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[20,12364,5020,220,16,20,13,271,248068,271,248069,271,27775,383,279,795],"pass_timings":[{"from":0,"seconds":11.684509,"tokens":1792},{"from":1792,"seconds":3.609409166999999,"tokens":256}],"passes":[1792,256],"peak_rss_gb":3.370008576,"plan_expected_peak_gb":8.9978851839999994,"prefill_chunk":256,"prefill_seconds":15.294160584,"prefill_tok_s":133.90731637423221,"prefill_tokens":2048,"process_peak_bound_gb":8.3318243200000008,"prompt_ids":[1905,1716,13,13190,220,15,25,279,11661,383,1500,220,15,4800,220,18,22,7896,506,220,15,25,15,15,11,321,51715,220,15,12364,5020,220,15,13,13190,220,16,25,279,11661,383,1500,220,16,4800,220,21,23,7896,506,220,16,25,15,22,11,321,51715,220,16,18,12364,5020,220,16,13,13190,220,17,25,279,11661,383,1500,220,17,4800,220,24,24,7896,506,220,17,25,16,19,11,321,51715,220,17,21,12364,5020,220,17,13,13190,220,18,25,279,11661,383,1500,220,18,4800,220,16,18,15,7896,506,220,18,25,17,16,11,321,51715,220,18,24,12364,5020,220,18,13,13190,220,19,25,279,11661,383,1500,220,19,4800,220,16,21,16,7896,506,220,19,25,17,23,11,321,51715,220,20,17,12364,5020,220,19,13,13190,220,20,25,279,11661,383,1500,220,20,4800,220,16,24,17,7896,506,220,20,25,18,20,11,321,51715,220,21,20,12364,5020,220,20,13,13190,220,21,25,279,11661,383,1500,220,21,4800,220,17,17,18,7896,506,220,21,25,19,17,11,321,51715,220,22,23,12364,5020,220,21,13,13190,220,22,25,279,11661,383,1500,220,22,4800,220,17,20,19,7896,506,220,22,25,19,24,11,321,51715,220,24,16,12364,5020,220,22,13,13190,220,23,25,279,11661,383,1500,220,23,4800,220,17,23,20,7896,506,220,23,25,20,21,11,321,51715,220,16,15,19,12364,5020,220,23,13,13190,220,24,25,279,11661,383,1500,220,24,4800,220,18,16,21,7896,506,220,24,25,15,18,11,321,51715,220,16,16,22,12364,5020,220,24,13,13190,220,16,15,25,279,11661,383,1500,220,16,15,4800,220,18,19,22,7896,506,220,16,15,25,16,15,11,321,51715,220,16,18,15,12364,5020,220,16,15,13,13190,220,16,16,25,279,11661,383,1500,220,16,16,4800,220,18,22,23,7896,506,220,16,16,25,16,22,11,321,51715,220,16,19,18,12364,5020,220,16,16,13,13190,220,16,17,25,279,11661,383,1500,220,16,17,4800,220,19,15,24,7896,506,220,16,17,25,17,19,11,321,51715,220,16,20,21,12364,5020,220,16,17,13,13190,220,16,18,25,279,11661,383,1500,220,16,18,4800,220,19,19,15,7896,506,220,16,18,25,18,16,11,321,51715,220,16,21,24,12364,5020,220,16,18,13,13190,220,16,19,25,279,11661,383,1500,220,16,19,4800,220,19,22,16,7896,506,220,16,19,25,18,23,11,321,51715,220,16,23,17,12364,5020,220,16,19,13,13190,220,16,20,25,279,11661,383,1500,220,16,20,4800,220,20,15,17,7896,506,220,16,20,25,19,20,11,321,51715,220,16,24,20,12364,5020,220,16,20,13,13190,220,16,21,25,279,11661,383,1500,220,16,21,4800,220,20,18,18,7896,506,220,16,21,25,20,17,11,321,51715,220,17,15,23,12364,5020,220,16,21,13,13190,220,16,22,25,279,11661,383,1500,220,16,22,4800,220,21,19,7896,506,220,16,22,25,20,24,11,321,51715,220,17,17,16,12364,5020,220,16,22,13,13190,220,16,23,25,279,11661,383,1500,220,16,23,4800,220,24,20,7896,506,220,16,23,25,15,21,11,321,51715,220,17,18,19,12364,5020,220,16,23,13,13190,220,16,24,25,279,11661,383,1500,220,16,24,4800,220,16,17,21,7896,506,220,16,24,25,16,18,11,321,51715,220,17,19,22,12364,5020,220,16,24,13,13190,220,17,15,25,279,11661,383,1500,220,17,15,4800,220,16,20,22,7896,506,220,17,15,25,17,15,11,321,51715,220,17,21,15,12364,5020,220,17,15,13,13190,220,17,16,25,279,11661,383,1500,220,17,16,4800,220,16,23,23,7896,506,220,17,16,25,17,22,11,321,51715,220,17,22,18,12364,5020,220,17,16,13,13190,220,17,17,25,279,11661,383,1500,220,17,17,4800,220,17,16,24,7896,506,220,17,17,25,18,19,11,321,51715,220,17,23,21,12364,5020,220,17,17,13,13190,220,17,18,25,279,11661,383,1500,220,17,18,4800,220,17,20,15,7896,506,220,17,18,25,19,16,11,321,51715,220,17,24,24,12364,5020,220,17,18,13,13190,220,17,19,25,279,11661,383,1500,220,17,19,4800,220,17,23,16,7896,506,220,15,25,19,23,11,321,51715,220,18,16,17,12364,5020,220,17,19,13,13190,220,17,20,25,279,11661,383,1500,220,17,20,4800,220,18,16,17,7896,506,220,16,25,20,20,11,321,51715,220,18,17,20,12364,5020,220,17,20,13,13190,220,17,21,25,279,11661,383,1500,220,17,21,4800,220,18,19,18,7896,506,220,17,25,15,17,11,321,51715,220,18,18,23,12364,5020,220,17,21,13,13190,220,17,22,25,279,11661,383,1500,220,17,22,4800,220,18,22,19,7896,506,220,18,25,15,24,11,321,51715,220,18,20,16,12364,5020,220,17,22,13,13190,220,17,23,25,279,11661,383,1500,220,17,23,4800,220,19,15,20,7896,506,220,19,25,16,21,11,321,51715,220,18,21,19,12364,5020,220,17,23,13,13190,220,17,24,25,279,11661,383,1500,220,17,24,4800,220,19,18,21,7896,506,220,20,25,17,18,11,321,51715,220,18,22,22,12364,5020,220,17,24,13,13190,220,18,15,25,279,11661,383,1500,220,18,15,4800,220,19,21,22,7896,506,220,21,25,18,15,11,321,51715,220,18,24,15,12364,5020,220,18,15,13,13190,220,18,16,25,279,11661,383,1500,220,18,16,4800,220,19,24,23,7896,506,220,22,25,18,22,11,321,51715,220,19,15,18,12364,5020,220,18,16,13,13190,220,18,17,25,279,11661,383,1500,220,18,17,4800,220,20,17,24,7896,506,220,23,25,19,19,11,321,51715,220,19,16,21,12364,5020,220,18,17,13,13190,220,18,18,25,279,11661,383,1500,220,18,18,4800,220,21,15,7896,506,220,24,25,20,16,11,321,51715,220,19,17,24,12364,5020,220,18,18,13,13190,220,18,19,25,279,11661,383,1500,220,18,19,4800,220,24,16,7896,506,220,16,15,25,20,23,11,321,51715,220,19,19,17,12364,5020,220,18,19,13,13190,220,18,20,25,279,11661,383,1500,220,18,20,4800,220,16,17,17,7896,506,220,16,16,25,15,20,11,321,51715,220,19,20,20,12364,5020,220,18,20,13,13190,220,18,21,25,279,11661,383,1500,220,18,21,4800,220,16,20,18,7896,506,220,16,17,25,16,17,11,321,51715,220,19,21,23,12364,5020,220,18,21,13,13190,220,18,22,25,279,11661,383,1500,220,18,22,4800,220,16,23,19,7896,506,220,16,18,25,16,24,11,321,51715,220,19,23,16,12364,5020,220,18,22,13,13190,220,18,23,25,279,11661,383,1500,220,18,23,4800,220,17,16,20,7896,506,220,16,19,25,17,21,11,321,51715,220,19,24,19,12364,5020,220,18,23,13,13190,220,18,24,25,279,11661,383,1500,220,18,24,4800,220,17,19,21,7896,506,220,16,20,25,18,18,11,321,51715,220,20,15,22,12364,5020,220,18,24,13,13190,220,19,15,25,279,11661,383,1500,220,19,15,4800,220,17,22,22,7896,506,220,16,21,25,19,15,11,321,51715,220,20,17,15,12364,5020,220,19,15,13,13190,220,19,16,25,279,11661,383,1500,220,19,16,4800,220,18,15,23,7896,506,220,16,22,25,19,22,11,321,51715,220,20,18,18,12364,5020,220,19,16,13,13190,220,19,17,25,279,11661,383,1500,220,19,17,4800,220,18,18,24,7896,506,220,16,23,25,20,19,11,321,51715,220,20,19,21,12364,5020,220,19,17,13,13190,220,19,18,25,279,11661,383,1500,220,19,18,4800,220,18,22,15,7896,506,220,16,24,25,15,16,11,321,51715,220,20,20,24,12364,5020,220,19,18,13,13190,220,19,19,25,279,11661,383,1500,220,19,19,4800,220,19,15,16,7896,506,220,17,15,25,15,23,11,321,51715,220,20,22,17,12364,5020,220,19,19,13,13190,220,19,20,25,279,11661,383,1500,220,19,20,4800,220,19,18,17,7896,506,220,17,16,25,16,20,11,321,51715,220,20,23,20,12364,5020,220,19,20,13,13190,220,19,21,25,279,11661,383,1500,220,19,21,4800,220,19,21,18,7896,506,220,17,17,25,17,17,11,321,51715,220,20,24,23,12364,5020,220,19,21,13,13190,220,19,22,25,279,11661,383,1500,220,19,22,4800,220,19,24,19,7896,506,220,17,18,25,17,24,11,321,51715,220,21,16,16,12364,5020,220,19,22,13,13190,220,19,23,25,279,11661,383,1500,220,19,23,4800,220,20,17,20,7896,506,220,15,25,18,21,11,321,51715,220,21,17,19,12364,5020,220,19,23,13,13190,220,19,24,25,279,11661,383,1500,220,19,24,4800,220,20,21,7896,506,220,16,25,19,18,11,321,51715,220,21,18,22,12364,5020,220,19,24,13,13190,220,20,15,25,279,11661,383,1500,220,20,15,4800,220,23,22,7896,506,220,17,25,20,15,11,321,51715,220,21,20,15,12364,5020,220,20,15,13,13190,220,20,16,25,279,11661,383,1500,220,20,16,4800,220,16,16,23,7896,506,220,18,25,20,22,11,321,51715,220,21,21,18,12364,5020,220,20,16,13,13190,220,20,17,25,279,11661,383,1500,220,20,17,4800,220,16,19,24,7896,506,220,19,25,15,19,11,321,51715,220,21,22,21,12364,5020,220,20,17,13,13190,220,20,18,25,279,11661,383,1500,220,20,18,4800,220,16,23,15,7896,506,220,20,25,16,16,11,321,51715,220,21,23,24,12364,5020,220,20,18,13,13190,220,20,19,25,279,11661,383,1500,220,20,19,4800,220,17,16,16,7896,506,220,21,25,16,23,11,321,51715,220,22,15,17,12364,5020,220,20,19,13,13190,220,20,20,25,279,11661,383,1500,220,20,20,4800,220,17,19,17,7896,506,220,22,25,17,20,11,321,51715,220,22,16],"reply_tokens":16,"retained_after":{"allocated_sequence_bytes":0,"charged_token_capacity":0,"checkpoint_fork_failures":0,"checkpoint_hits":0,"checkpoint_stores":0,"conversations":0,"enabled":false,"evictions":0,"held_gb":0,"held_images":0,"held_tokens":0,"hits":0,"max_conversations":4,"max_tokens":0,"misses":0,"persistent_hits":0,"reusable_checkpoints":0},"retained_before":{"allocated_sequence_bytes":0,"charged_token_capacity":0,"checkpoint_fork_failures":0,"checkpoint_hits":0,"checkpoint_stores":0,"conversations":0,"enabled":false,"evictions":0,"held_gb":0,"held_images":0,"held_tokens":0,"hits":0,"max_conversations":4,"max_tokens":0,"misses":0,"persistent_hits":0,"reusable_checkpoints":0},"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":84934656,"cachedRouterBytes":251658240,"completePromptHits":0,"completePromptStores":0,"contextArithmetic":"standard","decodeForwardPasses":15,"decodeIOSeconds":0.52234687599999996,"decodeLocalVictims":0,"decodeModelTokens":15,"decodeReadBytes":4722278400,"decodeRecords":1708,"decodeScatterSeconds":0,"decodeSeconds":1.921200542,"decodeSlotCPUBatches":0,"decodeSlotDirectBatches":613,"decodeSlotScatterBatches":0,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":16,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":46080,"embeddingCachedRows":32,"embeddingRowHits":37,"embeddingRowMisses":32,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.44805555555555554,"expertPrefetch":{"adopted":2266,"adoptedBytes":6265036800,"adoption":"slot","adoptSeconds":0.05063313999999991,"arrivalIssues":665,"cancelled":6,"candidates":2872,"capRefusals":0,"deferredLaneAcquisitions":2853,"demandBatches":613,"demandMisses":1697,"dirtyRescans":0,"expired":600,"failed":0,"forecastBuildSeconds":0.011864959,"forecastEvalSeconds":0.61566148299999968,"forecastMerged":2872,"forecastPasses":15,"forecastSeconds":0.02469005199999998,"forecastSelectSeconds":0.012807092999999993,"forecastTap":"attention-corrected","forecastTargets":705,"issued":2872,"issuedBytes":7940505600,"joinSeconds":0.04920939299999974,"layersComplete":18,"layersWithMisses":702,"mode":"on","passes":15,"peakLiveBytes":0,"pieceModeReads":2872,"predictorIdentity":"router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188","promoted":1199,"readShape":"piece","recordReads":0,"scheduleSeconds":0.007474058000000011,"slotEvictedKeys":2260,"slotRefusals":0,"slotReleases":606,"slotReservations":2872,"slotStale":0,"wastedBytes":1675468800},"finishReason":"length","firstTokenSeconds":15.314732875000001,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":912,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorVMAfter":{"reclaimableBytes":23127310336,"swapins":20,"swapouts":2908},"generatorVMBefore":{"reclaimableBytes":23387111424,"swapins":20,"swapouts":2908},"gpuKeptAwake":true,"imageEncodeSeconds":1.67e-07,"interTokenSeconds":[0.40611950000000002,0.129356625,0.123602541,0.14437145800000001,0.124497,0.096849792000000004,0.103168625,0.13609458399999999,0.10332733400000001,0.084279415999999996,0.079921791000000006,0.100622584,0.095472166999999997,0.098735832999999995,0.094209333000000006],"lifetimePhysicalFootprintPeakBytes":8331824320,"lifetimeRSSPeakBytes":3370008576,"memoryPressureCancelled":false,"mlxActiveEndBytes":6004673536,"mlxCacheEndBytes":711317938,"mlxPeakMemoryGB":7.9795652600000002,"ngramCachedRows":7408,"ngramCachePayloadBytes":2370560,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.14076691500000005,"ngramRowHits":96,"ngramRowMisses":144,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":8.3318243200000008,"physicalFootprintEndBytes":7330289016,"prefillComputeKeyExtents":[256,512,768,1024,1280,1536,1792,2048],"prefillComputePasses":[256,256,256,256,256,256,256,256],"prefillComputeQueryRows":[256,256,256,256,256,256,256,256],"prefillGPUWaitSeconds":2.2465297879999984,"prefillIOSeconds":5.9472954650000052,"prefillLocalVictims":0,"prefillMLXActiveBytes":6095161544,"prefillMLXCacheBytes":539935588,"prefillPasses":[1792,256],"prefillPhysicalFootprintBytes":7234751896,"prefillReadBytes":72678297600,"prefillRecords":26287,"prefillRowSortSeconds":0.006215495999999999,"prefillScatterSeconds":1.2347386989999996,"prefillSeconds":15.294160584,"prefillSlotCPUBatches":0,"prefillSlotDirectBatches":0,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":2048,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":2,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":0.000127083,"promptTokens":2048,"queueSeconds":2.6041999999999999e-05,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":17.238090374999999,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":104,"ropeTableHits":532,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":8314784960,"samples":863},"sampleSeconds":0.0023705800000000002,"sharedExpertPrelaunches":0,"sharedPrefixBoundaries":[],"sharedPrefixErrors":0,"sharedPrefixRefusals":0,"sharedPrefixStores":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":2.791e-06,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"swap_clean":true,"text":"5 filed note 15.\n\n<think>\n\n<\/think>\n\nBased on the data","tokens":2048,"verdict":"OK","warmup":[]}
````

### vq-dense-overlay-acceptance-tmp-v1/ssv_long.txt

Original bytes: 50993. SHA-256: `32e15bd0df7b057f31b74f94a24c179d4374c19ddc54b77d590e330710fc8f78`.

Normalized bytes: 50993. SHA-256: `32e15bd0df7b057f31b74f94a24c179d4374c19ddc54b77d590e330710fc8f78`.

````text
The archive records that the vault combination is SEVENTEEN. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. Inventory counts were reconciled against the quarterly ledger totals. The east wing humidity sensors reported nominal values throughout the day. Routine maintenance was performed on the north corridor lighting system. 

Question: what is the vault combination? Answer with one word.
````

### vq-dense-overlay-acceptance-tmp-v1/ssv_longmem.err

Original bytes: 2514. SHA-256: `af53b6a6416e56bf48d92e2ee36c474a58e1dc320d7fa3ce5d7478270cdb86d9`.

Normalized bytes: 2514. SHA-256: `af53b6a6416e56bf48d92e2ee36c474a58e1dc320d7fa3ce5d7478270cdb86d9`.

````text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (27.5 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~17 of 512 experts per layer  (821 global slots = 2.3 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.3 GB expert cache at load; 6.7 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 11831 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch in plain decode, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
  window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to the estimated request time without an unmeasured cache tradeoff; --max-context N chooses another window up to 262144
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.8s: expert cache ~17/512 per layer (821 global slots = 2.3 GB), eos [248044, 248046]
prompt tokens: 7972 (~1.6 min to the first token at this plan)
  prefill: reading 7972 prompt tokens, ~1.6 min to the first token at this plan (follow-up turns read only what is new)
  prefill: 7936/7972 tokens (100%), 287 tok/s recently, ~0 s left at this rate
  prefill: done, 7972 tokens in 30 s (268 tok/s)

-- prefill 7972 tok in 29.71s (268.3 tok/s)
-- prefill split: io 5.51s + scatter 1.16s | 24902 records (68.8 GB, 12.5 GB/s)
-- decode 4 tok in 0.52s (7.70 tok/s)
-- decode split: io 0.19s + scatter 0.00s | 588 records
-- expert cache ~17/512 experts per layer, hit rate 0.353 | ngram rows 24h/40m | sampled footprint peak 7.998 GB | total 30.3s
````

### vq-dense-overlay-acceptance-tmp-v1/ssv_longmem.json

Original bytes: 49525. SHA-256: `94bc86c745f6549ba49ffddf1ce23c52ab0149bb9fb9a900e5f9e12a5947eaa4`.

Normalized bytes: 49525. SHA-256: `94bc86c745f6549ba49ffddf1ce23c52ab0149bb9fb9a900e5f9e12a5947eaa4`.

````text
{"effective_expected_peak_gb":9.2500687359999993,"effective_mtp":false,"effective_pool_slots":821,"effective_prefill_chunk":256,"effective_prefill_cost_gb":0.33279999999999998,"encode_seconds":0.036063749999999999,"experimental_memory_family":true,"extra_expert_workspace_gb":0,"extra_read_scope_allowance_gb":0,"extra_router_cache_gb":0.25165823999999998,"launch_seconds":38.801953124999997,"load_seconds":8.5166996249999993,"optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":true,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directDemandReads":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedPrefillAttention":true,"fusedPrefillWorkspace":true,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[896,6571,36,923],"plan":{"availability_clamped":false,"context_qualification":false,"decode_estimate_cache_in_measured_range":true,"decode_lookahead":true,"device_available_gb":27.5,"device_ram_gb":51.5,"device_working_set_gb":40.200000000000003,"est_prefill_s_at_max_context":385.50588235294038,"est_prefill_tok_s":85,"est_warm_tok_s":3.4208333333333338,"expected_peak_gb":9,"expected_peak_semantics":"planned_full_workload_envelope_not_measured_usage","experts_per_layer_cached":17,"fully_resident":false,"implementation_context_limit":262144,"lookahead_reserve_bytes":428867584,"max_context_tokens":32768,"max_prefill_wait_minutes":30,"max_ram_percent":70,"memory_ledger":{"active_capacity_bytes":905969664,"additional_active_bytes":0,"expected_peak_bytes":8998410496,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":428867584,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2269900800,"prefill_bytes":332800000,"retained_capacity_bytes":327103488,"retained_recurrent_bytes":339738624,"version":1,"vision_resident_bytes":0},"memory_target_semantics":"process_budget_not_allocation_goal","model_context_limit":262144,"mtp":false,"mtp_context_limit":262144,"mtp_streamed_experts":false,"non_cache_allowance_bytes":6728509696,"planned_headroom_gb":1,"pool_gb":2.2999999999999998,"pool_slots":821,"prefill_chunk":256,"prefill_wait_scope":"accepted_request_to_first_model_token","prefix_cache_max_tokens":11831,"runtime_prefix_cache_enabled":true,"source":"--memory-gb","target_gb":10,"vision":true,"vision_charged_gb":0,"vision_context_limit":65536,"vision_resident_gb":0.90000000000000002,"vision_resident_reserved":false},"prompt_ids":[248045,846,198,760,17593,7189,421,279,33439,10286,369,4890,6571,36,923,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,4558,14162,25,1092,369,279,33439,10286,30,21134,440,799,3299,13,248046,198,248045,74455,198,248068,271,248069,271],"sampling":{"greedy":true,"requested_max_tokens":"16","seed":"default"},"schema_version":1,"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":226492416,"cachedRouterBytes":251658240,"completePromptHits":0,"completePromptStores":0,"contextArithmetic":"standard","decodeForwardPasses":4,"decodeIOSeconds":0.18611587500000007,"decodeLocalVictims":0,"decodeModelTokens":4,"decodeReadBytes":1625702400,"decodeRecords":588,"decodeScatterSeconds":0,"decodeSeconds":0.51936066700000005,"decodeSlotCPUBatches":0,"decodeSlotDirectBatches":189,"decodeSlotScatterBatches":0,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":4,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":84960,"embeddingCachedRows":59,"embeddingRowHits":50,"embeddingRowMisses":59,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.35312500000000002,"expertPrefetch":{"adopted":654,"adoptedBytes":1808179200,"adoption":"slot","adoptSeconds":0.011496880999999988,"arrivalIssues":187,"cancelled":2,"candidates":882,"capRefusals":0,"deferredLaneAcquisitions":958,"demandBatches":425,"demandMisses":588,"dirtyRescans":0,"expired":226,"failed":0,"forecastBuildSeconds":0.003279665000000001,"forecastEvalSeconds":0.144476295,"forecastMerged":882,"forecastPasses":4,"forecastSeconds":0.007059877000000003,"forecastSelectSeconds":0.0037756290000000013,"forecastTap":"attention-corrected","forecastTargets":188,"issued":882,"issuedBytes":2438553600,"joinSeconds":0.011121719000000004,"layersComplete":0,"layersWithMisses":240,"mode":"on","passes":4,"peakLiveBytes":0,"pieceModeReads":882,"predictorIdentity":"router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188","promoted":310,"readShape":"piece","recordReads":0,"scheduleSeconds":0.002323289999999999,"slotEvictedKeys":656,"slotRefusals":0,"slotReleases":227,"slotReservations":882,"slotStale":0,"wastedBytes":630374400},"finishReason":"stop","firstTextSeconds":29.729666291000001,"firstTokenSeconds":29.728715915999999,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":1536,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorVMAfter":{"reclaimableBytes":24068390912,"swapins":20,"swapouts":2908},"generatorVMBefore":{"reclaimableBytes":22670032896,"swapins":20,"swapouts":2908},"gpuKeptAwake":true,"imageEncodeSeconds":2.0900000000000001e-07,"interTokenSeconds":[0.15604775000000001,0.117060083,0.11710554200000001],"lifetimePhysicalFootprintPeakBytes":8059669672,"lifetimeRSSPeakBytes":3050242048,"memoryPressureCancelled":false,"mlxActiveEndBytes":5480581848,"mlxCacheEndBytes":357582201,"mlxPeakMemoryGB":7.6261152279999997,"ngramCachedRows":1192,"ngramCachePayloadBytes":381440,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.026504999000000001,"ngramRowHits":24,"ngramRowMisses":40,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":8.0596696720000001,"physicalFootprintEndBytes":6317380384,"prefillComputeKeyExtents":[256,512,768,1024,1280,1536,1792,2048,2304,2560,2816,3072,3328,3584,3840,4096,4352,4608,4864,5120,5376,5632,5888,6144,6400,6656,6912,7168,7424,7680,7936,7972],"prefillComputePasses":[256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,36],"prefillComputeQueryRows":[256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,36],"prefillGPUWaitSeconds":6.8013391410000015,"prefillIOSeconds":5.5118260839999991,"prefillLocalVictims":0,"prefillMLXActiveBytes":5479993496,"prefillMLXCacheBytes":350451774,"prefillPasses":[7936,36],"prefillPhysicalFootprintBytes":6294606528,"prefillReadBytes":68849049600,"prefillRecords":24902,"prefillRowSortSeconds":0.018983876999999993,"prefillScatterSeconds":1.1581113380000001,"prefillSeconds":29.711430750000002,"prefillSlotCPUBatches":0,"prefillSlotDirectBatches":236,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":7972,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":2,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":0.036088959000000004,"promptTokens":7972,"queueSeconds":4.5410000000000002e-06,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":30.284725957999999,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":655,"ropeTableHits":449,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":7998147752,"samples":1513},"sampleSeconds":0.00085183399999999999,"sharedExpertPrelaunches":0,"sharedPrefixBoundaries":[],"sharedPrefixCommon":0,"sharedPrefixErrors":0,"sharedPrefixRefusals":0,"sharedPrefixStores":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":0.00029066699999999999,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"text":"SEVENTEEN"}
````

### vq-dense-overlay-acceptance-tmp-v1/ssv_longmem.txt

Original bytes: 10. SHA-256: `2e9fad2e271de488677d33bde2dd661601317f58b374941e44c1d077da46ebe3`.

Normalized bytes: 10. SHA-256: `2e9fad2e271de488677d33bde2dd661601317f58b374941e44c1d077da46ebe3`.

````text
SEVENTEEN
````

### vq-dense-overlay-acceptance-tmp-v1/ssv_mem.err

Original bytes: 2255. SHA-256: `70f8188f02e1a7911d348d4730fd5a921f2b87e6f4dffee59e48442faa177eaf`.

Normalized bytes: 2255. SHA-256: `70f8188f02e1a7911d348d4730fd5a921f2b87e6f4dffee59e48442faa177eaf`.

````text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (27.6 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~17 of 512 experts per layer  (821 global slots = 2.3 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.3 GB expert cache at load; 6.7 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 11831 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch in plain decode, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
  window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to the estimated request time without an unmeasured cache tradeoff; --max-context N chooses another window up to 262144
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.8s: expert cache ~17/512 per layer (821 global slots = 2.3 GB), eos [248044, 248046]
prompt tokens: 18 (~0 s to the first token at this plan)

-- prefill 18 tok in 0.91s (19.7 tok/s)
-- prefill split: io 0.68s + scatter 0.00s | 3420 records (9.5 GB, 13.9 GB/s)
-- decode 24 tok in 2.43s (9.89 tok/s)
-- decode split: io 0.85s + scatter 0.00s | 2265 records
-- expert cache ~17/512 experts per layer, hit rate 0.409 | ngram rows 0h/368m | sampled footprint peak 5.780 GB | total 3.4s
````

### vq-dense-overlay-acceptance-tmp-v1/ssv_mem.json

Original bytes: 9139. SHA-256: `0a8fed24fca7514ea009384bf81b9c58249a27a2ec13fbed55545e5870768df2`.

Normalized bytes: 9139. SHA-256: `0a8fed24fca7514ea009384bf81b9c58249a27a2ec13fbed55545e5870768df2`.

````text
{"effective_expected_peak_gb":9.2500687359999993,"effective_mtp":false,"effective_pool_slots":821,"effective_prefill_chunk":256,"effective_prefill_cost_gb":0.33279999999999998,"encode_seconds":0.010070792,"experimental_memory_family":true,"extra_expert_workspace_gb":0,"extra_read_scope_allowance_gb":0,"extra_router_cache_gb":0.25165823999999998,"launch_seconds":11.8006005,"load_seconds":8.42485675,"optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":true,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directDemandReads":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedPrefillAttention":true,"fusedPrefillWorkspace":true,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[760,12515,7701,6105,15048,4016,310,264,24057,2512,2972,28232,60845,69377,159034,271,13962,14392,13909,12,8046,68868,25,271],"plan":{"availability_clamped":false,"context_qualification":false,"decode_estimate_cache_in_measured_range":true,"decode_lookahead":true,"device_available_gb":27.600000000000001,"device_ram_gb":51.5,"device_working_set_gb":40.200000000000003,"est_prefill_s_at_max_context":385.50588235294038,"est_prefill_tok_s":85,"est_warm_tok_s":3.4208333333333338,"expected_peak_gb":9,"expected_peak_semantics":"planned_full_workload_envelope_not_measured_usage","experts_per_layer_cached":17,"fully_resident":false,"implementation_context_limit":262144,"lookahead_reserve_bytes":428867584,"max_context_tokens":32768,"max_prefill_wait_minutes":30,"max_ram_percent":70,"memory_ledger":{"active_capacity_bytes":905969664,"additional_active_bytes":0,"expected_peak_bytes":8998410496,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":428867584,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2269900800,"prefill_bytes":332800000,"retained_capacity_bytes":327103488,"retained_recurrent_bytes":339738624,"version":1,"vision_resident_bytes":0},"memory_target_semantics":"process_budget_not_allocation_goal","model_context_limit":262144,"mtp":false,"mtp_context_limit":262144,"mtp_streamed_experts":false,"non_cache_allowance_bytes":6728509696,"planned_headroom_gb":1,"pool_gb":2.2999999999999998,"pool_slots":821,"prefill_chunk":256,"prefill_wait_scope":"accepted_request_to_first_model_token","prefix_cache_max_tokens":11831,"runtime_prefix_cache_enabled":true,"source":"--memory-gb","target_gb":10,"vision":true,"vision_charged_gb":0,"vision_context_limit":65536,"vision_resident_gb":0.90000000000000002,"vision_resident_reserved":false},"prompt_ids":[248045,846,198,9930,369,279,12515,6105,30,248046,198,248045,74455,198,248068,271,248069,271],"sampling":{"greedy":true,"requested_max_tokens":"24","seed":"default"},"schema_version":1,"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":28311552,"cachedRouterBytes":251658240,"completePromptHits":0,"completePromptStores":1,"contextArithmetic":"standard","decodeForwardPasses":23,"decodeIOSeconds":0.84885549800000049,"decodeLocalVictims":0,"decodeModelTokens":23,"decodeReadBytes":6262272000,"decodeRecords":2265,"decodeScatterSeconds":0,"decodeSeconds":2.4277077500000002,"decodeSlotCPUBatches":0,"decodeSlotDirectBatches":988,"decodeSlotScatterBatches":0,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":24,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":48960,"embeddingCachedRows":34,"embeddingRowHits":3,"embeddingRowMisses":34,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.40932971014492753,"expertPrefetch":{"adopted":4256,"adoptedBytes":11766988800,"adoption":"slot","adoptSeconds":0.148721507,"arrivalIssues":1048,"cancelled":23,"candidates":4824,"capRefusals":0,"deferredLaneAcquisitions":4696,"demandBatches":1120,"demandMisses":2260,"dirtyRescans":0,"expired":545,"failed":0,"forecastBuildSeconds":0.017394399000000001,"forecastEvalSeconds":0.6141367485,"forecastMerged":4824,"forecastPasses":23,"forecastSeconds":0.036269523000000026,"forecastSelectSeconds":0.018846831000000001,"forecastTap":"attention-corrected","forecastTargets":1081,"issued":4824,"issuedBytes":13337395200,"joinSeconds":0.14608690300000199,"layersComplete":10,"layersWithMisses":1142,"mode":"on","passes":23,"peakLiveBytes":0,"pieceModeReads":4824,"predictorIdentity":"router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188","promoted":2857,"readShape":"piece","recordReads":0,"scheduleSeconds":0.01129189600000001,"slotEvictedKeys":4257,"slotRefusals":0,"slotReleases":568,"slotReservations":4824,"slotStale":0,"wastedBytes":1567641600},"finishReason":"length","firstTextSeconds":0.93759358299999995,"firstTokenSeconds":0.93457725000000003,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":576,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorVMAfter":{"reclaimableBytes":22464987136,"swapins":20,"swapouts":2908},"generatorVMBefore":{"reclaimableBytes":22901161984,"swapins":20,"swapouts":2908},"gpuKeptAwake":true,"imageEncodeSeconds":2.4999999999999999e-07,"interTokenSeconds":[0.13588066700000001,0.115315209,0.102768042,0.10277966700000001,0.1059755,0.094630832999999998,0.095912708999999999,0.094324749999999999,0.098827250000000005,0.10887891700000001,0.10801683400000001,0.11849662499999999,0.092105999999999993,0.093241624999999995,0.12027575,0.103537292,0.090562875000000001,0.092244667000000002,0.087645500000000001,0.127455334,0.10228137499999999,0.120447709,0.11567137500000001],"lifetimePhysicalFootprintPeakBytes":5779591944,"lifetimeRSSPeakBytes":5143101440,"memoryPressureCancelled":false,"mlxActiveEndBytes":5424569496,"mlxCacheEndBytes":88111156,"mlxPeakMemoryGB":5.4311573820000003,"ngramCachedRows":656,"ngramCachePayloadBytes":209920,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.025931418999999994,"ngramRowHits":0,"ngramRowMisses":368,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":5.7795919439999999,"physicalFootprintEndBytes":5779591944,"prefillComputeKeyExtents":[18],"prefillComputePasses":[18],"prefillComputeQueryRows":[18],"prefillGPUWaitSeconds":0,"prefillIOSeconds":0.6819857939999997,"prefillLocalVictims":0,"prefillMLXActiveBytes":5281904024,"prefillMLXCacheBytes":86653084,"prefillPasses":[18],"prefillPhysicalFootprintBytes":5615719008,"prefillReadBytes":9455616000,"prefillRecords":3420,"prefillRowSortSeconds":0,"prefillScatterSeconds":0,"prefillSeconds":0.91451608299999998,"prefillSlotCPUBatches":0,"prefillSlotDirectBatches":132,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":18,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":0,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":0.010095125,"promptTokens":18,"queueSeconds":1.1625e-05,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":3.3749330830000002,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":24,"ropeTableHits":264,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":5779591944,"samples":169},"sampleSeconds":0.002892960000000001,"sharedExpertPrelaunches":0,"sharedPrefixBoundaries":[],"sharedPrefixCommon":0,"sharedPrefixErrors":0,"sharedPrefixRefusals":0,"sharedPrefixStores":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":0.001060624,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"text":"The sky appears blue primarily due to a phenomenon called **Rayleigh scattering**.\n\n### Step-by-Step Explanation:\n\n"}
````

### vq-dense-overlay-acceptance-tmp-v1/ssv_mem.txt

Original bytes: 116. SHA-256: `ba700ec9e65fd4d42c732f0b0d3c03d65d4199e977604fa4a74f90ad45e179e1`.

Normalized bytes: 116. SHA-256: `ba700ec9e65fd4d42c732f0b0d3c03d65d4199e977604fa4a74f90ad45e179e1`.

````text
The sky appears blue primarily due to a phenomenon called **Rayleigh scattering**.

### Step-by-Step Explanation:


````

### vq-dense-overlay-acceptance-tmp-v1/ssv_ngram.txt

Original bytes: 929. SHA-256: `7aee6c252d1fc64ffc1d396b5e8d37d3be66e22a785afade923966b9d29a35f3`.

Normalized bytes: 929. SHA-256: `7aee6c252d1fc64ffc1d396b5e8d37d3be66e22a785afade923966b9d29a35f3`.

````text
16410909,39682429,55103279,60931720,87006904,116506179,131512017,152932897,169641436,182022480,209277433,237891023,256841529,277007269,290665954,300984276
18158303,36390029,45652312,70783524,98191154,114024957,127804916,159566246,175132467,192583600,217919476,237199054,259336807,261799367,289359313,307699687
14018266,20311704,43480436,63941281,95787780,113074662,139009389,153597172,176521398,195310421,213995347,230817794,250415398,270032340,289909058,309324234
19328306,31622976,57795084,66463709,93919746,116410415,120151274,145148395,173389511,188877183,200309508,238866090,246672398,274484811,290423659,310127336
5058702,22280190,50893597,78955315,97296665,116744385,125916430,144813497,168457659,191037312,207392458,222765427,244080806,265398615,299171972,308041519
12491660,20431478,44408400,65983911,98770238,116367196,122763968,157962372,172188198,192734484,216716967,225308066,255605896,265905913,289339931,306513116
````

### vq-dense-overlay-acceptance-tmp-v1/ssv_q.log

Original bytes: 5020. SHA-256: `0b97bcbfdd85221333b354c80f9743e1088181117c7c91907f1e38d6c65c560c`.

Normalized bytes: 5020. SHA-256: `0b97bcbfdd85221333b354c80f9743e1088181117c7c91907f1e38d6c65c560c`.

````text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (26.9 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~17 of 512 experts per layer  (821 global slots = 2.3 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.3 GB expert cache at load; 6.7 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 11831 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch in plain decode, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
  window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to the estimated request time without an unmeasured cache tradeoff; --max-context N chooses another window up to 262144
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.8s: expert cache ~17/512 per layer (821 global slots = 2.3 GB), eos [248044, 248046]
elastic: off — an explicit size is pinned; omit the size flag for elastic auto
slotstream listening on http://127.0.0.1:11467
try it:
  curl localhost:11467/api/chat -d '{"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "hello"}]}'
or point any Ollama or OpenAI client at http://localhost:11467
[7:43:34 AM] request D0D4E34B /api/chat: accepted
prefix cache: miss: no retained state (0 prior evictions)
[7:43:36 AM] request D0D4E34B /api/chat: ended after 1.2 s
[7:43:36 AM] request C9422E35 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:37 AM] request C9422E35 /api/chat: ended after 1.3 s
[7:43:37 AM] request 7B36D2E3 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:38 AM] request 7B36D2E3 /api/chat: ended after 1.2 s
[7:43:38 AM] request D88F4D8D /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:39 AM] request D88F4D8D /api/chat: ended after 1.2 s
[7:43:39 AM] request 20F9AA0E /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:41 AM] request 20F9AA0E /api/chat: ended after 1.6 s
[7:43:41 AM] request 3802949F /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:43 AM] request 3802949F /api/chat: ended after 2.1 s
[7:43:43 AM] request 74338DE2 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:45 AM] request 74338DE2 /api/chat: ended after 1.7 s
[7:43:45 AM] request 326E8952 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:49 AM] request 326E8952 /api/chat: ended after 4.0 s
[7:43:49 AM] request 757AA757 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:50 AM] request 757AA757 /api/chat: ended after 1.7 s
[7:43:50 AM] request 9E9A85B1 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:52 AM] request 9E9A85B1 /api/chat: ended after 1.3 s
[7:43:52 AM] request 51ED470C /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:53 AM] request 51ED470C /api/chat: ended after 1.7 s
[7:43:54 AM] request 18AC8A71 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:55 AM] request 18AC8A71 /api/chat: ended after 1.4 s
[7:43:55 AM] request 59FE7A46 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:57 AM] request 59FE7A46 /api/chat: ended after 1.6 s
[7:43:57 AM] request 4EB6539B /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:43:59 AM] request 4EB6539B /api/chat: ended after 2.2 s
[7:43:59 AM] request 31A23E27 /api/chat: accepted
prefix cache: miss: retained states are not exact prefixes of this prompt
[7:44:00 AM] request 31A23E27 /api/chat: ended after 1.4 s
[7:44:00 AM] stopping: asked to stop (SIGTERM)
````

### vq-dense-overlay-acceptance-tmp-v1/ssv_small.txt

Original bytes: 116. SHA-256: `ba700ec9e65fd4d42c732f0b0d3c03d65d4199e977604fa4a74f90ad45e179e1`.

Normalized bytes: 116. SHA-256: `ba700ec9e65fd4d42c732f0b0d3c03d65d4199e977604fa4a74f90ad45e179e1`.

````text
The sky appears blue primarily due to a phenomenon called **Rayleigh scattering**.

### Step-by-Step Explanation:


````

### vq-dense-overlay-acceptance-tmp-v1/verify.sh

Original bytes: 19333. SHA-256: `cca70929c85234342d3cac25489be6a30db6886f39f0bb0375ebeb4d423dabd8`.

Normalized bytes: 19333. SHA-256: `cca70929c85234342d3cac25489be6a30db6886f39f0bb0375ebeb4d423dabd8`.

````text
#!/bin/bash
# slotstream verification battery. Runs every correctness gate end to end.
# (SPM unit tests require Xcode; this machine has CLT only — the goldens below
# are the actual acceptance tests and run against the real checkpoint.)
set -eo pipefail
cd "$(dirname "$0")/.."
BIN=${SLOTSTREAM_TEST_BINARY:-${BIN:-.build/release/slotstream}}
VERIFY_OUT=${SLOTSTREAM_VERIFY_OUT:-.build/verification-$(date +%Y%m%d-%H%M%S)}
mkdir -p "$VERIFY_OUT"
export BIN SLOTSTREAM_TEST_BINARY="$BIN"
CHECK_INDEX=0
safety_before() {
  python3 - "$1" <<'PYSAFE'
import sys
sys.path.insert(0, 'Tools')
from prefill_bench import preflight
preflight(float(sys.argv[1]))
PYSAFE
}
run_model() { safety_before 13 || return 2; "$@"; }
# Keep the selected path out of evaluated snippets, including substitutions.
run_binary() { "$BIN" "$@"; }
PASS=0; FAIL=0
check() {
  CHECK_INDEX=$((CHECK_INDEX+1))
  local record="$VERIFY_OUT/check-$CHECK_INDEX.txt"
  printf '%s\n%s\n' "$1" "$2" > "$record"
  if [[ "$2" == "run_binary "* ]]; then safety_before 13 || return 2; fi
  if eval "$2" >>"$record" 2>&1; then echo "PASS  $1"; PASS=$((PASS+1))
  else echo "FAIL  $1 (details: $record)"; FAIL=$((FAIL+1)); fi
}
QPID=""
cleanup() {
  if [ -n "$QPID" ]; then
    kill "$QPID" 2>/dev/null || true
    wait "$QPID" 2>/dev/null || true
  fi
}
trap cleanup EXIT INT TERM

# Use a reconstructible frozen binary when supplied; otherwise build normally.
# Check the real process lock and reclaimable memory before heavy work.
safety_before 13
if [ -n "${SLOTSTREAM_TEST_BINARY:-}" ] && [ "$BIN" != .build/release/slotstream ]; then
  python3 - "$BIN" <<'PYBUILD'
import sys
sys.path.insert(0, 'Tools')
from serve_bench import verified_build
verified_build(sys.argv[1])
PYBUILD
  echo "== frozen build: $BIN =="
else
  echo "== build =="
  safety_before 7
  make build >"$VERIFY_OUT/build.txt" 2>&1
fi

# Ordinary equality gates use 8–10 GB. The live governor drill separately
# declares a 13 GB ceiling: its unchanged 1/2 GB deadbands require a larger
# starting arena. It checks its derived target and real headroom before load,
# every explicit poll and generation, and samples its whole memory interval.
SMALL_MEMORY=8.1
BIG_MEMORY=10
ECBIG=960

echo "== weights provenance (hashes all 105.3 GB vs the pinned revisions; the draft head is optional) =="
if python3 - "$BIN" "$VERIFY_OUT/model-verification" <<'PYVERIFY'
import os,sys
from pathlib import Path
sys.path.insert(0, 'Tools')
from context_qualification import quiet_preflight, verification_lock
from prefill_bench import run_child
out=Path(sys.argv[2]);out.mkdir(exist_ok=False)
quiet_preflight(13)
with verification_lock():
    code=run_child([sys.argv[1], 'pull', '--verify'], os.environ.copy(), out, 600)
raise SystemExit(code)
PYVERIFY
then
  echo "PASS  pull --verify: every pinned file matches"; PASS=$((PASS+1))
else
  echo "FAIL  pull --verify (details: $VERIFY_OUT/model-verification)"; FAIL=$((FAIL+1))
  exit 1
fi

echo "== goldens (need bench/parity31 from Tools/parity_ref.py under mlx==0.31.1) =="
run_model "$BIN" ngram-golden --tokens "9707,11,1246,525,498,30" 2>/dev/null | sed 's/^pos[0-9]*: //' > /tmp/ssv_ngram.txt
check "ngram row ids == python reference"  "diff /tmp/ssv_ngram.txt bench/parity31/ngram_ids.txt"
check "chat template == transformers"      "[ \"\$(run_binary template-check 2>/dev/null)\" = '248045,8678,198,2523,513,10631,13,248046,198,248045,846,198,12675,1017,248046,198,248045,74455,198,248068,271,248069,271' ]"
check "layer parity (historical reference, one-row projections)"  "run_binary parity --tokens '9707,11,1246,525,498,30' --layers 2 --compare bench/parity31 --row-invariant"

# The historical fixtures remain immutable. A backend upgrade also needs a
# current independent model implementation, plus the catalogue's scalar
# numerical oracles: two implementations sharing MLX cannot alone certify it.
REFERENCE_PYTHON=${SLOTSTREAM_REFERENCE_PYTHON:-.venv/bin/python}
CURRENT_LAYERS="$VERIFY_OUT/current-layers"
check "independent current-backend layer reference" \
  '"$REFERENCE_PYTHON" Tools/current_backend_reference.py --kind layers --out "$CURRENT_LAYERS"'
check "production layer parity against current backend" \
  'run_binary parity --tokens 9707,11,1246,525,498,30 --layers 2 --compare "$CURRENT_LAYERS"'

echo "== planner: right thing across machine setups (simulated, no model needed) =="
if Tools/planner_gates.sh; then
  echo "PASS  planner gates"; PASS=$((PASS+1))
else
  echo "FAIL  planner gates"; FAIL=$((FAIL+1))
fi

echo "== sampler vs numpy reference + elastic governor policy (no weights needed) =="
if Tools/sampler_gates.sh; then
  echo "PASS  sampler + governor gates"; PASS=$((PASS+1))
else
  echo "FAIL  sampler + governor gates"; FAIL=$((FAIL+1))
fi

echo "== golden equivalence: streaming must not change the math =="
run_model "$BIN" run --prompt "Why is the sky blue?" --max-tokens 24 --greedy --memory-gb $BIG_MEMORY 2>/dev/null > /tmp/ssv_big.txt
run_model "$BIN" run --prompt "Why is the sky blue?" --max-tokens 24 --greedy --memory-gb $SMALL_MEMORY 2>/dev/null > /tmp/ssv_small.txt
check "$SMALL_MEMORY GB cache output == $BIG_MEMORY GB cache output" "diff /tmp/ssv_big.txt /tmp/ssv_small.txt"

echo "== elastic pool: live resizes must not change the math =="
check "grow/shrink/regrow byte-identical (elastic-check)" "run_binary elastic-check --big-slots $ECBIG"

# Drives the governor itself — poll, decide, lock, resize, log — not just its
# policy function, using the availability seam so no real pressure is needed.
# This required full gate fails acceptance when it cannot run with headroom;
# a diagnostic SKIP is not a passing shrink/cooldown/growth result.
echo "== elastic governor: shrinks, honors the cooldown, grows back =="
safety_before 16
DRILL_LOG="$VERIFY_OUT/elastic-drill.txt"
DRILL_STATUS=0
"$BIN" elastic-drill --slots 1000 --max-memory-gb 13 --memory-limit-gb 13 --mtp off >"$DRILL_LOG" 2>&1 || DRILL_STATUS=$?
DRILL=$(sed -nE '/^ELASTIC DRILL (PASS|FAIL|SKIP)(:|$)/p' "$DRILL_LOG")
if [ "$DRILL_STATUS" -ne 0 ]; then
  DRILL="ELASTIC DRILL FAIL: exit $DRILL_STATUS (details: $DRILL_LOG)"
elif [[ "$DRILL" == *$'\n'* ]]; then
  DRILL="ELASTIC DRILL FAIL: multiple final statuses (details: $DRILL_LOG)"
elif [ -z "$DRILL" ]; then
  DRILL="ELASTIC DRILL FAIL: missing final status (details: $DRILL_LOG)"
fi
case "$DRILL" in
  "ELASTIC DRILL PASS:"*) echo "PASS  $DRILL"; PASS=$((PASS+1)) ;;
  "ELASTIC DRILL SKIP:"*) echo "FAIL  required full gate skipped: $DRILL"; FAIL=$((FAIL+1)) ;;
  *)      echo "FAIL  $DRILL"; FAIL=$((FAIL+1)) ;;
esac

echo "== small adaptive cache: pressure recovery below the normal growth band =="
safety_before 13
SMALL_DRILL_LOG="$VERIFY_OUT/elastic-drill-small.txt"
SMALL_DRILL_STATUS=0
"$BIN" elastic-drill --memory-limit-gb 10 --max-memory-gb 10 --mtp off >"$SMALL_DRILL_LOG" 2>&1 || SMALL_DRILL_STATUS=$?
SMALL_DRILL=$(sed -nE '/^ELASTIC DRILL (PASS|FAIL|SKIP)(:|$)/p' "$SMALL_DRILL_LOG")
if [ "$SMALL_DRILL_STATUS" -eq 0 ] && [[ "$SMALL_DRILL" == "ELASTIC DRILL PASS:"* ]] && [[ "$SMALL_DRILL" != *$'\n'* ]]; then
  echo "PASS  small adaptive cache recovery"; PASS=$((PASS+1))
else
  echo "FAIL  small adaptive cache recovery (details: $SMALL_DRILL_LOG)"; FAIL=$((FAIL+1))
fi

echo "== adaptive server: saved ceiling survives startup and the live timer =="
safety_before 13
if python3 Tools/adaptive_memory_e2e.py --binary "$BIN" --out "$VERIFY_OUT/adaptive-server"; then
  echo "PASS  adaptive server lifecycle"; PASS=$((PASS+1))
else
  echo "FAIL  adaptive server lifecycle"; FAIL=$((FAIL+1))
fi

echo "== conversation prefix cache: live determinism and exact scheduled reuse =="
check "prefix reuse, invalidation and live reply equality (prefix-check)" "run_binary prefix-check"
check "a continued conversation equals a cold one (prefix-exact-check)" "run_binary prefix-exact-check"

echo "== prefill sweep: matches the pool path, deterministic, blind to the pool =="
check "sweep within the prefill-rechunk control, identical cold and warm (sweep-check)" "run_binary sweep-check"

echo "== decode overlap: direct demand reads and the GPU keepalive leave output exact =="
check "direct reads and keepalive equal the staged path on a cold cache (decode-overlap-check)" "run_binary decode-overlap-check"
check "streamed draft experts and the plain-decode lookahead leave output exact (draft-stream-check)" "run_binary draft-stream-check"

# The MTP draft head is a separately converted artifact (Tools/mtp_convert.py),
# not part of `pull` — a fresh install legitimately lacks it, so these SKIP
# rather than fail when it is absent.
echo "== MTP draft head: parity with the Python reference + speculative gates =="
MTPFILE="$HOME/.slotstream/models/qwen38-flash-next-mlx-4bit/mtp.safetensors"
if [ -f "$MTPFILE" ]; then
  CURRENT_MTP="$VERIFY_OUT/current-mtp"
  check "independent current-backend draft-head reference" \
    '"$REFERENCE_PYTHON" Tools/current_backend_reference.py --kind mtp --out "$CURRENT_MTP"'
  check "mtp head parity vs current Python reference (mtp-parity)" \
    'run_binary mtp-parity --fixture "$CURRENT_MTP/comparison.safetensors"'
  # Keep the old strict comparison visible without confusing cross-backend
  # arithmetic differences with a failed Swift port. Unexpected command
  # failures still fail acceptance; the current reference above is required.
  safety_before 13
  LEGACY_MTP_STATUS=0
  run_binary mtp-parity >"$VERIFY_OUT/mtp-legacy-reference.txt" 2>&1 || LEGACY_MTP_STATUS=$?
  if [ "$LEGACY_MTP_STATUS" -eq 0 ]; then
    echo "DIAGNOSTIC  historical MLX 0.31 draft-head reference also agrees"
  elif [ "$LEGACY_MTP_STATUS" -eq 2 ] && grep -q 'MTP PARITY FAIL' "$VERIFY_OUT/mtp-legacy-reference.txt"; then
    echo "DIAGNOSTIC  historical MLX 0.31 draft-head reference differs (retained in mtp-legacy-reference.txt)"
  else
    echo "FAIL  historical draft-head diagnostic could not complete"; FAIL=$((FAIL+1))
  fi
  # MTP is priced at startup; the combined vision leg needs its own explicit
  # 12 GB target. It must not add a draft head outside an MTP-off plan.
  safety_before 15
  if "$BIN" mtp-check --memory-gb 12 --mtp on --vision on --image Tools/assets/vision_test/secret1.jpg >"$VERIFY_OUT/mtp.txt" 2>&1 \
      && python3 - "$VERIFY_OUT/mtp.txt" <<'PYMTP'
import json,sys
from pathlib import Path
text=Path(sys.argv[1]).read_text()
assert 'PASS  vision speculation deterministic' in text
assert 'PASS  vision speculation ran' in text
assert 'SKIP' not in text and 'MTP CHECK PASS' in text
rows=[json.loads(line.removeprefix('MTP CHECK MEMORY ')) for line in text.splitlines() if line.startswith('MTP CHECK MEMORY ')]
assert len(rows)==1 and rows[0]['memory_validated'] is True
PYMTP
  then
    echo "PASS  speculative decode gates (determinism, state integrity, accept sanity)"; PASS=$((PASS+1))
  else
    echo "FAIL  speculative decode gates"; tail -5 "$VERIFY_OUT/mtp.txt"; FAIL=$((FAIL+1))
  fi
  # In the exact mode a multi-row verify pass must reproduce the one-row
  # passes bit for bit (the stock deviation is reported alongside): one
  # prompt whose positions cross 1,024 keys, where the attention kernel
  # changes, and one above the indexer budget, where a block selection is
  # active.
  check "verify pass rows equal plain decode bit for bit (mtp-rowcheck)" \
        "run_binary mtp-rowcheck --memory-gb $BIG_MEMORY"
else
  echo "SKIP  mtp gates (no mtp.safetensors — convert with Tools/mtp_convert.py)"
fi

echo "== memory target keeps its promise =="
run_model "$BIN" run --prompt "Why is the sky blue?" --max-tokens 24 --greedy --memory-gb $BIG_MEMORY --sample-footprint --stats-json /tmp/ssv_mem.json 2>/tmp/ssv_mem.err > /tmp/ssv_mem.txt
check "--memory-gb $BIG_MEMORY process footprint and RSS stay under target" \
      "python3 Tools/memory_gate.py /tmp/ssv_mem.json --limit-gb $BIG_MEMORY"
check "--memory-gb $BIG_MEMORY output is stable" "diff /tmp/ssv_mem.txt /tmp/ssv_big.txt"

# The short-prompt gate above cannot see KV/indexer growth, which is what made
# the promise hold by 0.1 GB on a long prompt before the prefill pass was
# budgeted. Re-check it where the pressure actually is.
python3 - <<'PYEOF' > /tmp/ssv_long.txt
f = ["Routine maintenance was performed on the north corridor lighting system. ",
     "Inventory counts were reconciled against the quarterly ledger totals. ",
     "The east wing humidity sensors reported nominal values throughout the day. "]
b = "The archive records that the vault combination is SEVENTEEN. "
for i in range(700):
    b += f[i % 3]
print(b + "\n\nQuestion: what is the vault combination? Answer with one word.")
PYEOF
# Use the normal non-thinking chat template. A bare raw prompt can spend the
# entire output allowance in reasoning, which is invalid recall evidence.
run_model "$BIN" run --prompt-file /tmp/ssv_long.txt --max-tokens 16 --greedy --memory-gb $BIG_MEMORY \
  --sample-footprint --stats-json /tmp/ssv_longmem.json \
  2>/tmp/ssv_longmem.err > /tmp/ssv_longmem.txt
check "--memory-gb $BIG_MEMORY process footprint and RSS under target on the long prompt" \
      "python3 Tools/memory_gate.py /tmp/ssv_longmem.json --limit-gb $BIG_MEMORY"
check "long-context answer still correct (sparse indexer active)" \
      "python3 Tools/long_context_gate.py /tmp/ssv_longmem.json /tmp/ssv_longmem.txt --expected SEVENTEEN --minimum-prompt-tokens 7000 --maximum-output-tokens 16"

# context-check is the tool that earns any future move of the 32k ceiling; the
# battery runs one small rung so the command itself stays proven (a 2k prompt
# at the small target reads in about a minute).
CONTEXT_STATUS=0
# A resource exclusion is a failed gate, not permission to omit the rest of
# the battery. Preserve both process status and diagnostics under set -e.
run_model "$BIN" context-check --tokens 2048 --memory-gb $BIG_MEMORY --sample-footprint --json \
  2>"$VERIFY_OUT/context-check.stderr.txt" > /tmp/ssv_ctx.json || CONTEXT_STATUS=$?
printf '%s\n' "$CONTEXT_STATUS" > "$VERIFY_OUT/context-check.exit-status.txt"
check "context-check: 2k rung reads inside the plan and reports it" \
      "[ \"\$CONTEXT_STATUS\" -eq 0 ] && python3 -c 'import json; d=json.loads(open(\"/tmp/ssv_ctx.json\").read().strip().splitlines()[-1]); assert d[\"fits\"] and d[\"aborted\"] is None and d[\"prefill_tokens\"]==2048, d'"

check "context-check: process memory remains under target" \
      "python3 Tools/memory_gate.py /tmp/ssv_ctx.json --limit-gb $BIG_MEMORY"

echo "== serving robustness (inputs that used to crash or corrupt output) =="
safety_before 13
if python3 Tools/issue21_e2e.py --binary "$BIN" --out "$VERIFY_OUT/issue21"; then
  echo "PASS  issue 21 streaming, branched reuse and exact restart"; PASS=$((PASS+1))
else
  echo "FAIL  issue 21 serving regression suite"; FAIL=$((FAIL+1))
fi
echo "== behavioural sanity: has the conversion lost anything obvious? =="
# NOT the FP8 comparison the plan calls for (see N4) — that needs an inference
# credential for Qwen3.8-Flash-Next FP8, which is not provisioned. This catches
# gross quantization or architecture damage and gates future re-quantization.
# `set -e` is on, so every step here has to be failure-tolerant on purpose:
# a `kill` of an already-dead server, and a `wait` on a killed one (which
# returns 143), both abort the whole battery otherwise. That is exactly how an
# earlier version of this block silently truncated the run after this gate.
safety_before 13
"$BIN" serve --port 11467 --memory-gb $BIG_MEMORY >/tmp/ssv_q.log 2>&1 &
QPID=$!
for _ in $(seq 1 120); do
  if curl -s --max-time 3 http://127.0.0.1:11467/api/version >/dev/null 2>&1; then break; fi
  sleep 2
done
if Tools/quality_probe.sh 11467; then
  echo "PASS  behavioural quality probe (15 items)"; PASS=$((PASS+1))
else
  echo "FAIL  behavioural quality probe"; FAIL=$((FAIL+1))
fi
kill $QPID 2>/dev/null || true
wait $QPID 2>/dev/null || true
QPID=""

echo "== weights behind a symlink (Foundation will not list a symlinked dir) =="
MODEL_DIR=models/qwen38-flash-next-mlx-4bit
[ -d "$MODEL_DIR" ] || MODEL_DIR="$HOME/.slotstream/models/qwen38-flash-next-mlx-4bit"
SYM=/tmp/ssv_symlink_model
rm -f "$SYM"; ln -s "$(cd "$MODEL_DIR" && pwd)" "$SYM"
check "run through a symlinked model dir"  "run_binary run --model \"\$SYM\" --memory-gb $SMALL_MEMORY --max-tokens 1 --greedy --prompt hi"
rm -f "$SYM"

safety_before 13
if Tools/api_robustness.sh 11466 13; then
  echo "PASS  serving robustness suite"; PASS=$((PASS+1))
else
  echo "FAIL  serving robustness suite"; FAIL=$((FAIL+1))
fi

echo "== vision =="
# The tower against an independent implementation. It loads 0.9 GB of vision
# tensors and none of the 105 GB trunk, so it is cheap and can run anywhere the
# weights are. mlx 0.31.1 for the same reason the parity goldens use it.
VP="$VERIFY_OUT/vision-parity"
if [ -x .venv31/bin/python ]; then
  check "vision tower dumps its pixels and embeddings" \
    'run_binary vision-parity --out "$VP"'
  safety_before 7
  if .venv31/bin/python Tools/vision_ref.py "$VP" | tail -8; then
    echo "PASS  vision tower matches the float32 reference within the bf16 band"
    PASS=$((PASS+1))
  else
    echo "FAIL  vision tower parity"; FAIL=$((FAIL+1))
  fi
else
  echo "SKIP  vision parity (no .venv31; see CLAUDE.md for the mlx 0.31.1 venv)"
  FAIL=$((FAIL+1)) # Required full vision acceptance did not run.
fi

# Every serving surface, with a real picture, against a real server. The model
# has to name what is in the photograph: a tower wired to the wrong positions
# still answers fluently, and nothing cheaper than this notices.
#
# Full original photographs require a 3.99 GB attention workspace reservation.
# Keep this explicit profile local to this server: ordinary equality/quality
# gates still use BIG_MEMORY. The 10 GB predecessor now correctly refuses the
# larger image before dispatch, and that counterexample remains in db/.
VISION_MEMORY=14.5
VISION_PREFILL=3072
NEED_GB=$(awk "BEGIN{print $VISION_MEMORY + 6}")
AVAIL_GB=$("$BIN" doctor --json 2>/dev/null | python3 -c 'import json,sys; print(json.load(sys.stdin).get("device_available_gb", 0))' 2>/dev/null || echo 0)
if [ "$(awk "BEGIN{print ($AVAIL_GB < $NEED_GB)}")" = "1" ]; then
  echo "SKIP  vision serving suite (only ${AVAIL_GB} GB reclaimable, needs ${NEED_GB})"
  FAIL=$((FAIL+1)) # Required full vision acceptance did not run.
  echo "      re-run after preflight: SLOTSTREAM_PREFILL_CHUNK=$VISION_PREFILL SLOTSTREAM_BENCH_DETAILS=1 $BIN serve --memory-gb $VISION_MEMORY --mtp off --vision on --max-context 32768 --max-prefill-wait 0 --no-elastic --port 11468"
  echo "      then: python3 Tools/vision_serving.py 11468"
else
safety_before "$NEED_GB"
SLOTSTREAM_PREFILL_CHUNK="$VISION_PREFILL" SLOTSTREAM_BENCH_DETAILS=1 "$BIN" serve --memory-gb "$VISION_MEMORY" --mtp off --vision on --max-context 32768 --max-prefill-wait 0 --no-elastic --port 11468 > /tmp/ssv-vision-serve.log 2>&1 &
QPID=$!
for _ in $(seq 1 120); do
  if grep -q "listening on" /tmp/ssv-vision-serve.log 2>/dev/null; then break; fi
  sleep 1
done
if python3 Tools/vision_serving.py 11468; then
  echo "PASS  vision serving suite"; PASS=$((PASS+1))
else
  echo "FAIL  vision serving suite"; FAIL=$((FAIL+1))
fi
kill "$QPID" 2>/dev/null || true
wait "$QPID" 2>/dev/null || true
QPID=""
fi

echo
echo "passed $PASS, failed $FAIL"
[ $FAIL -eq 0 ]
````

### vq-dense-overlay-acceptance-tmp-v1/static_gates.sh

Original bytes: 2684. SHA-256: `d8c95b03010acfbe2a9a9e523155ae07ffeb962c6adfea9703091cb34f2de2c6`.

Normalized bytes: 2684. SHA-256: `d8c95b03010acfbe2a9a9e523155ae07ffeb962c6adfea9703091cb34f2de2c6`.

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
             quantization_inventory quantization_baseline quantization_quality quantization_logit_pilot vq_kernel_sources vq_ple_stream vq_model_reference vq_execution_profile vq_draft_inventory vq_dense_overlay vq_model_fetch vq_rotary_table_source; do
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

### vq-dense-overlay-acceptance-tmp-v1/current_backend_reference.py

Original bytes: 9088. SHA-256: `42d0ae3c09f97514f0599c82c890aaf6c3214415584631af806b51bae2d70b95`.

Normalized bytes: 9088. SHA-256: `42d0ae3c09f97514f0599c82c890aaf6c3214415584631af806b51bae2d70b95`.

````text
"""Run the independent Python model implementation on MLX 0.32.2.

Write live comparison outputs to an explicitly new experiment directory.
Never update the historical parity or MTP golden fixtures. These comparisons
check the Swift port; the float64 component oracles check the shared kernels.
"""
import argparse
import ctypes
import ctypes.util
import fcntl
import hashlib
import json
import os
from pathlib import Path
import resource
import struct
import sys
import threading

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "Tools"))
from prefill_bench import preflight, vm_snapshot

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--kind", choices=["layers", "mtp"], required=True)
parser.add_argument("--out", type=Path, required=True)
parser.add_argument("--model", type=Path,
                    default=Path.home() / ".slotstream/models/qwen38-flash-next-mlx-4bit")
options = parser.parse_args()
kind, out, modeldir = options.kind, options.out, options.model
before = preflight(14)
model_lock = open(f"/tmp/slotstream-model-{os.getuid()}.lock", "a")
fcntl.flock(model_lock, fcntl.LOCK_EX | fcntl.LOCK_NB)

import mlx.core as mx
import mlx.nn as nn
import numpy as np

if mx.__version__ != "0.32.2":
    raise RuntimeError("current backend comparison requires MLX 0.32.2, got " + mx.__version__)
mx.set_cache_limit(128 << 20)
out.mkdir(parents=True, exist_ok=False)
libproc = ctypes.CDLL(ctypes.util.find_library("proc"))


def physical():
    # macOS rusage_info_v4 ABI: uuid[16], then 35 uint64 fields. Physical
    # footprint is field 7; the lifetime maximum is field 28. RSS alone
    # misses allocations that Metal has released before the observation.
    data = ctypes.create_string_buffer(296)
    if libproc.proc_pid_rusage(os.getpid(), 4, data) != 0:
        raise RuntimeError("physical footprint unavailable")
    return {"current_bytes": int.from_bytes(data.raw[72:80], "little"),
            "lifetime_peak_bytes": int.from_bytes(data.raw[240:248], "little"),
            "rss_peak_bytes": resource.getrusage(resource.RUSAGE_SELF).ru_maxrss}


stop = threading.Event()


def guard_memory():
    while not stop.wait(.05):
        try:
            memory = physical()
        except Exception as error:
            (out / "memory-observation-error.txt").write_text(str(error) + "\n")
            os._exit(98)
        if max(memory.values()) > 10_000_000_000:
            (out / "memory-refusal.json").write_text(json.dumps(memory, indent=2) + "\n")
            os._exit(99)


threading.Thread(target=guard_memory, daemon=True).start()
if kind == "layers":
    from parity_ref import load_reference

    ref = load_reference(str(modeldir / "qwen4_exp.py"))
    cfg = json.loads((modeldir / "config.json").read_text())
    args = ref.ModelArgs.from_dict(cfg)
    targs = args.text
    model = ref.Model(args)
    tokens = [9707, 11, 1246, 525, 498, 30]
    wanted = tuple([f"model.layers.{i}." for i in range(2)] +
                   ["model.embed_tokens", "model.hyper_connection_mixer", "lm_head"])
    index = json.loads((modeldir / "model.safetensors.index.json").read_text())["weight_map"]
    selected = {name: shard for name, shard in index.items()
                if name.removeprefix("language_model.").startswith(wanted)
                and "ngram_embedding.shard_" not in name}
    arrays = {}
    for shard in sorted(set(selected.values())):
        loaded = mx.load(str(modeldir / shard))
        arrays.update({name: loaded[name] for name, file in selected.items() if file == shard})
    weights = model.sanitize(arrays)
    qcfg = cfg.get("quantization", {})

    def predicate(name, module):
        if "ngram_embedding.shard_" in name:
            return False  # Replaced with bounded storage below, never evaluated.
        if name in qcfg:
            return qcfg[name]
        return hasattr(module, "to_quantized") and name + ".scales" in weights

    nn.quantize(model, group_size=qcfg.get("group_size", 64), bits=qcfg.get("bits", 4),
                class_predicate=predicate)
    model.load_weights(list(weights.items()), strict=False)
    model.eval()

    # Storage-only adapter: the Python embedding loads a complete large
    # shard before gathering. Read its requested rows from the original
    # safetensors, then use the same dequantization operator. Hashing,
    # position/state logic and every model layer remain the reference.
    class RowTable(nn.Module):
        def __init__(self, base):
            super().__init__()
            self._base = base

        def __call__(self, indices):
            rows = np.array(indices).reshape(-1).tolist()
            assert 0 < len(rows) <= len(tokens) * targs.heads_per_ngram * (targs.ngram_size - 1)

            def read(suffix):
                name = self._base + suffix
                with (modeldir / index[name]).open("rb") as file:
                    length = struct.unpack("<Q", file.read(8))[0]
                    assert length <= 64 * 1024 * 1024
                    info = json.loads(file.read(length))[name]
                    shape, dtype = info["shape"], info["dtype"]
                    assert len(shape) == 2
                    width = {"U32": 4, "BF16": 2, "F16": 2, "F32": 4}[dtype]
                    record = shape[1] * width
                    assert info["data_offsets"][1] - info["data_offsets"][0] == shape[0] * record
                    pieces = []
                    for row in rows:
                        assert 0 <= row < shape[0]
                        file.seek(8 + length + info["data_offsets"][0] + row * record)
                        value = file.read(record)
                        assert len(value) == record
                        pieces.append(value)
                raw = b"".join(pieces)
                if dtype == "BF16":
                    values = (np.frombuffer(raw, np.uint16).astype(np.uint32) << 16).view(np.float32)
                    return mx.array(values.reshape(len(rows), shape[1])).astype(mx.bfloat16)
                values = np.frombuffer(raw, {"U32": np.uint32, "F16": np.float16, "F32": np.float32}[dtype])
                return mx.array(values.reshape(len(rows), shape[1]))

            config = qcfg[self._base.removeprefix("language_model.")]
            return mx.dequantize(read(".weight"), read(".scales"), read(".biases"),
                                 group_size=config["group_size"], bits=config["bits"])

    ple = targs.ple_layer_ids[0] - 1
    ng = model.model.layers[ple].ple.ple_embedding
    prefix = f"language_model.model.layers.{ple}.ple.ple_embedding.ngram_embedding."
    for shard in range(ng.n_shards):
        setattr(ng.ngram_embedding, f"shard_{shard}", RowTable(prefix + f"shard_{shard}"))
    text = model.model
    ids = mx.array([tokens])
    h = mx.tile(text.embed_tokens(ids), (1, 1, text.hc))
    caches = model.make_cache()
    eos = targs.eos_token_id if not isinstance(targs.eos_token_id, list) else targs.eos_token_id[0]
    previous = mx.full((1, targs.ngram_size - 1), eos, mx.int64)
    for i in range(2):
        cache = caches[i]
        idx = cache.indexer if hasattr(cache, "indexer") else None
        h = text.layers[i](h, text.rope, None, None, cache, idx, ids, previous)
        mx.eval(h)
        np.array(h.astype(mx.float32)).tofile(out / f"layer_{i}.bin")
        print("completed independent layer", i, flush=True)
    sources = [modeldir / "qwen4_exp.py", ROOT / "Tools/parity_ref.py"]
else:
    sys.path.insert(0, str(ROOT / "Tools/reference"))
    from mtp_ref import load_mtp
    from qwen4_exp import ModelArgs, RotaryEmbedding, _AttnCache

    args = ModelArgs.from_dict(json.loads((ROOT / "Tools/reference/config.json").read_text())).text
    model = load_mtp(str(modeldir / "mtp.safetensors"), args)
    rope = RotaryEmbedding(int(args.head_dim * args.partial_rotary_factor), args.rope_theta)
    inputs = ROOT / "Tools/reference/fixtures/mtp_parity_inputs.safetensors"
    arrays = mx.load(str(inputs))
    cache = _AttnCache()
    a, ma = model(arrays["embedded"], arrays["hidden"], rope, cache)
    b, mb = model(arrays["embedded2"], arrays["hidden2"], rope, cache)
    mx.eval(a, ma, b, mb)
    assert cache.offset == arrays["embedded"].shape[1] + 1
    mx.save_safetensors(str(out / "comparison.safetensors"), dict(arrays, out1=a, multi1=ma, out2=b, multi2=mb))
    sources = [ROOT / "Tools/reference/mtp_ref.py", ROOT / "Tools/reference/qwen4_exp.py", inputs]

memory = physical()
assert max(memory.values()) <= 10_000_000_000, memory
receipt = {"mlx": mx.__version__, "kind": kind, "before": before, "after": vm_snapshot(),
           "mlx_peak_bytes": mx.get_peak_memory(), "process_memory": memory, "method": __doc__,
           "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
           "reference_sources": {str(p.relative_to(ROOT)) if p.is_relative_to(ROOT) else p.name:
                                 hashlib.sha256(p.read_bytes()).hexdigest() for p in sources}}
(out / "receipt.json").write_text(json.dumps(receipt, indent=2) + "\n")
stop.set()
````

### vq-dense-overlay-acceptance-manifest-v1.json

Original bytes: 26388. SHA-256: `1b17d1cd6572a5fefb7fdf6952e698884eb2b72ca830beb3e36823b719486676`.

Normalized bytes: 26388. SHA-256: `1b17d1cd6572a5fefb7fdf6952e698884eb2b72ca830beb3e36823b719486676`.

````text
[
  {
    "path": "vq-dense-overlay-acceptance-v1/affine/stderr.txt",
    "bytes": 32,
    "sha256": "5f05e68a94141d9d526d58e8048518f9e3f4d313b9f478253e3c9219bc4ad091",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/affine/stdout.txt",
    "bytes": 21347,
    "sha256": "7addccd78c1ed6b3162b05ea0c4094aa5948e99465431e04947593ea789e829c",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/run.json",
    "bytes": 5628,
    "sha256": "25253e206b8478a22997ddafc00eba7dfe166ad1aabbccdda20d513be01982c4",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/static/stderr.txt",
    "bytes": 5367,
    "sha256": "5dd0d0aeb7906030d8d985a5367a75e36957b62a3da1870048ab7eee7c3af52e",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/static/stdout.txt",
    "bytes": 28250,
    "sha256": "6366897c338b4e42d402c8a560972e9760515bbf4dd44033987bb7f94a0b1131",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/adaptive-server/report.json",
    "bytes": 5700,
    "sha256": "cd76953332300e07cb8afa258f269704230aa4b2fb2dc4d07cfe6e74b1e2b4ef",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/adaptive-server/server.log",
    "bytes": 2152,
    "sha256": "6d236e9df892ef14ec9463a0fb4ed89506ee2fb873df637e498f368cc594f048",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-1.txt",
    "bytes": 87,
    "sha256": "47e135e10a066f5ae8612148e92bddbc9ed3b585f467dad9261307f96c311234",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-10.txt",
    "bytes": 802,
    "sha256": "f86ac4f52c95a2655417ca3df6a0fae57276d457cf5d6cc91a3d263597fe729c",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-11.txt",
    "bytes": 210727,
    "sha256": "eaf56146fa63b75fd04d30ba27d9274b8006f466d517366ea94fa9ebd63a6c40",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-12.txt",
    "bytes": 2201,
    "sha256": "3f5a8793c1d9ab54de0862541e2737728b5149baaef5209ca3f31e678aa15221",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-13.txt",
    "bytes": 340,
    "sha256": "2053707d6bddb7c8f0c9789157f41595d0eb58744f0e7a07a0c7c3e5374f7e05",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-14.txt",
    "bytes": 426,
    "sha256": "08e5e1d17e3bcd3a1dee2c02a0d61c89eb5eb7b28cfc1ee61faef6aeaf5ed293",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-15.txt",
    "bytes": 3526,
    "sha256": "748445613b9ab2fe42bbac973c5e6ee1d9533336775534ecc78024f14120279b",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-16.txt",
    "bytes": 468,
    "sha256": "15b77310031fbfb2ef8438c7ba9bfc9c19c8cecf2526f1331b9bbd8f9c635f39",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-17.txt",
    "bytes": 71,
    "sha256": "29c9a3eb030bd06f358d49a86ee2a5f435b93ad3a3710b689ecdc9afb4af0f00",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-18.txt",
    "bytes": 486,
    "sha256": "909e2b0dfc90282efdda2c593b80452470a63cc4f55de676df2d382b704c0649",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-19.txt",
    "bytes": 292,
    "sha256": "4c4914bb3dcec6b643d6db1274eb322f10e2c2a19a5d02eb15779b0ad7e5bb15",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-2.txt",
    "bytes": 202,
    "sha256": "41d318695c0502e1ca324367f323bf4c936119ecba79f9fe78dddd3cafe25fb6",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-20.txt",
    "bytes": 265,
    "sha256": "7acff6429e179baad49cf31a8f9ac3c44bbba0aca91eb97fd240ad734d70a1da",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-21.txt",
    "bytes": 460,
    "sha256": "40b8ebc249c92001005b1b45f1422f478e982e3feb1d02fbe762d10a930bfd3d",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-22.txt",
    "bytes": 2133,
    "sha256": "81a6a2f026b13a602f103e5396201bda9eb5c9428872b3f46669b08dcc53fc73",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-23.txt",
    "bytes": 308,
    "sha256": "0692dbe990720c42b9a649e0ee5c8fc7947cf0f4010b8d7c69960485e03f9464",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-3.txt",
    "bytes": 260,
    "sha256": "fcfaedd51d025cbf44a9d614286b0393963d979add8bbe925a6ff2cb60f580c0",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-4.txt",
    "bytes": 341,
    "sha256": "9f6543c19000242a654b481cee7c2cd4d860e03315bf88c6d30a1f521993d785",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-5.txt",
    "bytes": 224,
    "sha256": "a99239e5bab2b1aa6624f1b97fc25ff4cb218e0e8ab903b4d6229c38e21b99a0",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-6.txt",
    "bytes": 83,
    "sha256": "f004e9fdfdc5f1a7ecb88d5c2cbe6963c972bc4a07427b162e62bfa5808f68c1",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-7.txt",
    "bytes": 414,
    "sha256": "1d70f1b280e24ed34eae26d045d8fa3b10982e38f8b82f543a8d801d57e5a769",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-8.txt",
    "bytes": 1145,
    "sha256": "88166adaa38e3b27c4921f352b07e97b51c29226cc18ecf4cb0fa0083e895765",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/check-9.txt",
    "bytes": 1295,
    "sha256": "373cd84a9ca60a94c2acd57c88f72daff423c8e6e383b0b2b53d90d751d29539",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/context-check.exit-status.txt",
    "bytes": 2,
    "sha256": "9a271f2a916b0b6ee6cecb2426f0b3206ef074578be55d9bc94f6f3fe3ab86aa",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/context-check.stderr.txt",
    "bytes": 1775,
    "sha256": "b01135afa31220bb3867a520472e248e623bfc8c5f76dd4332d1e8ab78f05770",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/elastic-drill-small.txt",
    "bytes": 1479,
    "sha256": "be5954cfadf01978500dd7c7efb8a89fffba234e83976860ec68e0c873b6e24a",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/elastic-drill.txt",
    "bytes": 1478,
    "sha256": "575b8de21399b81e284933cc6a72e6b13170560da281b320e8403299b76a3bd3",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/first-command.json",
    "bytes": 431,
    "sha256": "b2bea1f783701e91c6d0b2650e23140364a146ee706d66785ed4f26db2c2a3b1",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/first-server.log",
    "bytes": 12296,
    "sha256": "a631da7e1cb6f0689d36e3b0057de8ef1747e3623f1cd4380ff2e94f3347e995",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/after-disconnect.json",
    "bytes": 471,
    "sha256": "3dbc74fa85935fcd37e23e55a628519ae06ad3b34f700319fb76cf0c1c3b28dc",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/branch-alpha-followup.json",
    "bytes": 15839,
    "sha256": "6e2e7657663b5d714b9cae54cab9d3afca2d1bc920e3208bf826a59276c2c3db",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/branch-alpha-followup.sse",
    "bytes": 5435,
    "sha256": "74dc485ac84cb58fe753f9f5a599c8a6953deaacbd82847557b467287338b477",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/branch-alpha-seed.json",
    "bytes": 25383,
    "sha256": "a0554c5beb1b5586700b31efabc0f08f11e1ca9c26c080577b0e4c193c99ea40",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/branch-alpha-seed.sse",
    "bytes": 11308,
    "sha256": "385ccccbb7bc356f5527c7d65c3f126f4413965de823002e2737d175bd17b863",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/branch-beta-seed.json",
    "bytes": 29755,
    "sha256": "dbb79737f6b0221615406f87cac4ec611724827eda4601bedf03440361869162",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/branch-beta-seed.sse",
    "bytes": 12467,
    "sha256": "762ee9a6b479869386673b15540db5856ca8f7584778588f193bb19022cbba15",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/cache-turn-1.json",
    "bytes": 15421,
    "sha256": "93661b14ff92abe7741b874e212830fe559d73c58d83ef816b1d03a1fb03ad2e",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/cache-turn-1.sse",
    "bytes": 6606,
    "sha256": "88fee2c05228666b41754bd8bb96d53669ab31e995f4b70b1947074298352b92",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/cache-turn-2.json",
    "bytes": 18192,
    "sha256": "f0d9d1289863cb40cc60c71e2c3488b19a3a5e80f01c05c2e9c1212622d55f0a",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/cache-turn-2.sse",
    "bytes": 6609,
    "sha256": "fd0899bdc4f454e1fa8bd49e375e56de0b505924865496cb274340423fbd311f",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/cache-turn-3.json",
    "bytes": 18369,
    "sha256": "5ceddf6bb66278a2019a54d30688b3f01cd0d3e653a6635daecb677fa981b21e",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/cache-turn-3.sse",
    "bytes": 6596,
    "sha256": "711e3dc9720e6492c7139b7b248f16fd4ed78fbe080d205f39fc96fa1016052f",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/disconnected-stream.http",
    "bytes": 343,
    "sha256": "d8d8720b4cacb09074fbae14b5e108314d82b3e60c1a3470bc459223103ffc4b",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/large-allowance-unused-tools.json",
    "bytes": 1865,
    "sha256": "7dfd37c1d6511cee43cbbd7492eb28b47a4b5286e6cf73fe481ee25293ac0072",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/large-allowance-unused-tools.sse",
    "bytes": 575,
    "sha256": "8d8fa8a24b828ae509c0cedbbd57e2a4463eb9a29273ffca564e5e717aa8881a",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/long-truncated-argument.json",
    "bytes": 129533,
    "sha256": "893e2c7168d117597f82f22b5cb033856fcd07e1d1b47fa458dae940f1bc02a1",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/long-truncated-argument.sse",
    "bytes": 64125,
    "sha256": "262bba2412903e95efe2ef28fa00b9dfcf9aab4aaf962e6c5a3ea03132ca09b8",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/nullable-truncated-argument.json",
    "bytes": 129655,
    "sha256": "8805c8693f1278a73d74a8edc973fc9e1867fa6d03a00392f49ea7713b3ea819",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/nullable-truncated-argument.sse",
    "bytes": 64128,
    "sha256": "341875a92791414c8b6c4ac4484adb151851efd5615e66b12d5b49a637228e24",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/plain-cap.json",
    "bytes": 48050,
    "sha256": "019c0bf36bf05e914a774062ee8c66fb69f54cb2127890a97a4f42a8b5e583c3",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/plain-cap.sse",
    "bytes": 28404,
    "sha256": "fa85c54f634bc10d03ca110f1a3e897c85928486b3949fb29a50d04469d4707b",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/results.json",
    "bytes": 2926,
    "sha256": "a81697fb8203ac1e2d24a86101013ea8eb5e2a2247205544fe5fa4a0481f026f",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/tools-unused-cap.json",
    "bytes": 48744,
    "sha256": "5b3f2cec77a104c6d3c8ff021af0a2231c40352ee1c513088cc15ca123596dfb",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21/tools-unused-cap.sse",
    "bytes": 28454,
    "sha256": "fb6224b5d986299529f6900816cac0ac524ab887072282fea63b6c6e4415a1a2",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21_e2e.py",
    "bytes": 5633,
    "sha256": "b535fc7439bd6756d9d6c0523e28820ab83b7870fb85ba7f1d1c995006e171c8",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/issue21_gate.py",
    "bytes": 11210,
    "sha256": "30191d536e4db61aa78165943e5be1ea1d25d1b22b25af7a088e097da187b72f",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/openai-tools.jsonl",
    "bytes": 44450,
    "sha256": "5d393346fa2f90cb5b721be00599bd4ce1cfc3d99ee3d519c3e257df423761b5",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/openai_tools_gate.py",
    "bytes": 12210,
    "sha256": "af34e19c6d12dfcd62d252a4c016e2d595aec4ae0dad4e3232e2c24f8ad2d1e3",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/.lock",
    "bytes": 0,
    "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/20ef8d7f66add1582d0356f02ad3055c598cb511.slotprefix",
    "bytes": 115669125,
    "sha256": "086480a41e7dfdb5cbd2af128977b6891cc905a4893c20973b20b01767165f2e",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/2ffe5452ffa7be329ecdfa819b2a1fb88607b78a.slotprefix",
    "bytes": 115673766,
    "sha256": "85c92104f9a09702eb3343c6a0d77556beb453d1d20a9c38a2d66da9f9823f3e",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/43c422a8836e61aeaa8206c3250332879a17e284.slotprefix",
    "bytes": 115665232,
    "sha256": "88ebc29f6d3b28480a40c98f211cd84d1c148d09aeb52d493d523609ae2f9d59",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/5714af9d3ec542028eda92164d6402a1.slotseg",
    "bytes": 14161444,
    "sha256": "55d483ac8a2055728bb3e18c4250ac5eee8e01c2583993180a0db5917e9505ca",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/6f651ca1a68c8a7082c4861eb51481fb3a41d239.slotprefix",
    "bytes": 115681167,
    "sha256": "5bdeb0cd74c7c8533ca376feafc3a9da34b0d3cdfdb761f322b6bfa5ee5a4bc9",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/72f60c191a72434fa3c627d25881def9.slotseg",
    "bytes": 21239230,
    "sha256": "58624e1c280d26da003077c164297cc4bc5d70626063feb6bd55fe51bf859a55",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/79aad8f9893544ca9e8c7918fb576a59.slotseg",
    "bytes": 21239227,
    "sha256": "3aec39c33c46f0a020ca5ca800cf7f2d8f0e0768a0d98330eb53177561f61385",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/86135bb6e3cd4f85b98c09330e0eadd8.slotseg",
    "bytes": 14161482,
    "sha256": "a3fa8645751144f7773c6716c45a24c72c5563d6b095b0a382137a5be82fa38c",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/8af1124d2bbaa082ed8af89e2144cbde95da2054.slotprefix",
    "bytes": 115665227,
    "sha256": "dd0bee03a6672a1ab24fd1cc6ed560a1196a4af646292de80cd1b094d7c2fbba",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/9c098ae43f4d450cbb1c9cdca893f638.slotseg",
    "bytes": 7083564,
    "sha256": "974ee22d71a0ec89848134f3711d0c267dd8db94d53029e19dcf826f4cd34aca",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/aac11151481a424291d2468847f02f1e.slotseg",
    "bytes": 7083527,
    "sha256": "248b8d437b8952ac08339f26d7cb1a68995876305dc0649267c86ee118f22db0",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/abce2e72b6d87d96efbe7715c73bc435693d3be3.slotprefix",
    "bytes": 115677096,
    "sha256": "4980718a9c05f58eda42f5ddacbd958a4c5a49544f6c6256d03e5f3d3e162873",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/c9ff773dcc11022cf82e9819159b3597fea4ac38.slotprefix",
    "bytes": 115684060,
    "sha256": "91cb3cc1765d06562a94fdb8e2de12cd0566b00e4e8b98523e486f17b097f6dc",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/d16db10e68b54164ba792cfd625d080c.slotseg",
    "bytes": 21239378,
    "sha256": "5529bd2042f19b87f305579cca88500c961b321b385874eaf02ee33be44c8029",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/f82a953684a64450a5dbd3f85a33ebdc.slotseg",
    "bytes": 7083526,
    "sha256": "87c4af43b3480f2007f1bafc17005abee60c16a3114ee60eb23d817f45cc7c3b",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/prefix/f984e796db0d5c6ffb37032ececa8331edc329e8.slotprefix",
    "bytes": 115681526,
    "sha256": "597c17cb7b15a9e30e2f1d7b1d863367596c6be9a1eae18a8e2137fdf598a23b",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/restart-command.json",
    "bytes": 431,
    "sha256": "4211ae028ee2717d821b5d130f650c19a862ef3f295686bf6685a1f86c6f2aa5",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/restart-result.json",
    "bytes": 191,
    "sha256": "48b4f9f0fa90468740f6af41ce27282149de9e242e8b47cdf49183efabe407ef",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/restart-server.log",
    "bytes": 2070,
    "sha256": "8605f06bde8a716885ee9fd29897a7396ff3c9b9f5c38228ab84a080a5d15d53",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/restart.sse",
    "bytes": 6596,
    "sha256": "243d68a59f18d55b29b9da86fbc6c5055f66f22118a577f075ea0a930570eddd",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/issue21/result.json",
    "bytes": 36962,
    "sha256": "114fa0c70bed26c24eb0baf595833d0f6b1c15ad3a394c3fdb6adb46b366735f",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/model-verification/stderr.txt",
    "bytes": 0,
    "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/model-verification/stdout.txt",
    "bytes": 1031,
    "sha256": "d88a51de9d4b5b8d81b48e3b969141655075e37063b5b8d0e0fd2a886cb368c9",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/mtp-legacy-reference.txt",
    "bytes": 216,
    "sha256": "c0f4555eac5e1d29a189fb5f19faa160761a76eec8054a5cc645d7dcbcea5c06",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/mtp.txt",
    "bytes": 3599,
    "sha256": "022eab299fcb70473a9c40a4985af4501017c7ff0955e4093d8639c60c120f91",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/vision-parity/embed.bin",
    "bytes": 7188480,
    "sha256": "72fed87772ce6e0a87efcb07ee34873cbcadce76b3fa5e4287015cb72cc2c9cd",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/vision-parity/manifest.json",
    "bytes": 475,
    "sha256": "133c1a1478935c19fe10083706e98e0697d5de77f84a644cf2f05108a6fc35e4",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-acceptance-v1/verify-results/vision-parity/pixels.bin",
    "bytes": 17252352,
    "sha256": "55a8cbc837f8ccbbe3e678acda0f521ec0a952f92d12218d3879e2e280908d53",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-native-supervision/identity.json",
    "bytes": 2469,
    "sha256": "28a8336b5e6b3790faff711322900882eeb24949bceb6043add35eef2cc7ac12",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-native-supervision/receipt.json",
    "bytes": 2139,
    "sha256": "7d41254121b56e44a3fb4fba2590e55ff44f0310bb004cdf2f52b33dc7f69acb",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-native-supervision/stderr.txt",
    "bytes": 0,
    "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-native-supervision/stdout.txt",
    "bytes": 98,
    "sha256": "f85b350626ae650fae0218889496b1fdf21f5aa75f76668edd4f58730f222389",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-reference/layer_0.bin",
    "bytes": 245760,
    "sha256": "688eccff47d94a53121a6da57a1a4b161155fa28818c8a61746d95dd296bf3c0",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-reference/layer_1.bin",
    "bytes": 245760,
    "sha256": "cf41a3a4c8221a743f8db5c1350d5b699e00b7e89b73997868bf528ffa901cf5",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-reference/receipt.json",
    "bytes": 4845,
    "sha256": "c677d2c3f96b8bcd2a430d739d9b0a2a7392b8849843e619f403e67681657f8d",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-reference-supervision/identity.json",
    "bytes": 2402,
    "sha256": "d6c226c1bf93cc7a02d5d3c89bb440f8463251856185fce23f6334ca82526402",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-reference-supervision/receipt.json",
    "bytes": 2139,
    "sha256": "5a8b1cba8a4cb22c5f3d99897240c61d27516e7be70bbd4b4cae6e547d610932",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-reference-supervision/stderr.txt",
    "bytes": 0,
    "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/layers-reference-supervision/stdout.txt",
    "bytes": 60,
    "sha256": "b4b19fa128ae1d7f77e49fb1f0818dc9e42caa8ab82b8f34d675abfcca3852af",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/mtp-native-supervision/identity.json",
    "bytes": 2421,
    "sha256": "149e259ec610ce0e59c57e708dd789cb65ca6aa3e83d1fd0afd537da39dabf60",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/mtp-native-supervision/receipt.json",
    "bytes": 2139,
    "sha256": "67b7f3e573d456851b0d9834f4adf85673f663b57d44a646c3e5eb9e2997257d",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/mtp-native-supervision/stderr.txt",
    "bytes": 0,
    "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/mtp-native-supervision/stdout.txt",
    "bytes": 208,
    "sha256": "6baff6abfec4abcd9c1eef27f79e5c7faa4128be16bf78fc4b1a590a47329f7f",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/mtp-reference/comparison.safetensors",
    "bytes": 256791,
    "sha256": "b754211cb78ab072dc8204e375df727df0bbfa4aa606c087c138c2d49f8362c4",
    "text_captured": false
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/mtp-reference/receipt.json",
    "bytes": 4995,
    "sha256": "2fca217ce15434acecbe36d59fe3327f7213e636253e0f978be8511d01d3912c",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/mtp-reference-supervision/identity.json",
    "bytes": 2396,
    "sha256": "d8fc6c5012a5d5fe3399c6dae502a6718ea272e9ebefc646b3cb7960a2f29e7a",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/mtp-reference-supervision/receipt.json",
    "bytes": 2139,
    "sha256": "8c97fbbd9ca812640a7d0a175c675312ef698b2b869115b421cc18021db3b563",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/mtp-reference-supervision/stderr.txt",
    "bytes": 0,
    "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/mtp-reference-supervision/stdout.txt",
    "bytes": 0,
    "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "text_captured": true
  },
  {
    "path": "vq-dense-overlay-reference-repair-v1/run.json",
    "bytes": 11974,
    "sha256": "cefc3212f35f93adaaca64909d02843e45e40724b7fdbbb060089eeac22636c2",
    "text_captured": true
  }
]
````

### frozen-dense-overlay-v2/build-identity.json

Original bytes: 31599. SHA-256: `4c9ff73749e2cc39d3ce36507e7312fe9212d07efa273aa00e4992577ce5f13d`.

Normalized bytes: 31599. SHA-256: `4c9ff73749e2cc39d3ce36507e7312fe9212d07efa273aa00e4992577ce5f13d`.

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
    "Sources/Slotstream/VQCheckpoint.swift": "5b6d5877b28ea19ad3624dfe1d660db3a2dab7da19212e060c097da1712b7c17",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQDenseOverlay.swift": "0102f31346cb84048b551265696cd4bcf4dd7f2a73c60be6840d654f9c4a2978",
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
    "Sources/Slotstream/VQResidentText.swift": "4ac08a39de539afef273d7925779a9ce175319d21bf6c44b3205ef20393c9592",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+Quantization.swift": "10c55f4cdae07ee3616899d3c80c7e0d34186e00eb71512a1385ad15bacef6cd",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "747654d88e344d45b3cc0c8c1d3796343186d247065fd66f6377d72d7051bf7a",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "d6aaa6d637b8e0a6ebbb709fa2eaf8b223ebd6f95854b596347b3da5fce1aa04",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "169fa926a8ed7dc630ab5ac6a6d11d684194c944cfa68607583ccada8a19bcda",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "4c8f6db56c024cc1dec2205e92f89c13dfc57314d0561b9493cc60c1c6700be8",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "1539fa20986c554865714a5b17d23c5563917419fd044ec2ab3972b8608f9355",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "34322a2ae7f1e0c8d281ee2177281a19c1e8266debf2f64a1d6969fd85c07dfc",
  "binary_sha256": "2ce253c1583b96921bf410ef4bfa8d0f6a0526567e46cf37041e35a534809076",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````
