---
type: run
created: 2026-10-03T14:25:41.593688+00:00
updated: 2026-10-03T14:25:41.593688+00:00
summary: Lossless aligned VQ expert export with full tensor reconstruction
binary: e878533ce71a6e91b0fae5e8bbe8baebbb6194dad84fead52e9b42f0620ad011
captured_at: 2026-10-03
command: Exact sequential commands are preserved in the driver and supervision identities below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Lossless aligned VQ expert export with full tensor reconstruction
tool: bounded VQ research diagnostics
---

A single bounded CPU-only transformation exports the unchanged VQ 3.2 expert codes and scales into 48 aligned files. All 288 reconstructed contiguous source-tensor hashes match, and every per-record padding region is zero. Codebooks, dense tensors, PLE and draft bytes are untouched. Source payloads are verified first; source and output stamps are rechecked; a complete manifest becomes visible atomically only after verification and synced writes. The exact export manifest SHA-256 is 230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834.

Output occupies 47866183680 bytes, inside the declared 48-GB output cap and 350-GB research-staging cap. Staging before export was 254809699818 bytes. Final process observations are 246923960 current, 258998968 lifetime physical peak and 272646144 lifetime RSS peak bytes, below the one-GB conversion bound. The converter enforces bounded reads and a time limit; it holds the shared verification lock and runs with no model process.

Synthetic reconstruction, corruption, zero-padding, truncation, invalid-extent and partial-write checks pass. This source proves the bounded storage transformation, not a native packed reader, speed gain, candidate admission or product distribution. The final manifest binds original tensor identities and all derived file hashes; derived payloads remain only in the declared research directory.

Local home prefixes are replaced with <HOME>. Original byte lengths and hashes identify the unmodified local files. For large transcripts, the normalized UTF-8 bytes are stored losslessly as zlib-compressed base64 inside this Markdown source. Decode with `zlib.decompress(base64.b64decode(block))` and verify the listed normalized byte length and SHA-256. Every encoded block was round-trip checked before writing. This changes storage only, not the captured evidence. Small transcripts remain plain text. Raw tensor fixtures and source-bound executables remain in the bounded research directory; manifests bind their hashes. No model is installed or activated.

### capture-vq-contiguous-export-v1.py

Original bytes: 3435. SHA-256: `a227a2741f8cb8c99efab63e58730f9236525ea62ac6f728410b7a12d055a4b1`.

Normalized bytes: 3435. SHA-256: `a227a2741f8cb8c99efab63e58730f9236525ea62ac6f728410b7a12d055a4b1`.

````text
from pathlib import Path
import json,sys,hashlib,runpy,shutil,subprocess
sys.path.insert(0,'Tools');import vq_record_repack
r=Path('.build/quantization-research');a='vq-contiguous-export-v1';b='vq-contiguous-records-v1';d=json.loads((r/a/'run.json').read_text());assert d['complete']
for path,sha in d['bound_files'].items():assert hashlib.sha256(Path(path).read_bytes()).hexdigest()==sha
root=Path.cwd();sources={}
for module in list(sys.modules.values()):
 value=getattr(module,'__file__',None)
 if value:
  p=Path(value).resolve()
  if p.is_relative_to(root/'Tools'):sources[str(p.relative_to(root))]=hashlib.sha256(p.read_bytes()).hexdigest()
head=subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip()
for path,sha in sources.items():
 if path!='Tools/vq_record_repack.py':assert hashlib.sha256(subprocess.check_output(['git','show',head+':'+path])).hexdigest()==sha,path
f=r/'frozen-contiguous-export-producer-v1';f.mkdir()
identity={'binary_sha256':hashlib.sha256(Path(sys.executable).read_bytes()).hexdigest(),'python':sys.version,'invocation':str(Path('.venv/bin/python').absolute()),'git_head_for_dependencies':head,'source':sources,'scope':'CPU-only Python converter, not a native model binary; direct exporter and driver digests were frozen before execution, dependency files match the unchanged committed tree'}
(f/'build-identity.json').write_text(json.dumps(identity,indent=2)+'\n')
files=['capture-vq-contiguous-export-v1.py','run-vq-contiguous-export-v1.py','vq-contiguous-record-hypothesis-v1.json','vq-contiguous-record-resource-estimate-v1.json',a+'.log',a+'/run.json',b+'/build.json',b+'/manifest.json']
for name in ('vq_record_repack.py','vq_record_repack_test.py'):
 shutil.copy2(Path('Tools')/name,r/name);files.append(name)
helper=runpy.run_path(str(r/'capture-vq-kernel-cache-v1.py'));files+=helper['supervision'](a+'/supervision')
helper['capture']('vq-contiguous-record-lossless-export','Lossless aligned VQ expert export with full tensor reconstruction', '''A single bounded CPU-only transformation exports the unchanged VQ 3.2 expert codes and scales into 48 aligned files. All 288 reconstructed contiguous source-tensor hashes match, and every per-record padding region is zero. Codebooks, dense tensors, PLE and draft bytes are untouched. Source payloads are verified first; source and output stamps are rechecked; a complete manifest becomes visible atomically only after verification and synced writes. The exact export manifest SHA-256 is 230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834.

Output occupies 47866183680 bytes, inside the declared 48-GB output cap and 350-GB research-staging cap. Staging before export was 254809699818 bytes. Final process observations are 246923960 current, 258998968 lifetime physical peak and 272646144 lifetime RSS peak bytes, below the one-GB conversion bound. The converter enforces bounded reads and a time limit; it holds the shared verification lock and runs with no model process.

Synthetic reconstruction, corruption, zero-padding, truncation, invalid-extent and partial-write checks pass. This source proves the bounded storage transformation, not a native packed reader, speed gain, candidate admission or product distribution. The final manifest binds original tensor identities and all derived file hashes; derived payloads remain only in the declared research directory.''',files,'frozen-contiguous-export-producer-v1')
````

### run-vq-contiguous-export-v1.py

Original bytes: 1606. SHA-256: `61083c43855f32fb2c660167c90884ea4b83a5f2e91cd3552954b80e1806e184`.

Normalized bytes: 1606. SHA-256: `61083c43855f32fb2c660167c90884ea4b83a5f2e91cd3552954b80e1806e184`.

````text
from pathlib import Path
from datetime import datetime,timezone
import json,sys
sys.path.insert(0,'Tools')
from quantization_logit_run import supervise,digest
r=Path('.build/quantization-research').resolve()
inputs=[Path('Tools/vq_record_repack.py'),Path('Tools/vq_record_repack_test.py'),r/'vq-contiguous-record-hypothesis-v1.json',Path(__file__)]
record={'schema':1,'scope':'bounded research lossless expert-record export and full reconstruction verification','started_at':datetime.now(timezone.utc).isoformat(),'bound_files':{str(p.resolve()):digest(p) for p in inputs},'complete':False}
out=r/'vq-contiguous-export-v1';out.mkdir()
def save():(out/'run.json').write_text(json.dumps(record,indent=2)+'\n')
save()
try:
 command=[str(Path('.venv/bin/python').absolute()),'Tools/vq_record_repack.py','--model',str(r/'candidate-3.2'),'--inventory',str(r/'inventory-3.2/inventory.json'),'--research-root',str(r),'--out',str(r/'vq-contiguous-records-v1')]
 record['command']=command;save()
 record['supervision']=supervise(command,out/'supervision',7200)
 assert all(digest(Path(p))==sha for p,sha in record['bound_files'].items())
 build=json.loads((r/'vq-contiguous-records-v1/build.json').read_text());assert build['complete'] and len(build['layers'])==48
 record['build_sha256']=digest(r/'vq-contiguous-records-v1/build.json');record['manifest_sha256']=digest(r/'vq-contiguous-records-v1/manifest.json');record['complete']=True;record['finished_at']=datetime.now(timezone.utc).isoformat();save();print(json.dumps(record),flush=True)
except BaseException as error:record['failure']=repr(error);save();raise
````

### vq-contiguous-record-hypothesis-v1.json

Original bytes: 1948. SHA-256: `81d00ecd963243984496c675cad9ef571f0dd1e746d179d06327fd9c538f257f`.

Normalized bytes: 1948. SHA-256: `81d00ecd963243984496c675cad9ef571f0dd1e746d179d06327fd9c538f257f`.

````text
{
  "schema": 1,
  "status": "prospective storage-only experiment, no payload generated",
  "parent_inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "hypothesis": "Store each complete expert record contiguously with 16 KiB record and file-payload alignment. Preserve all six codes/scales pieces exactly; retain original codebooks, dense tensors and PLE. This may reduce positional-read overhead without a numerical or quality change.",
  "output_file_bytes": 47866183680,
  "maximum_additional_payload_bytes": 48000000000,
  "maximum_total_staging_bytes": 350000000000,
  "minimum_disk_headroom_after_export_bytes": 10000000000,
  "conversion_maximum_process_bytes": 1000000000,
  "conversion_maximum_seconds": 7200,
  "conversion_minimum_reclaimable_bytes": 13000000000,
  "additional_raw_logit_bytes": 0,
  "paid_compute": false,
  "maximum_conversion_attempts": 1,
  "publication": "Create a new research directory only. Publish the complete manifest atomically after reconstructing and matching all 288 original tensor hashes and verifying zero padding. No product installation, deletion, migration or default change.",
  "follow_on_admission": "Native integration must pin the derived manifest and payload hashes and retain owned descriptors, exact ranges, cancellation, joins and bank publication fences. Same composite and 1536/288 cache geometry, with buffered policy held constant, require greedy and sparse exact parity before any timing campaign.",
  "maximum_follow_on_model_runs": 12,
  "follow_on_maximum_process_bytes": 10000000000,
  "follow_on_minimum_reclaimable_bytes": 13000000000,
  "timing": "Freeze the profile and parser after export identity is known; require separate full-logit validation and three alternating pairs with exact generated sequences. Use the bounded stable idle-admission protocol, retain every failure, and do not retry failed or ineligible cells automatically."
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

### vq-contiguous-export-v1.log

Original bytes: 3623. SHA-256: `6da6b51bb22433bb3de7472860f6567dc4205ca1e9fe16e26b1ef3cb4ca85807`.

Normalized bytes: 3560. SHA-256: `542d727f4c3ab5e4452c5dd997a8a934759f80ff44c442cccd5f8ab50e6dcbeb`.

````text
{"schema": 1, "scope": "bounded research lossless expert-record export and full reconstruction verification", "started_at": "2026-10-03T14:15:33.411188+00:00", "bound_files": {"<HOME>/Projects/slotstream/Tools/vq_record_repack.py": "ec0d9e61445b7cc1ae387730ece8a323d641a31fec61e2a570e5e091f04df4de", "<HOME>/Projects/slotstream/Tools/vq_record_repack_test.py": "81650b37dd53476588b091b08e23c33dcfd977651d18196c9f0139628dd291cb", "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-record-hypothesis-v1.json": "81d00ecd963243984496c675cad9ef571f0dd1e746d179d06327fd9c538f257f", "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-contiguous-export-v1.py": "61083c43855f32fb2c660167c90884ea4b83a5f2e91cd3552954b80e1806e184"}, "complete": true, "command": ["<HOME>/Projects/slotstream/.venv/bin/python", "Tools/vq_record_repack.py", "--model", "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2", "--inventory", "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json", "--research-root", "<HOME>/Projects/slotstream/.build/quantization-research", "--out", "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-records-v1"], "supervision": {"exit_code": 0, "failure": null, "sampled_peak_bytes": 258998968, "samples": 2838, "after": {"page_bytes": 16384, "reclaimable_bytes": 22049062912, "swapins": 36, "swapouts": 2908, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    22590.\nPages active:                                 993532.\nPages inactive:                              1202618.\nPages speculative:                              5917.\nPages throttled:                                   0.\nPages wired down:                             220129.\nPages purgeable:                                 187.\n\"Translation faults\":                     1937301047.\nPages copy-on-write:                        96800905.\nPages zero filled:                        3166363186.\nPages reactivated:                         173242164.\nPages purged:                               12642623.\nFile-backed pages:                           1322991.\nAnonymous pages:                              879076.\nPages stored in compressor:                  1142463.\nPages occupied by compressor:                 640626.\nDecompressions:                             99166756.\nCompressions:                              112525191.\nPageins:                                  2223840132.\nPageouts:                                     481287.\nSwapins:                                          36.\nSwapouts:                                       2908.\nPages tagged:                                 136571.\nPages tagged resident:                         97618.\nPages tagged compressed:                       38953.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5917.\nPages tag-storage free:                          195.\nPages tag-storage non-tag pageable:            92184.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5776128.\nTagged compressions:                          724541.\nTagged decompressions:                        600161.\n"}, "seconds": 154.79395612500957}, "build_sha256": "56883a24e6419b4a5d399cf1e8fc882bc0653737df1ae83c89ce2a50d4e2eb46", "manifest_sha256": "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834", "finished_at": "2026-10-03T14:18:08.239501+00:00"}
````

### vq-contiguous-export-v1/run.json

Original bytes: 3773. SHA-256: `a4c572f4bb5fe6fa2ee71b9b698cf14ebeb70228fcc30009bf7e3e17debdcb73`.

Normalized bytes: 3710. SHA-256: `9f913702133025bb79f75207e1cb01a48715bd8d25d0c07a465b8989b7c303f3`.

````text
{
  "schema": 1,
  "scope": "bounded research lossless expert-record export and full reconstruction verification",
  "started_at": "2026-10-03T14:15:33.411188+00:00",
  "bound_files": {
    "<HOME>/Projects/slotstream/Tools/vq_record_repack.py": "ec0d9e61445b7cc1ae387730ece8a323d641a31fec61e2a570e5e091f04df4de",
    "<HOME>/Projects/slotstream/Tools/vq_record_repack_test.py": "81650b37dd53476588b091b08e23c33dcfd977651d18196c9f0139628dd291cb",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-record-hypothesis-v1.json": "81d00ecd963243984496c675cad9ef571f0dd1e746d179d06327fd9c538f257f",
    "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-contiguous-export-v1.py": "61083c43855f32fb2c660167c90884ea4b83a5f2e91cd3552954b80e1806e184"
  },
  "complete": true,
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "Tools/vq_record_repack.py",
    "--model",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--research-root",
    "<HOME>/Projects/slotstream/.build/quantization-research",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-records-v1"
  ],
  "supervision": {
    "exit_code": 0,
    "failure": null,
    "sampled_peak_bytes": 258998968,
    "samples": 2838,
    "after": {
      "page_bytes": 16384,
      "reclaimable_bytes": 22049062912,
      "swapins": 36,
      "swapouts": 2908,
      "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    22590.\nPages active:                                 993532.\nPages inactive:                              1202618.\nPages speculative:                              5917.\nPages throttled:                                   0.\nPages wired down:                             220129.\nPages purgeable:                                 187.\n\"Translation faults\":                     1937301047.\nPages copy-on-write:                        96800905.\nPages zero filled:                        3166363186.\nPages reactivated:                         173242164.\nPages purged:                               12642623.\nFile-backed pages:                           1322991.\nAnonymous pages:                              879076.\nPages stored in compressor:                  1142463.\nPages occupied by compressor:                 640626.\nDecompressions:                             99166756.\nCompressions:                              112525191.\nPageins:                                  2223840132.\nPageouts:                                     481287.\nSwapins:                                          36.\nSwapouts:                                       2908.\nPages tagged:                                 136571.\nPages tagged resident:                         97618.\nPages tagged compressed:                       38953.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5917.\nPages tag-storage free:                          195.\nPages tag-storage non-tag pageable:            92184.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5776128.\nTagged compressions:                          724541.\nTagged decompressions:                        600161.\n"
    },
    "seconds": 154.79395612500957
  },
  "build_sha256": "56883a24e6419b4a5d399cf1e8fc882bc0653737df1ae83c89ce2a50d4e2eb46",
  "manifest_sha256": "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834",
  "finished_at": "2026-10-03T14:18:08.239501+00:00"
}
````

### vq-contiguous-records-v1/build.json

Original bytes: 204730. SHA-256: `56883a24e6419b4a5d399cf1e8fc882bc0653737df1ae83c89ce2a50d4e2eb46`.

Normalized bytes: 204730. SHA-256: `56883a24e6419b4a5d399cf1e8fc882bc0653737df1ae83c89ce2a50d4e2eb46`.

````zlib-base64
eNrsvVuvHEeS5/m+n0Kop12gVHBzu7hbv+0F8zbAAjO7LzuLgl+rtKOS1CKre3oG/d33b0lJZCqD
eTJbFPswz6FE8jA9I8LCPdzNfmHmZv/jf/rqqz+8GX9df2t/+Iev6I/xz/H93374dr1d+ODtj39f
p8/+8e/t22/2N6O9/eb779Dwh79/98OP3//T+u4Pp+Zv2798//e38fmbb79/++btj6v97et/+sev
8fn68ev1335YP779+s03/+3rH75ZY31N9l+//id6d+gP7cf13ds/f/MdTvb2+x//5c9v/tqyWpwr
eR3F92pJvVKvRqKUvBUbe/SmLeehNKVwHZOX75RG5rZsVmXa690F+trf/xg38z/wr9MF/7L+3P/l
7XoTd2xc5Y/vGn5c49v2zd9a//Z9e86qqapaTT99680/tx+++S7a2D74CLd/+r6n+vPp2j/HTfzH
Nv761f/9zY9v0YNf/cf1N9ziV//pLfrxzdtvxpt/+Op/Dnm+evPNf19ffb/fyfPV6er/y3/57v9E
05uv9o9r/cNXT//KRir0p58Pa+PtN/90w4HoWi/6y2HffHfbgU5Mnn857M0Pa/z92/b0kVZrkl8O
e/vXH79/+/bbNW+5wfTLYf/8zY9rfjW//+fvrh+XUyG1Xw774e8//mXF+D51NarFKw77L3/4zz+2
7958e3rsv9rt79++ffNf/nB8NDmbMLOXX643vv/hX77+/ruv//nHb95+/JpuJRej93f339eP33+1
v/n2WrcwWWbTD4cAky5Grr291ptUYthE/bxTnux/ypazazwn/+Gbb9fXvY3/iiGIh/fNtWMxXy2d
huB//e777/7lb9///c3TB+FXteL0/ql8g6UBl/vmu69idfpxvXnz/Y8HZyAy8fq+S74f4+9YciZm
1NUDTXPSGLf/Y/38NQz4EzK6kxDXGLf//eaDIGLGxSr/PNzfPHnE6UHOVDQ52c8PV6w3t8yZr76S
mrLFw/yf3q1ctx317iGznw67/WpfnZbA9/O7/eUvt0xu4pTIfnUYnug330yohX+4sgphzfv1YT8P
4ccvzLVa/vCwr+MBwz+eGHEMmxwd9tVfv/92fvPdX+Kzg45Sp3p42BNLe03p8DDMpK/x79NEuljO
MG1KvXrYafU8umwc9r+F7glV9L4XP3JXcWPFsHLFuP3n865/YiKUzIX1/WHztmmn7lJj5foDVOy/
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
jbj/+sN//eG/AZItauA=
````

### vq-contiguous-records-v1/manifest.json

Original bytes: 180021. SHA-256: `230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834`.

Normalized bytes: 180021. SHA-256: `230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834`.

````zlib-base64
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
/R+QUv38
````

### vq_record_repack.py

Original bytes: 12224. SHA-256: `ec0d9e61445b7cc1ae387730ece8a323d641a31fec61e2a570e5e091f04df4de`.

Normalized bytes: 12224. SHA-256: `ec0d9e61445b7cc1ae387730ece8a323d641a31fec61e2a570e5e091f04df4de`.

````text
#!/usr/bin/env python3
"""Build and independently verify a bounded, derived VQ expert read layout.

Research only. Values, codebooks and bank geometry never change. The final
manifest appears only after full reconstruction hashes match source tensors.
The output directory must be new; incomplete output has no completion manifest.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import struct
import time

from context_qualification import quiet_preflight, verification_lock
from quantization_inventory import unique_json
from vq_dense_overlay import VQ_INVENTORY, read_json
from vq_model_reference import verify_files, physical
from vq_ple_stream import TensorFile, stamp

ALIGNMENT = 16_384
EXPERTS = 512
MAXIMUM_STAGING_BYTES = 350_000_000_000
MAXIMUM_OUTPUT_BYTES = 48_000_000_000
MAXIMUM_SECONDS = 7_200
MAXIMUM_PROCESS_BYTES = 1_000_000_000
SCHEMA = 'slotstream-vq-layer-expert-six-piece-16k-v1'


def align(value, alignment=ALIGNMENT):
    if type(value) is not int or value <= 0 or type(alignment) is not int or alignment <= 0:
        raise ValueError('positive integer extent and alignment required')
    return ((value + alignment - 1) // alignment) * alignment


def header(rows, stride):
    if type(rows) is not int or not 1 <= rows <= EXPERTS or type(stride) is not int or not 0 < stride <= 3_000_000:
        raise ValueError('record extent exceeds the admitted bound')
    value = {'records': {'dtype': 'U8', 'shape': [rows, stride], 'data_offsets': [0, rows * stride]}}
    raw = json.dumps(value, sort_keys=True, separators=(',', ':')).encode()
    if len(raw) > ALIGNMENT - 8: raise ValueError('packed header exceeds alignment')
    return struct.pack('<Q', ALIGNMENT - 8) + raw + b' ' * (ALIGNMENT - 8 - len(raw))


def exact(fd, offset, count):
    if type(offset) is not int or type(count) is not int or offset < 0 or not 0 < count <= 3_000_000:
        raise ValueError('bounded read extent required')
    chunks = []; done = 0
    while done < count:
        part = os.pread(fd, count - done, offset + done)
        if not part: raise ValueError('short derived layout read')
        chunks.append(part); done += len(part)
    return b''.join(chunks)


def sha_file(path, check, expected_stamp):
    digest = hashlib.sha256()
    fd = os.open(path, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK)
    with os.fdopen(fd, 'rb') as f:
        if stamp(os.fstat(f.fileno())) != expected_stamp: raise ValueError('derived hash input changed')
        for value in iter(lambda: f.read(1_000_000), b''):
            check(); digest.update(value)
        if stamp(os.fstat(f.fileno())) != expected_stamp: raise ValueError('derived input changed during hashing')
    return digest.hexdigest()


def plan(inventory):
    projections = {p['name']: p for p in inventory['vq_projections']}
    if len(projections) != 144: raise ValueError('incomplete expert projection inventory')
    layers = []
    for layer in range(48):
        pieces = []; offset = 0
        for family in ('gate_proj', 'up_proj', 'down_proj'):
            name = f'model.layers.{layer}.mlp.switch_mlp.{family}'
            projection = projections[name]
            for suffix in ('codes', 'vq_scales'):
                value = projection['tensors'][suffix]
                lo, hi = value['data_offsets']
                if (value['shape'][0] != EXPERTS or hi <= lo or (hi - lo) % EXPERTS):
                    raise ValueError('source tensor does not contain complete expert pieces')
                count = (hi - lo) // EXPERTS
                if not 0 < count <= 1_500_000: raise ValueError('expert piece exceeds its bound')
                pieces.append({'name': name + '.' + suffix, 'shard': value['shard'],
                               'bytes': count, 'offset': offset, 'source_tensor': value})
                offset += count
        if offset != inventory['expert_record_bytes_by_layer'][str(layer)]:
            raise ValueError('record reconstruction disagrees with source geometry')
        stride = align(offset)
        layers.append({'layer': layer, 'filename': f'experts-{layer:02d}.safetensors',
                       'record_bytes': offset, 'stride_bytes': stride, 'pieces': pieces,
                       'file_bytes': ALIGNMENT + EXPERTS * stride})
    total = sum(v['file_bytes'] for v in layers)
    if total != 47_866_183_680 or total > MAXIMUM_OUTPUT_BYTES:
        raise ValueError('derived output exceeds its frozen byte plan')
    return layers


def write_layer(path, *, rows, pieces, stride, read_piece, check=lambda: None):
    if sum(pieces) > stride or not pieces or any(type(n) is not int or not 0 < n <= 1_500_000 for n in pieces):
        raise ValueError('record pieces exceed their stride')
    padding = b'\0' * (stride - sum(pieces))
    with path.open('xb') as out:
        out.write(header(rows, stride))
        for row in range(rows):
            check()
            for piece, count in enumerate(pieces):
                raw = read_piece(piece, row)
                if len(raw) != count: raise ValueError('source piece was short')
                out.write(raw)
            out.write(padding)
        out.flush(); os.fsync(out.fileno())


def verify_layer(path, *, rows, pieces, stride, source_hashes, check=lambda: None, expected_stamp=None):
    fd = os.open(path, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK)
    try:
        before = os.fstat(fd)
        if expected_stamp is not None and stamp(before) != expected_stamp: raise ValueError('derived verification input changed')
        import stat
        if not stat.S_ISREG(before.st_mode) or before.st_size != ALIGNMENT + rows * stride:
            raise ValueError('derived layout length or file type changed')
        if exact(fd, 0, ALIGNMENT) != header(rows, stride):
            raise ValueError('derived layout header changed')
        digests = [hashlib.sha256() for _ in pieces]
        for row in range(rows):
            check(); record = exact(fd, ALIGNMENT + row * stride, stride)
            offset = 0
            for h, count in zip(digests, pieces): h.update(record[offset:offset+count]); offset += count
            if any(record[offset:]): raise ValueError('record alignment padding is not zero')
        hashes = [h.hexdigest() for h in digests]
        if hashes != source_hashes: raise ValueError('derived layout changes reconstructed source tensor bytes')
        if stamp(os.fstat(fd)) != stamp(before): raise ValueError('derived layout changed during verification')
        return hashes
    finally: os.close(fd)


def run(options):
    root = options.research_root.resolve(); out = options.out.absolute()
    if out.is_symlink() or out.exists() or not out.parent.resolve().is_relative_to(root):
        raise ValueError('new derived layout must be contained by the research directory')
    inventory = read_json(options.inventory, VQ_INVENTORY)
    layers = plan(inventory); total = sum(v['file_bytes'] for v in layers)
    # Conservatively count every path, including hard-link duplicates. Never
    # follow a link out of the bounded research area or credit reclaimable files.
    used = sum(p.stat().st_size for p in root.rglob('*') if p.is_file() and not p.is_symlink())
    fs = os.statvfs(root)
    if used + total > MAXIMUM_STAGING_BYTES or fs.f_bavail * fs.f_frsize < total + 10_000_000_000:
        raise ValueError('derived layout exceeds staging cap or disk headroom')
    start = time.monotonic()
    def check():
        if time.monotonic() - start > MAXIMUM_SECONDS: raise TimeoutError('derived layout time bound exceeded')
        if max(physical().values()) > MAXIMUM_PROCESS_BYTES: raise RuntimeError('derived layout process bound exceeded')
    before = quiet_preflight(13)
    with verification_lock():
        provenance = verify_files(options.model, options.inventory)
        out.mkdir(mode=0o700)
        receipt = {'schema': 1, 'complete': False, 'qualification': 'unproven', 'layout': SCHEMA,
                   'parent_inventory_sha256': VQ_INVENTORY, 'before': before,
                   'source_provenance': provenance, 'maximum_seconds': MAXIMUM_SECONDS,
                   'output_file_bytes': total, 'staging_bytes_before': used, 'maximum_process_bytes': MAXIMUM_PROCESS_BYTES, 'layers': []}
        def save(): (out / 'build.json').write_text(json.dumps(receipt, indent=2) + '\n')
        save(); owners = {}; output_stamps = {}
        try:
            for layer in layers:
                check(); pieces = layer['pieces']; counts = [p['bytes'] for p in pieces]
                for piece in pieces:
                    shard = piece['shard']
                    if shard not in owners:
                        identity = inventory['files'][shard]
                        owner = TensorFile(options.model / shard, **identity)
                        if owner.identity != tuple(provenance['stamps'][shard]):
                            owner.close(); raise ValueError('source changed after full verification')
                        owners[shard] = owner
                    expected = {k:v for k,v in piece['source_tensor'].items() if k != 'shard'}
                    if owners[shard].header[piece['name']] != expected:
                        raise ValueError('source tensor header differs from pinned record map')
                def read_piece(index, row):
                    p = pieces[index]; owner = owners[p['shard']]; count = p['bytes']
                    return b''.join(owner.read(p['name'], row*count+pos, min(1_000_000,count-pos)) for pos in range(0,count,1_000_000))
                path = out / layer['filename']
                write_layer(path, rows=EXPERTS, pieces=counts, stride=layer['stride_bytes'], read_piece=read_piece, check=check)
                output_stamp = stamp(os.stat(path, follow_symlinks=False)); output_stamps[path] = output_stamp
                # Independently hash original contiguous tensors, then
                # reconstruct their order from the derived record layout.
                expected_hashes = []
                for p in pieces:
                    h = hashlib.sha256(); owner = owners[p['shard']]; length = p['bytes'] * EXPERTS
                    for pos in range(0,length,1_000_000):
                        check(); h.update(owner.read(p['name'],pos,min(1_000_000,length-pos)))
                    expected_hashes.append(h.hexdigest())
                verify_layer(path, rows=EXPERTS, pieces=counts, stride=layer['stride_bytes'], source_hashes=expected_hashes, check=check, expected_stamp=output_stamp)
                row = {**layer, 'source_tensor_sha256': expected_hashes, 'sha256': sha_file(path,check,output_stamp)}
                receipt['layers'].append(row); save()
                print(json.dumps({'layer':layer['layer'],'file_bytes':layer['file_bytes'],'verified':True}),flush=True)
            for owner in owners.values(): owner.verify_unchanged()
            if any(stamp(os.stat(p, follow_symlinks=False)) != value for p,value in output_stamps.items()):
                raise ValueError('derived layout changed before manifest publication')
            receipt['data_verified'] = True; receipt['seconds'] = time.monotonic()-start; save()
            final = {'schema':1,'layout':SCHEMA,'parent_inventory_sha256':VQ_INVENTORY,'layers':receipt['layers']}
            temporary = out / '.manifest.tmp'
            with temporary.open('x') as f:
                f.write(json.dumps(final,sort_keys=True,indent=2)+'\n');f.flush();os.fsync(f.fileno())
            os.link(temporary, out / 'manifest.json')  # Atomic visibility, existing paths refused.
            temporary.unlink()
            directory = os.open(out,os.O_RDONLY)
            try: os.fsync(directory)
            finally: os.close(directory)
            check(); receipt['complete'] = True; receipt['memory'] = physical(); save()
        except BaseException as error:
            receipt['failure']=repr(error);save();raise
        finally:
            for owner in owners.values():owner.close()


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    for name in ('model','inventory','research-root','out'):p.add_argument('--'+name,type=Path,required=True)
    run(p.parse_args())
````

### vq_record_repack_test.py

Original bytes: 2642. SHA-256: `81650b37dd53476588b091b08e23c33dcfd977651d18196c9f0139628dd291cb`.

Normalized bytes: 2642. SHA-256: `81650b37dd53476588b091b08e23c33dcfd977651d18196c9f0139628dd291cb`.

````text
import hashlib
from pathlib import Path
import tempfile
import unittest
from vq_record_repack import ALIGNMENT, align, exact, header, write_layer, verify_layer

class RepackChecks(unittest.TestCase):
    def test_transposition_preserves_source_piece_order_and_zero_padding(self):
        rows=3;pieces=[5,2,7,3,4,6]
        tensors=[bytes((p*31+i)%256 for i in range(rows*n)) for p,n in enumerate(pieces)]
        hashes=[hashlib.sha256(x).hexdigest() for x in tensors]
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)/'records.safetensors'
            write_layer(path,rows=rows,pieces=pieces,stride=64,
                        read_piece=lambda p,r:tensors[p][r*pieces[p]:(r+1)*pieces[p]])
            self.assertEqual(verify_layer(path,rows=rows,pieces=pieces,stride=64,source_hashes=hashes),hashes)
            data=path.read_bytes();self.assertEqual(len(data),ALIGNMENT+rows*64)
            for r in range(rows):
                expected=b''.join(t[r*n:(r+1)*n] for t,n in zip(tensors,pieces))
                self.assertEqual(data[ALIGNMENT+r*64:ALIGNMENT+(r+1)*64],expected+b'\0'*(64-sum(pieces)))
            for position in (ALIGNMENT,ALIGNMENT+sum(pieces),10):
                altered=bytearray(data);altered[position]^=1;path.write_bytes(altered)
                with self.assertRaises(ValueError):verify_layer(path,rows=rows,pieces=pieces,stride=64,source_hashes=hashes)
            path.write_bytes(data[:-1])
            with self.assertRaises(ValueError):verify_layer(path,rows=rows,pieces=pieces,stride=64,source_hashes=hashes)

    def test_failed_build_never_creates_a_completion_manifest(self):
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)/'records.safetensors'
            with self.assertRaises(ValueError):write_layer(path,rows=3,pieces=[4]*6,stride=64,read_piece=lambda p,r:b'bad')
            self.assertFalse((Path(tmp)/'manifest.json').exists())
            with self.assertRaises(FileExistsError):write_layer(path,rows=3,pieces=[4]*6,stride=64,read_piece=lambda p,r:b'good')

    def test_invalid_extents_are_refused(self):
        for value in (0,-1,True,1.5):
            with self.assertRaises(ValueError):align(value)
        for rows,stride in [(0,16),(513,16),(True,16),(1,0),(1,3_000_001)]:
            with self.assertRaises(ValueError):header(rows,stride)
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)/'x'
            with self.assertRaises(ValueError):write_layer(path,rows=1,pieces=[7]*6,stride=16,read_piece=lambda p,r:b'')
            self.assertFalse(path.exists())

if __name__=='__main__':unittest.main()
````

### vq-contiguous-export-v1/supervision/identity.json

Original bytes: 2646. SHA-256: `fec8e2b65b50f916d3b8f28d2b3865ce3a2e131b6ebdcc986db7f69499f537ef`.

Normalized bytes: 2611. SHA-256: `fedb564451d23eb32edd2e63dd82c26191c7491777126a5e7f00b44fddfce4a3`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "Tools/vq_record_repack.py",
    "--model",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--research-root",
    "<HOME>/Projects/slotstream/.build/quantization-research",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-records-v1"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22503915520,
    "swapins": 36,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   256481.\nPages active:                                 982700.\nPages inactive:                               913194.\nPages speculative:                             68951.\nPages throttled:                                   0.\nPages wired down:                             211246.\nPages purgeable:                               20846.\n\"Translation faults\":                     1936426304.\nPages copy-on-write:                        96726695.\nPages zero filled:                        3162362679.\nPages reactivated:                         173192459.\nPages purged:                               12622955.\nFile-backed pages:                           1096203.\nAnonymous pages:                              868642.\nPages stored in compressor:                  1164990.\nPages occupied by compressor:                 652060.\nDecompressions:                             99141372.\nCompressions:                              112520830.\nPageins:                                  2217509159.\nPageouts:                                     480268.\nSwapins:                                          36.\nSwapouts:                                       2908.\nPages tagged:                                 129824.\nPages tagged resident:                         90962.\nPages tagged compressed:                       38862.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5918.\nPages tag-storage free:                          802.\nPages tag-storage non-tag pageable:            91576.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5767616.\nTagged compressions:                          723735.\nTagged decompressions:                        599489.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-contiguous-export-v1/supervision/receipt.json

Original bytes: 2140. SHA-256: `9081cb6f214034d5239d82c8318cd366727af0a6eaa05fc1f4e591fcebc5c317`.

Normalized bytes: 2140. SHA-256: `9081cb6f214034d5239d82c8318cd366727af0a6eaa05fc1f4e591fcebc5c317`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 258998968,
  "samples": 2838,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22049062912,
    "swapins": 36,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    22590.\nPages active:                                 993532.\nPages inactive:                              1202618.\nPages speculative:                              5917.\nPages throttled:                                   0.\nPages wired down:                             220129.\nPages purgeable:                                 187.\n\"Translation faults\":                     1937301047.\nPages copy-on-write:                        96800905.\nPages zero filled:                        3166363186.\nPages reactivated:                         173242164.\nPages purged:                               12642623.\nFile-backed pages:                           1322991.\nAnonymous pages:                              879076.\nPages stored in compressor:                  1142463.\nPages occupied by compressor:                 640626.\nDecompressions:                             99166756.\nCompressions:                              112525191.\nPageins:                                  2223840132.\nPageouts:                                     481287.\nSwapins:                                          36.\nSwapouts:                                       2908.\nPages tagged:                                 136571.\nPages tagged resident:                         97618.\nPages tagged compressed:                       38953.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5917.\nPages tag-storage free:                          195.\nPages tag-storage non-tag pageable:            92184.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5776128.\nTagged compressions:                          724541.\nTagged decompressions:                        600161.\n"
  },
  "seconds": 154.79395612500957
}
````

### vq-contiguous-export-v1/supervision/stdout.txt

Original bytes: 8683. SHA-256: `d2e786f3fdd606613f806ddfbb6cff23919d2f64d637d7f8fa6453f040288c3a`.

Normalized bytes: 8683. SHA-256: `d2e786f3fdd606613f806ddfbb6cff23919d2f64d637d7f8fa6453f040288c3a`.

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
{"layer": 0, "file_bytes": 1342193664, "verified": true}
{"layer": 1, "file_bytes": 1342193664, "verified": true}
{"layer": 2, "file_bytes": 947929088, "verified": true}
{"layer": 3, "file_bytes": 947929088, "verified": true}
{"layer": 4, "file_bytes": 947929088, "verified": true}
{"layer": 5, "file_bytes": 1342193664, "verified": true}
{"layer": 6, "file_bytes": 947929088, "verified": true}
{"layer": 7, "file_bytes": 947929088, "verified": true}
{"layer": 8, "file_bytes": 947929088, "verified": true}
{"layer": 9, "file_bytes": 947929088, "verified": true}
{"layer": 10, "file_bytes": 947929088, "verified": true}
{"layer": 11, "file_bytes": 947929088, "verified": true}
{"layer": 12, "file_bytes": 947929088, "verified": true}
{"layer": 13, "file_bytes": 947929088, "verified": true}
{"layer": 14, "file_bytes": 947929088, "verified": true}
{"layer": 15, "file_bytes": 947929088, "verified": true}
{"layer": 16, "file_bytes": 947929088, "verified": true}
{"layer": 17, "file_bytes": 947929088, "verified": true}
{"layer": 18, "file_bytes": 947929088, "verified": true}
{"layer": 19, "file_bytes": 947929088, "verified": true}
{"layer": 20, "file_bytes": 947929088, "verified": true}
{"layer": 21, "file_bytes": 947929088, "verified": true}
{"layer": 22, "file_bytes": 947929088, "verified": true}
{"layer": 23, "file_bytes": 947929088, "verified": true}
{"layer": 24, "file_bytes": 947929088, "verified": true}
{"layer": 25, "file_bytes": 947929088, "verified": true}
{"layer": 26, "file_bytes": 947929088, "verified": true}
{"layer": 27, "file_bytes": 947929088, "verified": true}
{"layer": 28, "file_bytes": 947929088, "verified": true}
{"layer": 29, "file_bytes": 947929088, "verified": true}
{"layer": 30, "file_bytes": 947929088, "verified": true}
{"layer": 31, "file_bytes": 1342193664, "verified": true}
{"layer": 32, "file_bytes": 947929088, "verified": true}
{"layer": 33, "file_bytes": 947929088, "verified": true}
{"layer": 34, "file_bytes": 947929088, "verified": true}
{"layer": 35, "file_bytes": 947929088, "verified": true}
{"layer": 36, "file_bytes": 947929088, "verified": true}
{"layer": 37, "file_bytes": 947929088, "verified": true}
{"layer": 38, "file_bytes": 947929088, "verified": true}
{"layer": 39, "file_bytes": 1342193664, "verified": true}
{"layer": 40, "file_bytes": 947929088, "verified": true}
{"layer": 41, "file_bytes": 947929088, "verified": true}
{"layer": 42, "file_bytes": 947929088, "verified": true}
{"layer": 43, "file_bytes": 947929088, "verified": true}
{"layer": 44, "file_bytes": 947929088, "verified": true}
{"layer": 45, "file_bytes": 947929088, "verified": true}
{"layer": 46, "file_bytes": 947929088, "verified": true}
{"layer": 47, "file_bytes": 1342193664, "verified": true}
````

### vq-contiguous-export-v1/supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### frozen-contiguous-export-producer-v1/build-identity.json

Original bytes: 1829. SHA-256: `339a5970d0facd49a7cd3eca6aa30bcea77982841723c90924fa506969530bf4`.

Normalized bytes: 1822. SHA-256: `5d79b77c3fdf7b05541a5fd60fa4262e69966180f8ebc977aba765c2d25a6281`.

````text
{
  "binary_sha256": "e878533ce71a6e91b0fae5e8bbe8baebbb6194dad84fead52e9b42f0620ad011",
  "python": "3.12.9 (main, Feb 12 2025, 15:09:19) [Clang 19.1.6 ]",
  "invocation": "<HOME>/Projects/slotstream/.venv/bin/python",
  "git_head_for_dependencies": "86a703b88cb9d92bea929ac55fd311a1609ea99a",
  "source": {
    "Tools/prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472",
    "Tools/memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc",
    "Tools/context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34",
    "Tools/quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb",
    "Tools/vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e",
    "Tools/vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
    "Tools/vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
    "Tools/slotpack/pack.py": "1bdaef49bb324f37bb64c7c453f9ec724c9f96c3d1f579ff6f3e9417e1d510cd",
    "Tools/vq_dense_overlay.py": "34d3ed2bf55371cbc3472c48e54cd3c5b0006ba9dbfe6289b6506511b5477684",
    "Tools/quantization_quality.py": "99c99d16ee7bbb8576156fe5e8971a74ce243642bff240f855613c3ec0d135f8",
    "Tools/vq_execution_profile.py": "0e298b9a73df41d55e1191ffdcbf5cc778112e7dae309e6a3b647080c1f4ce91",
    "Tools/vq_model_reference.py": "315dfb1b2ae098f35b68b074a29c1dc0e0e7986c806012cdc16cea00794ac506",
    "Tools/vq_record_repack.py": "ec0d9e61445b7cc1ae387730ece8a323d641a31fec61e2a570e5e091f04df4de"
  },
  "scope": "CPU-only Python converter, not a native model binary; direct exporter and driver digests were frozen before execution, dependency files match the unchanged committed tree"
}
````
