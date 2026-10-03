---
type: run
created: 2026-10-03T08:47:48.999507+00:00
updated: 2026-10-03T08:47:48.999507+00:00
summary: Parallel VQ CPU sample exposes repeated projection construction
binary: 7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f
captured_at: 2026-10-03
command: Exact sequential producer and diagnostic commands are preserved in the driver and supervision identity transcripts below.
discarded: true
discard_reason: CPU sampling perturbs execution; every timing value from this run is excluded
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Parallel VQ CPU sample exposes repeated projection construction
tool: bounded VQ research diagnostics
---

One separately bounded run samples only its owned child process for five seconds. All timing from that run is discarded, regardless of its native eligibility field. The observer joins and the process completes inside the same 10 GB envelope. The main-thread tree has 2,088 samples. It attributes 471 to the demanded-read join/work subtree and 453 to the bank's output evaluation subtree. Three VQExpert constructors together occupy another 240 samples (99 + 91 + 50). PLE row work appears in a much smaller 28-sample block. These are sample-tree counts, not exact wall-time percentages or a breakdown computed from process-wide leaves.

The next falsifiable hypothesis is reusing identical kernel closures rather than reconstructing their source/header objects for every projection on every layer. Any cache must contain code only, preserve fresh private array contexts and banks, bound keys to the admitted layouts, and retain destructive-reuse and exact-output gates. Adoption requires a fresh matched comparison; this attribution alone establishes no speed gain. Read waiting and GPU work remain substantial. No numerical or memory check is waived.

The captured remote results separately show all four workflows, including complete main CI and the Mac app workflow, succeeding for the preceding 9d5639a serial-pilot commit. They do not claim remote success for the parallel-read sources.

Local home prefixes are replaced with <HOME>. Original byte counts and SHA-256 values identify unmodified local transcripts. Tensor fixture payloads, frozen executables and source archives remain in the bounded research directory; manifests bind their hashes. These functional runs do not qualify timing, task quality or an alternative production pack. No model is installed or activated.

### vq-parallel-cpu-sample-v1.py

Original bytes: 2499. SHA-256: `62aa6d8530af0ad2907e561c76ea0df955c7fe047f2e4a377748a0dde390f742`.

````text
from pathlib import Path
import sys,json,threading,subprocess,time,os
sys.path.insert(0,'Tools')
from quantization_logit_run import supervise,digest
r=Path('.build/quantization-research').resolve();f=r/'frozen-parallel-read-v2';out=r/'vq-parallel-cpu-sample-v1';out.mkdir()
profile=Path('bench/quantization/performance-pilot-v2.json').resolve();validation=r/'vq-read-pair-v1/validation-parallel/receipt.json'
cmd=[str(f/'slotstream'),'quantization-performance-pilot','--source-directory',str(r/'candidate-3.2'),'--source-inventory',str(r/'inventory-3.2/inventory.json'),'--profile',str(profile),'--output',str(out/'native'),'--measure','--validation-receipt',str(validation)]
protocol={'scope':'CPU stack diagnosis only; all timing discarded because sampling perturbs execution','extra_model_runs':1,'pack':'3.2','maximum_process_bytes':10000000000,'minimum_reclaimable_bytes':13000000000,'run_seconds':1800,'sampling_seconds':5,'sample_interval_ms':1,'sampling_delay_seconds':45,'binary_sha256':digest(f/'slotstream'),'metallib_sha256':digest(f/'mlx.metallib'),'profile_sha256':digest(profile),'command':cmd}
(out/'protocol.json').write_text(json.dumps(protocol,indent=2)+'\n')
stop=threading.Event(); observations=[]
def observe():
 started=time.monotonic(); found=None
 while not stop.wait(.1):
  if time.monotonic()-started>65: observations.append({'failure':'no owned child found within deadline'});return
  ps=subprocess.check_output(['ps','-axo','pid=,ppid=,comm='],text=True)
  for line in ps.splitlines():
   fields=line.strip().split(None,2)
   if len(fields)==3 and int(fields[1])==os.getpid() and fields[2]==str(f/'slotstream'):
    if found is None: found=(int(fields[0]),time.monotonic())
  if found and time.monotonic()-found[1]>=45:
   command=['/usr/bin/sample',str(found[0]),'5','1','-file',str(out/'sample.txt')]
   result=subprocess.run(command,capture_output=True,text=True,timeout=20)
   observations.append({'command':command,'code':result.returncode,'stdout':result.stdout,'stderr':result.stderr,'elapsed_since_child_observed':time.monotonic()-found[1]});return
thread=threading.Thread(target=observe);thread.start()
try: receipt=supervise(cmd,out/'supervision',1800)
finally:
 stop.set();thread.join(timeout=25)
 assert not thread.is_alive()
 (out/'observer.json').write_text(json.dumps(observations,indent=2)+'\n')
print(json.dumps({'complete':True,'discarded_timing':True,'reason':'CPU sample observer','sample_exists':(out/'sample.txt').exists(),'supervision':receipt}))
````

### vq-parallel-cpu-sample-v1.log

Original bytes: 2219. SHA-256: `5acdeef5f726d9cfd9b2f4a1bcd8bfc2c4be52d2748ad068b3219294022ca004`.

````text
{"complete": true, "discarded_timing": true, "reason": "CPU sample observer", "sample_exists": true, "supervision": {"exit_code": 0, "failure": null, "sampled_peak_bytes": 8017795240, "samples": 1116, "after": {"page_bytes": 16384, "reclaimable_bytes": 24818122752, "swapins": 16, "swapouts": 2904, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   483562.\nPages active:                                 850235.\nPages inactive:                               837013.\nPages speculative:                             63802.\nPages throttled:                                   0.\nPages wired down:                             170843.\nPages purgeable:                                6906.\n\"Translation faults\":                     1511165427.\nPages copy-on-write:                        78514435.\nPages zero filled:                        2405442384.\nPages reactivated:                          97269458.\nPages purged:                               11320974.\nFile-backed pages:                           1024310.\nAnonymous pages:                              726740.\nPages stored in compressor:                  1256244.\nPages occupied by compressor:                 677818.\nDecompressions:                             48222794.\nCompressions:                               58969005.\nPageins:                                  1162446613.\nPageouts:                                     375188.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 130927.\nPages tagged resident:                         85692.\nPages tagged compressed:                       45235.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5253.\nPages tag-storage free:                         2270.\nPages tag-storage non-tag pageable:            90773.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6954688.\nTagged compressions:                          508167.\nTagged decompressions:                        411742.\n"}, "seconds": 65.25069854201865}}
````

### vq-parallel-cpu-sample-v1/protocol.json

Original bytes: 1380. SHA-256: `cd348cdb95f94dedb0198b21d01e135e697277851845a8b88031e59c8f6e8b60`.

````text
{
  "scope": "CPU stack diagnosis only; all timing discarded because sampling perturbs execution",
  "extra_model_runs": 1,
  "pack": "3.2",
  "maximum_process_bytes": 10000000000,
  "minimum_reclaimable_bytes": 13000000000,
  "run_seconds": 1800,
  "sampling_seconds": 5,
  "sample_interval_ms": 1,
  "sampling_delay_seconds": 45,
  "binary_sha256": "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed",
  "profile_sha256": "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-parallel-read-v2/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/bench/quantization/performance-pilot-v2.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-parallel-cpu-sample-v1/native",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-parallel/receipt.json"
  ]
}
````

### vq-parallel-cpu-sample-v1/observer.json

Original bytes: 602. SHA-256: `d9c23d8aa265b05298f1d83e0bf1dbdc967ea12001138acfd516043404c5d249`.

````text
[
  {
    "command": [
      "/usr/bin/sample",
      "3263",
      "5",
      "1",
      "-file",
      "<HOME>/Projects/slotstream/.build/quantization-research/vq-parallel-cpu-sample-v1/sample.txt"
    ],
    "code": 0,
    "stdout": "",
    "stderr": "Sampling process 3263 for 5 seconds with 1 millisecond of run time between samples\nSampling completed, processing symbols...\nSample analysis of process 3263 written to file <HOME>/Projects/slotstream/.build/quantization-research/vq-parallel-cpu-sample-v1/sample.txt\n",
    "elapsed_since_child_observed": 50.615181834000396
  }
]
````

### vq-parallel-cpu-sample-v1/sample.txt

Original bytes: 660699. SHA-256: `44223fbd4f63e4ad5c26f26b2d2b7f516bd2ae3244ba4391302bc4bf0ccbb886`.

````text
Analysis of sampling slotstream (pid 3263) every 1 millisecond
Process:         slotstream [3263]
Path:            /Users/USER/*/slotstream
Load Address:    0x102cbc000
Identifier:      slotstream
Version:         0
Code Type:       ARM64
Platform:        macOS
Parent Process:  python3.12 [3190]
Target Type:     live task

Date/Time:       2026-10-03 03:46:21.144 -0500
Launch Time:     2026-10-03 03:45:35.976 -0500
OS Version:      macOS 26.6.2 (25G83)
Report Version:  7
Analysis Tool:   /usr/bin/sample

Physical footprint:         7.3G
Physical footprint (peak):  7.5G
Idle exit:                  untracked
----

Call graph:
    2088 Thread_4837863: Main Thread   DispatchQueue_<multiple>
    + 2088 start  (in dyld) + 6992  [0x18ce044e4]
    +   2088 main  (in slotstream) + 96  [0x103faa8bc]  main.swift:2004
    +     2088 protocol witness for ParsableCommand.run() in conformance QuantizationPerformancePilot  (in slotstream) + 64  [0x10407cf30]  /<compiler-generated>:0
    +       2088 QuantizationPerformancePilot.run()  (in slotstream) + 732  [0x10407ca14]  QuantizationCommands.swift:125
    +         2088 static Diagnostics.quantizationPerformancePilot(source:inventory:profileURL:output:validationURL:)  (in slotstream) + 5800  [0x103f3dfc8]  Diagnostics+VQPerformance.swift:127
    +           2088 withError<A>(_:)  (in slotstream) + 72  [0x1039d8960]  ErrorHandler.swift:150
    +             2088 ErrorHandler.withError<A>(_:)  (in slotstream) + 140  [0x1039d88ec]  ErrorHandler.swift:375
    +               2088 ErrorHandler.withErrorHandler<A>(_:_:)  (in slotstream) + 272  [0x1039d846c]  ErrorHandler.swift:354
    +                 2088 TaskLocal.withValue<A>(_:operation:file:line:)  (in libswift_Concurrency.dylib) + 232  [0x29293e380]
    +                   2088 partial apply for closure #1 in ErrorHandler.withErrorHandler<A>(_:_:)  (in slotstream) + 20  [0x1039d9a2c]  /<compiler-generated>:0
    +                     2088 partial apply for closure #1 in ErrorHandler.withError<A>(_:)  (in slotstream) + 20  [0x1039d9978]  /<compiler-generated>:0
    +                       2088 closure #1 in ErrorHandler.withError<A>(_:)  (in slotstream) + 44  [0x1039d9684]  ErrorHandler.swift:376
    +                         2088 partial apply for closure #1 in withError<A>(_:)  (in slotstream) + 20  [0x1039d9114]  /<compiler-generated>:0
    +                           2088 partial apply for closure #2 in static Diagnostics.quantizationPerformancePilot(source:inventory:profileURL:output:validationURL:)  (in slotstream) + 80  [0x103f437e4]  /<compiler-generated>:0
    +                             2088 closure #2 in static Diagnostics.quantizationPerformancePilot(source:inventory:profileURL:output:validationURL:)  (in slotstream) + 932  [0x103f42434]  Diagnostics+VQPerformance.swift:140
    +                               1950 VQModelProbe.forward(_:observe:trace:inspectState:)  (in slotstream) + 1124  [0x103d26c0c]  VQModelProbe.swift:67
    +                               ! 1322 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 5792  [0x103d29158]  VQModelProbe.swift:159
    +                               ! : 1322 VQRecordCache.call(_:layer:routes:)  (in slotstream) + 1252  [0x103d38f38]  VQRecordCache.swift:91
    +                               ! :   1276 specialized static VQRouteStream.partition(_:routes:batchExperts:apply:)  (in slotstream) + 1972  [0x103d41514]  VQRouteStream.swift:37
    +                               ! :   | 471 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 6440  [0x103d35e00]  VQRecordBank.swift:145
    +                               ! :   | + 471 partial apply for closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 20  [0x103d39e48]  /<compiler-generated>:0
    +                               ! :   | +   471 closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 564  [0x103d39d1c]  VQRecordCache.swift:86
    +                               ! :   | +     471 specialized static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 464  [0x103d3acf0]  VQRecordReadBatch.swift:59
    +                               ! :   | +       471 static OS_dispatch_queue.concurrentPerform(iterations:execute:)  (in libswiftDispatch.dylib) + 196  [0x1a7529e18]
    +                               ! :   | +         470 _swift_dispatch_apply_current  (in libswiftDispatch.dylib) + 128  [0x1a7529f3c]
    +                               ! :   | +         ! 470 dispatch_apply  (in libdispatch.dylib) + 96  [0x18d027ac8]
    +                               ! :   | +         !   468 _dispatch_apply_with_attr_f  (in libdispatch.dylib) + 1312  [0x18d027944]
    +                               ! :   | +         !   : 256 _dispatch_apply_invoke_and_wait  (in libdispatch.dylib) + 364  [0x18d028844]
    +                               ! :   | +         !   : | 256 _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
    +                               ! :   | +         !   : |   256 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +                               ! :   | +         !   : |     256 _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
    +                               ! :   | +         !   : |       256 _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
    +                               ! :   | +         !   : |         256 thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
    +                               ! :   | +         !   : |           256 partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
    +                               ! :   | +         !   : |             256 closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
    +                               ! :   | +         !   : |               256 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    +                               ! :   | +         !   : |                 235 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
    +                               ! :   | +         !   : |                 + 203 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +                               ! :   | +         !   : |                 + ! 202 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +                               ! :   | +         !   : |                 + ! : 202 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +                               ! :   | +         !   : |                 + ! 1 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1312  [0x103d47964]  /<compiler-generated>:0
    +                               ! :   | +         !   : |                 + !   1 __DataStorage._bytes.getter  (in Foundation) + 0  [0x18ee31d78]
    +                               ! :   | +         !   : |                 + 27 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
    +                               ! :   | +         !   : |                 + ! 27 specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
    +                               ! :   | +         !   : |                 + !   25 __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
    +                               ! :   | +         !   : |                 + !   : 25 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                               ! :   | +         !   : |                 + !   :   25 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +                               ! :   | +         !   : |                 + !   :     25 _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
    +                               ! :   | +         !   : |                 + !   :       25 madvise  (in libsystem_kernel.dylib) + 8  [0x18d18e9b0]
    +                               ! :   | +         !   : |                 + !   2 __DataStorage.init(length:)  (in Foundation) + 224  [0x18ee32fc8]
    +                               ! :   | +         !   : |                 + !     2 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                               ! :   | +         !   : |                 + !       2 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
    +                               ! :   | +         !   : |                 + !         2 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 528  [0x18cfd4c30]
    +                               ! :   | +         !   : |                 + !           1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 240  [0x18cfd6148]
    +                               ! :   | +         !   : |                 + !           | 1 _xzm_reclaim_mark_used_locked  (in libsystem_malloc.dylib) + 60  [0x18cfd6a9c]
    +                               ! :   | +         !   : |                 + !           |   1 mach_vm_reclaim_try_cancel  (in libsystem_kernel.dylib) + 260  [0x18d19f2f8]
    +                               ! :   | +         !   : |                 + !           |     1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +                               ! :   | +         !   : |                 + !           1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 364  [0x18cfd61c4]
    +                               ! :   | +         !   : |                 + !             1 xzm_reclaim_mark_free_locked  (in libsystem_malloc.dylib) + 116  [0x18cfd3968]
    +                               ! :   | +         !   : |                 + !               1 mach_vm_reclaim_try_enter  (in libsystem_kernel.dylib) + 296  [0x18d19f17c]
    +                               ! :   | +         !   : |                 + !                 1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +                               ! :   | +         !   : |                 + 4 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 536  [0x103d44300]  VQTensorFile.swift:143
    +                               ! :   | +         !   : |                 + ! 4 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +                               ! :   | +         !   : |                 + !   4 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +                               ! :   | +         !   : |                 + 1 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 704  [0x103d443a8]  VQTensorFile.swift:146
    +                               ! :   | +         !   : |                 +   1 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +                               ! :   | +         !   : |                 +     1 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +                               ! :   | +         !   : |                 16 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
    +                               ! :   | +         !   : |                 + 16 Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
    +                               ! :   | +         !   : |                 +   15 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
    +                               ! :   | +         !   : |                 +   ! 15 __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
    +                               ! :   | +         !   : |                 +   !   15 _platform_memmove  (in libsystem_platform.dylib) + 88,100  [0x18d1d93b8,0x18d1d93c4]
    +                               ! :   | +         !   : |                 +   1 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 220  [0x18ee35080]
    +                               ! :   | +         !   : |                 +     1 swift_release  (in libswiftCore.dylib) + 56  [0x1a0927128]
    +                               ! :   | +         !   : |                 3 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 192  [0x103d3afac]  VQRecordReadPlan.swift:35
    +                               ! :   | +         !   : |                 + 3 Data._Representation.reserveCapacity(_:)  (in Foundation) + 644  [0x18ee367cc]
    +                               ! :   | +         !   : |                 +   3 __DataStorage.init(capacity:)  (in Foundation) + 164  [0x18ee3313c]
    +                               ! :   | +         !   : |                 +     3 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                               ! :   | +         !   : |                 +       2 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
    +                               ! :   | +         !   : |                 +       ! 1 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 528  [0x18cfd4c30]
    +                               ! :   | +         !   : |                 +       ! : 1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 364  [0x18cfd61c4]
    +                               ! :   | +         !   : |                 +       ! :   1 xzm_reclaim_mark_free_locked  (in libsystem_malloc.dylib) + 116  [0x18cfd3968]
    +                               ! :   | +         !   : |                 +       ! :     1 mach_vm_reclaim_try_enter  (in libsystem_kernel.dylib) + 296  [0x18d19f17c]
    +                               ! :   | +         !   : |                 +       ! :       1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +                               ! :   | +         !   : |                 +       ! 1 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 316  [0x18cfd4b5c]
    +                               ! :   | +         !   : |                 +       1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 52  [0x18cfd4430]
    +                               ! :   | +         !   : |                 2 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 324  [0x103d3b030]  /<compiler-generated>:0
    +                               ! :   | +         !   : |                   2 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               ! :   | +         !   : |                     2 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               ! :   | +         !   : |                       2 __DataStorage.__deallocating_deinit  (in Foundation) + 104  [0x18ee33850]
    +                               ! :   | +         !   : |                         1 xzm_segment_group_free_chunk  (in libsystem_malloc.dylib) + 636  [0x18cfd53bc]
    +                               ! :   | +         !   : |                         ! 1 _xzm_segment_group_segment_span_free_coalesce  (in libsystem_malloc.dylib) + 244  [0x18cfd59c0]
    +                               ! :   | +         !   : |                         1 xzm_segment_group_free_chunk  (in libsystem_malloc.dylib) + 860  [0x18cfd549c]
    +                               ! :   | +         !   : |                           1 _xzm_segment_group_span_mark_free  (in libsystem_malloc.dylib) + 136  [0x18cfd5bfc]
    +                               ! :   | +         !   : |                             1 _xzm_reclaim_mark_free  (in libsystem_malloc.dylib) + 112  [0x18cfd3df0]
    +                               ! :   | +         !   : |                               1 xzm_reclaim_mark_free_locked  (in libsystem_malloc.dylib) + 116  [0x18cfd3968]
    +                               ! :   | +         !   : |                                 1 mach_vm_reclaim_try_enter  (in libsystem_kernel.dylib) + 296  [0x18d19f17c]
    +                               ! :   | +         !   : |                                   1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +                               ! :   | +         !   : 212 _dispatch_apply_invoke_and_wait  (in libdispatch.dylib) + 196  [0x18d02879c]
    +                               ! :   | +         !   :   212 _dispatch_once_wait  (in libdispatch.dylib) + 60  [0x18d015824]
    +                               ! :   | +         !   :     212 _dispatch_once_wait.cold.1  (in libdispatch.dylib) + 148  [0x18d04907c]
    +                               ! :   | +         !   :       212 _dlock_wait  (in libdispatch.dylib) + 56  [0x18d0158cc]
    +                               ! :   | +         !   :         212 __ulock_wait  (in libsystem_kernel.dylib) + 8  [0x18d18daf8]
    +                               ! :   | +         !   2 _dispatch_apply_with_attr_f  (in libdispatch.dylib) + 1472  [0x18d0279e4]
    +                               ! :   | +         !     2 _dispatch_root_queue_poke_slow  (in libdispatch.dylib) + 312  [0x18d0215ec]
    +                               ! :   | +         !       2 _pthread_workqueue_addthreads  (in libsystem_pthread.dylib) + 44  [0x18d1cbd74]
    +                               ! :   | +         !         2 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    +                               ! :   | +         1 _swift_dispatch_apply_current  (in libswiftDispatch.dylib) + 148  [0x1a7529f50]
    +                               ! :   | +           1 _Block_release  (in libsystem_blocks.dylib) + 120  [0x18ce9914c]
    +                               ! :   | 453 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 8324  [0x103d3655c]  VQRecordBank.swift:186
    +                               ! :   | + 453 eval(_:)  (in slotstream) + 72  [0x103a3587c]  Transforms+Eval.swift:124
    +                               ! :   | +   453 mlx_eval  (in slotstream) + 140  [0x102d9bf24]  transforms.cpp:71
    +                               ! :   | +     413 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 128  [0x103794dcc]  transforms.cpp:378
    +                               ! :   | +     ! 413 mlx::core::array::wait()  (in slotstream) + 48  [0x102da7c24]  array.cpp:148
    +                               ! :   | +     !   413 mlx::core::Event::wait()  (in slotstream) + 68  [0x1035b4a2c]  event.cpp:48
    +                               ! :   | +     !     413 -[IOSurfaceSharedEvent waitUntilSignaledValue:timeoutMS:]  (in IOSurface) + 72  [0x199826184]
    +                               ! :   | +     !       413 iokit_user_client_trap  (in IOKit) + 8  [0x19154cae0]
    +                               ! :   | +     40 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 120  [0x103794dc4]  transforms.cpp:378
    +                               ! :   | +       35 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 4404  [0x103793f94]  transforms.cpp:266
    +                               ! :   | +       : 32 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 200  [0x1035b31f8]  eval.cpp:45
    +                               ! :   | +       : | 9 mlx::core::copy_gpu(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, mlx::core::Stream const&)  (in slotstream) + 196  [0x10359c8e4]  copy.cpp:23
    +                               ! :   | +       : | + 9 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, mlx::core::Stream const&)  (in slotstream) + 148  [0x10358341c]  copy.cpp:21
    +                               ! :   | +       : | +   6 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 1744  [0x10359d030]  copy.cpp:111
    +                               ! :   | +       : | +   ! 3 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 56  [0x1035a06d0]  device.cpp:580
    +                               ! :   | +       : | +   ! : 3 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithDispatchType:]  (in AGXMetalG17X) + 276  [0x117ded754]
    +                               ! :   | +       : | +   ! :   3 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithConfig:]  (in AGXMetalG17X) + 164  [0x117ded950]
    +                               ! :   | +       : | +   ! :     2 -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 176  [0x117e4b6e0]
    +                               ! :   | +       : | +   ! :     | 2 __bzero  (in libsystem_platform.dylib) + 68  [0x18d1d9074]
    +                               ! :   | +       : | +   ! :     1 -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 72  [0x117e4b678]
    +                               ! :   | +       : | +   ! :       1 -[IOGPUMetalCommandEncoder initWithCommandBuffer:]  (in IOGPU) + 48  [0x1b2872d38]
    +                               ! :   | +       : | +   ! :         1 IOGPUDeviceGetNextGlobalTraceID  (in IOGPU) + 0  [0x1b2889b78]
    +                               ! :   | +       : | +   ! 3 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 144  [0x1035a0728]  device.cpp:581
    +                               ! :   | +       : | +   !   3 -[IOGPUMetalFence initWithDevice:]  (in IOGPU) + 120  [0x1b287cfd8]
    +                               ! :   | +       : | +   !     3 -[IOGPUMTLFence initWithDevice:]  (in IOGPU) + 136  [0x1b288c9a8]
    +                               ! :   | +       : | +   !       3 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! :   | +       : | +   !         2 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :   | +       : | +   !         | 2 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :   | +       : | +   !         |   2 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :   | +       : | +   !         1 io_connect_method  (in IOKit) + 480  [0x191530fcc]
    +                               ! :   | +       : | +   1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 1720  [0x10359d018]  copy.cpp:108
    +                               ! :   | +       : | +   ! 1 mlx::core::get_copy_kernel(mlx::core::metal::Device&, std::basic_string<char> const&, mlx::core::array const&, mlx::core::array const&)  (in slotstream) + 456  [0x1035d1898]  jit_kernels.cpp:289
    +                               ! :   | +       : | +   !   1 mlx::core::metal::Device::get_kernel(std::basic_string<char> const&, MTL::Library*, std::basic_string<char> const&, std::vector<std::tuple<void const*, MTL::DataType, unsigned long>> const&, std::vector<MTL::Function*> const&)  (in slotstream) + 96  [0x1035a3e94]  device.cpp:883
    +                               ! :   | +       : | +   !     1 std::__shared_mutex_base::lock_shared()  (in libc++.1.dylib) + 40  [0x18d0e6088]
    +                               ! :   | +       : | +   !       1 std::mutex::lock()  (in libc++.1.dylib) + 16  [0x18d0e2010]
    +                               ! :   | +       : | +   !         1 DYLD-STUB$$pthread_mutex_lock  (in libc++.1.dylib) + 12  [0x18d144904]
    +                               ! :   | +       : | +   1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 1804  [0x10359d06c]  copy.cpp:116
    +                               ! :   | +       : | +   ! 1 mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 124  [0x1035a0844]  device.cpp:353
    +                               ! :   | +       : | +   !   1 std::__hash_table<MTL::Resource*>::__emplace_unique_key_args<MTL::Resource*, MTL::Resource* const&>(MTL::Resource* const&, MTL::Resource* const&)  (in slotstream) + 168  [0x1035a5508]  __hash_table:1586
    +                               ! :   | +       : | +   !     1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! :   | +       : | +   !       1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 252  [0x18cff1038]
    +                               ! :   | +       : | +   1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 1832  [0x10359d088]  copy.cpp:117
    +                               ! :   | +       : | +     1 mlx::core::metal::CommandEncoder::set_output_array(mlx::core::array&, int, long long)  (in slotstream) + 24  [0x1035a0994]  device.cpp:365
    +                               ! :   | +       : | +       1 mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 144  [0x1035a0858]  device.cpp:355
    +                               ! :   | +       : | 7 mlx::core::copy_gpu(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, mlx::core::Stream const&)  (in slotstream) + 96  [0x10359c880]  copy.cpp:14
    +                               ! :   | +       : | + 7 mlx::core::set_copy_output_data(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, std::function<mlx::core::allocator::Buffer (unsigned long)>)  (in slotstream) + 124  [0x1030e1f34]  copy.h:38
    +                               ! :   | +       : | +   6 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! :   | +       : | +   ! 5 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! :   | +       : | +   ! : 5 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! :   | +       : | +   ! :   5 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
    +                               ! :   | +       : | +   ! :     5 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
    +                               ! :   | +       : | +   ! :       5 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
    +                               ! :   | +       : | +   ! :         5 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! :   | +       : | +   ! :           5 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! :   | +       : | +   ! :             5 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! :   | +       : | +   ! :               5 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :   | +       : | +   ! :                 5 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :   | +       : | +   ! :                   5 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :   | +       : | +   ! 1 objc_msgSend$initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:  (in AGXMetalG17X) + 0  [0x1184c2160]
    +                               ! :   | +       : | +   1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 120  [0x103585578]  allocator.cpp:130
    +                               ! :   | +       : | +     1 mlx::core::BufferCache<MTL::Buffer>::reuse_from_cache(unsigned long)  (in slotstream) + 36  [0x10358594c]  buffer_cache.h:32
    +                               ! :   | +       : | 7 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 276  [0x10359eb4c]  custom_kernel.cpp:29
    +                               ! :   | +       : | + 7 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! :   | +       : | +   6 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! :   | +       : | +   ! 6 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! :   | +       : | +   !   2 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 388  [0x117d65e60]
    +                               ! :   | +       : | +   !   : 2 -[IOGPUMetalBuffer initWithPrimaryBuffer:heapIndex:bufferIndex:bufferOffset:length:args:argsSize:gpuTag:]  (in IOGPU) + 276  [0x1b28701cc]
    +                               ! :   | +       : | +   !   :   1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! :   | +       : | +   !   :   | 1 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! :   | +       : | +   !   :   |   1 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! :   | +       : | +   !   :   |     1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :   | +       : | +   !   :   |       1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :   | +       : | +   !   :   |         1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :   | +       : | +   !   :   1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 700  [0x1b28849e4]
    +                               ! :   | +       : | +   !   :     1 objc_storeWeak  (in libobjc.A.dylib) + 544  [0x18cd6ab2c]
    +                               ! :   | +       : | +   !   :       1 locker_mixin<lockdebug::lock_mixin<objc_lock_base_t>>::unlockWith(lockdebug::lock_mixin<objc_lock_base_t>&)  (in libobjc.A.dylib) + 44  [0x18cd98dc8]
    +                               ! :   | +       : | +   !   2 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
    +                               ! :   | +       : | +   !   : 2 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
    +                               ! :   | +       : | +   !   :   2 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
    +                               ! :   | +       : | +   !   :     2 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! :   | +       : | +   !   :       2 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! :   | +       : | +   !   :         2 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! :   | +       : | +   !   :           2 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :   | +       : | +   !   :             2 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :   | +       : | +   !   :               2 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :   | +       : | +   !   1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 336  [0x117d65e2c]
    +                               ! :   | +       : | +   !   : 1 -[IOGPUMetalDevice allocBufferSubDataWithLength:options:alignment:heapIndex:bufferIndex:bufferOffset:parentAddress:parentLength:]  (in IOGPU) + 112  [0x1b28784c4]
    +                               ! :   | +       : | +   !   :   1 IOGPUMetalSuballocatorAllocate  (in IOGPU) + 468  [0x1b288e508]
    +                               ! :   | +       : | +   !   1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 240  [0x117d65dcc]
    +                               ! :   | +       : | +   1 -[AGXG17XFamilyDevice newBufferWithLength:options:]  (in AGXMetalG17X) + 120  [0x118419444]
    +                               ! :   | +       : | +     1 _objc_rootAllocWithZone  (in libobjc.A.dylib) + 52  [0x18cd69f64]
    +                               ! :   | +       : | +       1 _xzm_malloc_zone_malloc_type_calloc_entry  (in libsystem_malloc.dylib) + 100  [0x18cffa100]
    +                               ! :   | +       : | 3 mlx::core::Gather::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 2616  [0x1035c5014]  indexing.cpp:116
    +                               ! :   | +       : | + 2 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 56  [0x1035a06d0]  device.cpp:580
    +                               ! :   | +       : | + ! 2 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithDispatchType:]  (in AGXMetalG17X) + 276  [0x117ded754]
    +                               ! :   | +       : | + !   2 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithConfig:]  (in AGXMetalG17X) + 164  [0x117ded950]
    +                               ! :   | +       : | + !     1 -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 72  [0x117e4b678]
    +                               ! :   | +       : | + !     : 1 -[IOGPUMetalCommandEncoder initWithCommandBuffer:]  (in IOGPU) + 0  [0x1b2872d08]
    +                               ! :   | +       : | + !     1 -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 176  [0x117e4b6e0]
    +                               ! :   | +       : | + !       1 __bzero  (in libsystem_platform.dylib) + 68  [0x18d1d9074]
    +                               ! :   | +       : | + 1 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 144  [0x1035a0728]  device.cpp:581
    +                               ! :   | +       : | +   1 -[IOGPUMetalFence initWithDevice:]  (in IOGPU) + 120  [0x1b287cfd8]
    +                               ! :   | +       : | +     1 -[IOGPUMTLFence initWithDevice:]  (in IOGPU) + 136  [0x1b288c9a8]
    +                               ! :   | +       : | +       1 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! :   | +       : | +         1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :   | +       : | +           1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :   | +       : | +             1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :   | +       : | 2 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 1672  [0x10359f0c0]  custom_kernel.cpp:56
    +                               ! :   | +       : | + 1 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 56  [0x1035a06d0]  device.cpp:580
    +                               ! :   | +       : | + ! 1 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithDispatchType:]  (in AGXMetalG17X) + 276  [0x117ded754]
    +                               ! :   | +       : | + !   1 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithConfig:]  (in AGXMetalG17X) + 164  [0x117ded950]
    +                               ! :   | +       : | + !     1 -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 536  [0x117e4b848]
    +                               ! :   | +       : | + !       1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::beginComputePass(bool, eAGXDataBufferPools)  (in AGXMetalG17X) + 2644  [0x117e3fd38]
    +                               ! :   | +       : | + !         1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::insertIndirectTGOptKernel(eAGXDataBufferPools, indirectTGOptParams*&, unsigned short*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::InstanceTokenImproved*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::FenceToken*&)  (in AGXMetalG17X) + 456  [0x117e40568]
    +                               ! :   | +       : | + !           1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 480  [0x117e40f98]
    +                               ! :   | +       : | + 1 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 144  [0x1035a0728]  device.cpp:581
    +                               ! :   | +       : | +   1 -[IOGPUMetalFence initWithDevice:]  (in IOGPU) + 120  [0x1b287cfd8]
    +                               ! :   | +       : | +     1 -[IOGPUMTLFence initWithDevice:]  (in IOGPU) + 136  [0x1b288c9a8]
    +                               ! :   | +       : | +       1 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! :   | +       : | +         1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :   | +       : | +           1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :   | +       : | +             1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :   | +       : | 1 mlx::core::Gather::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 124  [0x1035c4658]  indexing.cpp:68
    +                               ! :   | +       : | + 1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! :   | +       : | +   1 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! :   | +       : | +     1 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! :   | +       : | +       1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
    +                               ! :   | +       : | +         1 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
    +                               ! :   | +       : | +           1 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
    +                               ! :   | +       : | +             1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! :   | +       : | +               1 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! :   | +       : | +                 1 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! :   | +       : | +                   1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :   | +       : | +                     1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :   | +       : | +                       1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :   | +       : | 1 mlx::core::Squeeze::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 0  [0x10358432c]  primitives.cpp:222
    +                               ! :   | +       : | 1 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 1456  [0x10359efe8]  custom_kernel.cpp:50
    +                               ! :   | +       : | + 1 fmt::v12::vformat(fmt::v12::basic_string_view<char>, fmt::v12::basic_format_args<fmt::v12::context>)  (in slotstream) + 128  [0x102d3c6ac]  format-inl.h:1445
    +                               ! :   | +       : | +   1 fmt::v12::detail::parse_format_string<char, fmt::v12::detail::format_handler<char>>(fmt::v12::basic_string_view<char>, fmt::v12::detail::format_handler<char>&&)  (in slotstream) + 100  [0x102d3cbb0]  base.h:1664
    +                               ! :   | +       : | +     1 fmt::v12::detail::write<char, fmt::v12::basic_appender<char>, int, 0>(fmt::v12::basic_appender<char>, int)  (in slotstream) + 380  [0x102d3dea0]  format.h:2309
    +                               ! :   | +       : | 1 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 1600  [0x10359f078]  custom_kernel.cpp:54
    +                               ! :   | +       : |   1 mlx::core::metal::Device::get_kernel(std::basic_string<char> const&, MTL::Library*, std::basic_string<char> const&, std::vector<std::tuple<void const*, MTL::DataType, unsigned long>> const&, std::vector<MTL::Function*> const&)  (in slotstream) + 264  [0x1035a3f3c]  device.cpp:886
    +                               ! :   | +       : 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 308  [0x1035b3264]  eval.cpp:49
    +                               ! :   | +       : | 1 std::__hash_table<std::shared_ptr<mlx::core::array::Data>>::__emplace_unique_key_args<std::shared_ptr<mlx::core::array::Data>, std::shared_ptr<mlx::core::array::Data> const&>(std::shared_ptr<mlx::core::array::Data> const&, std::shared_ptr<mlx::core::array::Data> const&)  (in slotstream) + 456  [0x10319d6d8]  __hash_table:1588
    +                               ! :   | +       : |   1 std::__hash_table<std::shared_ptr<mlx::core::array::Data>>::__do_rehash<true>(unsigned long)  (in slotstream) + 48  [0x10319d8d0]  __hash_table:1769
    +                               ! :   | +       : |     1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! :   | +       : |       1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 88  [0x18cff0f94]
    +                               ! :   | +       : 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 680  [0x1035b33d8]  eval.cpp:59
    +                               ! :   | +       : 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 1540  [0x1035b3734]  eval.cpp:69
    +                               ! :   | +       :   1 -[NSAutoreleasePool release]  (in Foundation) + 44  [0x18ea9b35c]
    +                               ! :   | +       2 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 4884  [0x103794174]  transforms.cpp:307
    +                               ! :   | +       : 1 mlx::core::array::detach()  (in slotstream) + 72  [0x102da79c0]  array.cpp:118
    +                               ! :   | +       : | 1 mlx::core::fast::CustomKernel::~CustomKernel()  (in slotstream) + 100  [0x10359f73c]  fast_primitives.h:436
    +                               ! :   | +       : |   1 _xzm_free_outlined  (in libsystem_malloc.dylib) + 0  [0x18cff447c]
    +                               ! :   | +       : 1 mlx::core::array::detach()  (in slotstream) + 324  [0x102da7abc]  array.cpp:127
    +                               ! :   | +       :   1 mlx::core::array::~array()  (in slotstream) + 156  [0x102da80f4]  array.cpp:245
    +                               ! :   | +       :     1 _free  (in libsystem_malloc.dylib) + 44  [0x18cffbcfc]
    +                               ! :   | +       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 524  [0x10379306c]  transforms.cpp:104
    +                               ! :   | +       : 1 mlx::core::Event::Event(mlx::core::Stream)  (in slotstream) + 104  [0x1035b496c]  event.cpp:43
    +                               ! :   | +       :   1 mlx::core::metal::EventImpl::EventImpl(mlx::core::metal::Device&)  (in slotstream) + 60  [0x1035b47d4]  event.cpp:16
    +                               ! :   | +       :     1 -[_MTLSharedEvent initWithOptions:]  (in Metal) + 44  [0x199a03134]
    +                               ! :   | +       :       1 -[IOSurfaceSharedEvent initWithOptions:]  (in IOSurface) + 128  [0x199825e14]
    +                               ! :   | +       :         1 IOConnectCallMethod  (in IOKit) + 176  [0x191530d84]
    +                               ! :   | +       :           1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :   | +       :             1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :   | +       :               1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :   | +       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 1556  [0x103793474]  transforms.cpp:160
    +                               ! :   | +       : 1 std::__hash_table<std::__hash_value_type<unsigned long, int>>::__emplace_unique_key_args<unsigned long, std::pair<unsigned long const, int>>(unsigned long const&, std::pair<unsigned long const, int>&&)  (in slotstream) + 356  [0x10379c000]  __hash_table:1588
    +                               ! :   | +       :   1 std::__hash_table<std::__hash_value_type<unsigned long, int>>::__do_rehash<true>(unsigned long)  (in slotstream) + 300  [0x10379c26c]  __hash_table:1786
    +                               ! :   | +       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 1140  [0x1037932d4]  transforms.cpp:172
    +                               ! :   | 99 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 2388  [0x103d34e2c]  VQRecordBank.swift:120
    +                               ! :   | + 54 specialized VQExpert.init(codes:codebook:scales:layout:residentBank:)  (in slotstream) + 3568  [0x103d25718]  VQExpert.swift:89
    +                               ! :   | + ! 54 static MLXFast.metalKernel<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 180  [0x103a09688]  MLXFastKernel.swift:181
    +                               ! :   | + !   52 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 924  [0x103a09b10]  MLXFastKernel.swift:69
    +                               ! :   | + !   : 52 mlx_fast_metal_kernel_new  (in slotstream) + 496  [0x102d6b780]  fast.cpp:483
    +                               ! :   | + !   :   12 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2444  [0x102db0d58]  metal_kernel.cpp:268
    +                               ! :   | + !   :   | 11 _platform_memchr  (in libsystem_platform.dylib) + 76,84,...  [0x18d1d6e4c,0x18d1d6e54,...]
    +                               ! :   | + !   :   | 1 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + !   :   8 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1116  [0x102db0828]  metal_kernel.cpp:240
    +                               ! :   | + !   :   | 8 _platform_memchr  (in libsystem_platform.dylib) + 84,76,...  [0x18d1d6e54,0x18d1d6e4c,...]
    +                               ! :   | + !   :   7 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 780  [0x102db06d8]  metal_kernel.cpp:239
    +                               ! :   | + !   :   | 6 _platform_memchr  (in libsystem_platform.dylib) + 76,104,...  [0x18d1d6e4c,0x18d1d6e68,...]
    +                               ! :   | + !   :   | 1 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + !   :   7 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2464  [0x102db0d6c]  metal_kernel.cpp:268
    +                               ! :   | + !   :   | 5 _platform_memcmp  (in libsystem_platform.dylib) + 48,128,...  [0x18d1d6f40,0x18d1d6f90,...]
    +                               ! :   | + !   :   | 2 DYLD-STUB$$memcmp  (in slotstream) + 4  [0x1040eaf08]
    +                               ! :   | + !   :   5 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2468,2464  [0x102db0d70,0x102db0d6c]  metal_kernel.cpp:268
    +                               ! :   | + !   :   4 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 436  [0x102db0580]  metal_kernel.cpp:238
    +                               ! :   | + !   :   | 3 _platform_memchr  (in libsystem_platform.dylib) + 104,120  [0x18d1d6e68,0x18d1d6e78]
    +                               ! :   | + !   :   | 1 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + !   :   3 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1136  [0x102db083c]  metal_kernel.cpp:240
    +                               ! :   | + !   :   | 3 _platform_memcmp  (in libsystem_platform.dylib) + 140,152,...  [0x18d1d6f9c,0x18d1d6fa8,...]
    +                               ! :   | + !   :   2 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 456  [0x102db0594]  metal_kernel.cpp:238
    +                               ! :   | + !   :   | 2 _platform_memcmp  (in libsystem_platform.dylib) + 236  [0x18d1d6ffc]
    +                               ! :   | + !   :   2 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1140  [0x102db0840]  metal_kernel.cpp:240
    +                               ! :   | + !   :   1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 388  [0x102db0550]  metal_kernel.cpp:238
    +                               ! :   | + !   :   1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 780  [0x102db06d8]  metal_kernel.cpp:239
    +                               ! :   | + !   1 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 516  [0x103a09978]  /<compiler-generated>:0
    +                               ! :   | + !   : 1 protocol witness for IteratorProtocol.next() in conformance IndexingIterator<A>  (in libswiftCore.dylib) + 460  [0x1a0acb278]
    +                               ! :   | + !   :   1 protocol witness for Collection.subscript.read in conformance [A]  (in libswiftCore.dylib) + 44  [0x1a0a69600]
    +                               ! :   | + !   :     1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 420  [0x18cff10e0]
    +                               ! :   | + !   1 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 772  [0x103a09a78]  MLXFastKernel.swift:72
    +                               ! :   | + !     1 StringProtocol.cString(using:)  (in Foundation) + 184  [0x18f4391fc]
    +                               ! :   | + !       1 objc_autoreleasePoolPop  (in libobjc.A.dylib) + 32  [0x18cd6805c]
    +                               ! :   | + 43 specialized VQExpert.init(codes:codebook:scales:layout:residentBank:)  (in slotstream) + 2044  [0x103d25124]  VQExpert.swift:76
    +                               ! :   | + ! 26 specialized static VQExpert.kernel(source:name:)  (in slotstream) + 128  [0x103d2475c]  VQExpert.swift:31
    +                               ! :   | + ! : 26 StringProtocol.components<A>(separatedBy:)  (in Foundation) + 572  [0x18f2a7828]
    +                               ! :   | + ! :   26 specialized _StringCompareOptionsIterable._range<A>(of:toHalfWidth:diacriticsInsensitive:caseFold:anchored:backwards:)  (in Foundation) + 136  [0x18f433580]
    +                               ! :   | + ! :     8 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 496  [0x18f152b68]
    +                               ! :   | + ! :     | 5 Substring.subscript.getter  (in libswiftCore.dylib) + 76,180,...  [0x1a0c6bf4c,0x1a0c6bfb4,...]
    +                               ! :   | + ! :     | 2 Substring.subscript.getter  (in libswiftCore.dylib) + 244  [0x1a0c6bff4]
    +                               ! :   | + ! :     | + 2 _allASCII(_:)  (in libswiftCore.dylib) + 104,132  [0x1a0c47954,0x1a0c47970]
    +                               ! :   | + ! :     | 1 DYLD-STUB$$Substring.subscript.getter  (in Foundation) + 12  [0x18f66b8a0]
    +                               ! :   | + ! :     7 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 524  [0x18f152b84]
    +                               ! :   | + ! :     | 6 Substring.subscript.getter  (in libswiftCore.dylib) + 76,144,...  [0x1a0c6bf4c,0x1a0c6bf90,...]
    +                               ! :   | + ! :     | 1 Substring.subscript.getter  (in libswiftCore.dylib) + 388  [0x1a0c6c084]
    +                               ! :   | + ! :     |   1 specialized static String._uncheckedFromUTF8(_:isASCII:)  (in libswiftCore.dylib) + 8  [0x1a0d6ffec]
    +                               ! :   | + ! :     3 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 588  [0x18f152bc4]
    +                               ! :   | + ! :     | 3 _stringCompareWithSmolCheck(_:_:expecting:)  (in libswiftCore.dylib) + 60,68,...  [0x1a092a22c,0x1a092a234,...]
    +                               ! :   | + ! :     2 Substring.index(_:offsetBy:)  (in libswiftCore.dylib) + 896  [0x1a0c6b2d0]
    +                               ! :   | + ! :     2 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 608  [0x18f152bd8]
    +                               ! :   | + ! :     | 1 DYLD-STUB$$swift_bridgeObjectRelease  (in Foundation) + 12  [0x18f672bb0]
    +                               ! :   | + ! :     | 1 swift_bridgeObjectRelease  (in libswiftCore.dylib) + 0  [0x1a0926f44]
    +                               ! :   | + ! :     2 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 776  [0x18f152c80]
    +                               ! :   | + ! :     | 2 Substring.index(_:offsetBy:)  (in libswiftCore.dylib) + 68,524  [0x1a0c6af94,0x1a0c6b15c]
    +                               ! :   | + ! :     1 Substring.subscript.getter  (in libswiftCore.dylib) + 404  [0x1a0c6c094]
    +                               ! :   | + ! :     1 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 608  [0x18f152bd8]
    +                               ! :   | + ! 12 specialized static VQExpert.kernel(source:name:)  (in slotstream) + 460  [0x103d248a8]  VQExpert.swift:36
    +                               ! :   | + ! : 12 static MLXFast.metalKernel<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 180  [0x103a09688]  MLXFastKernel.swift:181
    +                               ! :   | + ! :   10 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 924  [0x103a09b10]  MLXFastKernel.swift:69
    +                               ! :   | + ! :   | 10 mlx_fast_metal_kernel_new  (in slotstream) + 496  [0x102d6b780]  fast.cpp:483
    +                               ! :   | + ! :   |   3 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1116  [0x102db0828]  metal_kernel.cpp:240
    +                               ! :   | + ! :   |   + 2 _platform_memchr  (in libsystem_platform.dylib) + 84  [0x18d1d6e54]
    +                               ! :   | + ! :   |   + 1 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + ! :   |   2 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 780  [0x102db06d8]  metal_kernel.cpp:239
    +                               ! :   | + ! :   |   + 2 _platform_memchr  (in libsystem_platform.dylib) + 84,104  [0x18d1d6e54,0x18d1d6e68]
    +                               ! :   | + ! :   |   2 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2444  [0x102db0d58]  metal_kernel.cpp:268
    +                               ! :   | + ! :   |   + 2 _platform_memchr  (in libsystem_platform.dylib) + 0,76  [0x18d1d6e00,0x18d1d6e4c]
    +                               ! :   | + ! :   |   1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 436  [0x102db0580]  metal_kernel.cpp:238
    +                               ! :   | + ! :   |   + 1 _platform_memchr  (in libsystem_platform.dylib) + 104  [0x18d1d6e68]
    +                               ! :   | + ! :   |   1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 456  [0x102db0594]  metal_kernel.cpp:238
    +                               ! :   | + ! :   |   + 1 DYLD-STUB$$memcmp  (in slotstream) + 4  [0x1040eaf08]
    +                               ! :   | + ! :   |   1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2464  [0x102db0d6c]  metal_kernel.cpp:268
    +                               ! :   | + ! :   |     1 _platform_memcmp  (in libsystem_platform.dylib) + 48  [0x18d1d6f40]
    +                               ! :   | + ! :   1 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 592  [0x103a099c4]  /<compiler-generated>:0
    +                               ! :   | + ! :   | 1 swift_bridgeObjectRetain  (in libswiftCore.dylib) + 0  [0x1a09263c8]
    +                               ! :   | + ! :   1 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 968  [0x103a09b3c]  MLXFastKernel.swift:64
    +                               ! :   | + ! :     1 mlx_vector_string_free  (in slotstream) + 96  [0x102d9d370]  vector.cpp:425
    +                               ! :   | + ! :       1 DYLD-STUB$$operator delete(void*)  (in slotstream) + 0  [0x1040ea5ec]
    +                               ! :   | + ! 5 specialized static VQExpert.kernel(source:name:)  (in slotstream) + 228  [0x103d247c0]  VQExpert.swift:34
    +                               ! :   | + !   5 StringProtocol.replacingOccurrences<A, B>(of:with:options:range:)  (in Foundation) + 260  [0x18f434ef4]
    +                               ! :   | + !     5 -[NSString stringByReplacingOccurrencesOfString:withString:options:range:]  (in Foundation) + 100  [0x18eaa9dbc]
    +                               ! :   | + !       5 CFStringFindAndReplace  (in CoreFoundation) + 284  [0x18d27c2a8]
    +                               ! :   | + !         5 CFStringFindWithOptionsAndLocale  (in CoreFoundation) + 840,1032,...  [0x18d219bc4,0x18d219c84,...]
    +                               ! :   | + 1 specialized VQExpert.init(codes:codebook:scales:layout:residentBank:)  (in slotstream) + 3280  [0x103d255f8]  /<compiler-generated>:0
    +                               ! :   | + ! 1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               ! :   | + !   1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               ! :   | + !     1 _ContiguousArrayStorage.__deallocating_deinit  (in libswiftCore.dylib) + 96  [0x1a092af04]
    +                               ! :   | + !       1 swift_arrayDestroy  (in libswiftCore.dylib) + 192  [0x1a09292b4]
    +                               ! :   | + !         1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 148  [0x1a098de2c]
    +                               ! :   | + 1 specialized VQExpert.init(codes:codebook:scales:layout:residentBank:)  (in slotstream) + 1152  [0x103d24da8]  VQExpert.swift:60
    +                               ! :   | +   1 MLXArray.reshaped<A>(_:stream:)  (in slotstream) + 160  [0x103a03da4]
    +                               ! :   | +     1 mlx_reshape  (in slotstream) + 464  [0x102d8c93c]  ops.cpp:3073
    +                               ! :   | +       1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! :   | +         1 _xzm_xzone_malloc  (in libsystem_malloc.dylib) + 192  [0x18cfeba10]
    +                               ! :   | 91 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 1728  [0x103d34b98]  VQRecordBank.swift:120
    +                               ! :   | + 47 specialized VQExpert.init(codes:codebook:scales:layout:residentBank:)  (in slotstream) + 3568  [0x103d25718]  VQExpert.swift:89
    +                               ! :   | + ! 47 static MLXFast.metalKernel<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 180  [0x103a09688]  MLXFastKernel.swift:181
    +                               ! :   | + !   45 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 924  [0x103a09b10]  MLXFastKernel.swift:69
    +                               ! :   | + !   : 45 mlx_fast_metal_kernel_new  (in slotstream) + 496  [0x102d6b780]  fast.cpp:483
    +                               ! :   | + !   :   13 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2444  [0x102db0d58]  metal_kernel.cpp:268
    +                               ! :   | + !   :   | 13 _platform_memchr  (in libsystem_platform.dylib) + 84,120,...  [0x18d1d6e54,0x18d1d6e78,...]
    +                               ! :   | + !   :   8 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 436  [0x102db0580]  metal_kernel.cpp:238
    +                               ! :   | + !   :   | 7 _platform_memchr  (in libsystem_platform.dylib) + 76,84,...  [0x18d1d6e4c,0x18d1d6e54,...]
    +                               ! :   | + !   :   | 1 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + !   :   6 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 780  [0x102db06d8]  metal_kernel.cpp:239
    +                               ! :   | + !   :   | 4 _platform_memchr  (in libsystem_platform.dylib) + 104,76,...  [0x18d1d6e68,0x18d1d6e4c,...]
    +                               ! :   | + !   :   | 2 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + !   :   6 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2464  [0x102db0d6c]  metal_kernel.cpp:268
    +                               ! :   | + !   :   | 4 DYLD-STUB$$memcmp  (in slotstream) + 4  [0x1040eaf08]
    +                               ! :   | + !   :   | 2 _platform_memcmp  (in libsystem_platform.dylib) + 0,128  [0x18d1d6f10,0x18d1d6f90]
    +                               ! :   | + !   :   5 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1116  [0x102db0828]  metal_kernel.cpp:240
    +                               ! :   | + !   :   | 4 _platform_memchr  (in libsystem_platform.dylib) + 84,76,...  [0x18d1d6e54,0x18d1d6e4c,...]
    +                               ! :   | + !   :   | 1 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + !   :   4 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2468,2444,...  [0x102db0d70,0x102db0d58,...]  metal_kernel.cpp:268
    +                               ! :   | + !   :   1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 800  [0x102db06ec]  metal_kernel.cpp:239
    +                               ! :   | + !   :   | 1 _platform_memcmp  (in libsystem_platform.dylib) + 236  [0x18d1d6ffc]
    +                               ! :   | + !   :   1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1136  [0x102db083c]  metal_kernel.cpp:240
    +                               ! :   | + !   :   | 1 _platform_memcmp  (in libsystem_platform.dylib) + 236  [0x18d1d6ffc]
    +                               ! :   | + !   :   1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1116  [0x102db0828]  metal_kernel.cpp:240
    +                               ! :   | + !   1 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 464  [0x103a09944]  MLXFastKernel.swift:0
    +                               ! :   | + !   : 1 String.utf8CString.getter  (in libswiftCore.dylib) + 76  [0x1a0be30f0]
    +                               ! :   | + !   :   1 specialized _copyCollectionToContiguousArray<A>(_:)  (in libswiftCore.dylib) + 100  [0x1a0a6e5a8]
    +                               ! :   | + !   :     1 _platform_memmove  (in libsystem_platform.dylib) + 444  [0x18d1d951c]
    +                               ! :   | + !   1 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 772  [0x103a09a78]  MLXFastKernel.swift:72
    +                               ! :   | + !     1 StringProtocol.cString(using:)  (in Foundation) + 172  [0x18f4391f0]
    +                               ! :   | + !       1 _platform_memmove  (in libsystem_platform.dylib) + 88  [0x18d1d93b8]
    +                               ! :   | + 42 specialized VQExpert.init(codes:codebook:scales:layout:residentBank:)  (in slotstream) + 2044  [0x103d25124]  VQExpert.swift:76
    +                               ! :   | + ! 26 specialized static VQExpert.kernel(source:name:)  (in slotstream) + 128  [0x103d2475c]  VQExpert.swift:31
    +                               ! :   | + ! : 26 StringProtocol.components<A>(separatedBy:)  (in Foundation) + 572  [0x18f2a7828]
    +                               ! :   | + ! :   26 specialized _StringCompareOptionsIterable._range<A>(of:toHalfWidth:diacriticsInsensitive:caseFold:anchored:backwards:)  (in Foundation) + 136  [0x18f433580]
    +                               ! :   | + ! :     10 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 496  [0x18f152b68]
    +                               ! :   | + ! :     | 5 Substring.subscript.getter  (in libswiftCore.dylib) + 388  [0x1a0c6c084]
    +                               ! :   | + ! :     | + 5 specialized static String._uncheckedFromUTF8(_:isASCII:)  (in libswiftCore.dylib) + 288,8,...  [0x1a0d70104,0x1a0d6ffec,...]
    +                               ! :   | + ! :     | 4 Substring.subscript.getter  (in libswiftCore.dylib) + 40,76,...  [0x1a0c6bf28,0x1a0c6bf4c,...]
    +                               ! :   | + ! :     | 1 Substring.subscript.getter  (in libswiftCore.dylib) + 244  [0x1a0c6bff4]
    +                               ! :   | + ! :     |   1 _allASCII(_:)  (in libswiftCore.dylib) + 104  [0x1a0c47954]
    +                               ! :   | + ! :     8 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 524  [0x18f152b84]
    +                               ! :   | + ! :     | 3 Substring.subscript.getter  (in libswiftCore.dylib) + 244  [0x1a0c6bff4]
    +                               ! :   | + ! :     | + 3 _allASCII(_:)  (in libswiftCore.dylib) + 96,104,...  [0x1a0c4794c,0x1a0c47954,...]
    +                               ! :   | + ! :     | 2 Substring.subscript.getter  (in libswiftCore.dylib) + 388  [0x1a0c6c084]
    +                               ! :   | + ! :     | + 2 specialized static String._uncheckedFromUTF8(_:isASCII:)  (in libswiftCore.dylib) + 20,28  [0x1a0d6fff8,0x1a0d70000]
    +                               ! :   | + ! :     | 2 Substring.subscript.getter  (in libswiftCore.dylib) + 76,444  [0x1a0c6bf4c,0x1a0c6c0bc]
    +                               ! :   | + ! :     | 1 DYLD-STUB$$Substring.subscript.getter  (in Foundation) + 12  [0x18f66b8a0]
    +                               ! :   | + ! :     4 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 776  [0x18f152c80]
    +                               ! :   | + ! :     | 4 Substring.index(_:offsetBy:)  (in libswiftCore.dylib) + 104,16,...  [0x1a0c6afb8,0x1a0c6af60,...]
    +                               ! :   | + ! :     2 Substring.subscript.getter  (in libswiftCore.dylib) + 404  [0x1a0c6c094]
    +                               ! :   | + ! :     1 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 588  [0x18f152bc4]
    +                               ! :   | + ! :     | 1 _stringCompareWithSmolCheck(_:_:expecting:)  (in libswiftCore.dylib) + 0  [0x1a092a1f0]
    +                               ! :   | + ! :     1 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 600  [0x18f152bd0]
    +                               ! :   | + ! :       1 DYLD-STUB$$swift_bridgeObjectRelease  (in Foundation) + 12  [0x18f672bb0]
    +                               ! :   | + ! 8 specialized static VQExpert.kernel(source:name:)  (in slotstream) + 228  [0x103d247c0]  VQExpert.swift:34
    +                               ! :   | + ! : 7 StringProtocol.replacingOccurrences<A, B>(of:with:options:range:)  (in Foundation) + 260  [0x18f434ef4]
    +                               ! :   | + ! : | 6 -[NSString stringByReplacingOccurrencesOfString:withString:options:range:]  (in Foundation) + 100  [0x18eaa9dbc]
    +                               ! :   | + ! : | + 6 CFStringFindAndReplace  (in CoreFoundation) + 284  [0x18d27c2a8]
    +                               ! :   | + ! : | +   5 CFStringFindWithOptionsAndLocale  (in CoreFoundation) + 756,816,...  [0x18d219b70,0x18d219bac,...]
    +                               ! :   | + ! : | +   1 CFStringFindWithOptionsAndLocale  (in CoreFoundation) + 112  [0x18d2198ec]
    +                               ! :   | + ! : | +     1 __CFStringFillCharacterSetInlineBuffer  (in CoreFoundation) + 0  [0x18d21ca54]
    +                               ! :   | + ! : | 1 -[NSString stringByReplacingOccurrencesOfString:withString:options:range:]  (in Foundation) + 72  [0x18eaa9da0]
    +                               ! :   | + ! : |   1 -[NSString mutableCopyWithZone:]  (in Foundation) + 0  [0x18ea88814]
    +                               ! :   | + ! : 1 StringProtocol.replacingOccurrences<A, B>(of:with:options:range:)  (in Foundation) + 164  [0x18f434e94]
    +                               ! :   | + ! :   1 String._bridgeToObjectiveCImpl()  (in libswiftCore.dylib) + 340  [0x1a0b28cb4]
    +                               ! :   | + ! 8 specialized static VQExpert.kernel(source:name:)  (in slotstream) + 460  [0x103d248a8]  VQExpert.swift:36
    +                               ! :   | + !   8 static MLXFast.metalKernel<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 180  [0x103a09688]  MLXFastKernel.swift:181
    +                               ! :   | + !     8 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 924  [0x103a09b10]  MLXFastKernel.swift:69
    +                               ! :   | + !       8 mlx_fast_metal_kernel_new  (in slotstream) + 496  [0x102d6b780]  fast.cpp:483
    +                               ! :   | + !         3 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 436  [0x102db0580]  metal_kernel.cpp:238
    +                               ! :   | + !         | 2 _platform_memchr  (in libsystem_platform.dylib) + 84,104  [0x18d1d6e54,0x18d1d6e68]
    +                               ! :   | + !         | 1 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + !         2 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2444  [0x102db0d58]  metal_kernel.cpp:268
    +                               ! :   | + !         | 2 _platform_memchr  (in libsystem_platform.dylib) + 104,120  [0x18d1d6e68,0x18d1d6e78]
    +                               ! :   | + !         1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 780  [0x102db06d8]  metal_kernel.cpp:239
    +                               ! :   | + !         | 1 _platform_memchr  (in libsystem_platform.dylib) + 120  [0x18d1d6e78]
    +                               ! :   | + !         1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1116  [0x102db0828]  metal_kernel.cpp:240
    +                               ! :   | + !         | 1 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + !         1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2464  [0x102db0d6c]  metal_kernel.cpp:268
    +                               ! :   | + 1 specialized VQExpert.init(codes:codebook:scales:layout:residentBank:)  (in slotstream) + 3816  [0x103d25810]  VQExpert.swift:0
    +                               ! :   | + ! 1 outlined destroy of VQExpert  (in slotstream) + 28  [0x103d25e20]  /<compiler-generated>:0
    +                               ! :   | + !   1 destroy for VQExpert  (in slotstream) + 64  [0x103d25a64]  /<compiler-generated>:0
    +                               ! :   | + !     1 DYLD-STUB$$swift_release  (in slotstream) + 0  [0x1040eb738]
    +                               ! :   | + 1 specialized VQExpert.init(codes:codebook:scales:layout:residentBank:)  (in slotstream) + 1152  [0x103d24da8]  VQExpert.swift:60
    +                               ! :   | +   1 MLXArray.reshaped<A>(_:stream:)  (in slotstream) + 160  [0x103a03da4]
    +                               ! :   | +     1 mlx_reshape  (in slotstream) + 384  [0x102d8c8ec]  ops.cpp:3075
    +                               ! :   | +       1 mlx::core::reshape(mlx::core::array const&, mlx::core::SmallVector<int, 10ul>, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 104  [0x1036e4c94]  ops.cpp:459
    +                               ! :   | +         1 _platform_memcmp  (in libsystem_platform.dylib) + 272  [0x18d1d7020]
    +                               ! :   | 91 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 4932  [0x103d3581c]  VQRecordBank.swift:170
    +                               ! :   | + 91 specialized Data._Representation.withUnsafeBytes<A>(_:)  (in slotstream) + 476  [0x103d37c74]  /<compiler-generated>:0
    +                               ! :   | +   91 _platform_memmove  (in libsystem_platform.dylib) + 88,100,...  [0x18d1d93b8,0x18d1d93c4,...]
    +                               ! :   | 50 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 2776  [0x103d34fb0]  VQRecordBank.swift:120
    +                               ! :   | + 33 specialized VQExpert.init(codes:codebook:scales:layout:residentBank:)  (in slotstream) + 3568  [0x103d25718]  VQExpert.swift:89
    +                               ! :   | + ! 33 static MLXFast.metalKernel<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 180  [0x103a09688]  MLXFastKernel.swift:181
    +                               ! :   | + !   33 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 924  [0x103a09b10]  MLXFastKernel.swift:69
    +                               ! :   | + !     32 mlx_fast_metal_kernel_new  (in slotstream) + 496  [0x102d6b780]  fast.cpp:483
    +                               ! :   | + !     : 8 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2444  [0x102db0d58]  metal_kernel.cpp:268
    +                               ! :   | + !     : | 6 _platform_memchr  (in libsystem_platform.dylib) + 84,120,...  [0x18d1d6e54,0x18d1d6e78,...]
    +                               ! :   | + !     : | 2 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + !     : 7 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2464  [0x102db0d6c]  metal_kernel.cpp:268
    +                               ! :   | + !     : | 4 _platform_memcmp  (in libsystem_platform.dylib) + 128  [0x18d1d6f90]
    +                               ! :   | + !     : | 3 DYLD-STUB$$memcmp  (in slotstream) + 4,8  [0x1040eaf08,0x1040eaf0c]
    +                               ! :   | + !     : 4 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 436  [0x102db0580]  metal_kernel.cpp:238
    +                               ! :   | + !     : | 4 _platform_memchr  (in libsystem_platform.dylib) + 76,84,...  [0x18d1d6e4c,0x18d1d6e54,...]
    +                               ! :   | + !     : 4 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1116  [0x102db0828]  metal_kernel.cpp:240
    +                               ! :   | + !     : | 4 _platform_memchr  (in libsystem_platform.dylib) + 120,0,...  [0x18d1d6e78,0x18d1d6e00,...]
    +                               ! :   | + !     : 3 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 780  [0x102db06d8]  metal_kernel.cpp:239
    +                               ! :   | + !     : | 2 _platform_memchr  (in libsystem_platform.dylib) + 76,84  [0x18d1d6e4c,0x18d1d6e54]
    +                               ! :   | + !     : | 1 DYLD-STUB$$memchr  (in slotstream) + 4  [0x1040eaefc]
    +                               ! :   | + !     : 2 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 456  [0x102db0594]  metal_kernel.cpp:238
    +                               ! :   | + !     : | 1 DYLD-STUB$$memcmp  (in slotstream) + 4  [0x1040eaf08]
    +                               ! :   | + !     : | 1 _platform_memcmp  (in libsystem_platform.dylib) + 0  [0x18d1d6f10]
    +                               ! :   | + !     : 2 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 800  [0x102db06ec]  metal_kernel.cpp:239
    +                               ! :   | + !     : | 1 DYLD-STUB$$memcmp  (in slotstream) + 4  [0x1040eaf08]
    +                               ! :   | + !     : | 1 _platform_memcmp  (in libsystem_platform.dylib) + 0  [0x18d1d6f10]
    +                               ! :   | + !     : 1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 804  [0x102db06f0]  metal_kernel.cpp:239
    +                               ! :   | + !     : 1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1656  [0x102db0a44]  metal_kernel.cpp:249
    +                               ! :   | + !     :   1 std::pair<std::basic_string<char>, std::basic_string<char>>::pair[abi:nqe210106]<char const (&) [31], char const (&) [5], 0>(char const (&) [31], char const (&) [5])  (in slotstream) + 144  [0x102db1e30]  pair.h:165
    +                               ! :   | + !     :     1 _platform_memmove  (in libsystem_platform.dylib) + 428  [0x18d1d950c]
    +                               ! :   | + !     1 mlx_fast_metal_kernel_new  (in slotstream) + 608  [0x102d6b7f0]  fast.cpp:483
    +                               ! :   | + !       1 std::__function::__func<mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)>::~__func()  (in slotstream) + 32  [0x102db2db4]  function.h:155
    +                               ! :   | + !         1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0::~$_0()  (in slotstream) + 244  [0x102db1788]  metal_kernel.cpp:273
    +                               ! :   | + 17 specialized VQExpert.init(codes:codebook:scales:layout:residentBank:)  (in slotstream) + 2044  [0x103d25124]  VQExpert.swift:76
    +                               ! :   | +   12 specialized static VQExpert.kernel(source:name:)  (in slotstream) + 128  [0x103d2475c]  VQExpert.swift:31
    +                               ! :   | +   : 12 StringProtocol.components<A>(separatedBy:)  (in Foundation) + 572  [0x18f2a7828]
    +                               ! :   | +   :   12 specialized _StringCompareOptionsIterable._range<A>(of:toHalfWidth:diacriticsInsensitive:caseFold:anchored:backwards:)  (in Foundation) + 136  [0x18f433580]
    +                               ! :   | +   :     3 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 776  [0x18f152c80]
    +                               ! :   | +   :     | 2 Substring.index(_:offsetBy:)  (in libswiftCore.dylib) + 68,104  [0x1a0c6af94,0x1a0c6afb8]
    +                               ! :   | +   :     | 1 DYLD-STUB$$Substring.index(_:offsetBy:)  (in Foundation) + 12  [0x18f66b800]
    +                               ! :   | +   :     2 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 496  [0x18f152b68]
    +                               ! :   | +   :     | 1 Substring.subscript.getter  (in libswiftCore.dylib) + 388  [0x1a0c6c084]
    +                               ! :   | +   :     | + 1 specialized static String._uncheckedFromUTF8(_:isASCII:)  (in libswiftCore.dylib) + 296  [0x1a0d7010c]
    +                               ! :   | +   :     | 1 Substring.subscript.getter  (in libswiftCore.dylib) + 44  [0x1a0c6bf2c]
    +                               ! :   | +   :     2 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 524  [0x18f152b84]
    +                               ! :   | +   :     | 2 Substring.subscript.getter  (in libswiftCore.dylib) + 44,444  [0x1a0c6bf2c,0x1a0c6c0bc]
    +                               ! :   | +   :     1 Substring.index(_:offsetBy:)  (in libswiftCore.dylib) + 896  [0x1a0c6b2d0]
    +                               ! :   | +   :     1 Substring.index(before:)  (in libswiftCore.dylib) + 92  [0x1a0c6ae58]
    +                               ! :   | +   :     1 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 336  [0x18f152ac8]
    +                               ! :   | +   :     | 1 Substring._uncheckedIndex(before:)  (in libswiftCore.dylib) + 76  [0x1a0c6aefc]
    +                               ! :   | +   :     |   1 _StringGuts._opaqueCharacterStride(endingAt:in:)  (in libswiftCore.dylib) + 2548  [0x1a0c72f9c]
    +                               ! :   | +   :     1 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 588  [0x18f152bc4]
    +                               ! :   | +   :     | 1 _stringCompareWithSmolCheck(_:_:expecting:)  (in libswiftCore.dylib) + 60  [0x1a092a22c]
    +                               ! :   | +   :     1 specialized BidirectionalCollection._range<A>(of:anchored:backwards:)  (in Foundation) + 600  [0x18f152bd0]
    +                               ! :   | +   :       1 DYLD-STUB$$swift_bridgeObjectRelease  (in Foundation) + 12  [0x18f672bb0]
    +                               ! :   | +   3 specialized static VQExpert.kernel(source:name:)  (in slotstream) + 460  [0x103d248a8]  VQExpert.swift:36
    +                               ! :   | +   : 3 static MLXFast.metalKernel<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 180  [0x103a09688]  MLXFastKernel.swift:181
    +                               ! :   | +   :   2 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 924  [0x103a09b10]  MLXFastKernel.swift:69
    +                               ! :   | +   :   | 2 mlx_fast_metal_kernel_new  (in slotstream) + 496  [0x102d6b780]  fast.cpp:483
    +                               ! :   | +   :   |   1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 780  [0x102db06d8]  metal_kernel.cpp:239
    +                               ! :   | +   :   |   + 1 _platform_memchr  (in libsystem_platform.dylib) + 104  [0x18d1d6e68]
    +                               ! :   | +   :   |   1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2444  [0x102db0d58]  metal_kernel.cpp:268
    +                               ! :   | +   :   |     1 _platform_memchr  (in libsystem_platform.dylib) + 76  [0x18d1d6e4c]
    +                               ! :   | +   :   1 specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 952  [0x103a09b2c]  /<compiler-generated>:0
    +                               ! :   | +   :     1 swift_release  (in libswiftCore.dylib) + 4  [0x1a09270f4]
    +                               ! :   | +   2 specialized static VQExpert.kernel(source:name:)  (in slotstream) + 228  [0x103d247c0]  VQExpert.swift:34
    +                               ! :   | +     2 StringProtocol.replacingOccurrences<A, B>(of:with:options:range:)  (in Foundation) + 260  [0x18f434ef4]
    +                               ! :   | +       2 -[NSString stringByReplacingOccurrencesOfString:withString:options:range:]  (in Foundation) + 100  [0x18eaa9dbc]
    +                               ! :   | +         2 CFStringFindAndReplace  (in CoreFoundation) + 284  [0x18d27c2a8]
    +                               ! :   | +           2 CFStringFindWithOptionsAndLocale  (in CoreFoundation) + 2956  [0x18d21a408]
    +                               ! :   | 11 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 7928  [0x103d363d0]  VQRecordBank.swift:185
    +                               ! :   | + 3 VQRecordOperations.composed(_:slots:topK:dispatchPairs:)  (in slotstream) + 108  [0x103d2ff04]  VQRecord.swift:131
    +                               ! :   | + ! 2 VQExpert.operation(_:expertIDs:topK:dispatchPairs:)  (in slotstream) + 972  [0x103d24070]  VQExpert.swift:160
    +                               ! :   | + ! : 2 MLXArray.__allocating_init<A, B>(_:_:)  (in slotstream) + 28  [0x1039f7aa4]  /<compiler-generated>:0
    +                               ! :   | + ! :   1 specialized MLXArray.__allocating_init<A, B>(_:_:)  (in slotstream) + 60  [0x1039fa984]  MLXArray+Init.swift:370
    +                               ! :   | + ! :   | 1 _ArrayBuffer.count.getter  (in libswiftCore.dylib) + 32  [0x1a0a5f400]
    +                               ! :   | + ! :   |   1 _swift_isClassOrObjCExistentialType  (in libswiftCore.dylib) + 64  [0x1a09273fc]
    +                               ! :   | + ! :   1 specialized MLXArray.__allocating_init<A, B>(_:_:)  (in slotstream) + 152  [0x1039fa9e0]  MLXArray+Init.swift:372
    +                               ! :   | + ! :     1 Array.withUnsafeBufferPointer<A, B>(_:)  (in slotstream) + 76  [0x1039f8e04]  /<compiler-generated>:0
    +                               ! :   | + ! :       1 _ArrayBuffer.withUnsafeBufferPointer<A, B>(_:)  (in slotstream) + 260  [0x1039fa69c]  /<compiler-generated>:0
    +                               ! :   | + ! :         1 partial apply for closure #1 in MLXArray.init<A, B>(_:_:)  (in slotstream) + 36  [0x1039febcc]  /<compiler-generated>:0
    +                               ! :   | + ! :           1 closure #1 in MLXArray.init<A, B>(_:_:)  (in slotstream) + 384  [0x1039f8d70]  MLXArray+Init.swift:374
    +                               ! :   | + ! :             1 mlx_array_new_data  (in slotstream) + 44  [0x102d52c14]  array.cpp:244
    +                               ! :   | + ! :               1 mlx_array_set_data  (in slotstream) + 5744  [0x102d51da4]  array.cpp:195
    +                               ! :   | + ! :                 1 mlx::core::array::init<int*>(int*)  (in slotstream) + 80  [0x102d57614]  array.h:600
    +                               ! :   | + ! :                   1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 240  [0x1035855f0]  allocator.cpp:149
    +                               ! :   | + ! :                     1 -[AGXBuffer initWithHeap:length:alignment:pointerTag:options:]  (in AGXMetalG17X) + 100  [0x117d65638]
    +                               ! :   | + ! :                       1 -[IOGPUMetalHeap newSubResourceWithLength:alignment:options:offset:]  (in IOGPU) + 208  [0x1b287dfd4]
    +                               ! :   | + ! :                         1 MTLRangeAllocatorAllocate  (in Metal) + 160  [0x1998c944c]
    +                               ! :   | + ! 1 VQExpert.operation(_:expertIDs:topK:dispatchPairs:)  (in slotstream) + 568  [0x103d23edc]  VQExpert.swift:150
    +                               ! :   | + !   1 MLXArray.__allocating_init<A, B>(_:_:)  (in slotstream) + 28  [0x1039f7aa4]  /<compiler-generated>:0
    +                               ! :   | + !     1 specialized MLXArray.__allocating_init<A, B>(_:_:)  (in slotstream) + 152  [0x1039fa9e0]  MLXArray+Init.swift:372
    +                               ! :   | + !       1 Array.withUnsafeBufferPointer<A, B>(_:)  (in slotstream) + 76  [0x1039f8e04]  /<compiler-generated>:0
    +                               ! :   | + !         1 _ArrayBuffer.withUnsafeBufferPointer<A, B>(_:)  (in slotstream) + 260  [0x1039fa69c]  /<compiler-generated>:0
    +                               ! :   | + !           1 partial apply for closure #1 in MLXArray.init<A, B>(_:_:)  (in slotstream) + 36  [0x1039febcc]  /<compiler-generated>:0
    +                               ! :   | + !             1 closure #1 in MLXArray.init<A, B>(_:_:)  (in slotstream) + 384  [0x1039f8d70]  MLXArray+Init.swift:374
    +                               ! :   | + !               1 mlx_array_new_data  (in slotstream) + 44  [0x102d52c14]  array.cpp:244
    +                               ! :   | + !                 1 mlx_array_set_data  (in slotstream) + 5516  [0x102d51cc0]  array.cpp:179
    +                               ! :   | + !                   1 mlx::core::array::init<unsigned int*>(unsigned int*)  (in slotstream) + 80  [0x102d5bd24]  array.h:600
    +                               ! :   | + !                     1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 240  [0x1035855f0]  allocator.cpp:149
    +                               ! :   | + !                       1 -[AGXBuffer initWithHeap:length:alignment:pointerTag:options:]  (in AGXMetalG17X) + 132  [0x117d65658]
    +                               ! :   | + !                         1 -[AGXBuffer(Internal) initImplWithHeap:resource:length:pointerTag:atOffset:]  (in AGXMetalG17X) + 68  [0x117d65c68]
    +                               ! :   | + !                           1 -[IOGPUMetalBuffer initWithHeap:resource:offset:length:gpuTag:]  (in IOGPU) + 100  [0x1b286ff88]
    +                               ! :   | + !                             1 -[IOGPUMetalResource initWithResource:]  (in IOGPU) + 156  [0x1b2884c6c]
    +                               ! :   | + !                               1 objc_storeWeak  (in libobjc.A.dylib) + 468  [0x18cd6aae0]
    +                               ! :   | + !                                 1 weak_register_no_lock  (in libobjc.A.dylib) + 172  [0x18cd6ac0c]
    +                               ! :   | + !                                   1 weak_entry_for_referent  (in libobjc.A.dylib) + 0  [0x18cd9a3b8]
    +                               ! :   | + 2 VQRecordOperations.composed(_:slots:topK:dispatchPairs:)  (in slotstream) + 124  [0x103d2ff14]  VQRecord.swift:131
    +                               ! :   | + ! 2 partial apply for closure #2 in VQExpert.operation(_:expertIDs:topK:dispatchPairs:)  (in slotstream) + 44  [0x103d259b8]  /<compiler-generated>:0
    +                               ! :   | + !   1 closure #2 in VQExpert.operation(_:expertIDs:topK:dispatchPairs:)  (in slotstream) + 128  [0x103d241b4]  VQExpert.swift:162
    +                               ! :   | + !   : 1 MLXArray.asType(_:stream:)  (in slotstream) + 148  [0x103a04dc0]  MLXArray.swift:498
    +                               ! :   | + !   :   1 mlx_astype  (in slotstream) + 180  [0x102d7be5c]  ops.cpp:451
    +                               ! :   | + !   :     1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! :   | + !   :       1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 692  [0x18cff11f0]
    +                               ! :   | + !   1 closure #2 in VQExpert.operation(_:expertIDs:topK:dispatchPairs:)  (in slotstream) + 1144  [0x103d245ac]  VQExpert.swift:162
    +                               ! :   | + !     1 MLXFast.MLXFastKernel.callAsFunction<A, B>(_:template:grid:threadGroup:outputShapes:outputDTypes:initValue:verbose:stream:)  (in slotstream) + 1672  [0x103a0945c]  MLXFastKernel.swift:154
    +                               ! :   | + !       1 mlx_fast_metal_kernel_apply  (in slotstream) + 244  [0x102d6bb98]  fast.cpp:525
    +                               ! :   | + !         1 std::__function::__func<mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)>::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>&&, std::tuple<int, int, int>&&, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>&&, std::optional<float>&&, bool&&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>&&)  (in slotstream) + 80  [0x102db2e88]  function.h:174
    +                               ! :   | + !           1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>> const&, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>) const  (in slotstream) + 2500  [0x102db3b04]  metal_kernel.cpp:323
    +                               ! :   | + !             1 std::basic_string<char>::append(char const*, unsigned long)  (in libc++.1.dylib) + 144  [0x18d0e1f3c]
    +                               ! :   | + !               1 _platform_memmove  (in libsystem_platform.dylib) + 428  [0x18d1d950c]
    +                               ! :   | + 2 VQRecordOperations.composed(_:slots:topK:dispatchPairs:)  (in slotstream) + 404  [0x103d3002c]  VQRecord.swift:133
    +                               ! :   | + ! 2 CompiledFunction.call(_:)  (in slotstream) + 144  [0x103a2c934]  Transforms+Compile.swift:141
    +                               ! :   | + !   2 CompiledFunction.innerCall(_:)  (in slotstream) + 968  [0x103a2cd1c]  Transforms+Compile.swift:246
    +                               ! :   | + !     2 mlx_closure_apply  (in slotstream) + 60  [0x102d646bc]  closure.cpp:102
    +                               ! :   | + !       1 std::__function::__func<mlx::core::detail::compile(std::function<std::vector<mlx::core::array> (std::vector<mlx::core::array> const&)>, unsigned long, bool, std::vector<unsigned long long>)::$_1, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&)>::operator()(std::vector<mlx::core::array> const&)  (in slotstream) + 0  [0x103649cb4]  function.h:173
    +                               ! :   | + !       1 std::__function::__func<mlx::core::detail::compile(std::function<std::vector<mlx::core::array> (std::vector<mlx::core::array> const&)>, unsigned long, bool, std::vector<unsigned long long>)::$_1, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&)>::operator()(std::vector<mlx::core::array> const&)  (in slotstream) + 44  [0x103649ce0]  function.h:174
    +                               ! :   | + !         1 std::__function::__func<mlx::core::detail::compile(std::function<std::pair<std::vector<mlx::core::array>, std::shared_ptr<void>> (std::vector<mlx::core::array> const&)>, unsigned long, bool, std::vector<unsigned long long>)::$_0, std::pair<std::vector<mlx::core::array>, std::shared_ptr<void>> (std::vector<mlx::core::array> const&)>::operator()(std::vector<mlx::core::array> const&)  (in slotstream) + 772  [0x10364845c]  function.h:174
    +                               ! :   | + !           1 mlx::core::detail::compile_replace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array> const&, std::vector<mlx::core::array> const&, std::vector<mlx::core::array> const&, bool)  (in slotstream) + 2368  [0x103642280]  compile.cpp:1077
    +                               ! :   | + !             1 mlx::core::array::array(mlx::core::SmallVector<int, 10ul>, mlx::core::Dtype, std::shared_ptr<mlx::core::Primitive>, std::vector<mlx::core::array>)  (in slotstream) + 104  [0x102da4440]  array.cpp:25
    +                               ! :   | + !               1 std::construct_at[abi:nqe210106]<mlx::core::array::ArrayDesc, mlx::core::SmallVector<int, 10ul>, mlx::core::Dtype&, std::shared_ptr<mlx::core::Primitive>, std::vector<mlx::core::array>, mlx::core::array::ArrayDesc*>(mlx::core::array::ArrayDesc*, mlx::core::SmallVector<int, 10ul>&&, mlx::core::Dtype&, std::shared_ptr<mlx::core::Primitive>&&, std::vector<mlx::core::array>&&)  (in slotstream) + 80  [0x102da9760]  construct_at.h:38
    +                               ! :   | + 2 VQRecordOperations.composed(_:slots:topK:dispatchPairs:)  (in slotstream) + 736  [0x103d30178]  VQRecord.swift:136
    +                               ! :   | + ! 2 partial apply for closure #2 in VQExpert.operation(_:expertIDs:topK:dispatchPairs:)  (in slotstream) + 44  [0x103d259b8]  /<compiler-generated>:0
    +                               ! :   | + !   2 closure #2 in VQExpert.operation(_:expertIDs:topK:dispatchPairs:)  (in slotstream) + 1144  [0x103d245ac]  VQExpert.swift:162
    +                               ! :   | + !     2 MLXFast.MLXFastKernel.callAsFunction<A, B>(_:template:grid:threadGroup:outputShapes:outputDTypes:initValue:verbose:stream:)  (in slotstream) + 1672  [0x103a0945c]  MLXFastKernel.swift:154
    +                               ! :   | + !       2 mlx_fast_metal_kernel_apply  (in slotstream) + 244  [0x102d6bb98]  fast.cpp:525
    +                               ! :   | + !         2 std::__function::__func<mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)>::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>&&, std::tuple<int, int, int>&&, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>&&, std::optional<float>&&, bool&&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>&&)  (in slotstream) + 80  [0x102db2e88]  function.h:174
    +                               ! :   | + !           1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>> const&, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>) const  (in slotstream) + 3176  [0x102db3da8]  metal_kernel.cpp:327
    +                               ! :   | + !           : 1 std::basic_string<char>::append(char const*, unsigned long)  (in libc++.1.dylib) + 32  [0x18d0e1ecc]
    +                               ! :   | + !           1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>> const&, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>) const  (in slotstream) + 3732  [0x102db3fd4]  metal_kernel.cpp:327
    +                               ! :   | + !             1 std::basic_string<char>::append(char const*, unsigned long)  (in libc++.1.dylib) + 32  [0x18d0e1ecc]
    +                               ! :   | + 1 VQRecordOperations.composed(_:slots:topK:dispatchPairs:)  (in slotstream) + 416  [0x103d30038]  /<compiler-generated>:0
    +                               ! :   | + ! 1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 120  [0x1a098de10]
    +                               ! :   | + 1 VQRecordOperations.composed(_:slots:topK:dispatchPairs:)  (in slotstream) + 732  [0x103d30174]  VQRecord.swift:136
    +                               ! :   | 5 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 8360  [0x103d36580]  VQRecordBank.swift:124
    +                               ! :   | + 5 Stream.synchronize()  (in slotstream) + 52  [0x103a2c510]  Stream.swift:158
    +                               ! :   | +   5 mlx_synchronize  (in slotstream) + 36  [0x102d9b570]  stream.cpp:85
    +                               ! :   | +     4 mlx::core::metal::CommandEncoder::synchronize()  (in slotstream) + 180  [0x1035a053c]  device.cpp:569
    +                               ! :   | +     ! 4 -[_MTLCommandBuffer waitUntilCompleted]  (in Metal) + 76  [0x19986693c]
    +                               ! :   | +     !   3 _pthread_cond_wait  (in libsystem_pthread.dylib) + 980  [0x18d1d0128]
    +                               ! :   | +     !   : 3 __psynch_cvwait  (in libsystem_kernel.dylib) + 8  [0x18d18f50c]
    +                               ! :   | +     !   1 _pthread_cond_wait  (in libsystem_pthread.dylib) + 936  [0x18d1d00fc]
    +                               ! :   | +     1 mlx::core::metal::CommandEncoder::synchronize()  (in slotstream) + 124  [0x1035a0504]  device.cpp:568
    +                               ! :   | +       1 mlx::core::metal::CommandEncoder::commit(std::function<void ()>)  (in slotstream) + 788  [0x1035a1ca4]  device.cpp:558
    +                               ! :   | +         1 -[AGXG17XFamilyCommandBuffer commit]  (in AGXMetalG17X) + 888  [0x117def984]
    +                               ! :   | +           1 -[IOGPUMetalCommandBuffer commit]  (in IOGPU) + 228  [0x1b2871478]
    +                               ! :   | +             1 -[_MTLCommandQueue commitCommandBuffer:wake:]  (in Metal) + 268  [0x19986242c]
    +                               ! :   | +               1 dispatch_source_merge_data  (in libdispatch.dylib) + 92  [0x18d029458]
    +                               ! :   | +                 1 _dispatch_event_loop_poke  (in libdispatch.dylib) + 336  [0x18d035eb0]
    +                               ! :   | +                   1 _dispatch_kq_poll  (in libdispatch.dylib) + 220  [0x18d036a64]
    +                               ! :   | +                     1 kevent_id  (in libsystem_kernel.dylib) + 8  [0x18d18da74]
    +                               ! :   | 1 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 6740  [0x103d35f2c]  /<compiler-generated>:0
    +                               ! :   | + 1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               ! :   | +   1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               ! :   | +     1 _ContiguousArrayStorage.__deallocating_deinit  (in libswiftCore.dylib) + 96  [0x1a092af04]
    +                               ! :   | +       1 swift_arrayDestroy  (in libswiftCore.dylib) + 192  [0x1a09292b4]
    +                               ! :   | +         1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               ! :   | +           1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               ! :   | +             1 _ContiguousArrayStorage.__deallocating_deinit  (in libswiftCore.dylib) + 96  [0x1a092af04]
    +                               ! :   | +               1 swift::swift_cvw_arrayDestroy(swift::OpaqueValue*, unsigned long, unsigned long, swift::TargetMetadata<swift::InProcess> const*)  (in libswiftCore.dylib) + 1156  [0x1a0970e50]
    +                               ! :   | +                 1 multiPayloadEnumFN<&handleRefCountsDestroy(swift::TargetMetadata<swift::InProcess> const*, swift::LayoutStringReader1&, unsigned long&, unsigned char*)>(swift::TargetMetadata<swift::InProcess> const*, swift::LayoutStringReader1&, unsigned long&, unsigned char*)  (in libswiftCore.dylib) + 248  [0x1a0976584]
    +                               ! :   | +                   1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               ! :   | +                     1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               ! :   | +                       1 __DataStorage.__deallocating_deinit  (in Foundation) + 104  [0x18ee33850]
    +                               ! :   | +                         1 xzm_segment_group_free_chunk  (in libsystem_malloc.dylib) + 636  [0x18cfd53bc]
    +                               ! :   | +                           1 _xzm_segment_group_segment_span_free_coalesce  (in libsystem_malloc.dylib) + 256  [0x18cfd59cc]
    +                               ! :   | +                             1 _xzm_segment_group_span_mark_used  (in libsystem_malloc.dylib) + 148  [0x18cfd73b0]
    +                               ! :   | +                               1 _xzm_reclaim_mark_used  (in libsystem_malloc.dylib) + 124  [0x18cfd3fac]
    +                               ! :   | +                                 1 _xzm_reclaim_mark_used_locked  (in libsystem_malloc.dylib) + 60  [0x18cfd6a9c]
    +                               ! :   | +                                   1 mach_vm_reclaim_try_cancel  (in libsystem_kernel.dylib) + 260  [0x18d19f2f8]
    +                               ! :   | +                                     1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +                               ! :   | 1 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 1296  [0x103d349e8]  VQRecordBank.swift:120
    +                               ! :   | 1 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 1052  [0x103d348f4]  VQRecordBank.swift:122
    +                               ! :   | + 1 swift_allocObject  (in libswiftCore.dylib) + 136  [0x1a0924b48]
    +                               ! :   | +   1 swift::swift_slowAllocTyped(unsigned long, unsigned long, unsigned long long)  (in libswiftCore.dylib) + 56  [0x1a098b5d8]
    +                               ! :   | +     1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 256  [0x18cff103c]
    +                               ! :   | 1 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 3104  [0x103d350f8]  VQRecordBank.swift:131
    +                               ! :   | + 1 specialized __RawDictionaryStorage.find<A>(_:)  (in slotstream) + 64  [0x103aba06c]
    +                               ! :   | +   1 Hasher._combine(_:)  (in libswiftCore.dylib) + 128  [0x1a0b77724]
    +                               ! :   | 1 VQRecordBank.call(_:layer:routes:dispatchPairs:books:shouldContinue:batchReader:read:)  (in slotstream) + 3668  [0x103d3532c]  VQRecordBank.swift:136
    +                               ! :   |   1 specialized Dictionary._Variant.removeValue(forKey:)  (in slotstream) + 80  [0x103adc8fc]  /<compiler-generated>:0
    +                               ! :   |     1 specialized _NativeDictionary._delete(at:)  (in slotstream) + 124  [0x103adfd40]  /<compiler-generated>:0
    +                               ! :   40 specialized static VQRouteStream.partition(_:routes:batchExperts:apply:)  (in slotstream) + 3324  [0x103d41a5c]  VQRouteStream.swift:53
    +                               ! :   | 40 eval(_:)  (in slotstream) + 72  [0x103a3587c]  Transforms+Eval.swift:124
    +                               ! :   |   40 mlx_eval  (in slotstream) + 140  [0x102d9bf24]  transforms.cpp:71
    +                               ! :   |     38 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 128  [0x103794dcc]  transforms.cpp:378
    +                               ! :   |     + 38 mlx::core::array::wait()  (in slotstream) + 48  [0x102da7c24]  array.cpp:148
    +                               ! :   |     +   38 mlx::core::Event::wait()  (in slotstream) + 68  [0x1035b4a2c]  event.cpp:48
    +                               ! :   |     +     37 -[IOSurfaceSharedEvent waitUntilSignaledValue:timeoutMS:]  (in IOSurface) + 72  [0x199826184]
    +                               ! :   |     +     ! 37 iokit_user_client_trap  (in IOKit) + 8  [0x19154cae0]
    +                               ! :   |     +     1 -[IOSurfaceSharedEvent waitUntilSignaledValue:timeoutMS:]  (in IOSurface) + 52  [0x199826170]
    +                               ! :   |     +       1 _ioSurfaceConnectInternal  (in IOSurface) + 108  [0x199821c44]
    +                               ! :   |     2 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 120  [0x103794dc4]  transforms.cpp:378
    +                               ! :   |       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 4404  [0x103793f94]  transforms.cpp:266
    +                               ! :   |       ! 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 200  [0x1035b31f8]  eval.cpp:45
    +                               ! :   |       !   1 mlx::core::Gather::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 2616  [0x1035c5014]  indexing.cpp:116
    +                               ! :   |       !     1 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 56  [0x1035a06d0]  device.cpp:580
    +                               ! :   |       !       1 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithDispatchType:]  (in AGXMetalG17X) + 276  [0x117ded754]
    +                               ! :   |       !         1 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithConfig:]  (in AGXMetalG17X) + 164  [0x117ded950]
    +                               ! :   |       !           1 -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 536  [0x117e4b848]
    +                               ! :   |       !             1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::beginComputePass(bool, eAGXDataBufferPools)  (in AGXMetalG17X) + 2644  [0x117e3fd38]
    +                               ! :   |       !               1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::insertIndirectTGOptKernel(eAGXDataBufferPools, indirectTGOptParams*&, unsigned short*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::InstanceTokenImproved*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::FenceToken*&)  (in AGXMetalG17X) + 456  [0x117e40568]
    +                               ! :   |       !                 1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 1100  [0x117e41204]
    +                               ! :   |       !                   1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::bindBufferResourceToCommand(unsigned int, bool)  (in AGXMetalG17X) + 392  [0x117e42f80]
    +                               ! :   |       !                     1 AGX::HAL300::ComputeCoalescingResourceTracker::ComputeCoalescingResourceTracker()  (in AGXMetalG17X) + 272  [0x117e438ec]
    +                               ! :   |       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 5140  [0x103794274]  transforms.cpp:343
    +                               ! :   |         1 mlx::core::gpu::finalize(mlx::core::Stream)  (in slotstream) + 88  [0x1035b3b50]  eval.cpp:76
    +                               ! :   |           1 mlx::core::metal::CommandEncoder::commit(std::function<void ()>)  (in slotstream) + 456  [0x1035a1b58]  device.cpp:520
    +                               ! :   |             1 MTLDispatchListAppendBlock  (in Metal) + 60  [0x199861f88]
    +                               ! :   |               1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 692  [0x18cff11f0]
    +                               ! :   1 specialized static VQRouteStream.partition(_:routes:batchExperts:apply:)  (in slotstream) + 1624  [0x103d413b8]  VQRouteStream.swift:37
    +                               ! :   | 1 MLXArray.__allocating_init<A, B>(_:_:)  (in slotstream) + 28  [0x1039f7aa4]  /<compiler-generated>:0
    +                               ! :   |   1 specialized MLXArray.__allocating_init<A, B>(_:_:)  (in slotstream) + 152  [0x1039fa9e0]  MLXArray+Init.swift:372
    +                               ! :   |     1 Array.withUnsafeBufferPointer<A, B>(_:)  (in slotstream) + 76  [0x1039f8e04]  /<compiler-generated>:0
    +                               ! :   |       1 _ArrayBuffer.withUnsafeBufferPointer<A, B>(_:)  (in slotstream) + 260  [0x1039fa69c]  /<compiler-generated>:0
    +                               ! :   |         1 partial apply for closure #1 in MLXArray.init<A, B>(_:_:)  (in slotstream) + 36  [0x1039febcc]  /<compiler-generated>:0
    +                               ! :   |           1 closure #1 in MLXArray.init<A, B>(_:_:)  (in slotstream) + 384  [0x1039f8d70]  MLXArray+Init.swift:374
    +                               ! :   |             1 mlx_array_new_data  (in slotstream) + 44  [0x102d52c14]  array.cpp:244
    +                               ! :   |               1 mlx_array_set_data  (in slotstream) + 5744  [0x102d51da4]  array.cpp:195
    +                               ! :   |                 1 mlx::core::array::init<int*>(int*)  (in slotstream) + 80  [0x102d57614]  array.h:600
    +                               ! :   |                   1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 200  [0x1035855c8]  allocator.cpp:147
    +                               ! :   |                     1 std::mutex::unlock()  (in libc++.1.dylib) + 16  [0x18d0e2038]
    +                               ! :   |                       1 _pthread_mutex_firstfit_unlock_slow  (in libsystem_pthread.dylib) + 220  [0x18d1cab94]
    +                               ! :   |                         1 _pthread_mutex_firstfit_wake  (in libsystem_pthread.dylib) + 28  [0x18d1ccf0c]
    +                               ! :   |                           1 __psynch_mutexdrop  (in libsystem_kernel.dylib) + 8  [0x18d18eba8]
    +                               ! :   1 specialized static VQRouteStream.partition(_:routes:batchExperts:apply:)  (in slotstream) + 1676  [0x103d413ec]  VQRouteStream.swift:37
    +                               ! :   | 1 MLXArray.subscript.getter  (in slotstream) + 88  [0x1039f2234]
    +                               ! :   |   1 specialized ContiguousArray._createNewBuffer(bufferIsUnique:minimumCapacity:growForAppend:)  (in slotstream) + 16  [0x1039b8a60]  /<compiler-generated>:0
    +                               ! :   |     1 specialized _ContiguousArrayBuffer._consumeAndCreateNew(bufferIsUnique:minimumCapacity:growForAppend:)  (in slotstream) + 248  [0x1039b8d44]  /<compiler-generated>:0
    +                               ! :   |       1 swift_arrayInitWithCopy  (in libswiftCore.dylib) + 16  [0x1a09275ac]
    +                               ! :   1 specialized static VQRouteStream.partition(_:routes:batchExperts:apply:)  (in slotstream) + 2056  [0x103d41568]  VQRouteStream.swift:37
    +                               ! :   | 1 eval(_:)  (in slotstream) + 28  [0x103a35850]  Transforms+Eval.swift:123
    +                               ! :   |   1 specialized closure #1 in new_mlx_vector_array<A>(_:)  (in slotstream) + 88  [0x1039e32bc]  Cmlx+Util.swift:9
    +                               ! :   |     1 specialized ContiguousArray._createNewBuffer(bufferIsUnique:minimumCapacity:growForAppend:)  (in slotstream) + 16  [0x1039b8a44]  /<compiler-generated>:0
    +                               ! :   |       1 specialized _ContiguousArrayBuffer._consumeAndCreateNew(bufferIsUnique:minimumCapacity:growForAppend:)  (in slotstream) + 128  [0x1039b8bcc]  /<compiler-generated>:0
    +                               ! :   |         1 swift_allocObject  (in libswiftCore.dylib) + 136  [0x1a0924b48]
    +                               ! :   |           1 swift::swift_slowAllocTyped(unsigned long, unsigned long, unsigned long long)  (in libswiftCore.dylib) + 56  [0x1a098b5d8]
    +                               ! :   |             1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 764  [0x18cff1238]
    +                               ! :   1 specialized static VQRouteStream.partition(_:routes:batchExperts:apply:)  (in slotstream) + 2432  [0x103d416e0]  VQRouteStream.swift:47
    +                               ! :   | 1 specialized Set.init<A>(_:)  (in slotstream) + 40  [0x103b51a64]
    +                               ! :   |   1 _NativeSet.init(capacity:)  (in libswiftCore.dylib) + 32  [0x1a0c1334c]
    +                               ! :   |     1 __swift_instantiateCanonicalPrespecializedGenericMetadata  (in libswiftCore.dylib) + 0  [0x1a0db8c5c]
    +                               ! :   1 specialized static VQRouteStream.partition(_:routes:batchExperts:apply:)  (in slotstream) + 3044  [0x103d41944]  VQRouteStream.swift:52
    +                               ! :   | 1 MLXArray.subscript.getter  (in slotstream) + 332  [0x1039f2328]
    +                               ! :   |   1 getItem(src:operation:stream:)  (in slotstream) + 0  [0x1039f0ad0]  MLXArray+Indexing.swift:530
    +                               ! :   1 specialized static VQRouteStream.partition(_:routes:batchExperts:apply:)  (in slotstream) + 3224  [0x103d419f8]  VQRouteStream.swift:52
    +                               ! :     1 MLXArray.reshaped<A>(_:stream:)  (in slotstream) + 120  [0x103a03d7c]
    +                               ! :       1 Sequence<>.asInt32.getter  (in slotstream) + 68  [0x1039e20e8]  Foundation+Util.swift:28
    +                               ! :         1 Sequence.map<A, B>(_:)  (in slotstream) + 208  [0x102cf8690]  /<compiler-generated>:0
    +                               ! :           1 __swift_instantiateCanonicalPrespecializedGenericMetadata  (in libswiftCore.dylib) + 40  [0x1a0db8c84]
    +                               ! :             1 _swift_getGenericMetadata(swift::MetadataRequest, void const* const*, swift::TargetTypeContextDescriptor<swift::InProcess> const*)  (in libswiftCore.dylib) + 264  [0x1a0997c00]
    +                               ! :               1 swift::LockingConcurrentMap<swift::GenericCacheEntry, swift::LockingConcurrentMapStorage<swift::GenericCacheEntry, (unsigned short)14>>::getOrInsert<swift::MetadataCacheKey, swift::MetadataRequest&, swift::TargetTypeContextDescriptor<swift::InProcess> const*&, void const* const*&>(swift::MetadataCacheKey, swift::MetadataRequest&, swift::TargetTypeContextDescriptor<swift::InProcess> const*&, void const* const*&)  (in libswiftCore.dylib) + 88  [0x1a09ab0a0]
    +                               ! :                 1 swift::StableAddressConcurrentReadableHashMap<swift::GenericCacheEntry, swift::TaggedMetadataAllocator<(unsigned short)14>, swift::Mutex>::getOrInsert<swift::MetadataCacheKey, swift::MetadataWaitQueue::Worker&, swift::MetadataRequest&, swift::TargetTypeContextDescriptor<swift::InProcess> const*&, void const* const*&>(swift::MetadataCacheKey, swift::MetadataWaitQueue::Worker&, swift::MetadataRequest&, swift::TargetTypeContextDescriptor<swift::InProcess> const*&, void const* const*&)  (in libswiftCore.dylib) + 188  [0x1a09ab350]
    +                               ! :                   1 swift::ConcurrentReadableHashMap<swift::HashMapElementWrapper<swift::GenericCacheEntry>, swift::Mutex>::find<swift::MetadataCacheKey>(swift::MetadataCacheKey const&, swift::ConcurrentReadableHashMap<swift::HashMapElementWrapper<swift::GenericCacheEntry>, swift::Mutex>::IndexStorage, unsigned long, swift::HashMapElementWrapper<swift::GenericCacheEntry>*)  (in libswiftCore.dylib) + 28  [0x1a09a773c]
    +                               ! 460 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 5412  [0x103d28fdc]  VQModelProbe.swift:151
    +                               ! : 459 MLXArray.asArray<A>(_:)  (in slotstream) + 148  [0x1039e95d4]  MLXArray+Bytes.swift:128
    +                               ! : | 459 mlx_array_eval  (in slotstream) + 24  [0x102d537f8]  array.cpp:350
    +                               ! : |   459 mlx::core::array::eval()  (in slotstream) + 176  [0x102da7d54]  array.cpp:158
    +                               ! : |     313 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 128  [0x103794dcc]  transforms.cpp:378
    +                               ! : |     + 313 mlx::core::array::wait()  (in slotstream) + 48  [0x102da7c24]  array.cpp:148
    +                               ! : |     +   313 mlx::core::Event::wait()  (in slotstream) + 68  [0x1035b4a2c]  event.cpp:48
    +                               ! : |     +     313 -[IOSurfaceSharedEvent waitUntilSignaledValue:timeoutMS:]  (in IOSurface) + 72  [0x199826184]
    +                               ! : |     +       313 iokit_user_client_trap  (in IOKit) + 8  [0x19154cae0]
    +                               ! : |     146 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 120  [0x103794dc4]  transforms.cpp:378
    +                               ! : |       129 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 4404  [0x103793f94]  transforms.cpp:266
    +                               ! : |       ! 107 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 200  [0x1035b31f8]  eval.cpp:45
    +                               ! : |       ! : 14 mlx::core::copy_gpu(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, mlx::core::Stream const&)  (in slotstream) + 96  [0x10359c880]  copy.cpp:14
    +                               ! : |       ! : | 13 mlx::core::set_copy_output_data(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, std::function<mlx::core::allocator::Buffer (unsigned long)>)  (in slotstream) + 124  [0x1030e1f34]  copy.h:38
    +                               ! : |       ! : | + 13 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! : |       ! : | +   13 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! : |       ! : | +     13 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! : |       ! : | +       12 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
    +                               ! : |       ! : | +       ! 12 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
    +                               ! : |       ! : | +       !   12 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
    +                               ! : |       ! : | +       !     10 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : | +       !     : 10 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : | +       !     :   10 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : | +       !     :     10 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : | +       !     :       10 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : | +       !     :         10 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : | +       !     1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 168  [0x1b28847d0]
    +                               ! : |       ! : | +       !     : 1 objc_storeWeak  (in libobjc.A.dylib) + 468  [0x18cd6aae0]
    +                               ! : |       ! : | +       !     :   1 weak_register_no_lock  (in libobjc.A.dylib) + 184  [0x18cd6ac18]
    +                               ! : |       ! : | +       !     :     1 append_referrer(weak_entry_t*, objc_object**)  (in libobjc.A.dylib) + 320  [0x18cd6afc4]
    +                               ! : |       ! : | +       !     1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 680  [0x1b28849d0]
    +                               ! : |       ! : | +       !       1 objc_msgSend  (in libobjc.A.dylib) + 0  [0x18cd65800]
    +                               ! : |       ! : | +       1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 336  [0x117d65e2c]
    +                               ! : |       ! : | +         1 -[IOGPUMetalDevice allocBufferSubDataWithLength:options:alignment:heapIndex:bufferIndex:bufferOffset:parentAddress:parentLength:]  (in IOGPU) + 112  [0x1b28784c4]
    +                               ! : |       ! : | +           1 IOGPUMetalSuballocatorAllocate  (in IOGPU) + 1644  [0x1b288e9a0]
    +                               ! : |       ! : | +             1 -[AGXG17XFamilyDevice newBufferWithDescriptor:]  (in AGXMetalG17X) + 648  [0x118419180]
    +                               ! : |       ! : | +               1 objc_msgSend  (in libobjc.A.dylib) + 0  [0x18cd65800]
    +                               ! : |       ! : | 1 mlx::core::set_copy_output_data(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, std::function<mlx::core::allocator::Buffer (unsigned long)>)  (in slotstream) + 500  [0x1030e20ac]  copy.h:33
    +                               ! : |       ! : 11 mlx::core::QuantizedMatmul::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 108  [0x103618590]  quantized.cpp:1786
    +                               ! : |       ! : | 11 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! : |       ! : |   11 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! : |       ! : |     11 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! : |       ! : |       7 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
    +                               ! : |       ! : |       + 7 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
    +                               ! : |       ! : |       +   7 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
    +                               ! : |       ! : |       +     7 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : |       +       7 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : |       +         7 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : |       +           7 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : |       +             7 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : |       +               7 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : |       4 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 388  [0x117d65e60]
    +                               ! : |       ! : |         4 -[IOGPUMetalBuffer initWithPrimaryBuffer:heapIndex:bufferIndex:bufferOffset:length:args:argsSize:gpuTag:]  (in IOGPU) + 276  [0x1b28701cc]
    +                               ! : |       ! : |           2 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : |           ! 2 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : |           !   2 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : |           !     2 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : |           !       2 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : |           !         2 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : |           1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 116  [0x1b288479c]
    +                               ! : |       ! : |           ! 1 DYLD-STUB$$objc_msgSendSuper2  (in IOGPU) + 0  [0x1b289ae4c]
    +                               ! : |       ! : |           1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 168  [0x1b28847d0]
    +                               ! : |       ! : |             1 objc_storeWeak  (in libobjc.A.dylib) + 468  [0x18cd6aae0]
    +                               ! : |       ! : |               1 weak_register_no_lock  (in libobjc.A.dylib) + 184  [0x18cd6ac18]
    +                               ! : |       ! : |                 1 append_referrer(weak_entry_t*, objc_object**)  (in libobjc.A.dylib) + 240  [0x18cd6af74]
    +                               ! : |       ! : 11 mlx::core::fast::RMSNorm::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 264  [0x103608458]  normalization.cpp:49
    +                               ! : |       ! : | 11 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! : |       ! : |   10 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! : |       ! : |   + 10 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! : |       ! : |   +   8 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
    +                               ! : |       ! : |   +   ! 8 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
    +                               ! : |       ! : |   +   !   8 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
    +                               ! : |       ! : |   +   !     8 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : |   +   !       8 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : |   +   !         8 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : |   +   !           8 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : |   +   !             8 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : |   +   !               8 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : |   +   1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 336  [0x117d65e2c]
    +                               ! : |       ! : |   +   ! 1 -[IOGPUMetalDevice allocBufferSubDataWithLength:options:alignment:heapIndex:bufferIndex:bufferOffset:parentAddress:parentLength:]  (in IOGPU) + 184  [0x1b287850c]
    +                               ! : |       ! : |   +   !   1 _platform_memset  (in libsystem_platform.dylib) + 140  [0x18d1d911c]
    +                               ! : |       ! : |   +   1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 388  [0x117d65e60]
    +                               ! : |       ! : |   +     1 -[IOGPUMetalBuffer initWithPrimaryBuffer:heapIndex:bufferIndex:bufferOffset:length:args:argsSize:gpuTag:]  (in IOGPU) + 276  [0x1b28701cc]
    +                               ! : |       ! : |   +       1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : |   +         1 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : |   +           1 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : |   +             1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : |   +               1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : |   +                 1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : |   1 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! : |       ! : 10 mlx::core::QuantizedMatmul::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 884  [0x103618898]  quantized.cpp:1834
    +                               ! : |       ! : | 3 mlx::core::qmv(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, std::optional<mlx::core::array> const&, std::optional<mlx::core::array> const&, mlx::core::array&, int, int, int, int, int, mlx::core::metal::Device&, mlx::core::Stream const&, std::basic_string<char> const&)  (in slotstream) + 1492  [0x10360e904]  quantized.cpp:505
    +                               ! : |       ! : | + 1 mlx::core::get_template_definition<std::basic_string<char>, int, int, bool, bool, int>(std::basic_string_view<char>, std::basic_string_view<char>, std::basic_string<char>, int, int, bool, bool, int)  (in slotstream) + 236  [0x10361bf4c]  kernels.h:448
    +                               ! : |       ! : | + ! 1 std::basic_ostream<char>::__put_num[abi:nqe210106]<bool>(bool)  (in libc++.1.dylib) + 132  [0x18d10b4d4]
    +                               ! : |       ! : | + !   1 std::locale::locale(std::locale const&)  (in libc++.1.dylib) + 0  [0x18d0e14e4]
    +                               ! : |       ! : | + 1 mlx::core::get_template_definition<std::basic_string<char>, int, int, bool, bool, int>(std::basic_string_view<char>, std::basic_string_view<char>, std::basic_string<char>, int, int, bool, bool, int)  (in slotstream) + 568  [0x10361c098]  kernels.h:450
    +                               ! : |       ! : | + ! 1 fmt::v12::vformat(fmt::v12::basic_string_view<char>, fmt::v12::basic_format_args<fmt::v12::context>)  (in slotstream) + 128  [0x102d3c6ac]  format-inl.h:1445
    +                               ! : |       ! : | + !   1 fmt::v12::detail::parse_format_string<char, fmt::v12::detail::format_handler<char>>(fmt::v12::basic_string_view<char>, fmt::v12::detail::format_handler<char>&&)  (in slotstream) + 100  [0x102d3cbb0]  base.h:1664
    +                               ! : |       ! : | + !     1 fmt::v12::detail::parse_replacement_field<char, fmt::v12::detail::format_handler<char>&>(char const*, char const*, fmt::v12::detail::format_handler<char>&)  (in slotstream) + 480  [0x102d42a18]  base.h:1639
    +                               ! : |       ! : | + !       1 fmt::v12::detail::copy_noinline<char, char const*, fmt::v12::basic_appender<char>>(char const*, char const*, fmt::v12::basic_appender<char>)  (in slotstream) + 304  [0x102d3db88]  format.h:574
    +                               ! : |       ! : | + 1 mlx::core::get_template_definition<std::basic_string<char>, int, int, bool, bool, int>(std::basic_string_view<char>, std::basic_string_view<char>, std::basic_string<char>, int, int, bool, bool, int)  (in slotstream) + 692  [0x10361c114]  kernels.h:454
    +                               ! : |       ! : | +   1 std::ios_base::~ios_base()  (in libc++.1.dylib) + 128  [0x18d0e2350]
    +                               ! : |       ! : | +     1 free  (in libsystem_malloc.dylib) + 0  [0x18cfc26b8]
    +                               ! : |       ! : | 3 mlx::core::qmv(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, std::optional<mlx::core::array> const&, std::optional<mlx::core::array> const&, mlx::core::array&, int, int, int, int, int, mlx::core::metal::Device&, mlx::core::Stream const&, std::basic_string<char> const&)  (in slotstream) + 1948  [0x10360eacc]  quantized.cpp:534
    +                               ! : |       ! : | + 2 mlx::core::metal::CommandEncoder::dispatch_threadgroups(MTL::Size, MTL::Size)  (in slotstream) + 108  [0x1035a0d04]  device.cpp:413
    +                               ! : |       ! : | + ! 2 -[AGXG17XFamilyComputeContext dispatchThreadgroups:threadsPerThreadgroup:]  (in AGXMetalG17X) + 596  [0x117e487a8]
    +                               ! : |       ! : | + !   1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 860  [0x117e41114]
    +                               ! : |       ! : | + !   : 1 AGX::SpillInfoGen4<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses>::checkSpillParamsForCompute(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned long long)  (in AGXMetalG17X) + 708  [0x118040b2c]
    +                               ! : |       ! : | + !   1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 3600  [0x117e41bc8]
    +                               ! : |       ! : | + 1 mlx::core::metal::CommandEncoder::dispatch_threadgroups(MTL::Size, MTL::Size)  (in slotstream) + 36  [0x1035a0cbc]  device.cpp:411
    +                               ! : |       ! : | +   1 mlx::core::metal::CommandEncoder::maybeInsertBarrier()  (in slotstream) + 52  [0x1035a0bb4]  device.cpp:395
    +                               ! : |       ! : | +     1 -[AGXG17XFamilyComputeContext memoryBarrierWithScope:]  (in AGXMetalG17X) + 144  [0x117e46194]
    +                               ! : |       ! : | +       1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::insertIndirectTGOptKernel(eAGXDataBufferPools, indirectTGOptParams*&, unsigned short*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::InstanceTokenImproved*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::FenceToken*&)  (in AGXMetalG17X) + 456  [0x117e40568]
    +                               ! : |       ! : | +         1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 240  [0x117e40ea8]
    +                               ! : |       ! : | 1 mlx::core::qmv(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, std::optional<mlx::core::array> const&, std::optional<mlx::core::array> const&, mlx::core::array&, int, int, int, int, int, mlx::core::metal::Device&, mlx::core::Stream const&, std::basic_string<char> const&)  (in slotstream) + 888  [0x10360e6a8]  quantized.cpp:494
    +                               ! : |       ! : | + 1 mlx::core::concatenate<std::basic_string<char>, std::basic_string<char>, char const*, int, char const*, int, char const*, char const*, char const*>(std::basic_string<char>&, std::basic_string<char>, std::basic_string<char>, char const*, int, char const*, int, char const*, char const*, char const*)  (in slotstream) + 212  [0x10360ed2c]  utils.h:69
    +                               ! : |       ! : | +   1 mlx::core::concatenate<int, char const*, int, char const*, char const*, char const*>(std::basic_string<char>&, int, char const*, int, char const*, char const*, char const*)  (in slotstream) + 164  [0x10361de28]  utils.h:69
    +                               ! : |       ! : | +     1 mlx::core::concatenate<int, char const*, char const*, char const*>(std::basic_string<char>&, int, char const*, char const*, char const*)  (in slotstream) + 152  [0x10361def8]  utils.h:69
    +                               ! : |       ! : | +       1 std::basic_string<char>::append(char const*, unsigned long)  (in libc++.1.dylib) + 32  [0x18d0e1ecc]
    +                               ! : |       ! : | 1 mlx::core::qmv(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, std::optional<mlx::core::array> const&, std::optional<mlx::core::array> const&, mlx::core::array&, int, int, int, int, int, mlx::core::metal::Device&, mlx::core::Stream const&, std::basic_string<char> const&)  (in slotstream) + 680  [0x10360e5d8]  quantized.cpp:496
    +                               ! : |       ! : | + 1 _platform_memmove  (in libsystem_platform.dylib) + 460  [0x18d1d952c]
    +                               ! : |       ! : | 1 mlx::core::qmv(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, std::optional<mlx::core::array> const&, std::optional<mlx::core::array> const&, mlx::core::array&, int, int, int, int, int, mlx::core::metal::Device&, mlx::core::Stream const&, std::basic_string<char> const&)  (in slotstream) + 2004  [0x10360eb04]  quantized.cpp:505
    +                               ! : |       ! : | + 1 _free  (in libsystem_malloc.dylib) + 0  [0x18cffbcd0]
    +                               ! : |       ! : | 1 mlx::core::qmv(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, std::optional<mlx::core::array> const&, std::optional<mlx::core::array> const&, mlx::core::array&, int, int, int, int, int, mlx::core::metal::Device&, mlx::core::Stream const&, std::basic_string<char> const&)  (in slotstream) + 1680  [0x10360e9c0]  quantized.cpp:521
    +                               ! : |       ! : |   1 mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 320  [0x1035a0908]  device.cpp:357
    +                               ! : |       ! : |     1 objc_msgSend  (in libobjc.A.dylib) + 56  [0x18cd65838]
    +                               ! : |       ! : 9 mlx::core::concatenate_gpu(std::vector<mlx::core::array> const&, mlx::core::array&, int, mlx::core::Stream const&)  (in slotstream) + 392  [0x10362fefc]  slicing.cpp:26
    +                               ! : |       ! : | 9 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! : |       ! : |   8 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! : |       ! : |   + 8 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! : |       ! : |   +   7 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
    +                               ! : |       ! : |   +   ! 7 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
    +                               ! : |       ! : |   +   !   7 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
    +                               ! : |       ! : |   +   !     7 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : |   +   !       6 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : |   +   !       : 6 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : |   +   !       :   6 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : |   +   !       :     6 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : |   +   !       :       6 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : |   +   !       1 IOGPUResourceCreate  (in IOGPU) + 440  [0x1b288b938]
    +                               ! : |       ! : |   +   1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 388  [0x117d65e60]
    +                               ! : |       ! : |   +     1 -[IOGPUMetalBuffer initWithPrimaryBuffer:heapIndex:bufferIndex:bufferOffset:length:args:argsSize:gpuTag:]  (in IOGPU) + 276  [0x1b28701cc]
    +                               ! : |       ! : |   +       1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : |   +         1 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : |   +           1 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : |   +             1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : |   +               1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : |   +                 1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : |   1 -[AGXG17XFamilyDevice newBufferWithLength:options:]  (in AGXMetalG17X) + 120  [0x118419444]
    +                               ! : |       ! : |     1 _objc_rootAllocWithZone  (in libobjc.A.dylib) + 52  [0x18cd69f64]
    +                               ! : |       ! : |       1 _xzm_xzone_malloc_freelist_outlined  (in libsystem_malloc.dylib) + 324  [0x18cff27e4]
    +                               ! : |       ! : |         1 _xzm_xzone_find_and_malloc_from_freelist_chunk  (in libsystem_malloc.dylib) + 168  [0x18cff3024]
    +                               ! : |       ! : |           1 _xzm_chunk_list_pop  (in libsystem_malloc.dylib) + 0  [0x18cff38e8]
    +                               ! : |       ! : 7 mlx::core::concatenate_gpu(std::vector<mlx::core::array> const&, mlx::core::array&, int, mlx::core::Stream const&)  (in slotstream) + 1408  [0x1036302f4]  slicing.cpp:41
    +                               ! : |       ! : | 7 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, mlx::core::Stream const&)  (in slotstream) + 148  [0x10358341c]  copy.cpp:21
    +                               ! : |       ! : |   4 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 3164  [0x10359d5bc]  copy.cpp:163
    +                               ! : |       ! : |   + 3 mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 108  [0x1035a0d84]  device.cpp:421
    +                               ! : |       ! : |   + ! 3 -[AGXG17XFamilyComputeContext dispatchThreads:threadsPerThreadgroup:]  (in AGXMetalG17X) + 304  [0x117e478e8]
    +                               ! : |       ! : |   + !   2 AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3EncodedInstr<AGXIotoInstruction_SPECLM_0>::AGX3EncodedInstr(AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3Instr<AGXIotoInstruction_SPECLM_0> const&)  (in AGXMetalG17X) + 1304,4224  [0x117de5b60,0x117de66c8]
    +                               ! : |       ! : |   + !   1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 1100  [0x117e41204]
    +                               ! : |       ! : |   + !     1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::bindBufferResourceToCommand(unsigned int, bool)  (in AGXMetalG17X) + 632  [0x117e43070]
    +                               ! : |       ! : |   + 1 mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 36  [0x1035a0d3c]  device.cpp:419
    +                               ! : |       ! : |   +   1 mlx::core::metal::CommandEncoder::maybeInsertBarrier()  (in slotstream) + 52  [0x1035a0bb4]  device.cpp:395
    +                               ! : |       ! : |   +     1 -[AGXG17XFamilyComputeContext memoryBarrierWithScope:]  (in AGXMetalG17X) + 144  [0x117e46194]
    +                               ! : |       ! : |   +       1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::insertIndirectTGOptKernel(eAGXDataBufferPools, indirectTGOptParams*&, unsigned short*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::InstanceTokenImproved*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::FenceToken*&)  (in AGXMetalG17X) + 456  [0x117e40568]
    +                               ! : |       ! : |   +         1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 664  [0x117e41050]
    +                               ! : |       ! : |   +           1 AGX::ComputePipeline<AGX::HAL300::ObjClasses, AGX::HAL300::Classes, AGX::HAL300::Encoders>::bindResources(MTLResourceList*, IOGPUResourceList*)  (in AGXMetalG17X) + 84  [0x117e23a08]
    +                               ! : |       ! : |   1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 1804  [0x10359d06c]  copy.cpp:116
    +                               ! : |       ! : |   + 1 mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 72  [0x1035a0810]  device.cpp:349
    +                               ! : |       ! : |   +   1 std::__hash_table<void const*>::__emplace_unique_key_args<void const*, void const*>(void const* const&, void const*&&)  (in slotstream) + 284  [0x1035a59d8]  __hash_table:1580
    +                               ! : |       ! : |   1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 1832  [0x10359d088]  copy.cpp:117
    +                               ! : |       ! : |   + 1 mlx::core::metal::CommandEncoder::set_output_array(mlx::core::array&, int, long long)  (in slotstream) + 24  [0x1035a0994]  device.cpp:365
    +                               ! : |       ! : |   +   1 std::__hash_table<void const*>::__emplace_unique_key_args<void const*, void const*>(void const* const&, void const*&&)  (in slotstream) + 624  [0x1035a5b2c]  __hash_table:1614
    +                               ! : |       ! : |   1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 856  [0x10359ccb8]  copy.cpp:56
    +                               ! : |       ! : |     1 mlx::core::collapse_contiguous_dims(mlx::core::SmallVector<int, 10ul> const&, std::vector<mlx::core::SmallVector<long long, 10ul>> const&, long long)  (in slotstream) + 864  [0x102db99c0]  utils.cpp:67
    +                               ! : |       ! : 7 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 276  [0x10359eb4c]  custom_kernel.cpp:29
    +                               ! : |       ! : | 6 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! : |       ! : | + 6 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! : |       ! : | +   6 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! : |       ! : | +     6 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
    +                               ! : |       ! : | +       6 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
    +                               ! : |       ! : | +         6 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
    +                               ! : |       ! : | +           6 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : | +             6 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : | +               6 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : | +                 6 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : | +                   6 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : | +                     6 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : | 1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 240  [0x1035855f0]  allocator.cpp:149
    +                               ! : |       ! : |   1 -[AGXBuffer initWithHeap:length:alignment:pointerTag:options:]  (in AGXMetalG17X) + 132  [0x117d65658]
    +                               ! : |       ! : |     1 -[AGXBuffer(Internal) initImplWithHeap:resource:length:pointerTag:atOffset:]  (in AGXMetalG17X) + 68  [0x117d65c68]
    +                               ! : |       ! : |       1 -[IOGPUMetalBuffer initWithHeap:resource:offset:length:gpuTag:]  (in IOGPU) + 100  [0x1b286ff88]
    +                               ! : |       ! : |         1 -[IOGPUMetalResource initWithResource:]  (in IOGPU) + 308  [0x1b2884d04]
    +                               ! : |       ! : |           1 objc_storeWeak  (in libobjc.A.dylib) + 344  [0x18cd6aa64]
    +                               ! : |       ! : 5 mlx::core::binary_op_gpu(std::vector<mlx::core::array> const&, mlx::core::array&, char const*, mlx::core::Stream const&)  (in slotstream) + 300  [0x103587c20]  binary.cpp:206
    +                               ! : |       ! : | 5 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, mlx::core::array&, char const*, mlx::core::Stream const&)  (in slotstream) + 172  [0x103587a5c]  binary.cpp:193
    +                               ! : |       ! : |   2 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 832  [0x10358727c]  binary.cpp:113
    +                               ! : |       ! : |   + 2 mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 124  [0x1035a0844]  device.cpp:353
    +                               ! : |       ! : |   +   1 std::__hash_table<MTL::Resource*>::__emplace_unique_key_args<MTL::Resource*, MTL::Resource* const&>(MTL::Resource* const&, MTL::Resource* const&)  (in slotstream) + 108  [0x1035a54cc]  __hash_table:1574
    +                               ! : |       ! : |   +   1 std::__hash_table<MTL::Resource*>::__emplace_unique_key_args<MTL::Resource*, MTL::Resource* const&>(MTL::Resource* const&, MTL::Resource* const&)  (in slotstream) + 168  [0x1035a5508]  __hash_table:1586
    +                               ! : |       ! : |   +     1 DYLD-STUB$$operator new(unsigned long)  (in slotstream) + 4  [0x1040ea608]
    +                               ! : |       ! : |   1 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 684  [0x1035871e8]  binary.cpp:103
    +                               ! : |       ! : |   + 1 mlx::core::get_kernel_name(mlx::core::BinaryOpType, char const*, mlx::core::array const&, bool, int, int)  (in slotstream) + 408  [0x103586d3c]  binary.cpp:61
    +                               ! : |       ! : |   +   1 std::basic_string<char>::append(char const*, unsigned long)  (in libc++.1.dylib) + 192  [0x18d0e1f6c]
    +                               ! : |       ! : |   1 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 1412  [0x1035874c0]  binary.cpp:161
    +                               ! : |       ! : |   + 1 mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 108  [0x1035a0d84]  device.cpp:421
    +                               ! : |       ! : |   +   1 -[AGXG17XFamilyComputeContext dispatchThreads:threadsPerThreadgroup:]  (in AGXMetalG17X) + 304  [0x117e478e8]
    +                               ! : |       ! : |   +     1 AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3EncodedInstr<AGXIotoInstruction_SPECLM_0>::AGX3EncodedInstr(AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3Instr<AGXIotoInstruction_SPECLM_0> const&)  (in AGXMetalG17X) + 2492  [0x117de6004]
    +                               ! : |       ! : |   1 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 508  [0x103587138]  binary.cpp:89
    +                               ! : |       ! : |     1 _xzm_free  (in libsystem_malloc.dylib) + 1048  [0x18cfec530]
    +                               ! : |       ! : |       1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +                               ! : |       ! : 5 mlx::core::copy_gpu(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, mlx::core::Stream const&)  (in slotstream) + 196  [0x10359c8e4]  copy.cpp:23
    +                               ! : |       ! : | 5 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, mlx::core::Stream const&)  (in slotstream) + 148  [0x10358341c]  copy.cpp:21
    +                               ! : |       ! : |   2 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 2252  [0x10359d22c]  copy.cpp:178
    +                               ! : |       ! : |   + 2 mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 108  [0x1035a0d84]  device.cpp:421
    +                               ! : |       ! : |   +   2 -[AGXG17XFamilyComputeContext dispatchThreads:threadsPerThreadgroup:]  (in AGXMetalG17X) + 304  [0x117e478e8]
    +                               ! : |       ! : |   +     1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 1100  [0x117e41204]
    +                               ! : |       ! : |   +     ! 1 _ioGPUResourceListAddResourceEntry  (in IOGPU) + 372  [0x1b288dddc]
    +                               ! : |       ! : |   +     1 AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3EncodedInstr<AGXIotoInstruction_SPECLM_0>::AGX3EncodedInstr(AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3Instr<AGXIotoInstruction_SPECLM_0> const&)  (in AGXMetalG17X) + 3136  [0x117de6288]
    +                               ! : |       ! : |   1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 1720  [0x10359d018]  copy.cpp:108
    +                               ! : |       ! : |   + 1 mlx::core::get_copy_kernel(mlx::core::metal::Device&, std::basic_string<char> const&, mlx::core::array const&, mlx::core::array const&)  (in slotstream) + 456  [0x1035d1898]  jit_kernels.cpp:289
    +                               ! : |       ! : |   +   1 mlx::core::metal::Device::get_kernel(std::basic_string<char> const&, MTL::Library*, std::basic_string<char> const&, std::vector<std::tuple<void const*, MTL::DataType, unsigned long>> const&, std::vector<MTL::Function*> const&)  (in slotstream) + 328  [0x1035a3f7c]  device.cpp:888
    +                               ! : |       ! : |   +     1 std::__hash_table<std::__hash_value_type<std::basic_string<char>, NS::SharedPtr<MTL::ComputePipelineState>>>::find<std::basic_string<char>>(std::basic_string<char> const&)  (in slotstream) + 264  [0x1035a8ab0]  __hash_table:1820
    +                               ! : |       ! : |   +       1 _platform_memcmp  (in libsystem_platform.dylib) + 0  [0x18d1d6f10]
    +                               ! : |       ! : |   1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 1832  [0x10359d088]  copy.cpp:117
    +                               ! : |       ! : |   + 1 mlx::core::metal::CommandEncoder::set_output_array(mlx::core::array&, int, long long)  (in slotstream) + 24  [0x1035a0994]  device.cpp:365
    +                               ! : |       ! : |   +   1 mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 72  [0x1035a0810]  device.cpp:349
    +                               ! : |       ! : |   +     1 std::__hash_table<void const*>::__emplace_unique_key_args<void const*, void const*>(void const* const&, void const*&&)  (in slotstream) + 168  [0x1035a5964]  __hash_table:1586
    +                               ! : |       ! : |   +       1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |       ! : |   +         1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 172  [0x18cff0fe8]
    +                               ! : |       ! : |   1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 80  [0x10359c9b0]  copy.cpp:56
    +                               ! : |       ! : 3 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 1672  [0x10359f0c0]  custom_kernel.cpp:56
    +                               ! : |       ! : | 3 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 56  [0x1035a06d0]  device.cpp:580
    +                               ! : |       ! : |   3 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithDispatchType:]  (in AGXMetalG17X) + 276  [0x117ded754]
    +                               ! : |       ! : |     3 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithConfig:]  (in AGXMetalG17X) + 164  [0x117ded950]
    +                               ! : |       ! : |       2 -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 460  [0x117e4b7fc]
    +                               ! : |       ! : |       + 2 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::ComputeContext<AGX::HAL300::EncoderComputeServiceConfigA>(ComputeContextConfig, AGX::HAL300::EncoderComputeServiceConfigA)  (in AGXMetalG17X) + 1364  [0x117dd01b0]
    +                               ! : |       ! : |       +   2 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::ComputeContext<AGX::HAL300::EncoderComputeServiceConfigA>(ComputeContextConfig, AGX::HAL300::EncoderComputeServiceConfigA)  (in AGXMetalG17X) + 1604  [0x117dd02a0]
    +                               ! : |       ! : |       1 -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 536  [0x117e4b848]
    +                               ! : |       ! : |         1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::beginComputePass(bool, eAGXDataBufferPools)  (in AGXMetalG17X) + 2644  [0x117e3fd38]
    +                               ! : |       ! : |           1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::insertIndirectTGOptKernel(eAGXDataBufferPools, indirectTGOptParams*&, unsigned short*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::InstanceTokenImproved*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::FenceToken*&)  (in AGXMetalG17X) + 456  [0x117e40568]
    +                               ! : |       ! : |             1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 100  [0x117e40e1c]
    +                               ! : |       ! : |               1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::prepareForEnqueue(bool)  (in AGXMetalG17X) + 664  [0x117e42ae4]
    +                               ! : |       ! : |                 1 AGX::Mempool<16u, 0u, true, 0u, 0u, AGX::HAL300::SamplerHeapElem>::addToResourceList(std::array<AGX::Mempool<16u, 0u, true, 0u, 0u, AGX::HAL300::SamplerHeapElem>::ChunkInfo, 1ul>&&, MTLResourceList*, bool*)  (in AGXMetalG17X) + 44  [0x11804023c]
    +                               ! : |       ! : |                   1 DYLD-STUB$$os_unfair_lock_lock  (in AGXMetalG17X) + 12  [0x118456f34]
    +                               ! : |       ! : 3 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 2192  [0x10359f2c8]  custom_kernel.cpp:99
    +                               ! : |       ! : | 3 mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 108  [0x1035a0d84]  device.cpp:421
    +                               ! : |       ! : |   3 -[AGXG17XFamilyComputeContext dispatchThreads:threadsPerThreadgroup:]  (in AGXMetalG17X) + 304  [0x117e478e8]
    +                               ! : |       ! : |     1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 480  [0x117e40f98]
    +                               ! : |       ! : |     + 1 AGX::ComputeUSCStateLoader<AGX::HAL300::Encoders, AGX::HAL300::Classes>::directTGSizeOptimization(AGX::HAL300::ComputeProgramVariant const*, AGX::ComputeDriverArgumentTable<AGX::HAL300::Classes>&, unsigned int&, bool)  (in AGXMetalG17X) + 92  [0x117e272e8]
    +                               ! : |       ! : |     1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 1436  [0x117e41354]
    +                               ! : |       ! : |     + 1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::reserveEnqueueDatabufferSpace(eAGXDataBufferPools, bool)  (in AGXMetalG17X) + 216  [0x117e43354]
    +                               ! : |       ! : |     +   1 agxaReserveCDMTokenSpace<AGX::HAL300::Encoders, AGX::HAL300::DataBufferAllocator>(eAGXDataBufferPools, AGX::HAL300::DataBufferAllocator&, unsigned long, bool, bool, unsigned int, AGX::FlagsConfiguration<eAGXDataBufferReserveFlags> const&)  (in AGXMetalG17X) + 140  [0x117db3e48]
    +                               ! : |       ! : |     1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 4288  [0x117e41e78]
    +                               ! : |       ! : |       1 <deduplicated_symbol>  (in AGXMetalG17X) + 72  [0x117e94118]
    +                               ! : |       ! : |         1 _platform_memmove  (in libsystem_platform.dylib) + 12  [0x18d1d936c]
    +                               ! : |       ! : 2 mlx::core::ArgPartition::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 224  [0x1036326dc]  sort.cpp:352
    +                               ! : |       ! : | 1 mlx::core::(anonymous namespace)::gpu_merge_sort(mlx::core::Stream const&, mlx::core::metal::Device&, mlx::core::array const&, mlx::core::array&, int, bool)  (in slotstream) + 1900  [0x103631c90]  sort.cpp:312
    +                               ! : |       ! : | + 1 mlx::core::type_to_name(mlx::core::array const&)  (in slotstream) + 12  [0x103639c94]  utils.cpp:58
    +                               ! : |       ! : | 1 mlx::core::(anonymous namespace)::gpu_merge_sort(mlx::core::Stream const&, mlx::core::metal::Device&, mlx::core::array const&, mlx::core::array&, int, bool)  (in slotstream) + 2412  [0x103631e90]  sort.cpp:312
    +                               ! : |       ! : |   1 mlx::core::metal::CommandEncoder::set_output_array(mlx::core::array&, int, long long)  (in slotstream) + 24  [0x1035a0994]  device.cpp:365
    +                               ! : |       ! : |     1 mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 72  [0x1035a0810]  device.cpp:349
    +                               ! : |       ! : |       1 std::__hash_table<void const*>::__emplace_unique_key_args<void const*, void const*>(void const* const&, void const*&&)  (in slotstream) + 168  [0x1035a5964]  __hash_table:1586
    +                               ! : |       ! : |         1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |       ! : |           1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 672  [0x18cff11dc]
    +                               ! : |       ! : 2 mlx::core::Convolution::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 720  [0x10358c96c]  conv.cpp:1780
    +                               ! : |       ! : | 1 mlx::core::(anonymous namespace)::conv_1D_gpu(mlx::core::Stream const&, mlx::core::metal::Device&, mlx::core::array const&, mlx::core::array const&, mlx::core::array&, std::vector<int> const&, std::vector<int> const&, std::vector<int> const&, std::vector<int> const&, int, bool, std::vector<mlx::core::array>&)  (in slotstream) + 116  [0x10358d3e4]  conv.cpp:1543
    +                               ! : |       ! : | + 1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! : |       ! : | +   1 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! : |       ! : | +     1 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! : |       ! : | +       1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
    +                               ! : |       ! : | +         1 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
    +                               ! : |       ! : | +           1 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
    +                               ! : |       ! : | +             1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : | +               1 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : | +                 1 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : | +                   1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : | +                     1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : | +                       1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : | 1 mlx::core::(anonymous namespace)::conv_1D_gpu(mlx::core::Stream const&, mlx::core::metal::Device&, mlx::core::array const&, mlx::core::array const&, mlx::core::array&, std::vector<int> const&, std::vector<int> const&, std::vector<int> const&, std::vector<int> const&, int, bool, std::vector<mlx::core::array>&)  (in slotstream) + 7468  [0x10358f09c]  conv.cpp:1553
    +                               ! : |       ! : |   1 mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 108  [0x1035a0d84]  device.cpp:421
    +                               ! : |       ! : |     1 -[AGXG17XFamilyComputeContext dispatchThreads:threadsPerThreadgroup:]  (in AGXMetalG17X) + 304  [0x117e478e8]
    +                               ! : |       ! : |       1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 2296  [0x117e416b0]
    +                               ! : |       ! : 2 mlx::core::Matmul::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 212  [0x1035efb04]  matmul.cpp:1470
    +                               ! : |       ! : | 2 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! : |       ! : |   2 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! : |       ! : |     2 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! : |       ! : |       2 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 388  [0x117d65e60]
    +                               ! : |       ! : |         2 -[IOGPUMetalBuffer initWithPrimaryBuffer:heapIndex:bufferIndex:bufferOffset:length:args:argsSize:gpuTag:]  (in IOGPU) + 276  [0x1b28701cc]
    +                               ! : |       ! : |           2 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : |             2 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : |               2 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : |                 2 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : |                   2 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : |                     2 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : 2 mlx::core::Negative::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 180  [0x103638b48]  unary.cpp:135
    +                               ! : |       ! : | 1 mlx::core::unary_op_gpu_inplace(std::vector<mlx::core::array> const&, mlx::core::array&, char const*, mlx::core::Stream const&)  (in slotstream) + 832  [0x103636c78]  unary.cpp:62
    +                               ! : |       ! : | + 1 mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 144  [0x1035a0858]  device.cpp:355
    +                               ! : |       ! : | 1 mlx::core::unary_op_gpu_inplace(std::vector<mlx::core::array> const&, mlx::core::array&, char const*, mlx::core::Stream const&)  (in slotstream) + 1144  [0x103636db0]  unary.cpp:94
    +                               ! : |       ! : |   1 mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 36  [0x1035a0d3c]  device.cpp:419
    +                               ! : |       ! : |     1 mlx::core::metal::CommandEncoder::maybeInsertBarrier()  (in slotstream) + 52  [0x1035a0bb4]  device.cpp:395
    +                               ! : |       ! : |       1 -[AGXG17XFamilyComputeContext memoryBarrierWithScope:]  (in AGXMetalG17X) + 144  [0x117e46194]
    +                               ! : |       ! : |         1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::insertIndirectTGOptKernel(eAGXDataBufferPools, indirectTGOptParams*&, unsigned short*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::InstanceTokenImproved*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::FenceToken*&)  (in AGXMetalG17X) + 404  [0x117e40534]
    +                               ! : |       ! : 1 mlx::core::ArgPartition::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 100  [0x103632660]  sort.cpp:346
    +                               ! : |       ! : | 1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! : |       ! : |   1 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! : |       ! : |     1 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! : |       ! : |       1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 388  [0x117d65e60]
    +                               ! : |       ! : |         1 -[IOGPUMetalBuffer initWithPrimaryBuffer:heapIndex:bufferIndex:bufferOffset:length:args:argsSize:gpuTag:]  (in IOGPU) + 276  [0x1b28701cc]
    +                               ! : |       ! : |           1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 168  [0x1b28847d0]
    +                               ! : |       ! : |             1 objc_storeWeak  (in libobjc.A.dylib) + 468  [0x18cd6aae0]
    +                               ! : |       ! : |               1 append_referrer(weak_entry_t*, objc_object**)  (in libobjc.A.dylib) + 384  [0x18cd6b004]
    +                               ! : |       ! : 1 mlx::core::AsType::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 0  [0x103583a54]  primitives.cpp:28
    +                               ! : |       ! : 1 mlx::core::Compiled::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 180  [0x103589288]  compiled.cpp:364
    +                               ! : |       ! : | 1 mlx::core::compiled_collapse_contiguous_dims(std::vector<mlx::core::array> const&, mlx::core::array const&, std::function<bool (unsigned long)> const&)  (in slotstream) + 1428  [0x102dad414]  compiled.cpp:0
    +                               ! : |       ! : |   1 _xzm_free  (in libsystem_malloc.dylib) + 352  [0x18cfec278]
    +                               ! : |       ! : |     1 _platform_memset  (in libsystem_platform.dylib) + 140  [0x18d1d911c]
    +                               ! : |       ! : 1 mlx::core::Compiled::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 364  [0x103589340]  compiled.cpp:373
    +                               ! : |       ! : | 1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |       ! : |   1 <deduplicated_symbol>  (in libsystem_malloc.dylib) + 136  [0x18cfeb1e4]
    +                               ! : |       ! : 1 mlx::core::Compiled::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 888  [0x10358954c]  compiled.cpp:394
    +                               ! : |       ! : | 1 objc_msgSend  (in libobjc.A.dylib) + 56  [0x18cd65838]
    +                               ! : |       ! : 1 mlx::core::Compiled::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 1296  [0x1035896e4]  compiled.cpp:422
    +                               ! : |       ! : | 1 mlx::core::metal::CommandEncoder::set_output_array(mlx::core::array&, int, long long)  (in slotstream) + 24  [0x1035a0994]  device.cpp:365
    +                               ! : |       ! : |   1 mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 72  [0x1035a0810]  device.cpp:349
    +                               ! : |       ! : |     1 std::__hash_table<void const*>::__emplace_unique_key_args<void const*, void const*>(void const* const&, void const*&&)  (in slotstream) + 160  [0x1035a595c]  __hash_table:1586
    +                               ! : |       ! : 1 mlx::core::Matmul::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 2060  [0x1035f023c]  matmul.cpp:1546
    +                               ! : |       ! : | 1 mlx::core::gemv(mlx::core::Stream const&, mlx::core::metal::Device&, mlx::core::array const&, mlx::core::array const&, mlx::core::array&, int, int, int, int, int, int, bool, bool, std::vector<mlx::core::array>&, mlx::core::SmallVector<int, 10ul>, mlx::core::SmallVector<long long, 10ul>, mlx::core::SmallVector<long long, 10ul>)  (in slotstream) + 1068  [0x1035f1a90]  matmul.cpp:1262
    +                               ! : |       ! : |   1 mlx::core::gemv_axbpy<false>(mlx::core::Stream const&, mlx::core::metal::Device&, mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, mlx::core::array&, int, int, int, int, int, int, bool, bool, std::vector<mlx::core::array>&, mlx::core::SmallVector<int, 10ul>, mlx::core::SmallVector<long long, 10ul>, mlx::core::SmallVector<long long, 10ul>, mlx::core::SmallVector<long long, 10ul>, float, float)  (in slotstream) + 1864  [0x1035ffa7c]  matmul.cpp:1225
    +                               ! : |       ! : 1 mlx::core::Negative::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 120  [0x103638b0c]  unary.cpp:135
    +                               ! : |       ! : | 1 mlx::core::set_unary_output_data(mlx::core::array const&, mlx::core::array&, std::function<mlx::core::allocator::Buffer (unsigned long)>)  (in slotstream) + 384  [0x103425554]  unary.h:25
    +                               ! : |       ! : |   1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! : |       ! : |     1 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! : |       ! : |       1 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! : |       ! : |         1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 388  [0x117d65e60]
    +                               ! : |       ! : |           1 -[IOGPUMetalBuffer initWithPrimaryBuffer:heapIndex:bufferIndex:bufferOffset:length:args:argsSize:gpuTag:]  (in IOGPU) + 276  [0x1b28701cc]
    +                               ! : |       ! : |             1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! : |       ! : |               1 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! : |       ! : |                 1 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! : |       ! : |                   1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       ! : |                     1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       ! : |                       1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       ! : 1 mlx::core::Reduce::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 1276  [0x103623104]  reduce.cpp:1053
    +                               ! : |       ! : | 1 mlx::core::strided_reduce_general_dispatch(mlx::core::array const&, mlx::core::array&, std::basic_string<char> const&, mlx::core::ReductionPlan const&, std::vector<int> const&, mlx::core::metal::CommandEncoder&, mlx::core::metal::Device&, mlx::core::Stream const&)  (in slotstream) + 2656  [0x103621260]  reduce.cpp:951
    +                               ! : |       ! : |   1 mlx::core::metal::CommandEncoder::dispatch_threadgroups(MTL::Size, MTL::Size)  (in slotstream) + 36  [0x1035a0cbc]  device.cpp:411
    +                               ! : |       ! : |     1 mlx::core::metal::CommandEncoder::maybeInsertBarrier()  (in slotstream) + 52  [0x1035a0bb4]  device.cpp:395
    +                               ! : |       ! : |       1 -[_MTLCommandBuffer executeSynchronizationNotifications:scope:resources:count:]  (in Metal) + 0  [0x199a0bc08]
    +                               ! : |       ! : 1 mlx::core::binary_op_gpu(std::vector<mlx::core::array> const&, mlx::core::array&, char const*, mlx::core::Stream const&)  (in slotstream) + 240  [0x103587be4]  binary.cpp:205
    +                               ! : |       ! : | 1 mlx::core::set_binary_op_output_data(mlx::core::array const&, mlx::core::array const&, mlx::core::array&, mlx::core::BinaryOpType, std::function<mlx::core::allocator::Buffer (unsigned long)>)  (in slotstream) + 1396  [0x102dc7150]  binary.h:91
    +                               ! : |       ! : |   1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 108  [0x10358556c]  allocator.cpp:129
    +                               ! : |       ! : |     1 DYLD-STUB$$std::mutex::lock()  (in slotstream) + 0  [0x1040ea460]
    +                               ! : |       ! : 1 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 0  [0x10359ea38]  custom_kernel.cpp:15
    +                               ! : |       ! : 1 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 856  [0x10359ed90]  custom_kernel.cpp:45
    +                               ! : |       ! : | 1 _xzm_free  (in libsystem_malloc.dylib) + 352  [0x18cfec278]
    +                               ! : |       ! : |   1 _platform_memset  (in libsystem_platform.dylib) + 180  [0x18d1d9144]
    +                               ! : |       ! : 1 mlx::core::fast::RMSNorm::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 496  [0x103608540]  normalization.cpp:49
    +                               ! : |       ! : | 1 mlx::core::contiguous_copy_gpu(mlx::core::array const&, mlx::core::Stream const&)  (in slotstream) + 560  [0x1035836c4]  copy.cpp:39
    +                               ! : |       ! : |   1 mlx::core::copy_gpu(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, mlx::core::Stream const&)  (in slotstream) + 196  [0x10359c8e4]  copy.cpp:23
    +                               ! : |       ! : |     1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, mlx::core::Stream const&)  (in slotstream) + 148  [0x10358341c]  copy.cpp:21
    +                               ! : |       ! : |       1 mlx::core::copy_gpu_inplace(mlx::core::array const&, mlx::core::array&, mlx::core::SmallVector<int, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, mlx::core::SmallVector<long long, 10ul> const&, long long, long long, mlx::core::CopyType, mlx::core::Stream const&, std::optional<mlx::core::array>, std::optional<mlx::core::array>)  (in slotstream) + 3164  [0x10359d5bc]  copy.cpp:163
    +                               ! : |       ! : |         1 mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 36  [0x1035a0d3c]  device.cpp:419
    +                               ! : |       ! : |           1 mlx::core::metal::CommandEncoder::maybeInsertBarrier()  (in slotstream) + 108  [0x1035a0bec]  device.cpp:401
    +                               ! : |       ! : |             1 std::__hash_table<MTL::Resource*>::__emplace_unique_key_args<MTL::Resource*, MTL::Resource* const&>(MTL::Resource* const&, MTL::Resource* const&)  (in slotstream) + 88  [0x1035a54b8]  __hash_table:1569
    +                               ! : |       ! : 1 mlx::core::fast::RMSNorm::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 912  [0x1036086e0]  normalization.cpp:84
    +                               ! : |       ! :   1 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 56  [0x1035a06d0]  device.cpp:580
    +                               ! : |       ! :     1 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithDispatchType:]  (in AGXMetalG17X) + 276  [0x117ded754]
    +                               ! : |       ! :       1 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithConfig:]  (in AGXMetalG17X) + 164  [0x117ded950]
    +                               ! : |       ! :         1 -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 536  [0x117e4b848]
    +                               ! : |       ! :           1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::beginComputePass(bool, eAGXDataBufferPools)  (in AGXMetalG17X) + 2644  [0x117e3fd38]
    +                               ! : |       ! :             1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::insertIndirectTGOptKernel(eAGXDataBufferPools, indirectTGOptParams*&, unsigned short*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::InstanceTokenImproved*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::FenceToken*&)  (in AGXMetalG17X) + 456  [0x117e40568]
    +                               ! : |       ! :               1 AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3EncodedInstr<AGXIotoInstruction_SPECLM_0>::AGX3EncodedInstr(AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3Instr<AGXIotoInstruction_SPECLM_0> const&)  (in AGXMetalG17X) + 3892  [0x117de657c]
    +                               ! : |       ! 4 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 308  [0x1035b3264]  eval.cpp:49
    +                               ! : |       ! : 3 std::__hash_table<std::shared_ptr<mlx::core::array::Data>>::__emplace_unique_key_args<std::shared_ptr<mlx::core::array::Data>, std::shared_ptr<mlx::core::array::Data> const&>(std::shared_ptr<mlx::core::array::Data> const&, std::shared_ptr<mlx::core::array::Data> const&)  (in slotstream) + 456  [0x10319d6d8]  __hash_table:1588
    +                               ! : |       ! : | 2 std::__hash_table<std::shared_ptr<mlx::core::array::Data>>::__do_rehash<true>(unsigned long)  (in slotstream) + 48  [0x10319d8d0]  __hash_table:1769
    +                               ! : |       ! : | + 2 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |       ! : | +   1 <deduplicated_symbol>  (in libsystem_malloc.dylib) + 136  [0x18cfeb1e4]
    +                               ! : |       ! : | +   1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 740  [0x18cff1220]
    +                               ! : |       ! : | 1 std::__hash_table<std::shared_ptr<mlx::core::array::Data>>::__do_rehash<true>(unsigned long)  (in slotstream) + 88  [0x10319d8f8]  __hash_table:1773
    +                               ! : |       ! : |   1 DYLD-STUB$$bzero  (in slotstream) + 4  [0x1040eaa34]
    +                               ! : |       ! : 1 std::__hash_table<std::shared_ptr<mlx::core::array::Data>>::__emplace_unique_key_args<std::shared_ptr<mlx::core::array::Data>, std::shared_ptr<mlx::core::array::Data> const&>(std::shared_ptr<mlx::core::array::Data> const&, std::shared_ptr<mlx::core::array::Data> const&)  (in slotstream) + 180  [0x10319d5c4]  __hash_table:1586
    +                               ! : |       ! :   1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |       ! :     1 _xzm_xzone_malloc  (in libsystem_malloc.dylib) + 8  [0x18cfeb958]
    +                               ! : |       ! 3 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 1748  [0x1035b3804]  eval.cpp:62
    +                               ! : |       ! : 3 mlx::core::metal::CommandEncoder::commit(std::function<void ()>)  (in slotstream) + 788  [0x1035a1ca4]  device.cpp:558
    +                               ! : |       ! :   2 -[AGXG17XFamilyCommandBuffer commit]  (in AGXMetalG17X) + 564  [0x117def840]
    +                               ! : |       ! :   | 2 -[AGXG17XFamilyCommandBuffer commitEncoder]  (in AGXMetalG17X) + 96  [0x117deca88]
    +                               ! : |       ! :   |   2 -[AGXG17XFamilyComputeContext deferredEndEncoding]  (in AGXMetalG17X) + 128  [0x117e4aebc]
    +                               ! : |       ! :   |     1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::endComputePass(bool, eAGXDataBufferPools)  (in AGXMetalG17X) + 672  [0x117e3ec14]
    +                               ! : |       ! :   |     + 1 FenceEncoder::encode(AGX::SidebandBufferAllocator&, bool, AGXStreamHardwareCommandRec*, AGX::FenceList*, AGX::FenceList*, AGX::FenceList*, AGX::FenceList*)  (in AGXMetalG17X) + 180  [0x117db387c]
    +                               ! : |       ! :   |     +   1 AGX::SidebandBufferAllocator::allocate(unsigned int, unsigned int, unsigned int*)  (in AGXMetalG17X) + 92  [0x117db3c28]
    +                               ! : |       ! :   |     +     1 IOGPUMetalCommandBufferStorageAllocSidebandBuffer  (in IOGPU) + 36  [0x1b2880520]
    +                               ! : |       ! :   |     1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::endComputePass(bool, eAGXDataBufferPools)  (in AGXMetalG17X) + 880  [0x117e3ece4]
    +                               ! : |       ! :   |       1 AGX::ContextCommon<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::DataBufferAllocator>::finalizeScsParameters(AGX::ContextCommon<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::DataBufferAllocator>::ScsPerKickParameters&, AGX::RayPayloadSizeAlignImpl<AGX::HAL300::Classes> const&)  (in AGXMetalG17X) + 52  [0x117e2815c]
    +                               ! : |       ! :   1 -[AGXG17XFamilyCommandBuffer commit]  (in AGXMetalG17X) + 888  [0x117def984]
    +                               ! : |       ! :     1 -[IOGPUMetalCommandBuffer commit]  (in IOGPU) + 228  [0x1b2871478]
    +                               ! : |       ! :       1 -[_MTLCommandQueue commitCommandBuffer:wake:]  (in Metal) + 268  [0x19986242c]
    +                               ! : |       ! :         1 dispatch_source_merge_data  (in libdispatch.dylib) + 92  [0x18d029458]
    +                               ! : |       ! :           1 _dispatch_event_loop_poke  (in libdispatch.dylib) + 336  [0x18d035eb0]
    +                               ! : |       ! :             1 _dispatch_kq_poll  (in libdispatch.dylib) + 220  [0x18d036a64]
    +                               ! : |       ! :               1 kevent_id  (in libsystem_kernel.dylib) + 8  [0x18d18da74]
    +                               ! : |       ! 3 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 1104  [0x1035b3580]  eval.cpp:66
    +                               ! : |       ! : 2 std::unordered_set<std::shared_ptr<mlx::core::array::Data>>::unordered_set(std::unordered_set<std::shared_ptr<mlx::core::array::Data>> const&)  (in slotstream) + 216  [0x10319e3b4]  unordered_set:1075
    +                               ! : |       ! : | 1 std::__hash_table<std::shared_ptr<mlx::core::array::Data>>::__do_rehash<true>(unsigned long)  (in slotstream) + 48  [0x10319d8d0]  __hash_table:1769
    +                               ! : |       ! : | + 1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |       ! : | +   1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 420  [0x18cff10e0]
    +                               ! : |       ! : | 1 std::__hash_table<std::shared_ptr<mlx::core::array::Data>>::__do_rehash<true>(unsigned long)  (in slotstream) + 88  [0x10319d8f8]  __hash_table:1775
    +                               ! : |       ! : 1 std::unordered_set<std::shared_ptr<mlx::core::array::Data>>::unordered_set(std::unordered_set<std::shared_ptr<mlx::core::array::Data>> const&)  (in slotstream) + 240  [0x10319e3cc]  unordered_set:1076
    +                               ! : |       ! :   1 std::__hash_table<std::shared_ptr<mlx::core::array::Data>>::__emplace_unique_key_args<std::shared_ptr<mlx::core::array::Data>, std::shared_ptr<mlx::core::array::Data> const&>(std::shared_ptr<mlx::core::array::Data> const&, std::shared_ptr<mlx::core::array::Data> const&)  (in slotstream) + 180  [0x10319d5c4]  __hash_table:1586
    +                               ! : |       ! :     1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |       ! :       1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 540  [0x18cff1158]
    +                               ! : |       ! 3 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 1188  [0x1035b35d4]  eval.cpp:66
    +                               ! : |       ! : 2 MTLDispatchListAppendBlock  (in Metal) + 72  [0x199861f94]
    +                               ! : |       ! : | 2 _Block_copy  (in libsystem_blocks.dylib) + 84  [0x18ce98d94]
    +                               ! : |       ! : |   1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 468  [0x18cff1110]
    +                               ! : |       ! : |   1 malloc_type_malloc  (in libsystem_malloc.dylib) + 72  [0x18cfdf078]
    +                               ! : |       ! : 1 MTLDispatchListAppendBlock  (in Metal) + 60  [0x199861f88]
    +                               ! : |       ! :   1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 88  [0x18cff0f94]
    +                               ! : |       ! 1 -[NSAutoreleasePool release]  (in Foundation) + 268  [0x18ea9b43c]
    +                               ! : |       ! 1 -[_MTLCommandBuffer addCompletedHandler:]  (in Metal) + 96  [0x199862024]
    +                               ! : |       ! 1 mlx::core::array::outputs() const  (in slotstream) + 200  [0x10319c904]  array.h:328
    +                               ! : |       ! 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 112  [0x1035b31a0]  eval.cpp:35
    +                               ! : |       ! : 1 std::vector<mlx::core::array>::reserve(unsigned long)  (in slotstream) + 188  [0x10319cb4c]  vector.h:1103
    +                               ! : |       ! 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 276  [0x1035b3244]  eval.cpp:48
    +                               ! : |       ! 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 540  [0x1035b334c]  eval.cpp:55
    +                               ! : |       ! 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 1088  [0x1035b3570]  eval.cpp:66
    +                               ! : |       ! : 1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |       ! :   1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 516  [0x18cff1140]
    +                               ! : |       ! 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 1256  [0x1035b3618]  eval.cpp:66
    +                               ! : |       ! : 1 std::__function::__func<mlx::core::gpu::eval(mlx::core::array&)::$_1, void (MTL::CommandBuffer*)>::~__func()  (in slotstream) + 128  [0x1035b45dc]  function.h:155
    +                               ! : |       ! 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 936  [0x1035b34d8]  eval.cpp:67
    +                               ! : |       !   1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |       !     1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 764  [0x18cff1238]
    +                               ! : |       7 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 4884  [0x103794174]  transforms.cpp:307
    +                               ! : |       ! 4 mlx::core::array::detach()  (in slotstream) + 72  [0x102da79c0]  array.cpp:118
    +                               ! : |       ! : 1 mlx::core::ArgPartition::~ArgPartition()  (in slotstream) + 0  [0x1034fb010]  primitives.h:332
    +                               ! : |       ! : 1 mlx::core::fast::CustomKernel::~CustomKernel()  (in slotstream) + 116  [0x10359f74c]  fast_primitives.h:436
    +                               ! : |       ! : | 1 _xzm_free  (in libsystem_malloc.dylib) + 352  [0x18cfec278]
    +                               ! : |       ! : 1 std::__shared_ptr_emplace<mlx::core::Slice>::__on_zero_shared()  (in slotstream) + 0  [0x103696b50]  shared_ptr.h:184
    +                               ! : |       ! : 1 std::__shared_ptr_emplace<mlx::core::Squeeze>::__on_zero_shared()  (in slotstream) + 0  [0x1036997bc]  shared_ptr.h:184
    +                               ! : |       ! 1 mlx::core::array::detach()  (in slotstream) + 324  [0x102da7abc]  array.cpp:127
    +                               ! : |       ! : 1 mlx::core::array::~array()  (in slotstream) + 148  [0x102da80ec]  array.cpp:245
    +                               ! : |       ! :   1 mlx::core::array::ArrayDesc::~ArrayDesc()  (in slotstream) + 472  [0x102da8848]  array.cpp:338
    +                               ! : |       ! :     1 _xzm_free  (in libsystem_malloc.dylib) + 564  [0x18cfec34c]
    +                               ! : |       ! 1 mlx::core::array::detach()  (in slotstream) + 332  [0x102da7ac4]  array.cpp:128
    +                               ! : |       ! 1 mlx::core::array::~array()  (in slotstream) + 176  [0x102da8108]  array.cpp:245
    +                               ! : |       3 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 524  [0x10379306c]  transforms.cpp:104
    +                               ! : |       ! 3 mlx::core::Event::Event(mlx::core::Stream)  (in slotstream) + 104  [0x1035b496c]  event.cpp:43
    +                               ! : |       !   3 mlx::core::metal::EventImpl::EventImpl(mlx::core::metal::Device&)  (in slotstream) + 60  [0x1035b47d4]  event.cpp:16
    +                               ! : |       !     3 -[_MTLSharedEvent initWithOptions:]  (in Metal) + 44  [0x199a03134]
    +                               ! : |       !       2 -[IOSurfaceSharedEvent initWithOptions:]  (in IOSurface) + 128  [0x199825e14]
    +                               ! : |       !       : 2 IOConnectCallMethod  (in IOKit) + 176  [0x191530d84]
    +                               ! : |       !       :   2 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       !       :     2 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       !       :       2 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       !       1 -[IOSurfaceSharedEvent initWithOptions:]  (in IOSurface) + 208  [0x199825e64]
    +                               ! : |       !         1 IOConnectCallMethod  (in IOKit) + 176  [0x191530d84]
    +                               ! : |       !           1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! : |       !             1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! : |       !               1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! : |       2 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 5104  [0x103794250]  transforms.cpp:340
    +                               ! : |       ! 2 mlx::core::Event::signal(mlx::core::Stream)  (in slotstream) + 296  [0x1035b4da8]  event.cpp:70
    +                               ! : |       !   1 mlx::core::metal::CommandEncoder::signal_event(mlx::core::Event, unsigned long long)  (in slotstream) + 36  [0x1035a1798]  device.cpp:500
    +                               ! : |       !   : 1 mlx::core::metal::CommandEncoder::end_encoding()  (in slotstream) + 536  [0x1035a0fd0]  device.cpp:460
    +                               ! : |       !   :   1 -[AGXG17XFamilyComputeContext waitForFence:]  (in AGXMetalG17X) + 168  [0x117e44250]
    +                               ! : |       !   :     1 __bzero  (in libsystem_platform.dylib) + 0  [0x18d1d9030]
    +                               ! : |       !   1 mlx::core::metal::CommandEncoder::signal_event(mlx::core::Event, unsigned long long)  (in slotstream) + 64  [0x1035a17b4]  device.cpp:501
    +                               ! : |       !     1 -[AGXG17XFamilyCommandBuffer encodeSignalEvent:value:]  (in AGXMetalG17X) + 52  [0x117ded3f8]
    +                               ! : |       !       1 -[IOGPUMetalCommandBuffer encodeSignalEvent:value:]  (in IOGPU) + 64  [0x1b2871ab4]
    +                               ! : |       !         1 -[AGXG17XFamilyCommandBuffer commitEncoder]  (in AGXMetalG17X) + 96  [0x117deca88]
    +                               ! : |       !           1 -[AGXG17XFamilyComputeContext destroyImpl]  (in AGXMetalG17X) + 68  [0x117e4b2c0]
    +                               ! : |       !             1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::~ComputeContext()  (in AGXMetalG17X) + 292  [0x117e4b448]
    +                               ! : |       !               1 _xzm_free  (in libsystem_malloc.dylib) + 564  [0x18cfec34c]
    +                               ! : |       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 1636  [0x1037934c4]  transforms.cpp:157
    +                               ! : |       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 1556  [0x103793474]  transforms.cpp:160
    +                               ! : |       ! 1 std::__hash_table<std::__hash_value_type<unsigned long, int>>::__emplace_unique_key_args<unsigned long, std::pair<unsigned long const, int>>(unsigned long const&, std::pair<unsigned long const, int>&&)  (in slotstream) + 356  [0x10379c000]  __hash_table:1588
    +                               ! : |       !   1 std::__hash_table<std::__hash_value_type<unsigned long, int>>::__do_rehash<true>(unsigned long)  (in slotstream) + 68  [0x10379c184]  __hash_table:1769
    +                               ! : |       !     1 _xzm_free  (in libsystem_malloc.dylib) + 352  [0x18cfec278]
    +                               ! : |       !       1 _platform_memset  (in libsystem_platform.dylib) + 140  [0x18d1d911c]
    +                               ! : |       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 2340  [0x103793784]  transforms.cpp:206
    +                               ! : |       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 3924  [0x103793db4]  transforms.cpp:249
    +                               ! : |       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 5140  [0x103794274]  transforms.cpp:343
    +                               ! : |         1 mlx::core::gpu::finalize(mlx::core::Stream)  (in slotstream) + 88  [0x1035b3b50]  eval.cpp:76
    +                               ! : |           1 mlx::core::metal::CommandEncoder::commit(std::function<void ()>)  (in slotstream) + 788  [0x1035a1ca4]  device.cpp:558
    +                               ! : |             1 -[AGXG17XFamilyCommandBuffer commit]  (in AGXMetalG17X) + 888  [0x117def984]
    +                               ! : |               1 -[IOGPUMetalCommandBuffer commit]  (in IOGPU) + 228  [0x1b2871478]
    +                               ! : |                 1 -[_MTLCommandQueue commitCommandBuffer:wake:]  (in Metal) + 268  [0x19986242c]
    +                               ! : |                   1 dispatch_source_merge_data  (in libdispatch.dylib) + 92  [0x18d029458]
    +                               ! : |                     1 _dispatch_event_loop_poke  (in libdispatch.dylib) + 336  [0x18d035eb0]
    +                               ! : |                       1 _dispatch_kq_poll  (in libdispatch.dylib) + 220  [0x18d036a64]
    +                               ! : |                         1 kevent_id  (in libsystem_kernel.dylib) + 8  [0x18d18da74]
    +                               ! : 1 MLXArray.asArray<A>(_:)  (in slotstream) + 212  [0x1039e9614]  MLXArray+Bytes.swift:130
    +                               ! :   1 Array.init<A>(unsafeUninitializedCapacity:initializingWith:)  (in slotstream) + 84  [0x1039e98ec]  /<compiler-generated>:0
    +                               ! :     1 ContiguousArray.init<A>(unsafeUninitializedCapacity:initializingWith:)  (in slotstream) + 164  [0x1039ea244]  /<compiler-generated>:0
    +                               ! :       1 partial apply for closure #1 in MLXArray.asArray<A>(_:)  (in slotstream) + 24  [0x1039ea72c]  /<compiler-generated>:0
    +                               ! :         1 closure #1 in MLXArray.asArray<A>(_:)  (in slotstream) + 276  [0x1039e9860]  MLXArray+Bytes.swift:133
    +                               ! :           1 MLXArray.copy(from:toContiguous:)  (in slotstream) + 292  [0x1039e9390]  MLXArray+Bytes.swift:70
    +                               ! :             1 _ContiguousArrayBuffer.init(_uninitializedCount:minimumCapacity:)  (in libswiftCore.dylib) + 60  [0x1a092c0fc]
    +                               ! :               1 __isPlatformOrVariantPlatformVersionAtLeast  (in libswiftCore.dylib) + 36  [0x1a0934070]
    +                               ! 97 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 9300  [0x103d29f0c]  VQModelProbe.swift:175
    +                               ! : 97 eval(_:)  (in slotstream) + 72  [0x103a3587c]  Transforms+Eval.swift:124
    +                               ! :   97 mlx_eval  (in slotstream) + 140  [0x102d9bf24]  transforms.cpp:71
    +                               ! :     79 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 128  [0x103794dcc]  transforms.cpp:378
    +                               ! :     | 79 mlx::core::array::wait()  (in slotstream) + 48  [0x102da7c24]  array.cpp:148
    +                               ! :     |   79 mlx::core::Event::wait()  (in slotstream) + 68  [0x1035b4a2c]  event.cpp:48
    +                               ! :     |     79 -[IOSurfaceSharedEvent waitUntilSignaledValue:timeoutMS:]  (in IOSurface) + 72  [0x199826184]
    +                               ! :     |       79 iokit_user_client_trap  (in IOKit) + 8  [0x19154cae0]
    +                               ! :     18 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 120  [0x103794dc4]  transforms.cpp:378
    +                               ! :       13 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 4404  [0x103793f94]  transforms.cpp:266
    +                               ! :       + 13 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 200  [0x1035b31f8]  eval.cpp:45
    +                               ! :       +   2 mlx::core::GatherAxis::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 816  [0x1035c67f0]  indexing.cpp:488
    +                               ! :       +   ! 1 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 56  [0x1035a06d0]  device.cpp:580
    +                               ! :       +   ! : 1 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithDispatchType:]  (in AGXMetalG17X) + 276  [0x117ded754]
    +                               ! :       +   ! :   1 -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithConfig:]  (in AGXMetalG17X) + 164  [0x117ded950]
    +                               ! :       +   ! :     1 -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 536  [0x117e4b848]
    +                               ! :       +   ! :       1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::beginComputePass(bool, eAGXDataBufferPools)  (in AGXMetalG17X) + 1524  [0x117e3f8d8]
    +                               ! :       +   ! 1 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 144  [0x1035a0728]  device.cpp:581
    +                               ! :       +   !   1 -[IOGPUMetalFence initWithDevice:]  (in IOGPU) + 120  [0x1b287cfd8]
    +                               ! :       +   !     1 -[IOGPUMTLFence initWithDevice:]  (in IOGPU) + 136  [0x1b288c9a8]
    +                               ! :       +   !       1 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! :       +   !         1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :       +   !           1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :       +   !             1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :       +   2 mlx::core::QuantizedMatmul::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 884  [0x103618898]  quantized.cpp:1834
    +                               ! :       +   ! 1 mlx::core::qmv(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, std::optional<mlx::core::array> const&, std::optional<mlx::core::array> const&, mlx::core::array&, int, int, int, int, int, mlx::core::metal::Device&, mlx::core::Stream const&, std::basic_string<char> const&)  (in slotstream) + 1492  [0x10360e904]  quantized.cpp:505
    +                               ! :       +   ! : 1 mlx::core::get_template_definition<std::basic_string<char>, int, int, bool, bool, int>(std::basic_string_view<char>, std::basic_string_view<char>, std::basic_string<char>, int, int, bool, bool, int)  (in slotstream) + 568  [0x10361c098]  kernels.h:450
    +                               ! :       +   ! :   1 fmt::v12::vformat(fmt::v12::basic_string_view<char>, fmt::v12::basic_format_args<fmt::v12::context>)  (in slotstream) + 128  [0x102d3c6ac]  format-inl.h:1445
    +                               ! :       +   ! :     1 fmt::v12::detail::parse_format_string<char, fmt::v12::detail::format_handler<char>>(fmt::v12::basic_string_view<char>, fmt::v12::detail::format_handler<char>&&)  (in slotstream) + 84  [0x102d3cba0]  base.h:1663
    +                               ! :       +   ! :       1 fmt::v12::detail::copy_noinline<char, char const*, fmt::v12::basic_appender<char>>(char const*, char const*, fmt::v12::basic_appender<char>)  (in slotstream) + 184  [0x102d3db10]  format.h:574
    +                               ! :       +   ! 1 mlx::core::qmv(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, std::optional<mlx::core::array> const&, std::optional<mlx::core::array> const&, mlx::core::array&, int, int, int, int, int, mlx::core::metal::Device&, mlx::core::Stream const&, std::basic_string<char> const&)  (in slotstream) + 1948  [0x10360eacc]  quantized.cpp:534
    +                               ! :       +   !   1 mlx::core::metal::CommandEncoder::dispatch_threadgroups(MTL::Size, MTL::Size)  (in slotstream) + 108  [0x1035a0d04]  device.cpp:413
    +                               ! :       +   !     1 -[AGXG17XFamilyComputeContext dispatchThreadgroups:threadsPerThreadgroup:]  (in AGXMetalG17X) + 596  [0x117e487a8]
    +                               ! :       +   !       1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 1100  [0x117e41204]
    +                               ! :       +   !         1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::bindBufferResourceToCommand(unsigned int, bool)  (in AGXMetalG17X) + 416  [0x117e42f98]
    +                               ! :       +   !           1 AGX::ComputeCoalescingResourceTracker<AGX::HAL300::Encoders, AGX::HAL300::Classes>::addResource(unsigned int, unsigned int)  (in AGXMetalG17X) + 240  [0x117e0cf60]
    +                               ! :       +   !             1 std::__hash_table<std::__hash_value_type<unsigned int, _ResourceTrackerBinding>>::__emplace_unique_key_args<unsigned int, std::piecewise_construct_t const&, std::tuple<unsigned int const&>, std::tuple<>>(unsigned int const&, std::piecewise_construct_t const&, std::tuple<unsigned int const&>&&, std::tuple<>&&)  (in AGXMetalG17X) + 252  [0x117db5c54]
    +                               ! :       +   !               1 operator_new_impl[abi:nqe210106](unsigned long, std::__type_descriptor_t)  (in libc++abi.dylib) + 72  [0x18d185500]
    +                               ! :       +   2 mlx::core::binary_op_gpu(std::vector<mlx::core::array> const&, mlx::core::array&, char const*, mlx::core::Stream const&)  (in slotstream) + 300  [0x103587c20]  binary.cpp:206
    +                               ! :       +   ! 2 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, mlx::core::array&, char const*, mlx::core::Stream const&)  (in slotstream) + 172  [0x103587a5c]  binary.cpp:193
    +                               ! :       +   !   1 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 768  [0x10358723c]  binary.cpp:108
    +                               ! :       +   !   : 1 mlx::core::get_binary_kernel(mlx::core::metal::Device&, std::basic_string<char> const&, mlx::core::Dtype, mlx::core::Dtype, char const*)  (in slotstream) + 408  [0x1035d0f74]  jit_kernels.cpp:145
    +                               ! :       +   !   1 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 1412  [0x1035874c0]  binary.cpp:161
    +                               ! :       +   !     1 mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 108  [0x1035a0d84]  device.cpp:421
    +                               ! :       +   !       1 -[AGXG17XFamilyComputeContext dispatchThreads:threadsPerThreadgroup:]  (in AGXMetalG17X) + 304  [0x117e478e8]
    +                               ! :       +   !         1 AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3EncodedInstr<AGXIotoInstruction_SPECLM_0>::AGX3EncodedInstr(AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3Instr<AGXIotoInstruction_SPECLM_0> const&)  (in AGXMetalG17X) + 2120  [0x117de5e90]
    +                               ! :       +   2 mlx::core::copy_gpu(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, mlx::core::Stream const&)  (in slotstream) + 96  [0x10359c880]  copy.cpp:14
    +                               ! :       +   ! 2 mlx::core::set_copy_output_data(mlx::core::array const&, mlx::core::array&, mlx::core::CopyType, std::function<mlx::core::allocator::Buffer (unsigned long)>)  (in slotstream) + 124  [0x1030e1f34]  copy.h:38
    +                               ! :       +   !   1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 120  [0x103585578]  allocator.cpp:130
    +                               ! :       +   !   : 1 mlx::core::BufferCache<MTL::Buffer>::reuse_from_cache(unsigned long)  (in slotstream) + 36  [0x10358594c]  buffer_cache.h:32
    +                               ! :       +   !   1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! :       +   !     1 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! :       +   !       1 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! :       +   !         1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
    +                               ! :       +   !           1 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
    +                               ! :       +   !             1 -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
    +                               ! :       +   !               1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! :       +   !                 1 IOGPUResourceCreate  (in IOGPU) + 164  [0x1b288b824]
    +                               ! :       +   !                   1 _CFRuntimeCreateInstance  (in CoreFoundation) + 840  [0x18d2128e8]
    +                               ! :       +   !                     1 objc_object::changeIsa(objc_class*)  (in libobjc.A.dylib) + 80  [0x18cd7f8c0]
    +                               ! :       +   1 mlx::core::ExpandDims::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 0  [0x10358408c]  primitives.cpp:153
    +                               ! :       +   1 mlx::core::QuantizedMatmul::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 108  [0x103618590]  quantized.cpp:1786
    +                               ! :       +   ! 1 mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
    +                               ! :       +   !   1 -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
    +                               ! :       +   !     1 -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
    +                               ! :       +   !       1 -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 388  [0x117d65e60]
    +                               ! :       +   !         1 -[IOGPUMetalBuffer initWithPrimaryBuffer:heapIndex:bufferIndex:bufferOffset:length:args:argsSize:gpuTag:]  (in IOGPU) + 276  [0x1b28701cc]
    +                               ! :       +   !           1 -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
    +                               ! :       +   !             1 IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
    +                               ! :       +   !               1 IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
    +                               ! :       +   !                 1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :       +   !                   1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :       +   !                     1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :       +   1 mlx::core::Softmax::eval_gpu(std::vector<mlx::core::array> const&, mlx::core::array&)  (in slotstream) + 716  [0x103631040]  softmax.cpp:60
    +                               ! :       +   ! 1 mlx::core::get_softmax_kernel(mlx::core::metal::Device&, std::basic_string<char> const&, bool, mlx::core::array const&)  (in slotstream) + 108  [0x1035d1d2c]  jit_kernels.cpp:329
    +                               ! :       +   !   1 _platform_memchr  (in libsystem_platform.dylib) + 0  [0x18d1d6e00]
    +                               ! :       +   1 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 1600  [0x10359f078]  custom_kernel.cpp:54
    +                               ! :       +   ! 1 mlx::core::metal::Device::get_kernel(std::basic_string<char> const&, MTL::Library*, std::basic_string<char> const&, std::vector<std::tuple<void const*, MTL::DataType, unsigned long>> const&, std::vector<MTL::Function*> const&)  (in slotstream) + 232  [0x1035a3f1c]  device.cpp:886
    +                               ! :       +   1 mlx::core::fast::CustomKernel::eval_gpu(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&)  (in slotstream) + 1800  [0x10359f140]  custom_kernel.cpp:61
    +                               ! :       +     1 mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 72  [0x1035a0810]  device.cpp:349
    +                               ! :       +       1 std::__hash_table<void const*>::__emplace_unique_key_args<void const*, void const*>(void const* const&, void const*&&)  (in slotstream) + 8  [0x1035a58c4]  __hash_table:1567
    +                               ! :       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 524  [0x10379306c]  transforms.cpp:104
    +                               ! :       + 1 mlx::core::Event::Event(mlx::core::Stream)  (in slotstream) + 104  [0x1035b496c]  event.cpp:43
    +                               ! :       +   1 mlx::core::metal::EventImpl::EventImpl(mlx::core::metal::Device&)  (in slotstream) + 60  [0x1035b47d4]  event.cpp:16
    +                               ! :       +     1 -[_MTLSharedEvent initWithOptions:]  (in Metal) + 44  [0x199a03134]
    +                               ! :       +       1 -[IOSurfaceSharedEvent initWithOptions:]  (in IOSurface) + 128  [0x199825e14]
    +                               ! :       +         1 IOConnectCallMethod  (in IOKit) + 176  [0x191530d84]
    +                               ! :       +           1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               ! :       +             1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               ! :       +               1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               ! :       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 2472  [0x103793808]  transforms.cpp:217
    +                               ! :       + 1 std::__hash_table<std::__hash_value_type<unsigned long, int>>::remove(std::__hash_const_iterator<std::__hash_node<std::__hash_value_type<unsigned long, int>, void*>*>)  (in slotstream) + 176  [0x10379d0cc]  __hash_table:1953
    +                               ! :       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 2488  [0x103793818]  transforms.cpp:217
    +                               ! :       + 1 _xzm_free  (in libsystem_malloc.dylib) + 264  [0x18cfec220]
    +                               ! :       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 4884  [0x103794174]  transforms.cpp:307
    +                               ! :       + 1 mlx::core::array::detach()  (in slotstream) + 80  [0x102da79c8]  array.cpp:118
    +                               ! :       +   1 _xzm_free  (in libsystem_malloc.dylib) + 352  [0x18cfec278]
    +                               ! :       +     1 _platform_memset  (in libsystem_platform.dylib) + 180  [0x18d1d9144]
    +                               ! :       1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 5104  [0x103794250]  transforms.cpp:340
    +                               ! :         1 mlx::core::Event::signal(mlx::core::Stream)  (in slotstream) + 296  [0x1035b4da8]  event.cpp:70
    +                               ! :           1 mlx::core::metal::CommandEncoder::signal_event(mlx::core::Event, unsigned long long)  (in slotstream) + 36  [0x1035a1798]  device.cpp:500
    +                               ! :             1 mlx::core::metal::CommandEncoder::end_encoding()  (in slotstream) + 1308  [0x1035a12d4]  device.cpp:471
    +                               ! :               1 std::__function::__func<mlx::core::metal::CommandEncoder::end_encoding()::$_0, void (MTL::CommandBuffer*)>::__func[abi:nqe210106](mlx::core::metal::CommandEncoder::end_encoding()::$_0 const&)  (in slotstream) + 188  [0x1035a6d38]  function.h:163
    +                               ! :                 1 std::unordered_set<void const*>::unordered_set(std::unordered_set<void const*> const&)  (in slotstream) + 216  [0x1035a6e8c]  unordered_set:1075
    +                               ! :                   1 std::__hash_table<void const*>::__do_rehash<true>(unsigned long)  (in slotstream) + 88  [0x1035a5bf0]  __hash_table:1773
    +                               ! :                     1 _platform_memset  (in libsystem_platform.dylib) + 160  [0x18d1d9130]
    +                               ! 28 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 580  [0x103d27cfc]  VQModelProbe.swift:110
    +                               ! : 28 PLELayer.callAsFunction(_:history:nNew:cache:)  (in slotstream) + 108  [0x103bc5f84]  Layers.swift:1929
    +                               ! :   28 PLELayer.transform(_:history:nNew:cache:)  (in slotstream) + 64  [0x103bc63b4]  Layers.swift:1933
    +                               ! :     28 partial apply for closure #1 in VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 24  [0x103d2a2e4]  /<compiler-generated>:0
    +                               ! :       26 VQCheckpoint.pleEmbedding(history:nNew:weights:)  (in slotstream) + 4480  [0x103d1b868]  VQCheckpoint.swift:443
    +                               ! :       | 15 specialized VQPLERows.gather(_:shouldContinue:)  (in slotstream) + 320  [0x103d2aa50]  VQPLERows.swift:51
    +                               ! :       | + 15 partial apply for closure #1 in VQCheckpoint.pleTable(_:shouldContinue:)  (in slotstream) + 12  [0x103d2277c]
    +                               ! :       | +   15 partial apply for closure #1 in VQCheckpoint.pleTable(_:shouldContinue:)  (in slotstream) + 12  [0x103d20324]
    +                               ! :       | +     15 partial apply for closure #1 in VQCheckpoint.pleTable(_:shouldContinue:)  (in slotstream) + 36  [0x103d21008]
    +                               ! :       | +       14 closure #1 in VQCheckpoint.pleTable(_:shouldContinue:)  (in slotstream) + 132  [0x103d18c1c]  VQCheckpoint.swift:341
    +                               ! :       | +       ! 14 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +                               ! :       | +       !   14 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +                               ! :       | +       !     14 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +                               ! :       | +       1 closure #1 in VQCheckpoint.pleTable(_:shouldContinue:)  (in slotstream) + 152  [0x103d18c30]  /<compiler-generated>:0
    +                               ! :       | +         1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 148  [0x1a098de2c]
    +                               ! :       | 11 specialized VQPLERows.gather(_:shouldContinue:)  (in slotstream) + 360  [0x103d2aa78]  VQPLERows.swift:53
    +                               ! :       |   11 partial apply for closure #2 in VQCheckpoint.pleTable(_:shouldContinue:)  (in slotstream) + 12  [0x103d22874]
    +                               ! :       |     11 partial apply for closure #2 in VQCheckpoint.pleTable(_:shouldContinue:)  (in slotstream) + 20  [0x103d20340]  /<compiler-generated>:0
    +                               ! :       |       11 closure #2 in VQCheckpoint.pleTable(_:shouldContinue:)  (in slotstream) + 144  [0x103d18cec]  VQCheckpoint.swift:342
    +                               ! :       |         11 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +                               ! :       |           11 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 840  [0x103d4778c]  /<compiler-generated>:0
    +                               ! :       |             11 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +                               ! :       2 VQCheckpoint.pleEmbedding(history:nNew:weights:)  (in slotstream) + 4300  [0x103d1b7b4]  VQCheckpoint.swift:442
    +                               ! :         1 specialized VQCheckpoint.pleTable(_:shouldContinue:)  (in slotstream) + 3540  [0x103d17b8c]  VQCheckpoint.swift:340
    +                               ! :         + 1 closure #2 in VQPLERows.init(rowCount:dimensions:entries:codebook:readCodes:readScales:)  (in slotstream) + 164  [0x103d2c590]  VQPLERows.swift:30
    +                               ! :         1 specialized VQCheckpoint.pleTable(_:shouldContinue:)  (in slotstream) + 3568  [0x103d17ba8]  VQCheckpoint.swift:340
    +                               ! 9 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 3952  [0x103d28a28]  VQModelProbe.swift:137
    +                               ! : 3 QSAAttention.callAsFunction(_:rope:cache:idxCache:lastQueryOnly:)  (in slotstream) + 4588  [0x103bb5b60]  Layers.swift:755
    +                               ! : | 1 ropePartial(_:_:_:)  (in slotstream) + 464  [0x103babe90]  Layers.swift:169
    +                               ! : | + 1 MLXArray.subscript.getter  (in slotstream) + 416  [0x1039f237c]
    +                               ! : | +   1 getItemND(src:operations:stream:)  (in slotstream) + 100  [0x1039f10a0]  MLXArray+Indexing.swift:587
    +                               ! : | +     1 expandEllipsisOperations(shape:operations:)  (in slotstream) + 460  [0x1039f2930]  MLXArray+Indexing.swift:512
    +                               ! : | +       1 specialized countNonNewAxisOperations<A>(_:)  (in slotstream) + 20  [0x1039f653c]  MLXArray+Indexing.swift:482
    +                               ! : | 1 ropePartial(_:_:_:)  (in slotstream) + 700  [0x103babf7c]  Layers.swift:172
    +                               ! : | + 1 MLXArray.subscript.getter  (in slotstream) + 416  [0x1039f237c]
    +                               ! : | +   1 getItemND(src:operations:stream:)  (in slotstream) + 648  [0x1039f12c4]  MLXArray+Indexing.swift:680
    +                               ! : | 1 ropePartial(_:_:_:)  (in slotstream) + 808  [0x103babfe8]  Layers.swift:173
    +                               ! : |   1 static MLXArray.- prefix(_:)  (in slotstream) + 212  [0x103a00058]
    +                               ! : |     1 swift_allocObject  (in libswiftCore.dylib) + 136  [0x1a0924b48]
    +                               ! : |       1 swift::swift_slowAllocTyped(unsigned long, unsigned long, unsigned long long)  (in libswiftCore.dylib) + 56  [0x1a098b5d8]
    +                               ! : |         1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 176  [0x18cff0fec]
    +                               ! : 2 QSAAttention.callAsFunction(_:rope:cache:idxCache:lastQueryOnly:)  (in slotstream) + 3420  [0x103bb56d0]  Layers.swift:751
    +                               ! : | 1 specialized static VQRotaryTable.angles(_:)  (in slotstream) + 240  [0x103d3d558]  VQRotaryTable.swift:34
    +                               ! : | + 1 MLXArray.asArray<A>(_:)  (in slotstream) + 148  [0x1039e95d4]  MLXArray+Bytes.swift:128
    +                               ! : | +   1 mlx_array_eval  (in slotstream) + 24  [0x102d537f8]  array.cpp:350
    +                               ! : | +     1 mlx::core::array::eval()  (in slotstream) + 176  [0x102da7d54]  array.cpp:158
    +                               ! : | +       1 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 120  [0x103794dc4]  transforms.cpp:378
    +                               ! : | +         1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 5140  [0x103794274]  transforms.cpp:343
    +                               ! : | +           1 mlx::core::gpu::finalize(mlx::core::Stream)  (in slotstream) + 88  [0x1035b3b50]  eval.cpp:76
    +                               ! : | +             1 mlx::core::metal::CommandEncoder::commit(std::function<void ()>)  (in slotstream) + 788  [0x1035a1ca4]  device.cpp:558
    +                               ! : | +               1 -[AGXG17XFamilyCommandBuffer commit]  (in AGXMetalG17X) + 888  [0x117def984]
    +                               ! : | +                 1 -[IOGPUMetalCommandBuffer commit]  (in IOGPU) + 228  [0x1b2871478]
    +                               ! : | +                   1 -[_MTLCommandQueue commitCommandBuffer:wake:]  (in Metal) + 268  [0x19986242c]
    +                               ! : | +                     1 dispatch_source_merge_data  (in libdispatch.dylib) + 92  [0x18d029458]
    +                               ! : | +                       1 _dispatch_event_loop_poke  (in libdispatch.dylib) + 336  [0x18d035eb0]
    +                               ! : | +                         1 _dispatch_kq_poll  (in libdispatch.dylib) + 220  [0x18d036a64]
    +                               ! : | +                           1 kevent_id  (in libsystem_kernel.dylib) + 8  [0x18d18da74]
    +                               ! : | 1 specialized static VQRotaryTable.angles(_:)  (in slotstream) + 644  [0x103d3d6ec]  VQRotaryTable.swift:36
    +                               ! : |   1 MLXArray.subscript.getter  (in slotstream) + 332  [0x1039f2328]
    +                               ! : |     1 getItem(src:operation:stream:)  (in slotstream) + 180  [0x1039f0b84]  MLXArray+Indexing.swift:564
    +                               ! : |       1 mlx_take_axis  (in slotstream) + 72  [0x102d94544]  ops.cpp:4083
    +                               ! : |         1 mlx::core::take(mlx::core::array const&, mlx::core::array const&, int, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 1576  [0x1037188e4]  ops.cpp:3707
    +                               ! : |           1 mlx::core::squeeze(mlx::core::array const&, int, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 112  [0x1036e6bb4]  ops.cpp:658
    +                               ! : |             1 mlx::core::squeeze_impl(mlx::core::array const&, std::vector<int>, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 448  [0x1036e6510]  ops.cpp:640
    +                               ! : |               1 mlx::core::array::array(mlx::core::SmallVector<int, 10ul>, mlx::core::Dtype, std::shared_ptr<mlx::core::Primitive>, std::vector<mlx::core::array>)  (in slotstream) + 52  [0x102da440c]  array.cpp:25
    +                               ! : |                 1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |                   1 <deduplicated_symbol>  (in libsystem_malloc.dylib) + 196  [0x18cfeb220]
    +                               ! : 1 QSAAttention.callAsFunction(_:rope:cache:idxCache:lastQueryOnly:)  (in slotstream) + 1492  [0x103bb4f48]  Layers.swift:742
    +                               ! : | 1 MLXArray.subscript.getter  (in slotstream) + 416  [0x1039f237c]
    +                               ! : |   1 getItemND(src:operations:stream:)  (in slotstream) + 1796  [0x1039f1740]  MLXArray+Indexing.swift:0
    +                               ! : |     1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 12  [0x1a098dda4]
    +                               ! : 1 QSAAttention.callAsFunction(_:rope:cache:idxCache:lastQueryOnly:)  (in slotstream) + 7000  [0x103bb64cc]  Layers.swift:824
    +                               ! : | 1 static QSAAttention.attend(q:k:v:sparse:base:scale:block:selection:selectedAttention:onSelected:fusedPrefillAttention:onFused:splitRows:onSplit:)  (in slotstream) + 4784  [0x103baaf04]  Layers.swift:964
    +                               ! : |   1 static MLXFast.scaledDotProductAttention(queries:keys:values:scale:mask:sinks:forceFused:stream:)  (in slotstream) + 464  [0x103a07ebc]  MLXFast.swift:219
    +                               ! : |     1 mlx_fast_scaled_dot_product_attention  (in slotstream) + 424  [0x102d6c810]  fast.cpp:637
    +                               ! : |       1 mlx::core::fast::scaled_dot_product_attention(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, float, std::basic_string<char> const&, std::optional<mlx::core::array>, std::optional<mlx::core::array> const&, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 3604  [0x1036ae2e8]  fast.cpp:951
    +                               ! : |         1 mlx::core::fast::ScaledDotProductAttention::ScaledDotProductAttention(mlx::core::Stream, std::function<std::vector<mlx::core::array> (std::vector<mlx::core::array>)>, float, bool, bool, bool, bool)  (in slotstream) + 0  [0x10369d35c]  fast_primitives.h:283
    +                               ! : 1 QSAAttention.callAsFunction(_:rope:cache:idxCache:lastQueryOnly:)  (in slotstream) + 7252  [0x103bb65c8]  Layers.swift:837
    +                               ! : | 1 MLXArray.reshaped<A>(_:stream:)  (in slotstream) + 160  [0x103a03da4]
    +                               ! : |   1 mlx_reshape  (in slotstream) + 384  [0x102d8c8ec]  ops.cpp:3075
    +                               ! : |     1 mlx::core::reshape(mlx::core::array const&, mlx::core::SmallVector<int, 10ul>, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 808  [0x1036e4f54]  ops.cpp:463
    +                               ! : |       1 mlx::core::array::array(mlx::core::SmallVector<int, 10ul>, mlx::core::Dtype, std::shared_ptr<mlx::core::Primitive>, std::vector<mlx::core::array>)  (in slotstream) + 104  [0x102da4440]  array.cpp:25
    +                               ! : |         1 std::construct_at[abi:nqe210106]<mlx::core::array::ArrayDesc, mlx::core::SmallVector<int, 10ul>, mlx::core::Dtype&, std::shared_ptr<mlx::core::Primitive>, std::vector<mlx::core::array>, mlx::core::array::ArrayDesc*>(mlx::core::array::ArrayDesc*, mlx::core::SmallVector<int, 10ul>&&, mlx::core::Dtype&, std::shared_ptr<mlx::core::Primitive>&&, std::vector<mlx::core::array>&&)  (in slotstream) + 260  [0x102da9814]  construct_at.h:38
    +                               ! : |           1 mlx::core::array::ArrayDesc::ArrayDesc(mlx::core::SmallVector<int, 10ul>, mlx::core::Dtype, std::shared_ptr<mlx::core::Primitive>, std::vector<mlx::core::array>)  (in slotstream) + 316  [0x102da8600]  array.cpp:274
    +                               ! : |             1 mlx::core::array::ArrayDesc::init()  (in slotstream) + 168  [0x102da8284]  array.cpp:254
    +                               ! : 1 QSAAttention.callAsFunction(_:rope:cache:idxCache:lastQueryOnly:)  (in slotstream) + 7340  [0x103bb6620]  Layers.swift:838
    +                               ! :   1 specialized static VQArithmetic.sigmoid(_:)  (in slotstream) + 500  [0x103d0d6e8]  VQArithmetic.swift:42
    +                               ! :     1 MLXFast.MLXFastKernel.callAsFunction<A, B>(_:template:grid:threadGroup:outputShapes:outputDTypes:initValue:verbose:stream:)  (in slotstream) + 1672  [0x103a0945c]  MLXFastKernel.swift:154
    +                               ! :       1 mlx_fast_metal_kernel_apply  (in slotstream) + 244  [0x102d6bb98]  fast.cpp:525
    +                               ! :         1 std::__function::__func<mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)>::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>&&, std::tuple<int, int, int>&&, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>&&, std::optional<float>&&, bool&&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>&&)  (in slotstream) + 80  [0x102db2e88]  function.h:174
    +                               ! :           1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>> const&, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>) const  (in slotstream) + 488  [0x102db3328]  metal_kernel.cpp:301
    +                               ! :             1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! :               1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 692  [0x18cff11f0]
    +                               ! 8 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 1788  [0x103d281b4]  VQModelProbe.swift:121
    +                               ! : 3 GatedResidual.callAsFunction(_:)  (in slotstream) + 1724  [0x103bc57b8]  Layers.swift:1854
    +                               ! : | 3 static MLXArray.+ infix<A>(_:_:)  (in slotstream) + 112  [0x103a00934]
    +                               ! : |   2 specialized MLXArray.__allocating_init<A>(_:dtype:)  (in slotstream) + 212  [0x1039bc5e8]  MLXArray+Init.swift:274
    +                               ! : |   + 2 swift_dynamicCast  (in libswiftCore.dylib) + 96  [0x1a09277ac]
    +                               ! : |   +   2 tryCast(swift::OpaqueValue*, swift::TargetMetadata<swift::InProcess> const*, swift::OpaqueValue*, swift::TargetMetadata<swift::InProcess> const*, swift::TargetMetadata<swift::InProcess> const*&, swift::TargetMetadata<swift::InProcess> const*&, bool, bool, bool)  (in libswiftCore.dylib) + 1008  [0x1a0980d20]
    +                               ! : |   +     2 tryCastToConstrainedOpaqueExistential(swift::OpaqueValue*, swift::TargetMetadata<swift::InProcess> const*, swift::OpaqueValue*, swift::TargetMetadata<swift::InProcess> const*, swift::TargetMetadata<swift::InProcess> const*&, swift::TargetMetadata<swift::InProcess> const*&, bool, bool, bool)  (in libswiftCore.dylib) + 60  [0x1a0983180]
    +                               ! : |   +       2 _conformsToProtocols(swift::OpaqueValue const*, swift::TargetMetadata<swift::InProcess> const*, swift::TargetExistentialTypeMetadata<swift::InProcess> const*, swift::TargetWitnessTable<swift::InProcess> const**, bool)  (in libswiftCore.dylib) + 176  [0x1a0984588]
    +                               ! : |   +         2 swift::_conformsToProtocolInContext(swift::OpaqueValue const*, swift::TargetMetadata<swift::InProcess> const*, swift::TargetProtocolDescriptorRef<swift::InProcess>, swift::TargetWitnessTable<swift::InProcess> const**, bool)  (in libswiftCore.dylib) + 40  [0x1a097b8f0]
    +                               ! : |   +           2 swift::_conformsToProtocol(swift::OpaqueValue const*, swift::TargetMetadata<swift::InProcess> const*, swift::TargetProtocolDescriptorRef<swift::InProcess>, swift::TargetWitnessTable<swift::InProcess> const**, swift::ConformanceExecutionContext*)  (in libswiftCore.dylib) + 152  [0x1a097b7e8]
    +                               ! : |   +             2 swift_conformsToProtocolWithExecutionContext  (in libswiftCore.dylib) + 72  [0x1a09d88d8]
    +                               ! : |   +               1 swift_conformsToProtocolMaybeInstantiateSuperclasses(swift::TargetMetadata<swift::InProcess> const*, swift::TargetProtocolDescriptor<swift::InProcess> const*, bool)  (in libswiftCore.dylib) + 228  [0x1a09da654]
    +                               ! : |   +               ! 1 getContextDescriptor(swift::TargetMetadata<swift::InProcess> const*)  (in libswiftCore.dylib) + 0  [0x1a09da424]
    +                               ! : |   +               1 swift_conformsToProtocolMaybeInstantiateSuperclasses(swift::TargetMetadata<swift::InProcess> const*, swift::TargetProtocolDescriptor<swift::InProcess> const*, bool)  (in libswiftCore.dylib) + 972  [0x1a09da93c]
    +                               ! : |   +                 1 dyld4::APIs::_dyld_find_protocol_conformance(void const*, void const*, void const*) const  (in dyld) + 164  [0x18cdf3e74]
    +                               ! : |   +                   1 <deduplicated_symbol>  (in dyld) + 24  [0x18cdff2f8]
    +                               ! : |   +                     1 <deduplicated_symbol>  (in dyld) + 40  [0x18cdff364]
    +                               ! : |   +                       1 <deduplicated_symbol>  (in dyld) + 0  [0x18ce4c40c]
    +                               ! : |   1 specialized MLXArray.__allocating_init<A>(_:dtype:)  (in slotstream) + 4652  [0x1039bd740]  MLXArray+Init.swift:0
    +                               ! : |     1 mlx_array_new_float32  (in slotstream) + 52  [0x102d5068c]  array.cpp:115
    +                               ! : |       1 mlx::core::array::array<float>(float, mlx::core::Dtype)  (in slotstream) + 160  [0x102d54cf8]  array.h:540
    +                               ! : |         1 mlx::core::array::init<float*>(float*)  (in slotstream) + 128  [0x102d54e04]  array.h:600
    +                               ! : |           1 mlx::core::array::set_data(mlx::core::allocator::Buffer, std::function<void (mlx::core::allocator::Buffer)>)  (in slotstream) + 84  [0x102da76f8]  array.cpp:170
    +                               ! : |             1 std::construct_at[abi:nqe210106]<mlx::core::array::Data, mlx::core::allocator::Buffer&, std::function<void (mlx::core::allocator::Buffer)>&, mlx::core::array::Data*>(mlx::core::array::Data*, mlx::core::allocator::Buffer&, std::function<void (mlx::core::allocator::Buffer)>&)  (in slotstream) + 44  [0x102da9eb8]  construct_at.h:38
    +                               ! : 2 GatedResidual.callAsFunction(_:)  (in slotstream) + 148  [0x103bc5190]  Layers.swift:1842
    +                               ! : | 1 RMSNorm.callAsFunction(_:compiledFinish:)  (in slotstream) + 616  [0x103bab3b0]  Layers.swift:42
    +                               ! : | + 1 static MLXFast.rmsNorm(_:weight:eps:stream:)  (in slotstream) + 132  [0x103a087d8]
    +                               ! : | +   1 mlx_fast_rms_norm  (in slotstream) + 120  [0x102d6bfe0]  fast.cpp:551
    +                               ! : | +     1 mlx::core::fast::rms_norm(mlx::core::array const&, std::optional<mlx::core::array> const&, float, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 388  [0x1036a53d4]  fast.cpp:111
    +                               ! : | +       1 mlx::core::array::array<int>(int, mlx::core::Dtype)  (in slotstream) + 148  [0x102d5752c]  array.h:539
    +                               ! : | +         1 mlx::core::SmallVector<int, 10ul>::free_storage()  (in slotstream) + 0  [0x102d54c3c]  small_vector.h:473
    +                               ! : | 1 RMSNorm.callAsFunction(_:compiledFinish:)  (in slotstream) + 672  [0x103bab3e8]  Layers.swift:42
    +                               ! : |   1 MLXArray.reshaped<A>(_:stream:)  (in slotstream) + 120  [0x103a03d7c]
    +                               ! : |     1 Sequence<>.asInt32.getter  (in slotstream) + 68  [0x1039e20e8]  Foundation+Util.swift:28
    +                               ! : |       1 Sequence.map<A, B>(_:)  (in slotstream) + 584  [0x102cf8808]  /<compiler-generated>:0
    +                               ! : |         1 protocol witness for IteratorProtocol.next() in conformance IndexingIterator<A>  (in libswiftCore.dylib) + 460  [0x1a0acb278]
    +                               ! : |           1 protocol witness for Collection.subscript.read in conformance [A]  (in libswiftCore.dylib) + 44  [0x1a0a69600]
    +                               ! : |             1 _xzm_xzone_malloc  (in libsystem_malloc.dylib) + 24  [0x18cfeb968]
    +                               ! : 1 GatedResidual.callAsFunction(_:)  (in slotstream) + 1752  [0x103bc57d4]  /<compiler-generated>:0
    +                               ! : | 1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               ! : |   1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               ! : |     1 MLXArray.__deallocating_deinit  (in slotstream) + 56  [0x103a052a4]  MLXArray.swift:0
    +                               ! : |       1 _xzm_free  (in libsystem_malloc.dylib) + 196  [0x18cfec1dc]
    +                               ! : 1 GatedResidual.callAsFunction(_:)  (in slotstream) + 552  [0x103bc5324]  Layers.swift:1846
    +                               ! : | 1 relu(_:)  (in slotstream) + 40  [0x103a47320]
    +                               ! : |   1 closure #2 in compile(inputs:outputs:shapeless:_:)  (in slotstream) + 92  [0x103a2e2c0]  Transforms+Compile.swift:313
    +                               ! : |     1 CompiledFunction.call(_:)  (in slotstream) + 144  [0x103a2c934]  Transforms+Compile.swift:141
    +                               ! : |       1 CompiledFunction.innerCall(_:)  (in slotstream) + 932  [0x103a2ccf8]  Transforms+Compile.swift:240
    +                               ! : |         1 specialized closure #1 in new_mlx_vector_array<A>(_:)  (in slotstream) + 268  [0x1039e3370]  Cmlx+Util.swift:9
    +                               ! : |           1 swift_beginAccess  (in libswiftCore.dylib) + 84  [0x1a0922c24]
    +                               ! : |             1 swift::runtime::AccessSet::insert(swift::runtime::Access*, void*, void*, swift::ExclusivityFlags)  (in libswiftCore.dylib) + 112  [0x1a0987974]
    +                               ! : 1 GatedResidual.callAsFunction(_:)  (in slotstream) + 1620  [0x103bc5750]  Layers.swift:1854
    +                               ! :   1 static MLXArray.+ infix<A>(_:_:)  (in slotstream) + 264  [0x103a007bc]
    +                               ! :     1 mlx_divide  (in slotstream) + 68  [0x102d80eb4]  ops.cpp:1315
    +                               ! :       1 mlx::core::divide(mlx::core::array const&, mlx::core::array const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 480  [0x1036de7dc]  ops.cpp:3126
    +                               ! :         1 mlx::core::broadcast_arrays(std::vector<mlx::core::array> const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 180  [0x1036e20e4]  ops.cpp:1899
    +                               ! :           1 mlx::core::Broadcast::output_shape(std::vector<mlx::core::array> const&)  (in slotstream) + 532  [0x103749398]  primitives.cpp:884
    +                               ! :             1 _platform_memmove  (in libsystem_platform.dylib) + 444  [0x18d1d951c]
    +                               ! 8 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 1956  [0x103d2825c]  VQModelProbe.swift:125
    +                               ! : 2 GDNLayer.callAsFunction(_:cache:)  (in slotstream) + 5004  [0x103bbb28c]  Layers.swift:1255
    +                               ! : | 2 specialized static VQArithmetic.sigmoid(_:)  (in slotstream) + 500  [0x103d0d6e8]  VQArithmetic.swift:42
    +                               ! : |   1 MLXFast.MLXFastKernel.callAsFunction<A, B>(_:template:grid:threadGroup:outputShapes:outputDTypes:initValue:verbose:stream:)  (in slotstream) + 132  [0x103a08e58]  <stdin>:0
    +                               ! : |   + 1 _swift_getGenericMetadata(swift::MetadataRequest, void const* const*, swift::TargetTypeContextDescriptor<swift::InProcess> const*)  (in libswiftCore.dylib) + 264  [0x1a0997c00]
    +                               ! : |   +   1 swift::LockingConcurrentMap<swift::GenericCacheEntry, swift::LockingConcurrentMapStorage<swift::GenericCacheEntry, (unsigned short)14>>::getOrInsert<swift::MetadataCacheKey, swift::MetadataRequest&, swift::TargetTypeContextDescriptor<swift::InProcess> const*&, void const* const*&>(swift::MetadataCacheKey, swift::MetadataRequest&, swift::TargetTypeContextDescriptor<swift::InProcess> const*&, void const* const*&)  (in libswiftCore.dylib) + 88  [0x1a09ab0a0]
    +                               ! : |   +     1 swift::StableAddressConcurrentReadableHashMap<swift::GenericCacheEntry, swift::TaggedMetadataAllocator<(unsigned short)14>, swift::Mutex>::getOrInsert<swift::MetadataCacheKey, swift::MetadataWaitQueue::Worker&, swift::MetadataRequest&, swift::TargetTypeContextDescriptor<swift::InProcess> const*&, void const* const*&>(swift::MetadataCacheKey, swift::MetadataWaitQueue::Worker&, swift::MetadataRequest&, swift::TargetTypeContextDescriptor<swift::InProcess> const*&, void const* const*&)  (in libswiftCore.dylib) + 104  [0x1a09ab2fc]
    +                               ! : |   +       1 swift::MetadataCacheKey::operator==(swift::MetadataCacheKey const&) const  (in libswiftCore.dylib) + 128  [0x1a09a742c]
    +                               ! : |   +         1 _platform_memcmp  (in libsystem_platform.dylib) + 0  [0x18d1d6f10]
    +                               ! : |   1 MLXFast.MLXFastKernel.callAsFunction<A, B>(_:template:grid:threadGroup:outputShapes:outputDTypes:initValue:verbose:stream:)  (in slotstream) + 1048  [0x103a091ec]  MLXFastKernel.swift:0
    +                               ! : |     1 Zip2Sequence.Iterator.next()  (in libswiftCore.dylib) + 820  [0x1a0c2fb28]
    +                               ! : |       1 protocol witness for IteratorProtocol.next() in conformance IndexingIterator<A>  (in libswiftCore.dylib) + 88  [0x1a0acb104]
    +                               ! : |         1 swift_getAssociatedTypeWitness  (in libswiftCore.dylib) + 28  [0x1a0929564]
    +                               ! : 2 GDNLayer.callAsFunction(_:cache:)  (in slotstream) + 6768  [0x103bbb970]  Layers.swift:1296
    +                               ! : | 1 RMSNormGated.callAsFunction(_:gate:)  (in slotstream) + 108  [0x103bab914]  Layers.swift:63
    +                               ! : | + 1 MLXArray.asType(_:stream:)  (in slotstream) + 148  [0x103a04dc0]  MLXArray.swift:498
    +                               ! : | +   1 mlx_astype  (in slotstream) + 204  [0x102d7be74]  ops.cpp:451
    +                               ! : | +     1 mlx::core::array::~array()  (in slotstream) + 28  [0x102da8074]  array.cpp:212
    +                               ! : | 1 RMSNormGated.callAsFunction(_:gate:)  (in slotstream) + 208  [0x103bab978]  Layers.swift:65
    +                               ! : |   1 MLXArray.asType(_:stream:)  (in slotstream) + 148  [0x103a04dc0]  MLXArray.swift:498
    +                               ! : |     1 mlx_astype  (in slotstream) + 100  [0x102d7be0c]  ops.cpp:453
    +                               ! : |       1 mlx::core::astype(mlx::core::array, mlx::core::Dtype, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 48  [0x1036de5d0]  ops.cpp:316
    +                               ! : |         1 mlx::core::astype(mlx::core::array, mlx::core::Dtype, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 768  [0x1036e05d8]  ops.cpp:308
    +                               ! : |           1 mlx::core::array::array(mlx::core::SmallVector<int, 10ul>, mlx::core::Dtype, std::shared_ptr<mlx::core::Primitive>, std::vector<mlx::core::array>)  (in slotstream) + 104  [0x102da4440]  array.cpp:25
    +                               ! : |             1 std::construct_at[abi:nqe210106]<mlx::core::array::ArrayDesc, mlx::core::SmallVector<int, 10ul>, mlx::core::Dtype&, std::shared_ptr<mlx::core::Primitive>, std::vector<mlx::core::array>, mlx::core::array::ArrayDesc*>(mlx::core::array::ArrayDesc*, mlx::core::SmallVector<int, 10ul>&&, mlx::core::Dtype&, std::shared_ptr<mlx::core::Primitive>&&, std::vector<mlx::core::array>&&)  (in slotstream) + 180  [0x102da97c4]  construct_at.h:38
    +                               ! : |               1 _platform_memmove  (in libsystem_platform.dylib) + 428  [0x18d1d950c]
    +                               ! : 1 GDNLayer.callAsFunction(_:cache:)  (in slotstream) + 1972  [0x103bba6b4]  Layers.swift:1222
    +                               ! : | 1 specialized static QLinear.withReferenceRows(_:minimumRows:_:)  (in slotstream) + 1248  [0x103d7e38c]  Weights.swift:59
    +                               ! : |   1 QLinear.callAsFunction(_:)  (in slotstream) + 1164  [0x103d74930]  Weights.swift:42
    +                               ! : |     1 quantizedMatmul(_:_:scales:biases:transpose:groupSize:bits:mode:stream:)  (in slotstream) + 556  [0x103a22f00]
    +                               ! : |       1 mlx_quantized_matmul  (in slotstream) + 392  [0x102d8bd38]  ops.cpp:2967
    +                               ! : |         1 mlx::core::quantized_matmul(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, std::optional<mlx::core::array> const&, bool, std::optional<int>, std::optional<int>, std::basic_string<char> const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 1208  [0x10372294c]  ops.cpp:4826
    +                               ! : |           1 _platform_memmove  (in libsystem_platform.dylib) + 460  [0x18d1d952c]
    +                               ! : 1 GDNLayer.callAsFunction(_:cache:)  (in slotstream) + 2348  [0x103bba82c]  Layers.swift:1228
    +                               ! : | 1 concatenated<A>(_:axis:stream:)  (in slotstream) + 60  [0x103a2459c]
    +                               ! : |   1 new_mlx_vector_array<A>(_:)  (in slotstream) + 96  [0x1039ba114]  Cmlx+Util.swift:8
    +                               ! : |     1 withExtendedLifetime<A, B, C>(_:_:)  (in slotstream) + 84  [0x1039ba27c]  /<compiler-generated>:0
    +                               ! : |       1 partial apply for closure #1 in new_mlx_vector_array<A>(_:)  (in slotstream) + 24  [0x1039bb0b0]  /<compiler-generated>:0
    +                               ! : |         1 closure #1 in new_mlx_vector_array<A>(_:)  (in slotstream) + 96  [0x1039ba18c]  Cmlx+Util.swift:9
    +                               ! : |           1 Collection.map<A, B>(_:)  (in slotstream) + 312  [0x102cecb20]  /<compiler-generated>:0
    +                               ! : |             1 __swift_instantiateCanonicalPrespecializedGenericMetadata  (in libswiftCore.dylib) + 40  [0x1a0db8c84]
    +                               ! : |               1 _swift_getGenericMetadata(swift::MetadataRequest, void const* const*, swift::TargetTypeContextDescriptor<swift::InProcess> const*)  (in libswiftCore.dylib) + 208  [0x1a0997bc8]
    +                               ! : 1 GDNLayer.callAsFunction(_:cache:)  (in slotstream) + 3620  [0x103bbad24]  Layers.swift:1240
    +                               ! : | 1 MLXArray.subscript.getter  (in slotstream) + 416  [0x1039f237c]
    +                               ! : |   1 getItemND(src:operations:stream:)  (in slotstream) + 100  [0x1039f10a0]  MLXArray+Indexing.swift:587
    +                               ! : |     1 expandEllipsisOperations(shape:operations:)  (in slotstream) + 808  [0x1039f2a8c]  MLXArray+Indexing.swift:517
    +                               ! : |       1 specialized Array.append<A>(contentsOf:)  (in slotstream) + 136  [0x1039db3c4]  /<compiler-generated>:0
    +                               ! : |         1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               ! : |           1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               ! : |             1 _ContiguousArrayStorage.__deallocating_deinit  (in libswiftCore.dylib) + 96  [0x1a092af04]
    +                               ! : |               1 swift_arrayDestroy  (in libswiftCore.dylib) + 192  [0x1a09292b4]
    +                               ! : 1 GDNLayer.callAsFunction(_:cache:)  (in slotstream) + 5948  [0x103bbb63c]  Layers.swift:1255
    +                               ! :   1 MLXFast.MLXFastKernel.callAsFunction<A, B>(_:template:grid:threadGroup:outputShapes:outputDTypes:initValue:verbose:stream:)  (in slotstream) + 1672  [0x103a0945c]  MLXFastKernel.swift:154
    +                               ! :     1 mlx_fast_metal_kernel_apply  (in slotstream) + 244  [0x102d6bb98]  fast.cpp:525
    +                               ! :       1 std::__function::__func<mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)>::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>&&, std::tuple<int, int, int>&&, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>&&, std::optional<float>&&, bool&&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>&&)  (in slotstream) + 80  [0x102db2e88]  function.h:174
    +                               ! :         1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>> const&, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>) const  (in slotstream) + 876  [0x102db34ac]  metal_kernel.cpp:304
    +                               ! :           1 std::basic_ostream<char>::__put_num_integer_promote[abi:nqe210106]<int>(int)  (in libc++.1.dylib) + 388  [0x18d10bbc0]
    +                               ! :             1 std::basic_ostream<char>::sentry::~sentry()  (in libc++.1.dylib) + 24  [0x18d0e21c0]
    +                               ! 8 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 5096  [0x103d28ea0]  VQModelProbe.swift:146
    +                               ! : 2 GatedResidual.callAsFunction(_:)  (in slotstream) + 552  [0x103bc5324]  Layers.swift:1846
    +                               ! : | 2 relu(_:)  (in slotstream) + 40  [0x103a47320]
    +                               ! : |   2 closure #2 in compile(inputs:outputs:shapeless:_:)  (in slotstream) + 92  [0x103a2e2c0]  Transforms+Compile.swift:313
    +                               ! : |     2 CompiledFunction.call(_:)  (in slotstream) + 144  [0x103a2c934]  Transforms+Compile.swift:141
    +                               ! : |       1 CompiledFunction.innerCall(_:)  (in slotstream) + 1016  [0x103a2cd4c]  Transforms+Compile.swift:218
    +                               ! : |       + 1 mlx_closure_free  (in slotstream) + 68  [0x102d643bc]  closure.cpp:31
    +                               ! : |       +   1 std::__function::__func<mlx_closure_new_func_payload::$_0, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&)>::~__func()  (in slotstream) + 68  [0x102d65980]  function.h:155
    +                               ! : |       +     1 std::__shared_ptr_pointer<void*, void (*)(void*)>::__on_zero_shared()  (in slotstream) + 16  [0x102d657e0]  shared_ptr.h:123
    +                               ! : |       +       1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               ! : |       +         1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               ! : |       +           1 __deallocating_deinit in ClosureCaptureState #1 in new_mlx_closure(_:)  (in slotstream) + 16  [0x1039bb018]  /<compiler-generated>:0
    +                               ! : |       +             1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 80  [0x1a098dde8]
    +                               ! : |       1 CompiledFunction.innerCall(_:)  (in slotstream) + 968  [0x103a2cd1c]  Transforms+Compile.swift:246
    +                               ! : |         1 mlx_closure_apply  (in slotstream) + 60  [0x102d646bc]  closure.cpp:102
    +                               ! : |           1 std::__function::__func<mlx::core::detail::compile(std::function<std::vector<mlx::core::array> (std::vector<mlx::core::array> const&)>, unsigned long, bool, std::vector<unsigned long long>)::$_1, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&)>::operator()(std::vector<mlx::core::array> const&)  (in slotstream) + 44  [0x103649ce0]  function.h:174
    +                               ! : |             1 std::__function::__func<mlx::core::detail::compile(std::function<std::pair<std::vector<mlx::core::array>, std::shared_ptr<void>> (std::vector<mlx::core::array> const&)>, unsigned long, bool, std::vector<unsigned long long>)::$_0, std::pair<std::vector<mlx::core::array>, std::shared_ptr<void>> (std::vector<mlx::core::array> const&)>::operator()(std::vector<mlx::core::array> const&)  (in slotstream) + 772  [0x10364845c]  function.h:174
    +                               ! : |               1 mlx::core::detail::compile_replace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array> const&, std::vector<mlx::core::array> const&, std::vector<mlx::core::array> const&, bool)  (in slotstream) + 1272  [0x103641e38]  compile.cpp:1076
    +                               ! : |                 1 mlx::core::Compiled::output_shapes(std::vector<mlx::core::array> const&)  (in slotstream) + 788  [0x10363b874]  compile.cpp:213
    +                               ! : |                   1 std::vector<mlx::core::SmallVector<int, 10ul>>::vector[abi:nqe210106](unsigned long, mlx::core::SmallVector<int, 10ul> const&)  (in slotstream) + 100  [0x103642fa4]  vector.h:171
    +                               ! : |                     1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! : |                       1 DYLD-STUB$$malloc_type_malloc  (in libc++abi.dylib) + 12  [0x18d186c1c]
    +                               ! : 1 GatedResidual.callAsFunction(_:)  (in slotstream) + 1492  [0x103bc56d0]  /<compiler-generated>:0
    +                               ! : | 1 DYLD-STUB$$swift_release  (in slotstream) + 0  [0x1040eb738]
    +                               ! : 1 GatedResidual.callAsFunction(_:)  (in slotstream) + 356  [0x103bc5260]  Layers.swift:1844
    +                               ! : | 1 specialized static QLinear.withReferenceRows(_:minimumRows:_:)  (in slotstream) + 1248  [0x103d7e38c]  Weights.swift:59
    +                               ! : |   1 QLinear.callAsFunction(_:)  (in slotstream) + 1164  [0x103d74930]  Weights.swift:42
    +                               ! : |     1 quantizedMatmul(_:_:scales:biases:transpose:groupSize:bits:mode:stream:)  (in slotstream) + 556  [0x103a22f00]
    +                               ! : |       1 mlx_quantized_matmul  (in slotstream) + 392  [0x102d8bd38]  ops.cpp:2967
    +                               ! : |         1 mlx::core::quantized_matmul(mlx::core::array const&, mlx::core::array const&, mlx::core::array const&, std::optional<mlx::core::array> const&, bool, std::optional<int>, std::optional<int>, std::basic_string<char> const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 656  [0x103722724]  ops.cpp:4818
    +                               ! : |           1 mlx::core::array::~array()  (in slotstream) + 28  [0x102da8074]  array.cpp:212
    +                               ! : 1 GatedResidual.callAsFunction(_:)  (in slotstream) + 752  [0x103bc53ec]  Layers.swift:1847
    +                               ! : | 1 specialized static VQArithmetic.sigmoid(_:)  (in slotstream) + 500  [0x103d0d6e8]  VQArithmetic.swift:42
    +                               ! : |   1 MLXFast.MLXFastKernel.callAsFunction<A, B>(_:template:grid:threadGroup:outputShapes:outputDTypes:initValue:verbose:stream:)  (in slotstream) + 1672  [0x103a0945c]  MLXFastKernel.swift:154
    +                               ! : |     1 mlx_fast_metal_kernel_apply  (in slotstream) + 244  [0x102d6bb98]  fast.cpp:525
    +                               ! : |       1 std::__function::__func<mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)>::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>&&, std::tuple<int, int, int>&&, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>&&, std::optional<float>&&, bool&&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>&&)  (in slotstream) + 80  [0x102db2e88]  function.h:174
    +                               ! : |         1 mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>> const&, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>) const  (in slotstream) + 7652  [0x102db4f24]  metal_kernel.cpp:358
    +                               ! : |           1 mlx::core::array::make_arrays(std::vector<mlx::core::SmallVector<int, 10ul>>, std::vector<mlx::core::Dtype> const&, std::shared_ptr<mlx::core::Primitive> const&, std::vector<mlx::core::array> const&)  (in slotstream) + 464  [0x102da4744]  array.cpp:54
    +                               ! : |             1 mlx::core::array::~array()  (in slotstream) + 28  [0x102da8074]  array.cpp:212
    +                               ! : 1 GatedResidual.callAsFunction(_:)  (in slotstream) + 1364  [0x103bc5650]  Layers.swift:1850
    +                               ! : | 1 MLXArray.all(axis:keepDims:stream:)  (in slotstream) + 136  [0x103a03918]
    +                               ! : |   1 mlx_mean_axis  (in slotstream) + 68  [0x102d87d48]  ops.cpp:2390
    +                               ! : |     1 mlx::core::mean(mlx::core::array const&, int, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 124  [0x1037014e8]  ops.cpp:2345
    +                               ! : |       1 mlx::core::mean(mlx::core::array const&, std::vector<int> const&, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 316  [0x103700de4]  ops.cpp:2337
    +                               ! : |         1 mlx::core::sum(mlx::core::array const&, std::vector<int> const&, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 956  [0x1037008a4]  ops.cpp:2276
    +                               ! : |           1 mlx::core::squeeze(mlx::core::array const&, std::vector<int> const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 56  [0x1036e6730]  ops.cpp:654
    +                               ! : |             1 mlx::core::(anonymous namespace)::normalize_squeeze_axes(mlx::core::array const&, std::vector<int> const&)  (in slotstream) + 108  [0x1036e6814]  ops.cpp:610
    +                               ! : 1 GatedResidual.callAsFunction(_:)  (in slotstream) + 1620  [0x103bc5750]  Layers.swift:1854
    +                               ! : | 1 static MLXArray.+ infix<A>(_:_:)  (in slotstream) + 320  [0x103a007f4]
    +                               ! : |   1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               ! : |     1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               ! : |       1 MLXArray.__deallocating_deinit  (in slotstream) + 56  [0x103a052a4]  MLXArray.swift:0
    +                               ! : |         1 _xzm_free  (in libsystem_malloc.dylib) + 28  [0x18cfec134]
    +                               ! : 1 GatedResidual.callAsFunction(_:)  (in slotstream) + 1644  [0x103bc5768]  Layers.swift:1854
    +                               ! :   1 specialized static VQArithmetic.sigmoid(_:)  (in slotstream) + 500  [0x103d0d6e8]  VQArithmetic.swift:42
    +                               ! :     1 MLXFast.MLXFastKernel.callAsFunction<A, B>(_:template:grid:threadGroup:outputShapes:outputDTypes:initValue:verbose:stream:)  (in slotstream) + 1484  [0x103a093a0]  MLXFastKernel.swift:150
    +                               ! :       1 specialized ContiguousArray._createNewBuffer(bufferIsUnique:minimumCapacity:growForAppend:)  (in libswiftCore.dylib) + 20  [0x1a0adb510]
    +                               ! :         1 specialized _ContiguousArrayBuffer._consumeAndCreateNew(bufferIsUnique:minimumCapacity:growForAppend:)  (in libswiftCore.dylib) + 120  [0x1a0adba8c]
    +                               ! :           1 swift_allocObject  (in libswiftCore.dylib) + 136  [0x1a0924b48]
    +                               ! :             1 swift::swift_slowAllocTyped(unsigned long, unsigned long, unsigned long long)  (in libswiftCore.dylib) + 56  [0x1a098b5d8]
    +                               ! :               1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 420  [0x18cff10e0]
    +                               ! 1 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 9436  [0x103d29f94]  /<compiler-generated>:0
    +                               ! : 1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               ! :   1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               ! :     1 MLXArray.__deallocating_deinit  (in slotstream) + 40  [0x103a05294]  MLXArray.swift:35
    +                               ! :       1 mlx_array_free  (in slotstream) + 16  [0x102d5033c]  array.cpp:29
    +                               ! :         1 mlx::core::array::~array()  (in slotstream) + 156  [0x102da80f4]  array.cpp:245
    +                               ! :           1 std::__shared_ptr_emplace<mlx::core::array::ArrayDesc>::__on_zero_shared_weak()  (in slotstream) + 0  [0x102d55eec]  shared_ptr.h:191
    +                               ! 1 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 4788  [0x103d28d6c]  VQModelProbe.swift:144
    +                               ! : 1 static MLXArray.+ infix(_:_:)  (in slotstream) + 80  [0x103a00524]
    +                               ! 1 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 4944  [0x103d28e08]  VQModelProbe.swift:144
    +                               ! : 1 static MLXArray.+ infix(_:_:)  (in slotstream) + 224  [0x103a005b4]
    +                               ! :   1 mlx_add  (in slotstream) + 148  [0x102d78d14]  ops.cpp:26
    +                               ! :     1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! :       1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 692  [0x18cff11f0]
    +                               ! 1 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 5292  [0x103d28f64]  VQModelProbe.swift:150
    +                               ! : 1 takeAlong(_:_:axis:stream:)  (in slotstream) + 160  [0x103a25034]
    +                               ! :   1 mlx_take_along_axis  (in slotstream) + 72  [0x102d948b8]  ops.cpp:4119
    +                               ! :     1 mlx::core::take_along_axis(mlx::core::array const&, mlx::core::array const&, int, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 412  [0x103718d74]  ops.cpp:3761
    +                               ! :       1 std::vector<mlx::core::array>::__emplace_back_slow_path<mlx::core::array const&>(mlx::core::array const&)  (in slotstream) + 268  [0x102d9d750]  vector.h:1134
    +                               ! 1 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 6696  [0x103d294e0]  VQModelProbe.swift:168
    +                               ! : 1 MLXArray.all(axis:keepDims:stream:)  (in slotstream) + 136  [0x103a03918]
    +                               ! :   1 mlx_sum_axis  (in slotstream) + 68  [0x102d9407c]  ops.cpp:4039
    +                               ! :     1 _xzm_free  (in libsystem_malloc.dylib) + 996  [0x18cfec4fc]
    +                               ! 1 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 7172  [0x103d296bc]  VQModelProbe.swift:170
    +                               ! : 1 specialized __RawDictionaryStorage.find<A>(_:hashValue:)  (in slotstream) + 108  [0x102cc7b14]  /<compiler-generated>:0
    +                               ! :   1 _stringCompareFastUTF8(_:_:expecting:bothNFC:)  (in libswiftCore.dylib) + 40  [0x1a0c46ae4]
    +                               ! 1 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 8332  [0x103d29b44]  VQModelProbe.swift:170
    +                               ! : 1 QLinear.callAsFunction(_:)  (in slotstream) + 1116  [0x103d74900]  Weights.swift:42
    +                               ! :   1 specialized static StreamOrDevice.default.getter  (in slotstream) + 20  [0x103a2c54c]  Stream.swift:38
    +                               ! 1 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 7744  [0x103d298f8]  VQModelProbe.swift:171
    +                               ! : 1 relu(_:)  (in slotstream) + 40  [0x103a47320]
    +                               ! :   1 closure #2 in compile(inputs:outputs:shapeless:_:)  (in slotstream) + 92  [0x103a2e2c0]  Transforms+Compile.swift:313
    +                               ! :     1 CompiledFunction.call(_:)  (in slotstream) + 144  [0x103a2c934]  Transforms+Compile.swift:141
    +                               ! :       1 CompiledFunction.innerCall(_:)  (in slotstream) + 968  [0x103a2cd1c]  Transforms+Compile.swift:246
    +                               ! :         1 mlx_closure_apply  (in slotstream) + 60  [0x102d646bc]  closure.cpp:102
    +                               ! :           1 std::__function::__func<mlx::core::detail::compile(std::function<std::vector<mlx::core::array> (std::vector<mlx::core::array> const&)>, unsigned long, bool, std::vector<unsigned long long>)::$_1, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&)>::operator()(std::vector<mlx::core::array> const&)  (in slotstream) + 44  [0x103649ce0]  function.h:174
    +                               ! :             1 std::__function::__func<mlx::core::detail::compile(std::function<std::pair<std::vector<mlx::core::array>, std::shared_ptr<void>> (std::vector<mlx::core::array> const&)>, unsigned long, bool, std::vector<unsigned long long>)::$_0, std::pair<std::vector<mlx::core::array>, std::shared_ptr<void>> (std::vector<mlx::core::array> const&)>::operator()(std::vector<mlx::core::array> const&)  (in slotstream) + 772  [0x10364845c]  function.h:174
    +                               ! :               1 mlx::core::detail::compile_replace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array> const&, std::vector<mlx::core::array> const&, std::vector<mlx::core::array> const&, bool)  (in slotstream) + 176  [0x1036419f0]  compile.cpp:1055
    +                               ! :                 1 std::__hash_table<std::__hash_value_type<unsigned long, mlx::core::array>>::__emplace_unique_key_args<unsigned long, std::pair<unsigned long const, mlx::core::array>>(unsigned long const&, std::pair<unsigned long const, mlx::core::array>&&)  (in slotstream) + 392  [0x102da9438]  __hash_table:1588
    +                               ! :                   1 std::__hash_table<std::__hash_value_type<unsigned long, mlx::core::array>>::__do_rehash<true>(unsigned long)  (in slotstream) + 48  [0x102da95f4]  __hash_table:1769
    +                               ! :                     1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               ! :                       1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 516  [0x18cff1140]
    +                               ! 1 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 8868  [0x103d29d5c]  VQModelProbe.swift:172
    +                               ! : 1 specialized static VQArithmetic.sigmoid(_:)  (in slotstream) + 500  [0x103d0d6e8]  VQArithmetic.swift:42
    +                               ! :   1 MLXFast.MLXFastKernel.callAsFunction<A, B>(_:template:grid:threadGroup:outputShapes:outputDTypes:initValue:verbose:stream:)  (in slotstream) + 1048  [0x103a091ec]  MLXFastKernel.swift:0
    +                               ! :     1 Zip2Sequence.Iterator.next()  (in libswiftCore.dylib) + 800  [0x1a0c2fb14]
    +                               ! :       1 swift_checkMetadataState  (in libswiftCore.dylib) + 36  [0x1a09235f0]
    +                               ! :         1 performOnMetadataCache<swift::MetadataResponse, swift_checkMetadataState::CheckStateCallbacks>(swift::TargetMetadata<swift::InProcess> const*, swift_checkMetadataState::CheckStateCallbacks&&)  (in libswiftCore.dylib) + 776  [0x1a09a269c]
    +                               ! :           1 swift::ConcurrentReadableHashMap<swift::HashMapElementWrapper<swift::GenericCacheEntry>, swift::Mutex>::find<swift::MetadataCacheKey>(swift::MetadataCacheKey const&, swift::ConcurrentReadableHashMap<swift::HashMapElementWrapper<swift::GenericCacheEntry>, swift::Mutex>::IndexStorage, unsigned long, swift::HashMapElementWrapper<swift::GenericCacheEntry>*)  (in libswiftCore.dylib) + 264  [0x1a09a7828]
    +                               ! :             1 swift::ConcurrentReadableHashMap<swift::HashMapElementWrapper<swift::GenericCacheEntry>, swift::Mutex>::find<swift::MetadataCacheKey>(swift::MetadataCacheKey const&, swift::ConcurrentReadableHashMap<swift::HashMapElementWrapper<swift::GenericCacheEntry>, swift::Mutex>::IndexStorage, unsigned long, swift::HashMapElementWrapper<swift::GenericCacheEntry>*)  (in libswiftCore.dylib) + 264  [0x1a09a7828]
    +                               ! :               1 swift::MetadataCacheKey::operator==(swift::MetadataCacheKey const&) const  (in libswiftCore.dylib) + 48  [0x1a09a73dc]
    +                               ! 1 specialized VQModelProbe.block(_:hidden:history:trace:sparse:)  (in slotstream) + 8896  [0x103d29d78]  VQModelProbe.swift:172
    +                               !   1 static MLXArray.+ infix(_:_:)  (in slotstream) + 144  [0x103a00564]
    +                               !     1 swift_retain  (in libswiftCore.dylib) + 4  [0x1a0927008]
    +                               79 VQModelProbe.forward(_:observe:trace:inspectState:)  (in slotstream) + 1332  [0x103d26cdc]  VQModelProbe.swift:73
    +                               ! 79 MLXArray.item<A>(_:)  (in slotstream) + 140  [0x103a0559c]  MLXArray.swift:333
    +                               !   79 mlx_array_eval  (in slotstream) + 24  [0x102d537f8]  array.cpp:350
    +                               !     79 mlx::core::array::eval()  (in slotstream) + 176  [0x102da7d54]  array.cpp:158
    +                               !       65 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 128  [0x103794dcc]  transforms.cpp:378
    +                               !       : 65 mlx::core::array::wait()  (in slotstream) + 48  [0x102da7c24]  array.cpp:148
    +                               !       :   65 mlx::core::Event::wait()  (in slotstream) + 68  [0x1035b4a2c]  event.cpp:48
    +                               !       :     65 -[IOSurfaceSharedEvent waitUntilSignaledValue:timeoutMS:]  (in IOSurface) + 72  [0x199826184]
    +                               !       :       65 iokit_user_client_trap  (in IOKit) + 8  [0x19154cae0]
    +                               !       14 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 120  [0x103794dc4]  transforms.cpp:378
    +                               !         11 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 4404  [0x103793f94]  transforms.cpp:266
    +                               !         | 7 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 200  [0x1035b31f8]  eval.cpp:45
    +                               !         | + 7 mlx::core::binary_op_gpu(std::vector<mlx::core::array> const&, mlx::core::array&, char const*, mlx::core::Stream const&)  (in slotstream) + 300  [0x103587c20]  binary.cpp:206
    +                               !         | +   7 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, mlx::core::array&, char const*, mlx::core::Stream const&)  (in slotstream) + 172  [0x103587a5c]  binary.cpp:193
    +                               !         | +     3 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 1412  [0x1035874c0]  binary.cpp:161
    +                               !         | +     ! 3 mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 108  [0x1035a0d84]  device.cpp:421
    +                               !         | +     !   3 -[AGXG17XFamilyComputeContext dispatchThreads:threadsPerThreadgroup:]  (in AGXMetalG17X) + 304  [0x117e478e8]
    +                               !         | +     !     1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 1100  [0x117e41204]
    +                               !         | +     !     : 1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::bindBufferResourceToCommand(unsigned int, bool)  (in AGXMetalG17X) + 292  [0x117e42f1c]
    +                               !         | +     !     :   1 AGX::PassiveResourceGroupUsage<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses>::bindPassiveResource(_PassiveResourceInfo const&)  (in AGXMetalG17X) + 1000  [0x11803cdfc]
    +                               !         | +     !     :     1 $_0::operator()() const::'lambda0'(unsigned long, std::__type_descriptor_t)::__invoke(unsigned long, std::__type_descriptor_t)  (in libc++abi.dylib) + 16  [0x18d1854a8]
    +                               !         | +     !     :       1 operator_new_impl[abi:nqe210106](unsigned long, std::__type_descriptor_t)  (in libc++abi.dylib) + 36  [0x18d1854dc]
    +                               !         | +     !     :         1 _xzm_xzone_malloc  (in libsystem_malloc.dylib) + 8  [0x18cfeb958]
    +                               !         | +     !     1 AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 2344  [0x117e416e0]
    +                               !         | +     !     1 AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3EncodedInstr<AGXIotoInstruction_SPECLM_0>::AGX3EncodedInstr(AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3Instr<AGXIotoInstruction_SPECLM_0> const&)  (in AGXMetalG17X) + 3832  [0x117de6540]
    +                               !         | +     1 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 768  [0x10358723c]  binary.cpp:108
    +                               !         | +     ! 1 mlx::core::get_binary_kernel(mlx::core::metal::Device&, std::basic_string<char> const&, mlx::core::Dtype, mlx::core::Dtype, char const*)  (in slotstream) + 292  [0x1035d0f00]  jit_kernels.cpp:144
    +                               !         | +     !   1 DYLD-STUB$$memmove  (in slotstream) + 4  [0x1040eaf20]
    +                               !         | +     1 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 792  [0x103587254]  binary.cpp:110
    +                               !         | +     ! 1 mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 144  [0x1035a0728]  device.cpp:581
    +                               !         | +     !   1 -[IOGPUMTLFence initWithDevice:]  (in IOGPU) + 180  [0x1b288c9d4]
    +                               !         | +     1 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 812  [0x103587268]  binary.cpp:110
    +                               !         | +     ! 1 DYLD-STUB$$objc_msgSend  (in slotstream) + 0  [0x1040eafa0]
    +                               !         | +     1 mlx::core::binary_op_gpu_inplace(std::vector<mlx::core::array> const&, std::vector<mlx::core::array>&, char const*, mlx::core::Stream const&)  (in slotstream) + 872  [0x1035872a4]  binary.cpp:115
    +                               !         | +       1 mlx::core::metal::CommandEncoder::register_output_array(mlx::core::array const&)  (in slotstream) + 56  [0x1035a09e0]  device.cpp:370
    +                               !         | +         1 std::__hash_table<void const*>::__emplace_unique_key_args<void const*, void const*>(void const* const&, void const*&&)  (in slotstream) + 388  [0x1035a5a40]  __hash_table:1588
    +                               !         | 2 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 1104  [0x1035b3580]  eval.cpp:66
    +                               !         | + 2 std::unordered_set<std::shared_ptr<mlx::core::array::Data>>::unordered_set(std::unordered_set<std::shared_ptr<mlx::core::array::Data>> const&)  (in slotstream) + 216  [0x10319e3b4]  unordered_set:1075
    +                               !         | +   1 operator new(unsigned long)  (in libc++abi.dylib) + 80  [0x18d186804]
    +                               !         | +   1 std::__hash_table<std::shared_ptr<mlx::core::array::Data>>::__do_rehash<true>(unsigned long)  (in slotstream) + 48  [0x10319d8d0]  __hash_table:1769
    +                               !         | +     1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               !         | +       1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 420  [0x18cff10e0]
    +                               !         | 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 680  [0x1035b33d8]  eval.cpp:56
    +                               !         | + 1 _xzm_free  (in libsystem_malloc.dylib) + 996  [0x18cfec4fc]
    +                               !         | 1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 1088  [0x1035b3570]  eval.cpp:66
    +                               !         |   1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               !         |     1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 420  [0x18cff10e0]
    +                               !         1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 524  [0x10379306c]  transforms.cpp:104
    +                               !         | 1 mlx::core::Event::Event(mlx::core::Stream)  (in slotstream) + 104  [0x1035b496c]  event.cpp:43
    +                               !         |   1 mlx::core::metal::EventImpl::EventImpl(mlx::core::metal::Device&)  (in slotstream) + 60  [0x1035b47d4]  event.cpp:16
    +                               !         |     1 -[_MTLSharedEvent initWithOptions:]  (in Metal) + 44  [0x199a03134]
    +                               !         |       1 -[IOSurfaceSharedEvent initWithOptions:]  (in IOSurface) + 128  [0x199825e14]
    +                               !         |         1 IOConnectCallMethod  (in IOKit) + 176  [0x191530d84]
    +                               !         |           1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                               !         |             1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               !         |               1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               !         1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 752  [0x103793150]  transforms.cpp:115
    +                               !         | 1 std::deque<std::pair<std::reference_wrapper<mlx::core::array>, int>>::__add_back_capacity()  (in slotstream) + 184  [0x10379a644]  deque:2197
    +                               !         |   1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               !         |     1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 420  [0x18cff10e0]
    +                               !         1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 5140  [0x103794274]  transforms.cpp:343
    +                               !           1 mlx::core::gpu::finalize(mlx::core::Stream)  (in slotstream) + 88  [0x1035b3b50]  eval.cpp:76
    +                               !             1 mlx::core::metal::CommandEncoder::commit(std::function<void ()>)  (in slotstream) + 788  [0x1035a1ca4]  device.cpp:558
    +                               !               1 -[AGXG17XFamilyCommandBuffer commit]  (in AGXMetalG17X) + 888  [0x117def984]
    +                               !                 1 -[IOGPUMetalCommandBuffer commit]  (in IOGPU) + 228  [0x1b2871478]
    +                               !                   1 -[_MTLCommandQueue commitCommandBuffer:wake:]  (in Metal) + 268  [0x19986242c]
    +                               !                     1 dispatch_source_merge_data  (in libdispatch.dylib) + 92  [0x18d029458]
    +                               !                       1 _dispatch_event_loop_poke  (in libdispatch.dylib) + 336  [0x18d035eb0]
    +                               !                         1 _dispatch_kq_poll  (in libdispatch.dylib) + 220  [0x18d036a64]
    +                               !                           1 kevent_id  (in libsystem_kernel.dylib) + 8  [0x18d18da74]
    +                               27 VQModelProbe.forward(_:observe:trace:inspectState:)  (in slotstream) + 852  [0x103d26afc]  VQModelProbe.swift:86
    +                               ! 27 static Memory.clearCache()  (in slotstream) + 48  [0x103a0a308]  Memory.swift:357
    +                               !   27 mlx_clear_cache  (in slotstream) + 16  [0x102d78284]  memory.cpp:13
    +                               !     27 mlx::core::clear_cache()  (in slotstream) + 36  [0x1035864f4]  allocator.cpp:276
    +                               !       26 mlx::core::BufferCache<MTL::Buffer>::clear()  (in slotstream) + 100  [0x103585de0]  buffer_cache.h:90
    +                               !       : 24 std::__function::__func<mlx::core::metal::MetalAllocator::MetalAllocator(mlx::core::metal::Device&)::$_1, void (MTL::Buffer*)>::operator()(MTL::Buffer*&&)  (in slotstream) + 88  [0x1035866f0]  function.h:174
    +                               !       : | 23 -[AGXG17XFamilyBuffer dealloc]  (in AGXMetalG17X) + 76  [0x117dea1c0]
    +                               !       : | + 21 -[AGXBuffer dealloc]  (in AGXMetalG17X) + 96  [0x117d65c14]
    +                               !       : | + ! 17 -[IOGPUMetalBuffer dealloc]  (in IOGPU) + 320  [0x1b2870670]
    +                               !       : | + ! : 14 -[IOGPUMetalResource dealloc]  (in IOGPU) + 244  [0x1b2884e84]
    +                               !       : | + ! : | 14 _CFRelease  (in CoreFoundation) + 308  [0x18d35ff78]
    +                               !       : | + ! : |   14 ioGPUResourceFinalize  (in IOGPU) + 104  [0x1b288c23c]
    +                               !       : | + ! : |     14 iokit_user_client_trap  (in IOKit) + 8  [0x19154cae0]
    +                               !       : | + ! : 3 -[IOGPUMetalResource dealloc]  (in IOGPU) + 300  [0x1b2884ebc]
    +                               !       : | + ! :   3 -[_MTLObjectWithLabel dealloc]  (in Metal) + 64  [0x199861d04]
    +                               !       : | + ! :     3 _objc_rootDealloc  (in libobjc.A.dylib) + 72  [0x18cd67374]
    +                               !       : | + ! :       3 objc_destructInstance_nonnull_realized(objc_object*)  (in libobjc.A.dylib) + 76  [0x18cd96104]
    +                               !       : | + ! :         2 object_cxxDestructFromClass(objc_object*, objc_class*)  (in libobjc.A.dylib) + 116  [0x18cd6fdc0]
    +                               !       : | + ! :         + 2 -[IOGPUMetalResource .cxx_destruct]  (in IOGPU) + 52  [0x1b2885880]
    +                               !       : | + ! :         +   2 objc_destroyWeak  (in libobjc.A.dylib) + 152  [0x18cd70d80]
    +                               !       : | + ! :         +     2 weak_unregister_no_lock  (in libobjc.A.dylib) + 128  [0x18cd7ce78]
    +                               !       : | + ! :         1 object_cxxDestructFromClass(objc_object*, objc_class*)  (in libobjc.A.dylib) + 76  [0x18cd6fd98]
    +                               !       : | + ! :           1 lookupMethodInClassAndLoadCache  (in libobjc.A.dylib) + 52  [0x18cd6fc54]
    +                               !       : | + ! :             1 cache_getImp  (in libobjc.A.dylib) + 84  [0x18cd65cd4]
    +                               !       : | + ! 3 -[IOGPUMetalBuffer dealloc]  (in IOGPU) + 172  [0x1b28705dc]
    +                               !       : | + ! : 2 -[IOGPUMetalDevice deallocBufferSubData:heapIndex:bufferIndex:bufferOffset:length:]  (in IOGPU) + 56  [0x1b2878568]
    +                               !       : | + ! : | 1 IOGPUMetalSuballocatorFree  (in IOGPU) + 172  [0x1b288efbc]
    +                               !       : | + ! : | + 1 MTLRangeAllocatorDeallocate  (in Metal) + 112  [0x1998c9668]
    +                               !       : | + ! : | 1 IOGPUMetalSuballocatorFree  (in IOGPU) + 472  [0x1b288f0e8]
    +                               !       : | + ! : |   1 std::__tree<std::__value_type<unsigned int, short>, std::__map_value_compare<unsigned int, std::pair<unsigned int const, short>, true>, IOGPUMetalSuballocatorHeap::Allocator<std::pair<unsigned int const, short>>>::__emplace_multi<std::pair<unsigned int, short>>(std::pair<unsigned int, short>&&)  (in IOGPU) + 44  [0x1b288f860]
    +                               !       : | + ! : |     1 IOGPUMetalSuballocatorHeap::Allocator<std::__tree_node<std::__value_type<unsigned int, short>, void*>>::allocate(unsigned long)  (in IOGPU) + 56  [0x1b288f960]
    +                               !       : | + ! : 1 objc_msgSend  (in libobjc.A.dylib) + 32  [0x18cd65820]
    +                               !       : | + ! 1 -[IOGPUMetalBuffer dealloc]  (in IOGPU) + 0  [0x1b2870530]
    +                               !       : | + 1 -[AGXBuffer emitBufferResourceInfoSignpost:]  (in AGXMetalG17X) + 604  [0x117d653dc]
    +                               !       : | + 1 objc_msgSendSuper2  (in libobjc.A.dylib) + 104  [0x18cd65a88]
    +                               !       : | 1 _objc_rootRelease  (in libobjc.A.dylib) + 140  [0x18cd6b658]
    +                               !       : 1 std::__function::__func<mlx::core::metal::MetalAllocator::MetalAllocator(mlx::core::metal::Device&)::$_1, void (MTL::Buffer*)>::operator()(MTL::Buffer*&&)  (in slotstream) + 68  [0x1035866dc]  function.h:174
    +                               !       : | 1 mlx::core::metal::new_scoped_memory_pool()  (in slotstream) + 36  [0x10359fe84]  device.cpp:944
    +                               !       : |   1 objc_msgSend  (in libobjc.A.dylib) + 56  [0x18cd65838]
    +                               !       : 1 std::__function::__func<mlx::core::metal::MetalAllocator::MetalAllocator(mlx::core::metal::Device&)::$_1, void (MTL::Buffer*)>::operator()(MTL::Buffer*&&)  (in slotstream) + 60  [0x1035866d4]  function.h:174
    +                               !       1 mlx::core::BufferCache<MTL::Buffer>::clear()  (in slotstream) + 112  [0x103585dec]  buffer_cache.h:92
    +                               !         1 _xzm_free  (in libsystem_malloc.dylib) + 352  [0x18cfec278]
    +                               !           1 _platform_memset  (in libsystem_platform.dylib) + 176  [0x18d1d9140]
    +                               23 VQModelProbe.forward(_:observe:trace:inspectState:)  (in slotstream) + 4064  [0x103d27788]  VQModelProbe.swift:88
    +                               ! 23 eval(_:)  (in slotstream) + 72  [0x103a3587c]  Transforms+Eval.swift:124
    +                               !   23 mlx_eval  (in slotstream) + 140  [0x102d9bf24]  transforms.cpp:71
    +                               !     23 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 128  [0x103794dcc]  transforms.cpp:378
    +                               !       23 mlx::core::array::wait()  (in slotstream) + 48  [0x102da7c24]  array.cpp:148
    +                               !         23 mlx::core::Event::wait()  (in slotstream) + 68  [0x1035b4a2c]  event.cpp:48
    +                               !           23 -[IOSurfaceSharedEvent waitUntilSignaledValue:timeoutMS:]  (in IOSurface) + 72  [0x199826184]
    +                               !             23 iokit_user_client_trap  (in IOKit) + 8  [0x19154cae0]
    +                               4 VQModelProbe.forward(_:observe:trace:inspectState:)  (in slotstream) + 4296  [0x103d27870]  VQModelProbe.swift:88
    +                               ! 4 MLXArray.item<A>(_:)  (in slotstream) + 140  [0x103a0559c]  MLXArray.swift:333
    +                               !   4 mlx_array_eval  (in slotstream) + 24  [0x102d537f8]  array.cpp:350
    +                               !     4 mlx::core::array::eval()  (in slotstream) + 176  [0x102da7d54]  array.cpp:158
    +                               !       3 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 128  [0x103794dcc]  transforms.cpp:378
    +                               !       : 3 mlx::core::array::wait()  (in slotstream) + 48  [0x102da7c24]  array.cpp:148
    +                               !       :   3 mlx::core::Event::wait()  (in slotstream) + 68  [0x1035b4a2c]  event.cpp:48
    +                               !       :     3 -[IOSurfaceSharedEvent waitUntilSignaledValue:timeoutMS:]  (in IOSurface) + 72  [0x199826184]
    +                               !       :       3 iokit_user_client_trap  (in IOKit) + 8  [0x19154cae0]
    +                               !       1 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 120  [0x103794dc4]  transforms.cpp:378
    +                               !         1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 5140  [0x103794274]  transforms.cpp:343
    +                               !           1 mlx::core::gpu::finalize(mlx::core::Stream)  (in slotstream) + 88  [0x1035b3b50]  eval.cpp:76
    +                               !             1 mlx::core::metal::CommandEncoder::commit(std::function<void ()>)  (in slotstream) + 788  [0x1035a1ca4]  device.cpp:558
    +                               !               1 -[AGXG17XFamilyCommandBuffer commit]  (in AGXMetalG17X) + 888  [0x117def984]
    +                               !                 1 -[IOGPUMetalCommandBuffer commit]  (in IOGPU) + 228  [0x1b2871478]
    +                               !                   1 -[_MTLCommandQueue commitCommandBuffer:wake:]  (in Metal) + 268  [0x19986242c]
    +                               !                     1 dispatch_source_merge_data  (in libdispatch.dylib) + 92  [0x18d029458]
    +                               !                       1 _dispatch_event_loop_poke  (in libdispatch.dylib) + 336  [0x18d035eb0]
    +                               !                         1 _dispatch_kq_poll  (in libdispatch.dylib) + 220  [0x18d036a64]
    +                               !                           1 kevent_id  (in libsystem_kernel.dylib) + 8  [0x18d18da74]
    +                               2 VQModelProbe.forward(_:observe:trace:inspectState:)  (in slotstream) + 540  [0x103d269c4]  VQModelProbe.swift:59
    +                               ! 2 eval(_:)  (in slotstream) + 72  [0x103a3587c]  Transforms+Eval.swift:124
    +                               !   2 mlx_eval  (in slotstream) + 140  [0x102d9bf24]  transforms.cpp:71
    +                               !     1 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 120  [0x103794dc4]  transforms.cpp:378
    +                               !     : 1 mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 4404  [0x103793f94]  transforms.cpp:266
    +                               !     :   1 mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 92  [0x1035b318c]  eval.cpp:32
    +                               !     :     1 mlx::core::metal::get_command_encoder(mlx::core::Stream)  (in slotstream) + 316  [0x1035a41f0]  device.cpp:923
    +                               !     1 mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 128  [0x103794dcc]  transforms.cpp:378
    +                               !       1 mlx::core::array::wait()  (in slotstream) + 48  [0x102da7c24]  array.cpp:148
    +                               !         1 mlx::core::Event::wait()  (in slotstream) + 68  [0x1035b4a2c]  event.cpp:48
    +                               !           1 -[IOSurfaceSharedEvent waitUntilSignaledValue:timeoutMS:]  (in IOSurface) + 72  [0x199826184]
    +                               !             1 iokit_user_client_trap  (in IOKit) + 8  [0x19154cae0]
    +                               1 VQModelProbe.forward(_:observe:trace:inspectState:)  (in slotstream) + 952  [0x103d26b60]  VQModelProbe.swift:63
    +                               ! 1 host_statistics64  (in libsystem_kernel.dylib) + 252  [0x18d195d54]
    +                               !   1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                               !     1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                               1 VQModelProbe.forward(_:observe:trace:inspectState:)  (in slotstream) + 1236  [0x103d26c7c]  VQModelProbe.swift:73
    +                               ! 1 acos(_:stream:)  (in slotstream) + 92  [0x103a25834]
    +                               !   1 mlx_isfinite  (in slotstream) + 60  [0x102d84aa4]  ops.cpp:1899
    +                               !     1 mlx::core::isfinite(mlx::core::array const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 156  [0x1036fd4a8]  ops.cpp:2057
    +                               !       1 mlx::core::isnan(mlx::core::array const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 140  [0x1036fb910]  ops.cpp:2040
    +                               !         1 mlx::core::not_equal(mlx::core::array const&, mlx::core::array const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 392  [0x1036f9498]  ops.cpp:1965
    +                               !           1 mlx::core::broadcast_arrays(std::vector<mlx::core::array> const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 828  [0x1036e236c]  ops.cpp:1905
    +                               !             1 std::vector<mlx::core::array>::__emplace_back_slow_path<mlx::core::array const&>(mlx::core::array const&)  (in slotstream) + 112  [0x102d9d6b4]  vector.h:1128
    +                               !               1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                               !                 1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 420  [0x18cff10e0]
    +                               1 VQModelProbe.forward(_:observe:trace:inspectState:)  (in slotstream) + 4208  [0x103d27818]  VQModelProbe.swift:88
    +                                 1 acos(_:stream:)  (in slotstream) + 92  [0x103a25834]
    +                                   1 mlx_isfinite  (in slotstream) + 60  [0x102d84aa4]  ops.cpp:1899
    +                                     1 mlx::core::isfinite(mlx::core::array const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 136  [0x1036fd494]  ops.cpp:2057
    +                                       1 mlx::core::isinf(mlx::core::array const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 492  [0x1036fbe68]  ops.cpp:2050
    +                                         1 mlx::core::isneginf(mlx::core::array const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 160  [0x1036fd214]  ops.cpp:2071
    +                                           1 mlx::core::equal(mlx::core::array const&, mlx::core::array const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 392  [0x1036f8d24]  ops.cpp:1957
    +                                             1 mlx::core::broadcast_arrays(std::vector<mlx::core::array> const&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)  (in slotstream) + 732  [0x1036e230c]  ops.cpp:1908
    2088 Thread_4837872
    + 2088 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   2088 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    +     2088 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    2088 Thread_4840218
    + 2088 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   2088 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    +     2088 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    1928 Thread_4840071
    + 1897 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    + ! 1897 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    + !   1897 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    + 31 start_wqthread  (in libsystem_pthread.dylib) + 0  [0x18d1cac08]
    1898 Thread_4840214
    + 1859 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    + ! 1859 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    + !   1859 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    + 39 start_wqthread  (in libsystem_pthread.dylib) + 0  [0x18d1cac08]
    1892 Thread_4837873
    + 1862 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    + ! 1862 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    + !   1862 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    + 30 start_wqthread  (in libsystem_pthread.dylib) + 0  [0x18d1cac08]
    1860 Thread_4840217
    + 1808 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    + ! 1807 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    + ! : 1807 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    + ! 1 _pthread_wqthread  (in libsystem_pthread.dylib) + 292  [0x18d1cbec0]
    + !   1 _dispatch_workloop_worker_thread  (in libdispatch.dylib) + 688  [0x18d026714]
    + !     1 _dispatch_event_loop_merge  (in libdispatch.dylib) + 148  [0x18d0366b8]
    + !       1 _dispatch_mach_merge_msg  (in libdispatch.dylib) + 144  [0x18d02db5c]
    + !         1 dispatch_mach_msg_create  (in libdispatch.dylib) + 152  [0x18d031290]
    + !           1 _os_object_alloc_realized  (in libdispatch.dylib) + 32  [0x18d014850]
    + !             1 class_createInstance  (in libobjc.A.dylib) + 40  [0x18cd637b8]
    + 52 start_wqthread  (in libsystem_pthread.dylib) + 0  [0x18d1cac08]
    1843 Thread_4840275
    + 1789 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    + ! 1789 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    + !   1789 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    + 54 start_wqthread  (in libsystem_pthread.dylib) + 0  [0x18d1cac08]
    1839 Thread_4840213
    + 1789 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    + ! 1788 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    + ! : 1788 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    + ! 1 _pthread_wqthread  (in libsystem_pthread.dylib) + 292  [0x18d1cbec0]
    + !   1 _dispatch_workloop_worker_thread  (in libdispatch.dylib) + 688  [0x18d026714]
    + !     1 _dispatch_event_loop_merge  (in libdispatch.dylib) + 148  [0x18d0366b8]
    + !       1 _dispatch_mach_merge_msg  (in libdispatch.dylib) + 144  [0x18d02db5c]
    + !         1 dispatch_mach_msg_create  (in libdispatch.dylib) + 152  [0x18d031290]
    + !           1 _os_object_alloc_realized  (in libdispatch.dylib) + 32  [0x18d014850]
    + !             1 class_createInstance  (in libobjc.A.dylib) + 76  [0x18cd637dc]
    + !               1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 116  [0x18cff0fb0]
    + 50 start_wqthread  (in libsystem_pthread.dylib) + 0  [0x18d1cac08]
    1838 Thread_4840216
    + 1788 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    + ! 1787 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    + ! : 1787 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    + ! 1 _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
    + !   1 _dispatch_worker_thread2  (in libdispatch.dylib) + 156  [0x18d026104]
    + 50 start_wqthread  (in libsystem_pthread.dylib) + 0  [0x18d1cac08]
    1813 Thread_4840215
    + 1749 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    + ! 1749 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    + !   1749 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    + 64 start_wqthread  (in libsystem_pthread.dylib) + 0  [0x18d1cac08]
    1798 Thread_4840212
    + 1758 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    + ! 1757 _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
    + ! : 1757 __workq_kernreturn  (in libsystem_kernel.dylib) + 8  [0x18d18d9f0]
    + ! 1 _pthread_wqthread  (in libsystem_pthread.dylib) + 292  [0x18d1cbec0]
    + !   1 _dispatch_workloop_worker_thread  (in libdispatch.dylib) + 688  [0x18d026714]
    + !     1 _dispatch_event_loop_merge  (in libdispatch.dylib) + 148  [0x18d0366b8]
    + !       1 _dispatch_mach_merge_msg  (in libdispatch.dylib) + 204  [0x18d02db98]
    + !         1 _dispatch_queue_wakeup  (in libdispatch.dylib) + 500  [0x18d01ef28]
    + 40 start_wqthread  (in libsystem_pthread.dylib) + 0  [0x18d1cac08]
    309 Thread_<multiple>   DispatchQueue_71: com.Metal.CommandQueueDispatch  (serial)
    + 309 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   309 _pthread_wqthread  (in libsystem_pthread.dylib) + 292  [0x18d1cbec0]
    +     309 _dispatch_workloop_worker_thread  (in libdispatch.dylib) + 720  [0x18d026734]
    +       309 _dispatch_root_queue_drain_deferred_wlh  (in libdispatch.dylib) + 284  [0x18d026e34]
    +         309 _dispatch_lane_invoke  (in libdispatch.dylib) + 392  [0x18d01cb2c]
    +           309 _dispatch_lane_serial_drain  (in libdispatch.dylib) + 332  [0x18d01be98]
    +             308 _dispatch_source_invoke  (in libdispatch.dylib) + 844  [0x18d029e84]
    +             ! 308 _dispatch_source_latch_and_call  (in libdispatch.dylib) + 392  [0x18d02b1b0]
    +             !   307 _dispatch_continuation_pop  (in libdispatch.dylib) + 596  [0x18d0181c8]
    +             !   : 307 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +             !   :   304 -[_MTLCommandQueue _submitAvailableCommandBuffers]  (in Metal) + 512  [0x199862710]
    +             !   :   | 304 -[IOGPUMetalCommandQueue submitCommandBuffers:count:]  (in IOGPU) + 72  [0x1b28739e8]
    +             !   :   |   303 -[IOGPUMetalCommandQueue _submitCommandBuffers:count:]  (in IOGPU) + 360  [0x1b2873b7c]
    +             !   :   |   + 286 IOGPUCommandQueueSubmitCommandBuffers  (in IOGPU) + 184  [0x1b288b148]
    +             !   :   |   + ! 286 iokit_user_client_trap  (in IOKit) + 8  [0x19154cae0]
    +             !   :   |   + 17 IOGPUCommandQueueSubmitCommandBuffers  (in IOGPU) + 272  [0x1b288b1a0]
    +             !   :   |   +   17 IOConnectCallMethod  (in IOKit) + 176  [0x191530d84]
    +             !   :   |   +     17 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +             !   :   |   +       17 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +             !   :   |   +         17 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +             !   :   |   1 -[IOGPUMetalCommandQueue _submitCommandBuffers:count:]  (in IOGPU) + 184  [0x1b2873acc]
    +             !   :   |     1 -[AGXG17XFamilyCommandBuffer fillCommandBufferArgs:commandQueue:]  (in AGXMetalG17X) + 92  [0x117dec024]
    +             !   :   |       1 -[IOGPUMetalCommandBuffer fillCommandBufferArgs:commandQueue:]  (in IOGPU) + 204  [0x1b2872620]
    +             !   :   |         1 _Block_copy  (in libsystem_blocks.dylib) + 84  [0x18ce98d94]
    +             !   :   |           1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 468  [0x18cff1110]
    +             !   :   2 -[_MTLCommandQueue _submitAvailableCommandBuffers]  (in Metal) + 440  [0x1998626c8]
    +             !   :   | 2 -[NSMutableArray replaceObjectsInRange:withObjectsFromArray:range:]  (in CoreFoundation) + 316  [0x18d2c81f8]
    +             !   :   |   1 -[__NSArrayM replaceObjectsInRange:withObjects:count:]  (in CoreFoundation) + 296  [0x18d261c10]
    +             !   :   |   + 1 -[__NSArrayM insertObjects:count:atIndex:]  (in CoreFoundation) + 112  [0x18d2620c0]
    +             !   :   |   1 -[__NSArrayM replaceObjectsInRange:withObjects:count:]  (in CoreFoundation) + 304  [0x18d261c18]
    +             !   :   1 -[_MTLCommandQueue _submitAvailableCommandBuffers]  (in Metal) + 112  [0x199862580]
    +             !   :     1 objc_msgSend$objectAtIndex:  (in Metal) + 0  [0x199b13e60]
    +             !   1 _dispatch_continuation_pop  (in libdispatch.dylib) + 68  [0x18d017fb8]
    +             1 _dispatch_source_invoke  (in libdispatch.dylib) + 1552  [0x18d02a148]
    +               1 _dispatch_queue_invoke_finish  (in libdispatch.dylib) + 136  [0x18d01c338]
    +                 1 _dispatch_queue_invoke_finish.cold.1  (in libdispatch.dylib) + 0  [0x18d04a7e8]
    234 Thread_4840212   DispatchQueue_19: com.apple.root.user-interactive-qos  (concurrent)
    + 234 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   234 _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
    +     234 _dispatch_worker_thread2  (in libdispatch.dylib) + 184  [0x18d026120]
    +       233 _dispatch_root_queue_drain  (in libdispatch.dylib) + 708  [0x18d025adc]
    +       ! 233 <deduplicated_symbol>  (in libdispatch.dylib) + 28  [0x18d04ad6c]
    +       !   233 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +       !     233 _dispatch_apply_invoke  (in libdispatch.dylib) + 248  [0x18d0272f4]
    +       !       216 _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
    +       !       : 216 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +       !       :   216 _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
    +       !       :     216 _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
    +       !       :       216 thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
    +       !       :         216 partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
    +       !       :           216 closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
    +       !       :             216 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    +       !       :               204 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
    +       !       :               | 175 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +       !       :               | + 175 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +       !       :               | +   175 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +       !       :               | 25 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
    +       !       :               | + 25 specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
    +       !       :               | +   25 __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
    +       !       :               | +     24 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +       !       :               | +     ! 22 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +       !       :               | +     ! : 22 _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
    +       !       :               | +     ! :   22 madvise  (in libsystem_kernel.dylib) + 8  [0x18d18e9b0]
    +       !       :               | +     ! 1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
    +       !       :               | +     ! : 1 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 528  [0x18cfd4c30]
    +       !       :               | +     ! :   1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 400  [0x18cfd61e8]
    +       !       :               | +     ! :     1 _os_unfair_lock_unlock_slow  (in libsystem_platform.dylib) + 56  [0x18d1d74bc]
    +       !       :               | +     ! :       1 __ulock_wake  (in libsystem_kernel.dylib) + 8  [0x18d18dbcc]
    +       !       :               | +     ! 1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +       !       :               | +     1 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 628  [0x18cfeb4fc]
    +       !       :               | 2 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 704  [0x103d443a8]  VQTensorFile.swift:146
    +       !       :               | + 2 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +       !       :               | +   2 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +       !       :               | 1 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 520  [0x103d442f0]  VQTensorFile.swift:142
    +       !       :               | + 1 VQRecordReadBatch.Cancellation.canContinue.getter  (in slotstream) + 24  [0x103d3ae78]
    +       !       :               | +   1 _pthread_mutex_firstfit_lock_slow  (in libsystem_pthread.dylib) + 216  [0x18d1ca8e0]
    +       !       :               | +     1 _pthread_mutex_firstfit_lock_wait  (in libsystem_pthread.dylib) + 84  [0x18d1cce9c]
    +       !       :               | +       1 __psynch_mutexwait  (in libsystem_kernel.dylib) + 8  [0x18d18e9dc]
    +       !       :               | 1 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 536  [0x103d44300]  VQTensorFile.swift:143
    +       !       :               |   1 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +       !       :               |     1 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +       !       :               7 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
    +       !       :               | 7 Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
    +       !       :               |   7 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
    +       !       :               |     7 __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
    +       !       :               |       7 _platform_memmove  (in libsystem_platform.dylib) + 88,100  [0x18d1d93b8,0x18d1d93c4]
    +       !       :               2 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 192  [0x103d3afac]  VQRecordReadPlan.swift:35
    +       !       :               | 2 Data._Representation.reserveCapacity(_:)  (in Foundation) + 644  [0x18ee367cc]
    +       !       :               |   2 __DataStorage.init(capacity:)  (in Foundation) + 164  [0x18ee3313c]
    +       !       :               |     2 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +       !       :               |       1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 476  [0x18cfd45d8]
    +       !       :               |       + 1 _os_unfair_lock_lock_slow  (in libsystem_platform.dylib) + 172  [0x18d1d73c0]
    +       !       :               |       +   1 __ulock_wait2  (in libsystem_kernel.dylib) + 8  [0x18d199c98]
    +       !       :               |       1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
    +       !       :               |         1 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 528  [0x18cfd4c30]
    +       !       :               |           1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 240  [0x18cfd6148]
    +       !       :               |             1 _xzm_reclaim_mark_used_locked  (in libsystem_malloc.dylib) + 36  [0x18cfd6a84]
    +       !       :               1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 324  [0x103d3b030]  /<compiler-generated>:0
    +       !       :               | 1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +       !       :               |   1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +       !       :               |     1 __DataStorage.__deallocating_deinit  (in Foundation) + 104  [0x18ee33850]
    +       !       :               |       1 xzm_segment_group_free_chunk  (in libsystem_malloc.dylib) + 860  [0x18cfd549c]
    +       !       :               |         1 _xzm_segment_group_span_mark_free  (in libsystem_malloc.dylib) + 136  [0x18cfd5bfc]
    +       !       :               |           1 _xzm_reclaim_mark_free  (in libsystem_malloc.dylib) + 112  [0x18cfd3df0]
    +       !       :               |             1 xzm_reclaim_mark_free_locked  (in libsystem_malloc.dylib) + 116  [0x18cfd3968]
    +       !       :               |               1 mach_vm_reclaim_try_enter  (in libsystem_kernel.dylib) + 296  [0x18d19f17c]
    +       !       :               |                 1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +       !       :               1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 168  [0x103d3af94]  VQRecordReadPlan.swift:34
    +       !       :               | 1 VQRecordReadBatch.Cancellation.canContinue.getter  (in slotstream) + 24  [0x103d3ae78]
    +       !       :               |   1 _pthread_mutex_firstfit_lock_slow  (in libsystem_pthread.dylib) + 216  [0x18d1ca8e0]
    +       !       :               |     1 _pthread_mutex_firstfit_lock_wait  (in libsystem_pthread.dylib) + 84  [0x18d1cce9c]
    +       !       :               |       1 __psynch_mutexwait  (in libsystem_kernel.dylib) + 8  [0x18d18e9dc]
    +       !       :               1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 508  [0x103d3b0e8]  VQRecordReadPlan.swift:43
    +       !       :                 1 specialized _ArrayBuffer._consumeAndCreateNew(bufferIsUnique:minimumCapacity:growForAppend:)  (in slotstream) + 176  [0x103aaec70]  /<compiler-generated>:0
    +       !       17 _dlock_wake  (in libdispatch.dylib) + 32  [0x18d015954]
    +       !         17 __ulock_wake  (in libsystem_kernel.dylib) + 8  [0x18d18dbcc]
    +       1 _dispatch_root_queue_drain  (in libdispatch.dylib) + 184  [0x18d0258d0]
    206 Thread_4840213   DispatchQueue_19: com.apple.root.user-interactive-qos  (concurrent)
    + 206 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   206 _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
    +     206 _dispatch_worker_thread2  (in libdispatch.dylib) + 184  [0x18d026120]
    +       206 _dispatch_root_queue_drain  (in libdispatch.dylib) + 708  [0x18d025adc]
    +         206 <deduplicated_symbol>  (in libdispatch.dylib) + 28  [0x18d04ad6c]
    +           206 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +             206 _dispatch_apply_invoke  (in libdispatch.dylib) + 248  [0x18d0272f4]
    +               206 _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
    +                 206 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +                   206 _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
    +                     206 _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
    +                       206 thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
    +                         206 partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
    +                           206 closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
    +                             206 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    +                               195 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
    +                               ! 169 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +                               ! : 169 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +                               ! :   169 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +                               ! 23 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
    +                               ! : 23 specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
    +                               ! :   23 __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
    +                               ! :     23 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                               ! :       23 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +                               ! :         23 _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
    +                               ! :           23 madvise  (in libsystem_kernel.dylib) + 8  [0x18d18e9b0]
    +                               ! 3 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 704  [0x103d443a8]  VQTensorFile.swift:146
    +                               !   3 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +                               !     3 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +                               11 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
    +                                 11 Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
    +                                   11 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
    +                                     11 __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
    +                                       11 _platform_memmove  (in libsystem_platform.dylib) + 88,100,...  [0x18d1d93b8,0x18d1d93c4,...]
    206 Thread_4840215   DispatchQueue_19: com.apple.root.user-interactive-qos  (concurrent)
    + 206 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   206 _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
    +     206 _dispatch_worker_thread2  (in libdispatch.dylib) + 184  [0x18d026120]
    +       205 _dispatch_root_queue_drain  (in libdispatch.dylib) + 708  [0x18d025adc]
    +       ! 205 <deduplicated_symbol>  (in libdispatch.dylib) + 28  [0x18d04ad6c]
    +       !   205 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +       !     205 _dispatch_apply_invoke  (in libdispatch.dylib) + 248  [0x18d0272f4]
    +       !       205 _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
    +       !         205 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +       !           205 _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
    +       !             205 _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
    +       !               205 thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
    +       !                 205 partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
    +       !                   205 closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
    +       !                     205 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    +       !                       193 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
    +       !                       : 171 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +       !                       : | 170 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +       !                       : | + 170 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +       !                       : | 1 outlined consume of Data._Representation  (in slotstream) + 60  [0x102d17930]  /<compiler-generated>:0
    +       !                       : 20 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
    +       !                       : | 20 specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
    +       !                       : |   20 __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
    +       !                       : |     20 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +       !                       : |       18 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +       !                       : |       + 18 _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
    +       !                       : |       +   18 madvise  (in libsystem_kernel.dylib) + 8  [0x18d18e9b0]
    +       !                       : |       1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 476  [0x18cfd45d8]
    +       !                       : |       + 1 _os_unfair_lock_lock_slow  (in libsystem_platform.dylib) + 172  [0x18d1d73c0]
    +       !                       : |       +   1 __ulock_wait2  (in libsystem_kernel.dylib) + 8  [0x18d199c98]
    +       !                       : |       1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +       !                       : 2 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 704  [0x103d443a8]  VQTensorFile.swift:146
    +       !                       :   1 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +       !                       :   + 1 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +       !                       :   1 VQTensorFile.verifyUnchanged()  (in slotstream) + 172  [0x103d43fb0]  VQTensorFile.swift:131
    +       !                       10 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
    +       !                       : 10 Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
    +       !                       :   10 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
    +       !                       :     10 __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
    +       !                       :       10 _platform_memmove  (in libsystem_platform.dylib) + 88,104  [0x18d1d93b8,0x18d1d93c8]
    +       !                       2 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 192  [0x103d3afac]  VQRecordReadPlan.swift:35
    +       !                         2 Data._Representation.reserveCapacity(_:)  (in Foundation) + 644  [0x18ee367cc]
    +       !                           2 __DataStorage.init(capacity:)  (in Foundation) + 164  [0x18ee3313c]
    +       !                             2 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +       !                               2 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
    +       !                                 2 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 528  [0x18cfd4c30]
    +       !                                   1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 240  [0x18cfd6148]
    +       !                                   | 1 _xzm_reclaim_mark_used_locked  (in libsystem_malloc.dylib) + 60  [0x18cfd6a9c]
    +       !                                   |   1 mach_vm_reclaim_try_cancel  (in libsystem_kernel.dylib) + 260  [0x18d19f2f8]
    +       !                                   |     1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +       !                                   1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 364  [0x18cfd61c4]
    +       !                                     1 xzm_reclaim_mark_free_locked  (in libsystem_malloc.dylib) + 116  [0x18cfd3968]
    +       !                                       1 mach_vm_reclaim_try_enter  (in libsystem_kernel.dylib) + 128  [0x18d19f0d4]
    +       1 _dispatch_root_queue_drain  (in libdispatch.dylib) + 780  [0x18d025b24]
    +         1 __DISPATCH_ROOT_QUEUE_CONTENDED_WAIT__  (in libdispatch.dylib) + 112  [0x18d025c58]
    +           1 syscall_thread_switch  (in libsystem_kernel.dylib) + 8  [0x18d18bca0]
    205 Thread_4840216   DispatchQueue_19: com.apple.root.user-interactive-qos  (concurrent)
    + 205 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   205 _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
    +     205 _dispatch_worker_thread2  (in libdispatch.dylib) + 184  [0x18d026120]
    +       205 _dispatch_root_queue_drain  (in libdispatch.dylib) + 708  [0x18d025adc]
    +         205 <deduplicated_symbol>  (in libdispatch.dylib) + 28  [0x18d04ad6c]
    +           205 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +             205 _dispatch_apply_invoke  (in libdispatch.dylib) + 248  [0x18d0272f4]
    +               205 _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
    +                 205 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +                   205 _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
    +                     205 _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
    +                       205 thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
    +                         205 partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
    +                           205 closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
    +                             205 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    +                               181 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
    +                               ! 155 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +                               ! : 155 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +                               ! :   155 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +                               ! 23 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
    +                               ! : 23 specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
    +                               ! :   21 __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
    +                               ! :   | 21 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                               ! :   |   21 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +                               ! :   |     21 _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
    +                               ! :   |       21 madvise  (in libsystem_kernel.dylib) + 8  [0x18d18e9b0]
    +                               ! :   2 __DataStorage.init(length:)  (in Foundation) + 256  [0x18ee32fe8]
    +                               ! :     2 __DataStorage.length.setter  (in Foundation) + 84  [0x18ee3226c]
    +                               ! :       2 __bzero  (in libsystem_platform.dylib) + 68  [0x18d1d9074]
    +                               ! 2 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 192  [0x103d441a8]  VQTensorFile.swift:138
    +                               ! : 2 specialized __RawDictionaryStorage.find<A>(_:hashValue:)  (in slotstream) + 108  [0x102cc7b14]  /<compiler-generated>:0
    +                               ! :   1 _stringCompareInternal(_:_:expecting:)  (in libswiftCore.dylib) + 176  [0x1a0c468a4]
    +                               ! :   | 1 _StringObject.sharedUTF8.getter  (in libswiftCore.dylib) + 24  [0x1a095fe5c]
    +                               ! :   |   1 -[__NSCFString _fastCStringContents:]  (in CoreFoundation) + 0  [0x18d272a30]
    +                               ! :   1 _stringCompareInternal(_:_:expecting:)  (in libswiftCore.dylib) + 16  [0x1a0c46804]
    +                               ! 1 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 704  [0x103d443a8]  VQTensorFile.swift:146
    +                               !   1 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +                               !     1 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +                               21 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
    +                               ! 21 Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
    +                               !   21 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
    +                               !     21 __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
    +                               !       21 _platform_memmove  (in libsystem_platform.dylib) + 88,100  [0x18d1d93b8,0x18d1d93c4]
    +                               2 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 192  [0x103d3afac]  VQRecordReadPlan.swift:35
    +                               ! 2 Data._Representation.reserveCapacity(_:)  (in Foundation) + 644  [0x18ee367cc]
    +                               !   1 __DataStorage.init(capacity:)  (in Foundation) + 164  [0x18ee3313c]
    +                               !   : 1 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                               !   :   1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 476  [0x18cfd45d8]
    +                               !   :     1 _os_unfair_lock_lock_slow  (in libsystem_platform.dylib) + 172  [0x18d1d73c0]
    +                               !   :       1 __ulock_wait2  (in libsystem_kernel.dylib) + 8  [0x18d199c98]
    +                               !   1 __DataStorage.init(capacity:)  (in Foundation) + 148  [0x18ee3312c]
    +                               1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 324  [0x103d3b030]  /<compiler-generated>:0
    +                                 1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                                   1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                                     1 __DataStorage.__deallocating_deinit  (in Foundation) + 104  [0x18ee33850]
    +                                       1 xzm_segment_group_free_chunk  (in libsystem_malloc.dylib) + 636  [0x18cfd53bc]
    +                                         1 _xzm_segment_group_segment_span_free_coalesce  (in libsystem_malloc.dylib) + 48  [0x18cfd58fc]
    192 Thread_4840217   DispatchQueue_19: com.apple.root.user-interactive-qos  (concurrent)
    + 192 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   192 _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
    +     192 _dispatch_worker_thread2  (in libdispatch.dylib) + 184  [0x18d026120]
    +       192 _dispatch_root_queue_drain  (in libdispatch.dylib) + 708  [0x18d025adc]
    +         192 <deduplicated_symbol>  (in libdispatch.dylib) + 28  [0x18d04ad6c]
    +           192 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +             192 _dispatch_apply_invoke  (in libdispatch.dylib) + 248  [0x18d0272f4]
    +               192 _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
    +                 192 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +                   192 _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
    +                     192 _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
    +                       192 thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
    +                         192 partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
    +                           192 closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
    +                             192 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    +                               181 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
    +                               ! 148 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +                               ! : 147 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +                               ! : | 147 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +                               ! : 1 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 544  [0x103d47664]  ExactRead.swift:0
    +                               ! :   1 swift_retain  (in libswiftCore.dylib) + 0  [0x1a0927004]
    +                               ! 29 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
    +                               ! : 29 specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
    +                               ! :   28 __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
    +                               ! :   | 28 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                               ! :   |   25 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +                               ! :   |   + 25 _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
    +                               ! :   |   +   25 madvise  (in libsystem_kernel.dylib) + 8  [0x18d18e9b0]
    +                               ! :   |   2 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
    +                               ! :   |   + 2 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 528  [0x18cfd4c30]
    +                               ! :   |   +   1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 196  [0x18cfd611c]
    +                               ! :   |   +   ! 1 _os_unfair_lock_lock_slow  (in libsystem_platform.dylib) + 172  [0x18d1d73c0]
    +                               ! :   |   +   !   1 __ulock_wait2  (in libsystem_kernel.dylib) + 8  [0x18d199c98]
    +                               ! :   |   +   1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 240  [0x18cfd6148]
    +                               ! :   |   +     1 _xzm_reclaim_mark_used_locked  (in libsystem_malloc.dylib) + 60  [0x18cfd6a9c]
    +                               ! :   |   +       1 mach_vm_reclaim_try_cancel  (in libsystem_kernel.dylib) + 260  [0x18d19f2f8]
    +                               ! :   |   +         1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +                               ! :   |   1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 476  [0x18cfd45d8]
    +                               ! :   |     1 _os_unfair_lock_lock_slow  (in libsystem_platform.dylib) + 172  [0x18d1d73c0]
    +                               ! :   |       1 __ulock_wait2  (in libsystem_kernel.dylib) + 8  [0x18d199c98]
    +                               ! :   1 __DataStorage.init(length:)  (in Foundation) + 256  [0x18ee32fe8]
    +                               ! :     1 __DataStorage.length.setter  (in Foundation) + 84  [0x18ee3226c]
    +                               ! :       1 __bzero  (in libsystem_platform.dylib) + 68  [0x18d1d9074]
    +                               ! 2 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 192  [0x103d441a8]  VQTensorFile.swift:138
    +                               ! : 1 specialized __RawDictionaryStorage.find<A>(_:)  (in slotstream) + 68  [0x102cc785c]  /<compiler-generated>:0
    +                               ! : | 1 Hasher._finalize()  (in libswiftCore.dylib) + 40  [0x1a0a750ec]
    +                               ! : 1 specialized __RawDictionaryStorage.find<A>(_:hashValue:)  (in slotstream) + 108  [0x102cc7b14]  /<compiler-generated>:0
    +                               ! :   1 _stringCompareInternal(_:_:expecting:)  (in libswiftCore.dylib) + 176  [0x1a0c468a4]
    +                               ! :     1 _StringObject.sharedUTF8.getter  (in libswiftCore.dylib) + 24  [0x1a095fe5c]
    +                               ! :       1 _CFStringGetCStringPtrInternal  (in CoreFoundation) + 568  [0x18d21cf00]
    +                               ! 2 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 536  [0x103d44300]  VQTensorFile.swift:143
    +                               !   2 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +                               !     2 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +                               9 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
    +                               ! 9 Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
    +                               !   9 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
    +                               !     9 __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
    +                               !       9 _platform_memmove  (in libsystem_platform.dylib) + 88  [0x18d1d93b8]
    +                               2 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 192  [0x103d3afac]  VQRecordReadPlan.swift:35
    +                                 2 Data._Representation.reserveCapacity(_:)  (in Foundation) + 644  [0x18ee367cc]
    +                                   1 __DataStorage.init(capacity:)  (in Foundation) + 164  [0x18ee3313c]
    +                                   : 1 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                                   :   1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
    +                                   :     1 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 540  [0x18cfd4c3c]
    +                                   1 __DataStorage.init(capacity:)  (in Foundation) + 148  [0x18ee3312c]
    189 Thread_4840275   DispatchQueue_19: com.apple.root.user-interactive-qos  (concurrent)
    + 189 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   189 _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
    +     189 _dispatch_worker_thread2  (in libdispatch.dylib) + 184  [0x18d026120]
    +       188 _dispatch_root_queue_drain  (in libdispatch.dylib) + 708  [0x18d025adc]
    +       ! 188 <deduplicated_symbol>  (in libdispatch.dylib) + 28  [0x18d04ad6c]
    +       !   188 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +       !     188 _dispatch_apply_invoke  (in libdispatch.dylib) + 248  [0x18d0272f4]
    +       !       188 _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
    +       !         188 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +       !           188 _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
    +       !             188 _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
    +       !               188 thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
    +       !                 188 partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
    +       !                   188 closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
    +       !                     188 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    +       !                       171 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
    +       !                       : 154 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +       !                       : | 154 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +       !                       : |   154 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +       !                       : 15 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
    +       !                       : | 15 specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
    +       !                       : |   15 __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
    +       !                       : |     15 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +       !                       : |       14 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +       !                       : |       + 14 _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
    +       !                       : |       +   14 madvise  (in libsystem_kernel.dylib) + 8  [0x18d18e9b0]
    +       !                       : |       1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
    +       !                       : |         1 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 528  [0x18cfd4c30]
    +       !                       : |           1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 240  [0x18cfd6148]
    +       !                       : |             1 _xzm_reclaim_mark_used_locked  (in libsystem_malloc.dylib) + 60  [0x18cfd6a9c]
    +       !                       : |               1 mach_vm_reclaim_try_cancel  (in libsystem_kernel.dylib) + 260  [0x18d19f2f8]
    +       !                       : |                 1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +       !                       : 1 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 192  [0x103d441a8]  VQTensorFile.swift:138
    +       !                       : | 1 specialized __RawDictionaryStorage.find<A>(_:hashValue:)  (in slotstream) + 108  [0x102cc7b14]  /<compiler-generated>:0
    +       !                       : |   1 _stringCompareFastUTF8(_:_:expecting:bothNFC:)  (in libswiftCore.dylib) + 68  [0x1a0c46b00]
    +       !                       : |     1 _platform_memcmp  (in libsystem_platform.dylib) + 96  [0x18d1d6f70]
    +       !                       : 1 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 704  [0x103d443a8]  VQTensorFile.swift:146
    +       !                       :   1 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +       !                       :     1 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +       !                       10 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
    +       !                       : 10 Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
    +       !                       :   10 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
    +       !                       :     10 __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
    +       !                       :       10 _platform_memmove  (in libsystem_platform.dylib) + 88,104  [0x18d1d93b8,0x18d1d93c8]
    +       !                       5 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 192  [0x103d3afac]  VQRecordReadPlan.swift:35
    +       !                       : 5 Data._Representation.reserveCapacity(_:)  (in Foundation) + 644  [0x18ee367cc]
    +       !                       :   4 __DataStorage.init(capacity:)  (in Foundation) + 164  [0x18ee3313c]
    +       !                       :   | 4 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +       !                       :   |   4 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
    +       !                       :   |     4 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 528  [0x18cfd4c30]
    +       !                       :   |       2 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 240  [0x18cfd6148]
    +       !                       :   |       + 2 _xzm_reclaim_mark_used_locked  (in libsystem_malloc.dylib) + 60  [0x18cfd6a9c]
    +       !                       :   |       +   2 mach_vm_reclaim_try_cancel  (in libsystem_kernel.dylib) + 260  [0x18d19f2f8]
    +       !                       :   |       +     2 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +       !                       :   |       1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 400  [0x18cfd61e8]
    +       !                       :   |       + 1 _os_unfair_lock_unlock_slow  (in libsystem_platform.dylib) + 56  [0x18d1d74bc]
    +       !                       :   |       +   1 __ulock_wake  (in libsystem_kernel.dylib) + 8  [0x18d18dbcc]
    +       !                       :   |       1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 172  [0x18cfd6104]
    +       !                       :   1 __DataStorage.init(capacity:)  (in Foundation) + 148  [0x18ee3312c]
    +       !                       2 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 324  [0x103d3b030]  /<compiler-generated>:0
    +       !                         2 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +       !                           2 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +       !                             2 __DataStorage.__deallocating_deinit  (in Foundation) + 104  [0x18ee33850]
    +       !                               1 xzm_segment_group_free_chunk  (in libsystem_malloc.dylib) + 636  [0x18cfd53bc]
    +       !                               | 1 _xzm_segment_group_segment_span_free_coalesce  (in libsystem_malloc.dylib) + 432  [0x18cfd5a7c]
    +       !                               |   1 _xzm_segment_group_span_mark_used  (in libsystem_malloc.dylib) + 148  [0x18cfd73b0]
    +       !                               |     1 _xzm_reclaim_mark_used  (in libsystem_malloc.dylib) + 124  [0x18cfd3fac]
    +       !                               |       1 _xzm_reclaim_mark_used_locked  (in libsystem_malloc.dylib) + 60  [0x18cfd6a9c]
    +       !                               |         1 mach_vm_reclaim_try_cancel  (in libsystem_kernel.dylib) + 228  [0x18d19f2d8]
    +       !                               1 xzm_segment_group_free_chunk  (in libsystem_malloc.dylib) + 860  [0x18cfd549c]
    +       !                                 1 _xzm_segment_group_span_mark_free  (in libsystem_malloc.dylib) + 136  [0x18cfd5bfc]
    +       !                                   1 _xzm_reclaim_mark_free  (in libsystem_malloc.dylib) + 112  [0x18cfd3df0]
    +       !                                     1 xzm_reclaim_mark_free_locked  (in libsystem_malloc.dylib) + 116  [0x18cfd3968]
    +       !                                       1 mach_vm_reclaim_try_enter  (in libsystem_kernel.dylib) + 296  [0x18d19f17c]
    +       !                                         1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +       1 _dispatch_root_queue_drain  (in libdispatch.dylib) + 780  [0x18d025b24]
    +         1 __DISPATCH_ROOT_QUEUE_CONTENDED_WAIT__  (in libdispatch.dylib) + 56  [0x18d025c20]
    166 Thread_4837873   DispatchQueue_19: com.apple.root.user-interactive-qos  (concurrent)
    + 166 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   166 _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
    +     166 _dispatch_worker_thread2  (in libdispatch.dylib) + 184  [0x18d026120]
    +       166 _dispatch_root_queue_drain  (in libdispatch.dylib) + 708  [0x18d025adc]
    +         166 <deduplicated_symbol>  (in libdispatch.dylib) + 28  [0x18d04ad6c]
    +           166 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +             166 _dispatch_apply_invoke  (in libdispatch.dylib) + 248  [0x18d0272f4]
    +               166 _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
    +                 166 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +                   166 _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
    +                     166 _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
    +                       166 thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
    +                         166 partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
    +                           166 closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
    +                             166 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    +                               159 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
    +                               ! 136 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +                               ! : 136 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +                               ! :   136 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +                               ! 21 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
    +                               ! : 21 specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
    +                               ! :   20 __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
    +                               ! :   | 20 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                               ! :   |   19 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +                               ! :   |   + 19 _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
    +                               ! :   |   +   19 madvise  (in libsystem_kernel.dylib) + 8  [0x18d18e9b0]
    +                               ! :   |   1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 476  [0x18cfd45d8]
    +                               ! :   |     1 _os_unfair_lock_lock_slow  (in libsystem_platform.dylib) + 172  [0x18d1d73c0]
    +                               ! :   |       1 __ulock_wait2  (in libsystem_kernel.dylib) + 8  [0x18d199c98]
    +                               ! :   1 __DataStorage.init(length:)  (in Foundation) + 256  [0x18ee32fe8]
    +                               ! :     1 __DataStorage.length.setter  (in Foundation) + 84  [0x18ee3226c]
    +                               ! :       1 __bzero  (in libsystem_platform.dylib) + 64  [0x18d1d9070]
    +                               ! 1 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 192  [0x103d441a8]  VQTensorFile.swift:138
    +                               ! : 1 specialized __RawDictionaryStorage.find<A>(_:)  (in slotstream) + 68  [0x102cc785c]  /<compiler-generated>:0
    +                               ! :   1 Hasher._finalize()  (in libswiftCore.dylib) + 100  [0x1a0a75128]
    +                               ! 1 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 216  [0x103d441c0]  VQTensorFile.swift:138
    +                               !   1 outlined init with copy of TensorRef  (in slotstream) + 52  [0x103ae1e00]  /<compiler-generated>:0
    +                               !     1 initializeWithCopy for TensorRef  (in slotstream) + 120  [0x103aef1f8]  /<compiler-generated>:0
    +                               !       1 swift_retain  (in libswiftCore.dylib) + 32  [0x1a0927024]
    +                               6 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
    +                               ! 6 Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
    +                               !   6 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
    +                               !     6 __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
    +                               !       6 _platform_memmove  (in libsystem_platform.dylib) + 88,104  [0x18d1d93b8,0x18d1d93c8]
    +                               1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 168  [0x103d3af94]  VQRecordReadPlan.swift:34
    +                                 1 VQRecordReadBatch.Cancellation.canContinue.getter  (in slotstream) + 24  [0x103d3ae78]
    +                                   1 _pthread_mutex_firstfit_lock_slow  (in libsystem_pthread.dylib) + 216  [0x18d1ca8e0]
    +                                     1 _pthread_mutex_firstfit_lock_wait  (in libsystem_pthread.dylib) + 84  [0x18d1cce9c]
    +                                       1 __psynch_mutexwait  (in libsystem_kernel.dylib) + 8  [0x18d18e9dc]
    163 Thread_4840214   DispatchQueue_19: com.apple.root.user-interactive-qos  (concurrent)
    + 163 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   163 _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
    +     163 _dispatch_worker_thread2  (in libdispatch.dylib) + 184  [0x18d026120]
    +       163 _dispatch_root_queue_drain  (in libdispatch.dylib) + 708  [0x18d025adc]
    +         163 <deduplicated_symbol>  (in libdispatch.dylib) + 28  [0x18d04ad6c]
    +           163 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +             163 _dispatch_apply_invoke  (in libdispatch.dylib) + 248  [0x18d0272f4]
    +               163 _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
    +                 163 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +                   163 _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
    +                     163 _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
    +                       163 thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
    +                         163 partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
    +                           163 closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
    +                             163 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    +                               153 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
    +                               ! 127 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +                               ! : 127 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +                               ! :   127 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +                               ! 25 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
    +                               ! : 25 specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
    +                               ! :   25 __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
    +                               ! :     25 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                               ! :       24 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +                               ! :       | 24 _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
    +                               ! :       |   24 madvise  (in libsystem_kernel.dylib) + 8  [0x18d18e9b0]
    +                               ! :       1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 476  [0x18cfd45d8]
    +                               ! :         1 _os_unfair_lock_lock_slow  (in libsystem_platform.dylib) + 172  [0x18d1d73c0]
    +                               ! :           1 __ulock_wait2  (in libsystem_kernel.dylib) + 8  [0x18d199c98]
    +                               ! 1 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 192  [0x103d441a8]  VQTensorFile.swift:138
    +                               !   1 specialized __RawDictionaryStorage.find<A>(_:hashValue:)  (in slotstream) + 76  [0x102cc7af4]  /<compiler-generated>:0
    +                               8 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
    +                               ! 8 Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
    +                               !   7 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
    +                               !   : 7 __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
    +                               !   :   7 _platform_memmove  (in libsystem_platform.dylib) + 88,104  [0x18d1d93b8,0x18d1d93c8]
    +                               !   1 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 96  [0x18ee35004]
    +                               !     1 DYLD-STUB$$_stdlib_isOSVersionAtLeastOrVariantVersionAtLeast(_:_:_:_:_:_:)  (in Foundation) + 0  [0x18f66ba64]
    +                               1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 324  [0x103d3b030]  /<compiler-generated>:0
    +                               ! 1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                               !   1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                               !     1 __DataStorage.__deallocating_deinit  (in Foundation) + 104  [0x18ee33850]
    +                               !       1 _xzm_free  (in libsystem_malloc.dylib) + 0  [0x18cfec118]
    +                               1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 192  [0x103d3afac]  VQRecordReadPlan.swift:35
    +                                 1 Data._Representation.reserveCapacity(_:)  (in Foundation) + 644  [0x18ee367cc]
    +                                   1 __DataStorage.init(capacity:)  (in Foundation) + 164  [0x18ee3313c]
    +                                     1 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                                       1 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
    +                                         1 _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 528  [0x18cfd4c30]
    +                                           1 _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 196  [0x18cfd611c]
    +                                             1 _os_unfair_lock_lock_slow  (in libsystem_platform.dylib) + 172  [0x18d1d73c0]
    +                                               1 __ulock_wait2  (in libsystem_kernel.dylib) + 8  [0x18d199c98]
    144 Thread_4840071   DispatchQueue_19: com.apple.root.user-interactive-qos  (concurrent)
    + 144 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   144 _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
    +     144 _dispatch_worker_thread2  (in libdispatch.dylib) + 184  [0x18d026120]
    +       144 _dispatch_root_queue_drain  (in libdispatch.dylib) + 708  [0x18d025adc]
    +         144 <deduplicated_symbol>  (in libdispatch.dylib) + 28  [0x18d04ad6c]
    +           144 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +             144 _dispatch_apply_invoke  (in libdispatch.dylib) + 248  [0x18d0272f4]
    +               144 _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
    +                 144 _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
    +                   144 _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
    +                     144 _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
    +                       144 thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
    +                         144 partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
    +                           144 closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
    +                             143 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    +                             ! 139 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
    +                             ! : 110 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
    +                             ! : | 109 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
    +                             ! : | + 109 pread  (in libsystem_kernel.dylib) + 8  [0x18d18d650]
    +                             ! : | 1 specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1460  [0x103d479f8]  /<compiler-generated>:0
    +                             ! : |   1 VQRecordReadBatch.Cancellation.canContinue.getter  (in slotstream) + 36  [0x103d3ae84]
    +                             ! : |     1 -[NSLock unlock]  (in Foundation) + 28  [0x18ea826a8]
    +                             ! : 25 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
    +                             ! : | 25 specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
    +                             ! : |   25 __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
    +                             ! : |     25 _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
    +                             ! : |       25 xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
    +                             ! : |         25 _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
    +                             ! : |           25 madvise  (in libsystem_kernel.dylib) + 8  [0x18d18e9b0]
    +                             ! : 3 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 536  [0x103d44300]  VQTensorFile.swift:143
    +                             ! : | 3 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +                             ! : |   3 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +                             ! : 1 VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 704  [0x103d443a8]  VQTensorFile.swift:146
    +                             ! :   1 VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
    +                             ! :     1 fstat  (in libsystem_kernel.dylib) + 8  [0x18d19a288]
    +                             ! 1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 156  [0x103d3af88]  /<compiler-generated>:0
    +                             ! : 1 swift_bridgeObjectRetain  (in libswiftCore.dylib) + 8  [0x1a09263d0]
    +                             ! 1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 324  [0x103d3b030]  /<compiler-generated>:0
    +                             ! : 1 swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
    +                             ! :   1 _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
    +                             ! :     1 __DataStorage.__deallocating_deinit  (in Foundation) + 104  [0x18ee33850]
    +                             ! :       1 xzm_segment_group_free_chunk  (in libsystem_malloc.dylib) + 636  [0x18cfd53bc]
    +                             ! :         1 _xzm_segment_group_segment_span_free_coalesce  (in libsystem_malloc.dylib) + 256  [0x18cfd59cc]
    +                             ! :           1 _xzm_segment_group_span_mark_used  (in libsystem_malloc.dylib) + 148  [0x18cfd73b0]
    +                             ! :             1 _xzm_reclaim_mark_used  (in libsystem_malloc.dylib) + 124  [0x18cfd3fac]
    +                             ! :               1 _xzm_reclaim_mark_used_locked  (in libsystem_malloc.dylib) + 60  [0x18cfd6a9c]
    +                             ! :                 1 mach_vm_reclaim_try_cancel  (in libsystem_kernel.dylib) + 260  [0x18d19f2f8]
    +                             ! :                   1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +                             ! 1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 168  [0x103d3af94]  VQRecordReadPlan.swift:34
    +                             ! : 1 VQRecordReadBatch.Cancellation.canContinue.getter  (in slotstream) + 24  [0x103d3ae78]
    +                             ! :   1 -[NSLock lock]  (in Foundation) + 0  [0x18ea822d8]
    +                             ! 1 VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
    +                             !   1 Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
    +                             !     1 Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
    +                             !       1 __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
    +                             !         1 _platform_memmove  (in libsystem_platform.dylib) + 88  [0x18d1d93b8]
    +                             1 partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
    68 Thread_<multiple>   DispatchQueue_74: com.Metal.CompletionQueueDispatch  (serial)
    + 68 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
    +   68 _pthread_wqthread  (in libsystem_pthread.dylib) + 292  [0x18d1cbec0]
    +     68 _dispatch_workloop_worker_thread  (in libdispatch.dylib) + 720  [0x18d026734]
    +       68 _dispatch_root_queue_drain_deferred_wlh  (in libdispatch.dylib) + 284  [0x18d026e34]
    +         68 _dispatch_lane_invoke  (in libdispatch.dylib) + 392  [0x18d01cb2c]
    +           68 _dispatch_lane_serial_drain  (in libdispatch.dylib) + 332  [0x18d01be98]
    +             68 _dispatch_lane_invoke  (in libdispatch.dylib) + 448  [0x18d01cb64]
    +               68 _dispatch_lane_serial_drain  (in libdispatch.dylib) + 332  [0x18d01be98]
    +                 68 _dispatch_mach_invoke  (in libdispatch.dylib) + 472  [0x18d030bec]
    +                   68 _dispatch_lane_serial_drain  (in libdispatch.dylib) + 332  [0x18d01be98]
    +                     67 _dispatch_mach_msg_invoke  (in libdispatch.dylib) + 480  [0x18d02fe94]
    +                     ! 67 _dispatch_client_callout4  (in libdispatch.dylib) + 16  [0x18d02d4f8]
    +                     !   67 __IOGPUNotificationQueueSetDispatchQueue_block_invoke  (in IOGPU) + 64  [0x1b287d76c]
    +                     !     65 IOGPUNotificationQueueDispatchAvailableCompletionNotifications  (in IOGPU) + 136  [0x1b287d65c]
    +                     !     : 64 -[_MTLCommandQueue commandBufferDidComplete:startTime:completionTime:error:]  (in Metal) + 108  [0x199862f18]
    +                     !     : | 58 -[IOGPUMetalCommandBuffer didCompleteWithStartTime:endTime:error:]  (in IOGPU) + 220  [0x1b2871230]
    +                     !     : | + 58 -[_MTLCommandBuffer didCompleteWithStartTime:endTime:error:]  (in Metal) + 612  [0x199863284]
    +                     !     : | +   54 MTLDispatchListApply  (in Metal) + 60  [0x199862e88]
    +                     !     : | +   ! 52 _Block_release  (in libsystem_blocks.dylib) + 236  [0x18ce991c0]
    +                     !     : | +   ! : 50 _call_dispose_helpers_excp  (in libsystem_blocks.dylib) + 48  [0x18ce993fc]
    +                     !     : | +   ! : | 48 _Block_object_dispose  (in libsystem_blocks.dylib) + 256  [0x18ce98cf8]
    +                     !     : | +   ! : | + 32 std::__function::__func<mlx::core::gpu::eval(mlx::core::array&)::$_1, void (MTL::CommandBuffer*)>::~__func()  (in slotstream) + 108  [0x1035b45c8]  function.h:155
    +                     !     : | +   ! : | + ! 32 std::__shared_ptr_emplace<mlx::core::array::Data>::__on_zero_shared()  (in slotstream) + 52  [0x102da9e40]  shared_ptr.h:184
    +                     !     : | +   ! : | + !   28 mlx::core::metal::MetalAllocator::free(mlx::core::allocator::Buffer)  (in slotstream) + 36  [0x103585e78]  allocator.cpp:188
    +                     !     : | +   ! : | + !   : 28 std::mutex::lock()  (in libc++.1.dylib) + 16  [0x18d0e2010]
    +                     !     : | +   ! : | + !   :   28 _pthread_mutex_firstfit_lock_slow  (in libsystem_pthread.dylib) + 216  [0x18d1ca8e0]
    +                     !     : | +   ! : | + !   :     28 _pthread_mutex_firstfit_lock_wait  (in libsystem_pthread.dylib) + 84  [0x18d1cce9c]
    +                     !     : | +   ! : | + !   :       28 __psynch_mutexwait  (in libsystem_kernel.dylib) + 8  [0x18d18e9dc]
    +                     !     : | +   ! : | + !   4 mlx::core::metal::MetalAllocator::free(mlx::core::allocator::Buffer)  (in slotstream) + 96  [0x103585eb4]  allocator.cpp:191
    +                     !     : | +   ! : | + !     3 mlx::core::BufferCache<MTL::Buffer>::recycle_to_cache(MTL::Buffer*)  (in slotstream) + 160,184  [0x10358600c,0x103586024]  buffer_cache.h:55
    +                     !     : | +   ! : | + !     1 mlx::core::BufferCache<MTL::Buffer>::recycle_to_cache(MTL::Buffer*)  (in slotstream) + 40  [0x103585f94]  buffer_cache.h:51
    +                     !     : | +   ! : | + !       1 operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
    +                     !     : | +   ! : | + !         1 _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 764  [0x18cff1238]
    +                     !     : | +   ! : | + 4 std::__function::__func<mlx::core::gpu::eval(mlx::core::array&)::$_1, void (MTL::CommandBuffer*)>::~__func()  (in slotstream) + 124,44,...  [0x1035b45d8,0x1035b4588,...]  function.h:155
    +                     !     : | +   ! : | + 4 std::__function::__func<mlx::core::metal::CommandEncoder::commit(std::function<void ()>)::$_0, void (MTL::CommandBuffer*)>::~__func()  (in slotstream) + 32  [0x1035a745c]  function.h:155
    +                     !     : | +   ! : | + ! 4 mlx::core::metal::CommandEncoder::commit(std::function<void ()>)::$_0::~$_0()  (in slotstream) + 148  [0x1035a1e8c]  device.cpp:521
    +                     !     : | +   ! : | + !   4 std::__shared_ptr_emplace<mlx::core::metal::EventImpl>::__on_zero_shared()  (in slotstream) + 48  [0x1035b4f5c]  shared_ptr.h:184
    +                     !     : | +   ! : | + !     4 -[_MTLSharedEvent dealloc]  (in Metal) + 68  [0x199a03008]
    +                     !     : | +   ! : | + !       4 -[IOSurfaceSharedEvent dealloc]  (in IOSurface) + 68  [0x19981f294]
    +                     !     : | +   ! : | + !         4 mach_port_mod_refs  (in libsystem_kernel.dylib) + 40  [0x18d18c35c]
    +                     !     : | +   ! : | + !           4 _kernelrpc_mach_port_mod_refs_trap  (in libsystem_kernel.dylib) + 8  [0x18d18baf0]
    +                     !     : | +   ! : | + 4 std::__function::__func<mlx::core::metal::CommandEncoder::end_encoding()::$_0, void (MTL::CommandBuffer*)>::~__func()  (in slotstream) + 32  [0x1035a6a04]  function.h:155
    +                     !     : | +   ! : | + ! 3 mlx::core::metal::CommandEncoder::end_encoding()::$_0::~$_0()  (in slotstream) + 188  [0x1035a16f0]  device.cpp:471
    +                     !     : | +   ! : | + ! : 3 -[IOGPUMetalFence dealloc]  (in IOGPU) + 40  [0x1b287d054]
    +                     !     : | +   ! : | + ! :   3 -[IOGPUMTLFence dealloc]  (in IOGPU) + 84  [0x1b288ca2c]
    +                     !     : | +   ! : | + ! :     3 IOConnectCallMethod  (in IOKit) + 176  [0x191530d84]
    +                     !     : | +   ! : | + ! :       3 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                     !     : | +   ! : | + ! :         3 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                     !     : | +   ! : | + ! :           3 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                     !     : | +   ! : | + ! 1 mlx::core::metal::CommandEncoder::end_encoding()::$_0::~$_0()  (in slotstream) + 48  [0x1035a1664]  device.cpp:471
    +                     !     : | +   ! : | + !   1 -[IOGPUMetalFence dealloc]  (in IOGPU) + 40  [0x1b287d054]
    +                     !     : | +   ! : | + !     1 -[IOGPUMTLFence dealloc]  (in IOGPU) + 84  [0x1b288ca2c]
    +                     !     : | +   ! : | + !       1 IOConnectCallMethod  (in IOKit) + 176  [0x191530d84]
    +                     !     : | +   ! : | + !         1 io_connect_method  (in IOKit) + 520  [0x191530ff4]
    +                     !     : | +   ! : | + !           1 mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
    +                     !     : | +   ! : | + !             1 mach_msg2_trap  (in libsystem_kernel.dylib) + 8  [0x18d18bc34]
    +                     !     : | +   ! : | + 2 std::__function::__func<mlx::core::gpu::eval(mlx::core::array&)::$_1, void (MTL::CommandBuffer*)>::~__func()  (in slotstream) + 56  [0x1035b4594]  function.h:155
    +                     !     : | +   ! : | + ! 1 _xzm_free  (in libsystem_malloc.dylib) + 352  [0x18cfec278]
    +                     !     : | +   ! : | + ! : 1 _platform_memset  (in libsystem_platform.dylib) + 180  [0x18d1d9144]
    +                     !     : | +   ! : | + ! 1 _xzm_free  (in libsystem_malloc.dylib) + 256  [0x18cfec218]
    +                     !     : | +   ! : | + 1 _xzm_free  (in libsystem_malloc.dylib) + 352  [0x18cfec278]
    +                     !     : | +   ! : | + ! 1 _platform_memset  (in libsystem_platform.dylib) + 180  [0x18d1d9144]
    +                     !     : | +   ! : | + 1 std::__function::__func<mlx::core::gpu::eval(mlx::core::array&)::$_1, void (MTL::CommandBuffer*)>::~__func()  (in slotstream) + 140  [0x1035b45e8]  function.h:155
    +                     !     : | +   ! : | +   1 _xzm_free  (in libsystem_malloc.dylib) + 564  [0x18cfec34c]
    +                     !     : | +   ! : | 1 _call_custom_dispose_helper  (in libsystem_blocks.dylib) + 56  [0x18ce994c8]
    +                     !     : | +   ! : | 1 _xzm_free  (in libsystem_malloc.dylib) + 684  [0x18cfec3c4]
    +                     !     : | +   ! : 1 _Block_object_dispose  (in libsystem_blocks.dylib) + 268  [0x18ce98d04]
    +                     !     : | +   ! : 1 _call_dispose_helpers_excp  (in libsystem_blocks.dylib) + 84  [0x18ce99420]
    +                     !     : | +   ! :   1 _cleanup_generic_captures  (in libsystem_blocks.dylib) + 0  [0x18ce99eac]
    +                     !     : | +   ! 1 _Block_release  (in libsystem_blocks.dylib) + 260  [0x18ce991d8]
    +                     !     : | +   ! : 1 _xzm_free  (in libsystem_malloc.dylib) + 320  [0x18cfec258]
    +                     !     : | +   ! 1 _Block_release  (in libsystem_blocks.dylib) + 36  [0x18ce990f8]
    +                     !     : | +   4 MTLDispatchListApply  (in Metal) + 52  [0x199862e80]
    +                     !     : | +     3 invocation function for block in MTL::CommandBuffer::addCompletedHandler(std::function<void (MTL::CommandBuffer*)> const&)  (in slotstream) + 48  [0x1035a457c]  MTLCommandBuffer.hpp:287
    +                     !     : | +     : 1 std::__function::__func<mlx::core::metal::CommandEncoder::commit(std::function<void ()>)::$_0, void (MTL::CommandBuffer*)>::operator()(MTL::CommandBuffer*&&)  (in slotstream) + 0  [0x1035a74e0]  function.h:173
    +                     !     : | +     : 1 std::__function::__func<mlx::core::metal::CommandEncoder::commit(std::function<void ()>)::$_0, void (MTL::CommandBuffer*)>::operator()(MTL::CommandBuffer*&&)  (in slotstream) + 132  [0x1035a7564]  function.h:174
    +                     !     : | +     : | 1 std::__get_sp_mut(void const*)  (in libc++.1.dylib) + 32  [0x18d0e35c4]
    +                     !     : | +     : |   1 std::__hash_memory(void const*, unsigned long)  (in libc++.1.dylib) + 32  [0x18d0fa8f0]
    +                     !     : | +     : |     1 std::__murmur2_or_cityhash<unsigned long, 64ul>::__hash_len_0_to_16[abi:nqe210106](char const*, unsigned long)  (in libc++.1.dylib) + 84  [0x18d0fab5c]
    +                     !     : | +     : 1 std::__function::__func<mlx::core::metal::CommandEncoder::end_encoding()::$_0, void (MTL::CommandBuffer*)>::operator()(MTL::CommandBuffer*&&)  (in slotstream) + 308  [0x1035a6bbc]  function.h:174
    +                     !     : | +     :   1 std::__hash_table<std::__hash_value_type<void const*, NS::SharedPtr<MTL::Fence>>>::remove(std::__hash_const_iterator<std::__hash_node<std::__hash_value_type<void const*, NS::SharedPtr<MTL::Fence>>, void*>*>)  (in slotstream) + 176  [0x1035a7388]  __hash_table:1953
    +                     !     : | +     1 invocation function for block in MTL::CommandBuffer::addCompletedHandler(std::function<void (MTL::CommandBuffer*)> const&)  (in slotstream) + 0  [0x1035a454c]  MTLCommandBuffer.hpp:287
    +                     !     : | 6 -[IOGPUMetalCommandBuffer didCompleteWithStartTime:endTime:error:]  (in IOGPU) + 240  [0x1b2871244]
    +                     !     : |   6 IOGPUMetalCommandBufferStorageDealloc  (in IOGPU) + 76  [0x1b287f568]
    +                     !     : |     4 IOGPUMetalCommandBufferStorageReset  (in IOGPU) + 52  [0x1b287f5dc]
    +                     !     : |     ! 4 -[MTLResourceList releaseAllObjectsAndReset]  (in Metal) + 96  [0x199863548]
    +                     !     : |     !   4 _platform_memset  (in libsystem_platform.dylib) + 140  [0x18d1d911c]
    +                     !     : |     2 IOGPUMetalCommandBufferStorageReset  (in IOGPU) + 124  [0x1b287f624]
    +                     !     : |       2 _iogpuMetalCommandBufferStorageReleaseCurrentResources(IOGPUMetalCommandBufferStorage*)  (in IOGPU) + 60  [0x1b287f7d0]
    +                     !     : |         1 IOGPUMetalPooledResourceRelease  (in IOGPU) + 252  [0x1b28834e4]
    +                     !     : |         : 1 mach_absolute_time  (in libsystem_kernel.dylib) + 108  [0x18d18c10c]
    +                     !     : |         1 IOGPUMetalPooledResourceRelease  (in IOGPU) + 52  [0x1b288341c]
    +                     !     : 1 -[_MTLCommandQueue commandBufferDidComplete:startTime:completionTime:error:]  (in Metal) + 144  [0x199862f3c]
    +                     !     :   1 -[NSMutableArray removeObject:]  (in CoreFoundation) + 60  [0x18d27d51c]
    +                     !     :     1 -[__NSArrayM count]  (in CoreFoundation) + 0  [0x18d22ceac]
    +                     !     2 IOGPUNotificationQueueDispatchAvailableCompletionNotifications  (in IOGPU) + 144  [0x1b287d664]
    +                     !       2 _Block_release  (in libsystem_blocks.dylib) + 236  [0x18ce991c0]
    +                     !         2 _call_dispose_helpers_excp  (in libsystem_blocks.dylib) + 48  [0x18ce993fc]
    +                     !           1 -[AGXG17XFamilyCommandBuffer dealloc]  (in AGXMetalG17X) + 496  [0x117df0700]
    +                     !           | 1 -[IOGPUMetalCommandBuffer dealloc]  (in IOGPU) + 212  [0x1b28710a8]
    +                     !           |   1 -[_MTLCommandBuffer dealloc]  (in Metal) + 452  [0x1998639e8]
    +                     !           1 _call_custom_dispose_helper  (in libsystem_blocks.dylib) + 16  [0x18ce994a0]
    +                     1 _dispatch_mach_msg_invoke  (in libdispatch.dylib) + 500  [0x18d02fea8]
    +                       1 dispatch_release  (in libdispatch.dylib) + 152  [0x18d0141b4]
    +                         1 objc_msgSend$dealloc  (in libdispatch.dylib) + 0  [0x18d059160]
    1 Thread_4840214   DispatchQueue_75: IOGPUNotificationQueueDispatchMach  (serial)
      1 start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
        1 _pthread_wqthread  (in libsystem_pthread.dylib) + 292  [0x18d1cbec0]
          1 _dispatch_workloop_worker_thread  (in libdispatch.dylib) + 720  [0x18d026734]
            1 _dispatch_root_queue_drain_deferred_wlh  (in libdispatch.dylib) + 284  [0x18d026e34]
              1 _dispatch_lane_invoke  (in libdispatch.dylib) + 392  [0x18d01cb2c]
                1 _dispatch_lane_serial_drain  (in libdispatch.dylib) + 332  [0x18d01be98]
                  1 _dispatch_lane_invoke  (in libdispatch.dylib) + 448  [0x18d01cb64]
                    1 _dispatch_lane_serial_drain  (in libdispatch.dylib) + 332  [0x18d01be98]
                      1 _dispatch_mach_invoke  (in libdispatch.dylib) + 472  [0x18d030bec]
                        1 _dispatch_lane_serial_drain  (in libdispatch.dylib) + 104  [0x18d01bdb4]

Total number in stack (recursive counted multiple, when >=5):
        29       mach_msg2_internal  (in libsystem_kernel.dylib) + 76  [0x18d19e5a4]
        29       mach_msg2_trap  (in libsystem_kernel.dylib) + 0  [0x18d18bc2c]
        28       _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib) + 0  [0x18cff0f3c]
        28       io_connect_method  (in IOKit) + 520  [0x191530ff4]
        23       operator new(unsigned long)  (in libc++abi.dylib) + 52  [0x18d1867e8]
        23       start_wqthread  (in libsystem_pthread.dylib) + 8  [0x18d1cac10]
        22       _platform_memchr  (in libsystem_platform.dylib) + 0  [0x18d1d6e00]
        20       IOConnectCallMethod  (in IOKit) + 236  [0x191530dc0]
        20       _dispatch_client_callout  (in libdispatch.dylib) + 16  [0x18d02d4b0]
        20       _platform_memmove  (in libsystem_platform.dylib) + 0  [0x18d1d9360]
        18       _xzm_malloc_large_huge  (in libsystem_malloc.dylib) + 464  [0x18cfeb458]
        17       -[IOGPUMetalResource initWithDevice:remoteStorageResource:options:args:argsSize:]  (in IOGPU) + 484  [0x1b288490c]
        16       IOGPUResourceCreate  (in IOGPU) + 248  [0x1b288b878]
        15       _swift_release_dealloc  (in libswiftCore.dylib) + 64  [0x1a092ae88]
        15       swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 168  [0x1a098de40]
        14       -[AGXBuffer initWithDevice:length:alignment:options:isSuballocDisabled:pinnedGPULocation:]  (in AGXMetalG17X) + 32  [0x117d65a50]
        14       -[AGXBuffer(Internal) initWithDevice:length:alignment:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 44  [0x117d65f6c]
        14       _platform_memcmp  (in libsystem_platform.dylib) + 0  [0x18d1d6f10]
        14       mach_absolute_time  (in libsystem_kernel.dylib) + 0  [0x18d18c0a0]
        14       mlx::core::metal::MetalAllocator::malloc(unsigned long)  (in slotstream) + 264  [0x103585608]  allocator.cpp:152
        13       _xzm_free  (in libsystem_malloc.dylib) + 0  [0x18cfec118]
        12       VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 604  [0x103d44344]  VQTensorFile.swift:144
        12       __workq_kernreturn  (in libsystem_kernel.dylib) + 0  [0x18d18d9e8]
        12       pread  (in libsystem_kernel.dylib) + 0  [0x18d18d648]
        11       DYLD-STUB$$memchr  (in slotstream) + 0  [0x1040eaef8]
        11       VQTensorFile.verifyUnchanged()  (in slotstream) + 72  [0x103d43f4c]  VQTensorFile.swift:131
        11       _pthread_wqthread  (in libsystem_pthread.dylib) + 368  [0x18d1cbf0c]
        11       fstat  (in libsystem_kernel.dylib) + 0  [0x18d19a280]
        11       specialized Data._Representation.withUnsafeMutableBytes<A>(_:)  (in slotstream) + 1492  [0x103d47a18]  /<compiler-generated>:0
        10       -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 460  [0x117d65ea8]
        10       -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:args:argsSize:deallocator:]  (in IOGPU) + 60  [0x1b286fc04]
        10       -[IOGPUMetalBuffer initWithDevice:pointer:length:alignment:options:sysMemSize:gpuAddress:gpuTag:placementSparsePageSize:placementSparseResidencyBytes:args:argsSize:deallocator:]  (in IOGPU) + 480  [0x1b286fe38]
        10       Data.InlineSlice.append(contentsOf:)  (in Foundation) + 212  [0x18ee35078]
        10       Data._Representation.append(contentsOf:)  (in Foundation) + 628  [0x18ee384b0]
        10       VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 288  [0x103d3b00c]  VQRecordReadPlan.swift:39
        10       VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 312  [0x103d3b024]  VQRecordReadPlan.swift:39
        10       VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 564  [0x103d4431c]  VQTensorFile.swift:144
        10       __DataStorage.init(length:)  (in Foundation) + 208  [0x18ee32fb8]
        10       __DataStorage.replaceBytes(in:with:length:)  (in Foundation) + 208  [0x18ee32d5c]
        10       _dispatch_apply_invoke3  (in libdispatch.dylib) + 336  [0x18d0281a4]
        10       _dispatch_client_callout2  (in libdispatch.dylib) + 16  [0x18d02d4c8]
        10       _dispatch_once_callout  (in libdispatch.dylib) + 32  [0x18d016630]
        10       _platform_memset  (in libsystem_platform.dylib) + 0  [0x18d1d9090]
        10       _pthread_wqthread  (in libsystem_pthread.dylib) + 232  [0x18d1cbe84]
        10       _xzm_segment_group_clear_chunk  (in libsystem_malloc.dylib) + 44  [0x18cfd43a8]
        10       closure #2 in static VQRecordReadBatch.read(experts:pieceBytes:cancellation:reader:)  (in slotstream) + 224  [0x103d3a2b0]  VQRecordReadBatch.swift:63
        10       iokit_user_client_trap  (in IOKit) + 0  [0x19154cad8]
        10       madvise  (in libsystem_kernel.dylib) + 0  [0x18d18e9a8]
        10       partial apply for closure #2 in closure #2 in VQRecordCache.call(_:layer:routes:)  (in slotstream) + 12  [0x103d39e7c]  /<compiler-generated>:0
        10       partial apply for thunk for @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 28  [0x1a7529e84]
        10       specialized Data.init(count:)  (in slotstream) + 84  [0x1039ea788]  /<compiler-generated>:0
        10       thunk for @escaping @callee_guaranteed (@unowned Int) -> ()  (in libswiftDispatch.dylib) + 32  [0x1a7529eb0]
        10       xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 1260  [0x18cfd48e8]
        10       xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 504  [0x18cfd45f4]
        9       <deduplicated_symbol>  (in libdispatch.dylib) + 28  [0x18d04ad6c]
        9       _dispatch_apply_invoke  (in libdispatch.dylib) + 248  [0x18d0272f4]
        9       _dispatch_root_queue_drain  (in libdispatch.dylib) + 708  [0x18d025adc]
        9       _dispatch_worker_thread2  (in libdispatch.dylib) + 184  [0x18d026120]
        9       _xzm_segment_group_find_and_allocate_chunk  (in libsystem_malloc.dylib) + 528  [0x18cfd4c30]
        9       start_wqthread  (in libsystem_pthread.dylib) + 0  [0x18d1cac08]
        8       -[AGXBuffer(Internal) initWithDevice:length:alignment:pointerTag:options:isSuballocDisabled:resourceInArgs:pinnedGPULocation:]  (in AGXMetalG17X) + 388  [0x117d65e60]
        8       -[IOGPUMetalBuffer initWithPrimaryBuffer:heapIndex:bufferIndex:bufferOffset:length:args:argsSize:gpuTag:]  (in IOGPU) + 276  [0x1b28701cc]
        8       -[IOSurfaceSharedEvent waitUntilSignaledValue:timeoutMS:]  (in IOSurface) + 72  [0x199826184]
        8       IOConnectCallMethod  (in IOKit) + 176  [0x191530d84]
        8       Substring.subscript.getter  (in libswiftCore.dylib) + 0  [0x1a0c6bf00]
        8       __ulock_wait2  (in libsystem_kernel.dylib) + 0  [0x18d199c90]
        8       _os_unfair_lock_lock_slow  (in libsystem_platform.dylib) + 172  [0x18d1d73c0]
        8       _xzm_reclaim_mark_used_locked  (in libsystem_malloc.dylib) + 60  [0x18cfd6a9c]
        8       mlx::core::Event::wait()  (in slotstream) + 68  [0x1035b4a2c]  event.cpp:48
        8       mlx::core::array::wait()  (in slotstream) + 48  [0x102da7c24]  array.cpp:148
        8       mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 120  [0x103794dc4]  transforms.cpp:378
        8       mlx::core::eval(std::vector<mlx::core::array>)  (in slotstream) + 128  [0x103794dcc]  transforms.cpp:378
        7       -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithConfig:]  (in AGXMetalG17X) + 164  [0x117ded950]
        7       -[AGXG17XFamilyCommandBuffer computeCommandEncoderWithDispatchType:]  (in AGXMetalG17X) + 276  [0x117ded754]
        7       -[AGXG17XFamilyComputeContext dispatchThreads:threadsPerThreadgroup:]  (in AGXMetalG17X) + 304  [0x117e478e8]
        7       Data._Representation.reserveCapacity(_:)  (in Foundation) + 644  [0x18ee367cc]
        7       VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 192  [0x103d3afac]  VQRecordReadPlan.swift:35
        7       VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 704  [0x103d443a8]  VQTensorFile.swift:146
        7       __DataStorage.__deallocating_deinit  (in Foundation) + 104  [0x18ee33850]
        7       __DataStorage.init(capacity:)  (in Foundation) + 164  [0x18ee3313c]
        7       _xzm_free  (in libsystem_malloc.dylib) + 352  [0x18cfec278]
        7       mach_vm_reclaim_try_cancel  (in libsystem_kernel.dylib) + 260  [0x18d19f2f8]
        7       mlx::core::metal::CommandEncoder::dispatch_threads(MTL::Size, MTL::Size)  (in slotstream) + 108  [0x1035a0d84]  device.cpp:421
        7       mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 56  [0x1035a06d0]  device.cpp:580
        6       -[AGXG17XFamilyCommandBuffer commit]  (in AGXMetalG17X) + 888  [0x117def984]
        6       -[IOGPUMetalCommandBuffer commit]  (in IOGPU) + 228  [0x1b2871478]
        6       -[_MTLCommandQueue commitCommandBuffer:wake:]  (in Metal) + 268  [0x19986242c]
        6       AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::insertIndirectTGOptKernel(eAGXDataBufferPools, indirectTGOptParams*&, unsigned short*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::InstanceTokenImproved*&, AGX::CDMEncoderGen7<AGX::HAL300::ESLEncoder, AGX::HAL300::DeviceConstants>::FenceToken*&)  (in AGXMetalG17X) + 456  [0x117e40568]
        6       AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3EncodedInstr<AGXIotoInstruction_SPECLM_0>::AGX3EncodedInstr(AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3Instr<AGXIotoInstruction_SPECLM_0> const&)  (in AGXMetalG17X) + 0  [0x117de5648]
        6       DYLD-STUB$$memcmp  (in slotstream) + 0  [0x1040eaf04]
        6       VQRecordReadPlan.read(expert:shouldContinue:)  (in slotstream) + 324  [0x103d3b030]  /<compiler-generated>:0
        6       __bzero  (in libsystem_platform.dylib) + 0  [0x18d1d9030]
        6       _dispatch_event_loop_poke  (in libdispatch.dylib) + 336  [0x18d035eb0]
        6       _dispatch_kq_poll  (in libdispatch.dylib) + 220  [0x18d036a64]
        6       _dispatch_lane_serial_drain  (in libdispatch.dylib) + 332  [0x18d01be98]
        6       _pthread_wqthread  (in libsystem_pthread.dylib) + 292  [0x18d1cbec0]
        6       _xzm_segment_group_span_mark_smaller  (in libsystem_malloc.dylib) + 240  [0x18cfd6148]
        6       dispatch_source_merge_data  (in libdispatch.dylib) + 92  [0x18d029458]
        6       kevent_id  (in libsystem_kernel.dylib) + 0  [0x18d18da6c]
        6       mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 4404  [0x103793f94]  transforms.cpp:266
        6       mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 2444  [0x102db0d58]  metal_kernel.cpp:268
        6       mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 780  [0x102db06d8]  metal_kernel.cpp:239
        6       mlx::core::metal::CommandEncoder::commit(std::function<void ()>)  (in slotstream) + 788  [0x1035a1ca4]  device.cpp:558
        6       mlx_fast_metal_kernel_new  (in slotstream) + 496  [0x102d6b780]  fast.cpp:483
        6       objc_msgSend  (in libobjc.A.dylib) + 0  [0x18cd65800]
        6       specialized MLXFast.MLXFastKernel.init<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 924  [0x103a09b10]  MLXFastKernel.swift:69
        6       static MLXFast.metalKernel<A, B>(name:inputNames:outputNames:source:header:ensureRowContiguous:atomicOutputs:)  (in slotstream) + 180  [0x103a09688]  MLXFastKernel.swift:181
        6       xzm_reclaim_mark_free_locked  (in libsystem_malloc.dylib) + 116  [0x18cfd3968]
        6       xzm_segment_group_alloc_chunk  (in libsystem_malloc.dylib) + 476  [0x18cfd45d8]
        5       -[AGXG17XFamilyComputeContext initWithCommandBuffer:config:]  (in AGXMetalG17X) + 536  [0x117e4b848]
        5       AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 0  [0x117e40db8]
        5       AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X) + 1100  [0x117e41204]
        5       MLXFast.MLXFastKernel.callAsFunction<A, B>(_:template:grid:threadGroup:outputShapes:outputDTypes:initValue:verbose:stream:)  (in slotstream) + 1672  [0x103a0945c]  MLXFastKernel.swift:154
        5       Substring.index(_:offsetBy:)  (in libswiftCore.dylib) + 0  [0x1a0c6af50]
        5       VQTensorFile.read(_:offset:count:shouldContinue:)  (in slotstream) + 192  [0x103d441a8]  VQTensorFile.swift:138
        5       eval(_:)  (in slotstream) + 72  [0x103a3587c]  Transforms+Eval.swift:124
        5       mach_vm_reclaim_try_enter  (in libsystem_kernel.dylib) + 296  [0x18d19f17c]
        5       mlx::core::eval_impl(std::vector<mlx::core::array>, bool)  (in slotstream) + 5140  [0x103794274]  transforms.cpp:343
        5       mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 1116  [0x102db0828]  metal_kernel.cpp:240
        5       mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream) + 436  [0x102db0580]  metal_kernel.cpp:238
        5       mlx::core::gpu::eval(mlx::core::array&)  (in slotstream) + 200  [0x1035b31f8]  eval.cpp:45
        5       mlx::core::gpu::finalize(mlx::core::Stream)  (in slotstream) + 88  [0x1035b3b50]  eval.cpp:76
        5       mlx::core::metal::CommandEncoder::get_command_encoder()  (in slotstream) + 144  [0x1035a0728]  device.cpp:581
        5       mlx::core::metal::CommandEncoder::set_input_array(mlx::core::array const&, int, long long)  (in slotstream) + 72  [0x1035a0810]  device.cpp:349
        5       mlx::core::metal::CommandEncoder::set_output_array(mlx::core::array&, int, long long)  (in slotstream) + 24  [0x1035a0994]  device.cpp:365
        5       mlx_eval  (in slotstream) + 140  [0x102d9bf24]  transforms.cpp:71
        5       mlx_fast_metal_kernel_apply  (in slotstream) + 244  [0x102d6bb98]  fast.cpp:525
        5       specialized static VQArithmetic.sigmoid(_:)  (in slotstream) + 500  [0x103d0d6e8]  VQArithmetic.swift:42
        5       std::__function::__func<mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)::$_0, std::vector<mlx::core::array> (std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>, std::tuple<int, int, int>, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>, std::optional<float>, bool, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>)>::operator()(std::vector<mlx::core::array> const&, std::vector<mlx::core::SmallVector<int, 10ul>> const&, std::vector<mlx::core::Dtype> const&, std::tuple<int, int, int>&&, std::tuple<int, int, int>&&, std::vector<std::pair<std::basic_string<char>, std::variant<int, bool, mlx::core::Dtype>>>&&, std::optional<float>&&, bool&&, std::variant<std::monostate, mlx::core::Stream, mlx::core::ThreadLocalStream, mlx::core::Device, mlx::core::Device::DeviceType>&&)  (in slotstream) + 80  [0x102db2e88]  function.h:174
        5       swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib) + 0  [0x1a098dd98]
        5       xzm_segment_group_free_chunk  (in libsystem_malloc.dylib) + 636  [0x18cfd53bc]

Sort by top of stack, same collapsed (when >= 5):
        __workq_kernreturn  (in libsystem_kernel.dylib)        20473
        pread  (in libsystem_kernel.dylib)        1569
        iokit_user_client_trap  (in IOKit)        1234
        start_wqthread  (in libsystem_pthread.dylib)        410
        madvise  (in libsystem_kernel.dylib)        216
        __ulock_wait  (in libsystem_kernel.dylib)        212
        _platform_memmove  (in libsystem_platform.dylib)        197
        mach_msg2_trap  (in libsystem_kernel.dylib)        88
        _platform_memchr  (in libsystem_platform.dylib)        87
        __psynch_mutexwait  (in libsystem_kernel.dylib)        31
        _xzm_xzone_malloc_tiny  (in libsystem_malloc.dylib)        28
        _platform_memcmp  (in libsystem_platform.dylib)        25
        Substring.subscript.getter  (in libswiftCore.dylib)        23
        fstat  (in libsystem_kernel.dylib)        20
        __ulock_wake  (in libsystem_kernel.dylib)        19
        mlx::core::fast::metal_kernel(std::basic_string<char> const&, std::vector<std::basic_string<char>> const&, std::vector<std::basic_string<char>> const&, std::basic_string<char> const&, std::basic_string<char> const&, bool, bool, mlx::core::CompileOptions const&)  (in slotstream)        16
        mach_absolute_time  (in libsystem_kernel.dylib)        15
        DYLD-STUB$$memchr  (in slotstream)        13
        _platform_memset  (in libsystem_platform.dylib)        13
        _xzm_free  (in libsystem_malloc.dylib)        13
        CFStringFindWithOptionsAndLocale  (in CoreFoundation)        12
        DYLD-STUB$$memcmp  (in slotstream)        12
        Substring.index(_:offsetBy:)  (in libswiftCore.dylib)        11
        specialized static String._uncheckedFromUTF8(_:isASCII:)  (in libswiftCore.dylib)        9
        __bzero  (in libsystem_platform.dylib)        8
        __ulock_wait2  (in libsystem_kernel.dylib)        8
        AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3EncodedInstr<AGXIotoInstruction_SPECLM_0>::AGX3EncodedInstr(AGX::ESLInstructionEncoderGen3<AGX::HAL300::Encoders>::AGX3Instr<AGXIotoInstruction_SPECLM_0> const&)  (in AGXMetalG17X)        7
        _allASCII(_:)  (in libswiftCore.dylib)        6
        kevent_id  (in libsystem_kernel.dylib)        6
        objc_msgSend  (in libobjc.A.dylib)        6
        AGX::ComputeContext<AGX::HAL300::Encoders, AGX::HAL300::Classes, AGX::HAL300::ObjClasses, AGX::HAL300::CommandEncoding, AGX::HAL300::EncoderComputeServiceClasses>::performEnqueueKernel(eAGXDataBufferPools, unsigned long long, unsigned int, unsigned long long*)  (in AGXMetalG17X)        5
        _stringCompareWithSmolCheck(_:_:expecting:)  (in libswiftCore.dylib)        5
        std::__function::__func<mlx::core::gpu::eval(mlx::core::array&)::$_1, void (MTL::CommandBuffer*)>::~__func()  (in slotstream)        5
        std::__hash_table<void const*>::__emplace_unique_key_args<void const*, void const*>(void const* const&, void const*&&)  (in slotstream)        5
        swift::RefCounts<swift::RefCountBitsT<(swift::RefCountInlinedness)1>>::doDecrementSlow<(swift::PerformDeinit)1>(swift::RefCountBitsT<(swift::RefCountInlinedness)1>, unsigned int)  (in libswiftCore.dylib)        5

Binary Images:
       0x102cbc000 -        0x104699e1f +slotstream (0) <6432E7C1-963B-32AC-A6D8-32071468C775> /Users/*/slotstream
       0x117b10000 -        0x1184c81bf  com.apple.AGXMetalG17X (353.14 - 353.14) <F9CF9EC0-D72B-3515-8F7E-A99ED2303CE1> /System/Library/Extensions/AGXMetalG17X.bundle/Contents/MacOS/AGXMetalG17X
       0x18cd5c000 -        0x18cdaeb4b  libobjc.A.dylib (951.7) <03BD9E32-CF0A-37B0-898A-3CE8DE06D842> /usr/lib/libobjc.A.dylib
       0x18cdaf000 -        0x18cde3d58  libdyld.dylib (1387) <957F93B3-8805-39C7-9C51-EDD1715F550E> /usr/lib/system/libdyld.dylib
       0x18cde4000 -        0x18ce974ff  dyld (1.0.0 - 1387) <74E52480-C2BD-3C8D-812D-95FE2B74A096> /usr/lib/dyld
       0x18ce98000 -        0x18ce9b228  libsystem_blocks.dylib (96) <E0AC1231-27AA-3A13-8FAC-41D5802B1F3C> /usr/lib/system/libsystem_blocks.dylib
       0x18ce9c000 -        0x18cef055f  libxpc.dylib (3102.160.5) <33E44C2D-D65E-37A6-B85F-1A4CF524A050> /usr/lib/system/libxpc.dylib
       0x18cef1000 -        0x18cf119ff  libsystem_trace.dylib (1861.160.4) <93F1DD8C-6CD9-32B9-B222-D23DA5D161B4> /usr/lib/system/libsystem_trace.dylib
       0x18cf12000 -        0x18cfc05f7  libcorecrypto.dylib (1922.160.10) <0642DDAD-4771-3C82-805C-E7C6701C1461> /usr/lib/system/libcorecrypto.dylib
       0x18cfc1000 -        0x18d011257  libsystem_malloc.dylib (812.160.5) <D969A907-3E43-3951-9365-8C2DB3812E9D> /usr/lib/system/libsystem_malloc.dylib
       0x18d012000 -        0x18d05923f  libdispatch.dylib (1542.160.2) <B2000CD5-F580-314A-A141-E036719D854E> /usr/lib/system/libdispatch.dylib
       0x18d05a000 -        0x18d05cffb  libsystem_featureflags.dylib (103) <FEE12F9C-344B-33B3-8EDD-283580EF1C67> /usr/lib/system/libsystem_featureflags.dylib
       0x18d05d000 -        0x18d0de1e7  libsystem_c.dylib (1752.160.4) <D77CEB62-AFF6-3CEC-BA9B-4F057FBE2EB5> /usr/lib/system/libsystem_c.dylib
       0x18d0df000 -        0x18d16fae7  libc++.1.dylib (2100.43) <F0FD393C-15BC-3C75-A19D-897F7B225C78> /usr/lib/libc++.1.dylib
       0x18d170000 -        0x18d18a75f  libc++abi.dylib (2100.43) <F38A9C58-22AB-3798-BBAE-8DCD9CC0CE27> /usr/lib/libc++abi.dylib
       0x18d18b000 -        0x18d1c82e7  libsystem_kernel.dylib (12377.161.14) <C6A4A4CB-92E6-3BAF-AAE0-E8306259209A> /usr/lib/system/libsystem_kernel.dylib
       0x18d1c9000 -        0x18d1d5b3b  libsystem_pthread.dylib (539.100.4) <A373F0B0-9880-326A-88B4-DD8BE4E33072> /usr/lib/system/libsystem_pthread.dylib
       0x18d1d6000 -        0x18d1de963  libsystem_platform.dylib (375.120.2) <EDB83A19-EC17-32DE-9350-6145970A85D6> /usr/lib/system/libsystem_platform.dylib
       0x18d1df000 -        0x18d20e6eb  libsystem_info.dylib (600) <9B5FB84B-31AD-3EA7-8F89-8C700D369DC8> /usr/lib/system/libsystem_info.dylib
       0x18d20f000 -        0x18d76d5bf  com.apple.CoreFoundation (6.9 - 5026.6.7) <9B672762-7B1F-30BC-96DE-F176B372D66D> /System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation
       0x18d76e000 -        0x18da88fbf  com.apple.LaunchServices (1141.1 - 1141.1) <01579E0C-9D85-3521-8916-4DDC990CD064> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/LaunchServices
       0x18da89000 -        0x18dc7195f  com.apple.gpusw.MetalTools (1.0 - 1) <9C416BB2-0882-315C-AF23-F476E34983BC> /System/Library/PrivateFrameworks/MetalTools.framework/Versions/A/MetalTools
       0x18dc72000 -        0x18e46c4bf  libBLAS.dylib (1551.160.2) <23402175-D2CF-3B08-88D0-AFBBCF775FEF> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib
       0x18e46d000 -        0x18e57c35f  com.apple.Lexicon-framework (1.0 - 195.12) <946B1484-B180-3451-A452-B54BF5A6D392> /System/Library/PrivateFrameworks/Lexicon.framework/Versions/A/Lexicon
       0x18e57d000 -        0x18e6ec38f  libSparse.dylib (184.160.6) <EBF55041-4C12-323B-BD40-51A0E57C0AE1> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libSparse.dylib
       0x18e6ed000 -        0x18e7800ff  com.apple.SystemConfiguration (1.21 - 1.21) <1479C415-3678-3968-AC77-06373490860E> /System/Library/Frameworks/SystemConfiguration.framework/Versions/A/SystemConfiguration
       0x18e781000 -        0x18e7b557b  libCRFSuite.dylib (55) <1CA9048E-57DD-30F4-A3E6-FE6E97D5BF82> /usr/lib/libCRFSuite.dylib
       0x18e7b6000 -        0x18ea7da1f  libmecabra.dylib (1121.5.1) <62AED6E3-43B6-3BE8-A317-489772981700> /usr/lib/libmecabra.dylib
       0x18ea7e000 -        0x18fa61a9f  com.apple.Foundation (6.9 - 5026.6.7) <91DACE39-FA28-3191-818D-1FCC6A0E615A> /System/Library/Frameworks/Foundation.framework/Versions/C/Foundation
       0x18fa62000 -        0x18fc1183f  com.apple.LanguageModeling (1.0 - 433.6) <327536E3-A27C-38C2-A67F-D6488D04CCEE> /System/Library/PrivateFrameworks/LanguageModeling.framework/Versions/A/LanguageModeling
       0x18fc12000 -        0x18fd32cbf  com.apple.CoreDisplay (291.4 - 291.4) <D8E7E31A-7D3E-3742-A3EE-469C6237FAF4> /System/Library/Frameworks/CoreDisplay.framework/Versions/A/CoreDisplay
       0x18fd33000 -        0x1900f5fdf  com.apple.audio.AudioToolboxCore (1.0 - 1556.704) <8AF1606D-5C93-3B80-BC81-60C5688628E2> /System/Library/PrivateFrameworks/AudioToolboxCore.framework/Versions/A/AudioToolboxCore
       0x1900f6000 -        0x19031fd9f  com.apple.CoreText (877.6.0.2 - 877.6.0.2) <B00FAD17-3AB0-343A-8CD8-F188911D898A> /System/Library/Frameworks/CoreText.framework/Versions/A/CoreText
       0x190320000 -        0x190ab5e1f  com.apple.audio.CoreAudio (5.0 - 5.0) <D13AB14D-2B45-34D0-86DE-38DF75BF48E5> /System/Library/Frameworks/CoreAudio.framework/Versions/A/CoreAudio
       0x190ab6000 -        0x190ed521f  com.apple.security (7.0 - 61901.160.44) <9D0387FC-E8F6-3004-9C95-CA68EA715C8B> /System/Library/Frameworks/Security.framework/Versions/A/Security
       0x190ed6000 -        0x1911abd53  libicucore.A.dylib (76142.5.2.1) <53A3E31E-06A8-325E-B5A8-316B88AA3C92> /usr/lib/libicucore.A.dylib
       0x1911ac000 -        0x1911b5e5f  libsystem_darwin.dylib (1752.160.4) <8E07D22E-CE5A-38A0-B091-5B0338C326F5> /usr/lib/system/libsystem_darwin.dylib
       0x1911b6000 -        0x1914adcbf  com.apple.CoreServices.CarbonCore (1333 - 1333) <D884AF5B-23F7-313A-97ED-DD54518BA922> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/CarbonCore.framework/Versions/A/CarbonCore
       0x1914ae000 -        0x1914edf17  com.apple.CoreServicesInternal (505 - 505) <7D56DA94-31EB-35F0-B886-4010C075E035> /System/Library/PrivateFrameworks/CoreServicesInternal.framework/Versions/A/CoreServicesInternal
       0x1914ee000 -        0x19152d1bf  com.apple.CSStore (1141.1 - 1141.1) <12479A32-B72F-3A09-BB03-BA56C37853B5> /System/Library/PrivateFrameworks/CoreServicesStore.framework/Versions/A/CoreServicesStore
       0x19152e000 -        0x19161625f  com.apple.framework.IOKit (2.0.2 - 100231.120.3) <12372585-DF92-33EF-B632-714FAA13260A> /System/Library/Frameworks/IOKit.framework/Versions/A/IOKit
       0x191617000 -        0x1916291b6  libsystem_notify.dylib (348.160.3) <15799128-6CBD-30D6-A2BB-B9D02B4470C0> /usr/lib/system/libsystem_notify.dylib
       0x19162a000 -        0x191688173  libsandbox.1.dylib (2680.160.6) <CB15E3BE-AEA6-343F-A8ED-B251AFF556E7> /usr/lib/libsandbox.1.dylib
       0x191689000 -        0x192dac49f  com.apple.AppKit (6.9 - 2685.70.101) <B6B4BDAD-6428-3E64-8747-275700109B46> /System/Library/Frameworks/AppKit.framework/Versions/C/AppKit
       0x192dad000 -        0x192f6591f  com.apple.UIFoundation (1.0 - 1019.1) <659AFBBD-E22E-3474-BCFE-298DA57B1464> /System/Library/PrivateFrameworks/UIFoundation.framework/Versions/A/UIFoundation
       0x192f66000 -        0x192f7c3ff  com.apple.UniformTypeIdentifiers (709 - 709) <B57F62F5-1581-3CE6-8782-6072B970FDF2> /System/Library/Frameworks/UniformTypeIdentifiers.framework/Versions/A/UniformTypeIdentifiers
       0x192f7d000 -        0x1931d105f  com.apple.desktopservices (26.0 - 1827.5.3) <C5AF8E88-9770-3B2B-9F79-AA5B1082A2DB> /System/Library/PrivateFrameworks/DesktopServicesPriv.framework/Versions/A/DesktopServicesPriv
       0x193228000 -        0x19345865f  com.apple.CoreDuet (1.0 - 1) <838F99F9-D3FA-335B-9767-B5D04A3FACA6> /System/Library/PrivateFrameworks/CoreDuet.framework/Versions/A/CoreDuet
       0x193459000 -        0x19353195f  libboringssl.dylib (532.120.8) <5BF55637-F306-3D79-B5A1-DB8A871DAD4B> /usr/lib/libboringssl.dylib
       0x193532000 -        0x1938e71df  com.apple.CFNetwork (1.0 - 3860.700.1) <4A3B95C5-AA2E-338C-9398-56895AF82D97> /System/Library/Frameworks/CFNetwork.framework/Versions/A/CFNetwork
       0x1938e8000 -        0x193902f7b  libsystem_networkextension.dylib (2226.161.1) <9C7B1EEB-47BE-3791-93A9-CFC693CB9417> /usr/lib/system/libsystem_networkextension.dylib
       0x193903000 -        0x193904067  libenergytrace.dylib (23) <8E04C57D-3651-386E-83D5-4728B732F214> /usr/lib/libenergytrace.dylib
       0x193905000 -        0x193984eff  libMobileGestalt.dylib (1484.120.3) <D614ADAF-EEDD-3492-AEEB-7D03558D419C> /usr/lib/libMobileGestalt.dylib
       0x193985000 -        0x19399cfdf  libsystem_asl.dylib (406) <54439739-33EE-3273-839F-CBA67D7F5CB1> /usr/lib/system/libsystem_asl.dylib
       0x19399d000 -        0x1939c0797  com.apple.TCC (1.0 - 1) <A160698F-BE34-323D-B5BE-56D7371B1230> /System/Library/PrivateFrameworks/TCC.framework/Versions/A/TCC
       0x1939c1000 -        0x193f77a1f  com.apple.SkyLight (1.600.0 - 922.13.1) <0C8F41C6-6D93-3DB3-B522-CA8CFF5C3B33> /System/Library/PrivateFrameworks/SkyLight.framework/Versions/A/SkyLight
       0x193f78000 -        0x1946cd5ff  com.apple.CoreGraphics (2.0 - 1965.6.3) <38C8FBEC-DE88-33FE-B742-A192F22CC754> /System/Library/Frameworks/CoreGraphics.framework/Versions/A/CoreGraphics
       0x1946ce000 -        0x194875b8b  com.apple.ColorSync (4.13.0 - 3813.5.1) <873404F1-CC9D-30F9-AE06-8EA58D292005> /System/Library/Frameworks/ColorSync.framework/Versions/A/ColorSync
       0x194876000 -        0x1948e139f  com.apple.HIServices (1.22 - 818) <CD16C3FB-D2A0-3F68-98DC-CE67FCBFDFF2> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/HIServices.framework/Versions/A/HIServices
       0x1949df000 -        0x194bd345f  com.apple.Montreal (1.0 - 178) <95BA357E-906A-3183-A402-A41D486B5AB3> /System/Library/PrivateFrameworks/Montreal.framework/Versions/A/Montreal
       0x194bd4000 -        0x194cc93df  com.apple.NLP (1.0 - 233) <F532F0AF-4F7A-398C-87BF-2DC3A6909D3D> /System/Library/PrivateFrameworks/NLP.framework/Versions/A/NLP
       0x194cca000 -        0x1950b7f5f  com.apple.CoreData (120 - 1526) <712AD9C1-44D2-36F4-BA8E-15038521462B> /System/Library/Frameworks/CoreData.framework/Versions/A/CoreData
       0x1950b8000 -        0x1950d3ddf  com.apple.ProtocolBuffer (1 - 310.26.4.23.2) <C73EE6D7-FE28-30E3-BA6A-012DC32FA22F> /System/Library/PrivateFrameworks/ProtocolBuffer.framework/Versions/A/ProtocolBuffer
       0x1950d4000 -        0x1952bca2f  libsqlite3.dylib (382) <B67E4205-32B5-3FF3-9FB5-9186C0B32A90> /usr/lib/libsqlite3.dylib
       0x1952bd000 -        0x195342fff  com.apple.Accounts (113 - 113) <5F6B668E-00B2-3BEC-959F-26BD6B50D42B> /System/Library/Frameworks/Accounts.framework/Versions/A/Accounts
       0x195343000 -        0x195359e7f  com.apple.commonutilities (8.0 - 900) <59FFD032-1427-39F6-BC16-A6877582A243> /System/Library/PrivateFrameworks/CommonUtilities.framework/Versions/A/CommonUtilities
       0x19535a000 -        0x19544b49f  com.apple.BaseBoard (732.1.1 - 732.1.1) <959C748F-8851-3A25-BFFA-5FEA80296965> /System/Library/PrivateFrameworks/BaseBoard.framework/Versions/A/BaseBoard
       0x19544c000 -        0x1954b7d5f  com.apple.RunningBoardServices (1.0 - 1015.160.2.0.1) <F7CC7754-0B25-302A-BFD4-5D16E9F666AD> /System/Library/PrivateFrameworks/RunningBoardServices.framework/Versions/A/RunningBoardServices
       0x1954b8000 -        0x19552bc37  com.apple.AE (944 - 944) <435D6243-695B-3543-A722-10106F5696BD> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/AE.framework/Versions/A/AE
       0x19552c000 -        0x19553dd87  libdns_services.dylib (2881.160.4) <88925A0C-4960-3F6D-AF3A-B1983F7B3D18> /usr/lib/libdns_services.dylib
       0x19553e000 -        0x195546387  libsystem_symptoms.dylib (2169.160.3) <229122B9-B8B1-3F2F-870E-8650AE3C4FB5> /usr/lib/system/libsystem_symptoms.dylib
       0x195547000 -        0x196d6429f  com.apple.Network (1.0 - 5812.160.9) <1C7E652B-6B94-3180-93A6-EF8DBA3A5448> /System/Library/Frameworks/Network.framework/Versions/A/Network
       0x196d65000 -        0x196d94ddf  com.apple.analyticsd (1.0 - 1) <FAE24228-7E19-3F30-9872-3B25749ADAF8> /System/Library/PrivateFrameworks/CoreAnalytics.framework/Versions/A/CoreAnalytics
       0x196d95000 -        0x196d968bb  libDiagnosticMessagesClient.dylib (113) <6CD959AA-4825-306A-864A-BD69EC5F2DC0> /usr/lib/libDiagnosticMessagesClient.dylib
       0x196d97000 -        0x196e0337f  com.apple.spotlight.metadata.utilities (1.0 - 2418.6.3.9.400) <29AA0F7F-26F4-35B3-96DF-8A67B00A58AB> /System/Library/PrivateFrameworks/MetadataUtilities.framework/Versions/A/MetadataUtilities
       0x196e04000 -        0x196e8fb5f  com.apple.Metadata (26.6 - 2418.6.3.9.400) <DEFC137A-C15D-35CB-AF08-E4D06B6CF8B9> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/Metadata.framework/Versions/A/Metadata
       0x196e90000 -        0x196e991eb  com.apple.DiskArbitration (2.7 - 2.7) <332C4B80-5B3C-34E7-AD1F-F6131E607F95> /System/Library/Frameworks/DiskArbitration.framework/Versions/A/DiskArbitration
       0x196e9a000 -        0x1972be063  com.apple.vImage (8.1 - 632.120.2) <2B16DF37-A596-3D8A-AE47-33E580EB1354> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vImage.framework/Versions/A/vImage
       0x1972bf000 -        0x1976d4e3f  com.apple.QuartzCore (1195.17 - 1195.17) <98CB7012-30E5-3BDD-8C84-CDBDA9DB3017> /System/Library/Frameworks/QuartzCore.framework/Versions/A/QuartzCore
       0x1976d5000 -        0x197725cdf  libFontRegistry.dylib (408.6.0.3) <49E7449E-1385-3B53-94CC-36EFC31E98FE> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/ATS.framework/Versions/A/Resources/libFontRegistry.dylib
       0x197726000 -        0x1978ac83f  com.apple.coreui (2.1 - 975) <D58368A9-E06A-3514-8E77-823FCAD3161B> /System/Library/PrivateFrameworks/CoreUI.framework/Versions/A/CoreUI
       0x1978ad000 -        0x1979e16ff  com.apple.ViewBridge (833 - 833) <629F6765-51B0-3BB0-9C84-BE1A5166603A> /System/Library/PrivateFrameworks/ViewBridge.framework/Versions/A/ViewBridge
       0x1979e2000 -        0x1979ebe7f  com.apple.PerformanceAnalysis (1.427 - 427) <74C54353-A613-35A2-857A-737BB48906F9> /System/Library/PrivateFrameworks/PerformanceAnalysis.framework/Versions/A/PerformanceAnalysis
       0x1979ec000 -        0x1979f9aff  com.apple.OpenDirectory (26.6 - 666.100.1) <F53E8087-7A50-37C7-811E-3D84A07325F6> /System/Library/Frameworks/OpenDirectory.framework/Versions/A/OpenDirectory
       0x1979fa000 -        0x197a2327f  com.apple.CFOpenDirectory (26.6 - 666.100.1) <3B7FD4C1-D1D4-3DA9-B2F8-3D4094679D76> /System/Library/Frameworks/OpenDirectory.framework/Versions/A/Frameworks/CFOpenDirectory.framework/Versions/A/CFOpenDirectory
       0x197a24000 -        0x197a3091b  com.apple.CoreServices.FSEvents (1413.160.2 - 1413.160.2) <F1A7246D-30C0-345F-8138-266094EC8315> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/FSEvents.framework/Versions/A/FSEvents
       0x197a31000 -        0x197a5a0df  com.apple.coreservices.SharedFileList (225 - 225) <297AC970-E432-3BBD-986C-36782634062E> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/SharedFileList.framework/Versions/A/SharedFileList
       0x197a5b000 -        0x197a5e08f  libapp_launch_measurement.dylib (17) <E992D070-4D50-3292-855F-1B0055739F5E> /usr/lib/libapp_launch_measurement.dylib
       0x197a5f000 -        0x197aa79bf  com.apple.CoreAutoLayout (1.0 - 34) <54AD73AF-852E-3CD6-8B7D-E73BE79857D3> /System/Library/PrivateFrameworks/CoreAutoLayout.framework/Versions/A/CoreAutoLayout
       0x197aa8000 -        0x197b8e3c3  libxml2.2.dylib (39.10.3) <1E8A4F9E-3954-3458-B3BB-BE97F961C105> /usr/lib/libxml2.2.dylib
       0x197b8f000 -        0x197c0fbbf  com.apple.CoreVideo (1.8 - 0.0) <0616AF41-149E-3F4A-906E-56E2642457BE> /System/Library/Frameworks/CoreVideo.framework/Versions/A/CoreVideo
       0x197c10000 -        0x197c12f5f  com.apple.loginsupport (3.0 - 264.4.2) <87907862-52FF-3F24-AC29-7C1678BCD277> /System/Library/PrivateFrameworks/login.framework/Versions/A/Frameworks/loginsupport.framework/Versions/A/loginsupport
       0x197c13000 -        0x197c5041f  com.apple.aps.framework (4.0 - 4.0) <27479D70-8BF6-3D3C-B528-1BB9B1B98391> /System/Library/PrivateFrameworks/ApplePushService.framework/Versions/A/ApplePushService
       0x197c51000 -        0x197c7d65f  com.apple.UserManagement (1.0 - 1) <4A78C569-FF0D-398B-9C25-33453F0CEC40> /System/Library/PrivateFrameworks/UserManagement.framework/Versions/A/UserManagement
       0x197c7e000 -        0x1980a601f  com.apple.cloudkit.CloudKit (2360.120.2 - 2360.120.2) <676D50CC-8455-3267-B8E8-CA31B8EF8F91> /System/Library/Frameworks/CloudKit.framework/Versions/A/CloudKit
       0x1980a7000 -        0x19817b6bf  com.apple.CloudDocs (1.0 - 4479.160.12) <60516B57-C7CC-3FCE-ACB5-9E79189D4DE2> /System/Library/PrivateFrameworks/CloudDocs.framework/Versions/A/CloudDocs
       0x19817c000 -        0x1989b57df  com.apple.CoreML (1.0 - 3520.5.1) <E5B29092-BC9F-39CD-8F75-F2992B1E1D7A> /System/Library/Frameworks/CoreML.framework/Versions/A/CoreML
       0x1989b6000 -        0x1995607ff  libwebrtc.dylib (624.5.1.11.3) <BCB03518-81D5-3FCF-A2E6-FE6BCE46C6C5> /System/Library/Frameworks/WebKit.framework/Versions/A/Frameworks/WebCore.framework/Versions/A/Frameworks/libwebrtc.dylib
       0x199561000 -        0x1997e211f  com.apple.corelocation (3077.0.4 - 3077.0.4) <9805BB7B-12C9-39F5-9070-C5B8BFCAE2AF> /System/Library/Frameworks/CoreLocation.framework/Versions/A/CoreLocation
       0x1997e3000 -        0x19981b5b7  libsystem_containermanager.dylib (725.160.3) <14B2A47F-19C8-392F-8FDB-FE8AE375DD41> /usr/lib/system/libsystem_containermanager.dylib
       0x19981c000 -        0x19983825f  com.apple.IOSurface (393.5.8 - 393.5.8) <5556FD64-9D47-3547-961E-3A27681F3C51> /System/Library/Frameworks/IOSurface.framework/Versions/A/IOSurface
       0x199839000 -        0x19984305f  com.apple.IOAccelerator (487.4.3 - 487.4.3) <A0C21253-9F8C-3E9A-B9D9-02517BDAE43B> /System/Library/PrivateFrameworks/IOAccelerator.framework/Versions/A/IOAccelerator
       0x199844000 -        0x199b1de1f  com.apple.Metal (373.7 - 373.7) <493E76D9-74D4-333B-A3B2-E5F9BC86429D> /System/Library/Frameworks/Metal.framework/Versions/A/Metal
       0x199b1e000 -        0x199b4707f  com.apple.audio.caulk (1.0 - 214.701) <AD0B0769-76D4-3613-BAE4-DBBBE05F7E3E> /System/Library/PrivateFrameworks/caulk.framework/Versions/A/caulk
       0x199b48000 -        0x199ce93ff  com.apple.CoreMedia (1.0 - 3330.13.2) <DB8BA2C9-C144-310E-AD6B-EB623FB3C7FB> /System/Library/Frameworks/CoreMedia.framework/Versions/A/CoreMedia
       0x199cea000 -        0x199fb943f  libFontParser.dylib (435.6.0.2) <9E126CE0-FBB2-3B15-953F-CCDC758E34FB> /System/Library/PrivateFrameworks/FontServices.framework/libFontParser.dylib
       0x199fba000 -        0x19a2b511f  com.apple.HIToolbox (2.1.1 - 1250.1) <38408482-CE3B-359E-9465-7FEB4BB79B54> /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/HIToolbox.framework/Versions/A/HIToolbox
       0x19a2b6000 -        0x19a2ca5ff  com.apple.framework.DFRFoundation (1.0 - 293.1.1) <A871FDA3-D5BA-31E0-BD8C-E4A83F5E2B62> /System/Library/PrivateFrameworks/DFRFoundation.framework/Versions/A/DFRFoundation
       0x19a2cb000 -        0x19a2d035f  com.apple.dt.XCTTargetBootstrap (26.6 - 24901) <E0CFA0C8-A13D-369D-91E9-4A675C5DB5FD> /System/Library/PrivateFrameworks/XCTTargetBootstrap.framework/Versions/A/XCTTargetBootstrap
       0x19a2d1000 -        0x19a30e19f  com.apple.CoreSVG (1.0 - 341) <986D57A7-BFF1-3DAA-8EB1-17CCAA76C731> /System/Library/PrivateFrameworks/CoreSVG.framework/Versions/A/CoreSVG
       0x19a30f000 -        0x19a64ff1f  com.apple.ImageIO (3.3.0 - 2784.6.4) <C9CF487D-E759-3F94-ABEB-7AE5EB39AF7D> /System/Library/Frameworks/ImageIO.framework/Versions/A/ImageIO
       0x19a650000 -        0x19ab3af9f  com.apple.CoreImage (19.0.0 - 1592.120.2) <0943679D-FF88-3F18-BE4B-D8B4827AB0B5> /System/Library/Frameworks/CoreImage.framework/Versions/A/CoreImage
       0x19ab3b000 -        0x19abf4ddf  com.apple.MetalPerformanceShaders.MPSCore (1.0 - 1) <DBB5F038-E085-39C8-A9BF-C3B3CB3F6FD5> /System/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/Frameworks/MPSCore.framework/Versions/A/MPSCore
       0x19abf5000 -        0x19abf95d7  libsystem_configuration.dylib (1405.160.3) <D8D6280B-783D-3550-BDBA-2861AE40604F> /usr/lib/system/libsystem_configuration.dylib
       0x19abfa000 -        0x19ac0099f  libsystem_sandbox.dylib (2680.160.6) <54688162-B50D-3D31-A1E8-7B9766D3530D> /usr/lib/system/libsystem_sandbox.dylib
       0x19ac01000 -        0x19ac0217f  com.apple.AggregateDictionary (1.0 - 1) <91BDD1F8-831B-3B01-86BA-6BBCB43373C4> /System/Library/PrivateFrameworks/AggregateDictionary.framework/Versions/A/AggregateDictionary
       0x19ac03000 -        0x19ac074d3  com.apple.AppleSystemInfo (3.1.5 - 3.1.5) <4C6139EE-BF87-37A6-B226-830A6FDC36F8> /System/Library/PrivateFrameworks/AppleSystemInfo.framework/Versions/A/AppleSystemInfo
       0x19ac08000 -        0x19ac0946b  liblangid.dylib (140) <D201B12C-5258-3C03-89ED-B35FBFAEFA0C> /usr/lib/liblangid.dylib
       0x19ac0a000 -        0x19ad2945f  com.apple.CoreNLP (1.0 - 313) <B75F1F25-3C33-3983-B546-71588C610ED5> /System/Library/PrivateFrameworks/CoreNLP.framework/Versions/A/CoreNLP
       0x19ad2a000 -        0x19ad3091f  com.apple.LinguisticData (1.0 - 483.10) <FDD446CF-5D67-341F-8247-DAE855305379> /System/Library/PrivateFrameworks/LinguisticData.framework/Versions/A/LinguisticData
       0x19ad31000 -        0x19bdb941f  libBNNS.dylib (1961.160.8) <54A103BA-7D04-32DB-B204-179E2E0290CA> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBNNS.dylib
       0x19bdba000 -        0x19bef746f  libvDSP.dylib (1126.160.2) <4C851329-A9F4-3E9E-9E48-07FF4120DCF9> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libvDSP.dylib
       0x19bef8000 -        0x19bf2b63f  com.apple.CoreEmoji (1.0 - 261.4.6) <47AAECAD-C28C-352E-BB86-7F292E0BFBC6> /System/Library/PrivateFrameworks/CoreEmoji.framework/Versions/A/CoreEmoji
       0x19bf2c000 -        0x19bf65267  com.apple.IOMobileFramebuffer (343.0.0 - 343.0.0) <2BC48182-F354-3AB0-8F18-0C60CAAFE398> /System/Library/PrivateFrameworks/IOMobileFramebuffer.framework/Versions/A/IOMobileFramebuffer
       0x19bf66000 -        0x19bfe819f  com.apple.framework.CoreWLAN (16.0 - 1657) <EDA738B7-55E8-328B-AA44-B121D23BB318> /System/Library/Frameworks/CoreWLAN.framework/Versions/A/CoreWLAN
       0x19bfe9000 -        0x19c15de5f  com.apple.CoreUtils (8.3 - 830.24) <C943FF30-2340-3412-9880-5AB6FE22A95C> /System/Library/PrivateFrameworks/CoreUtils.framework/Versions/A/CoreUtils
       0x19c15e000 -        0x19c1756df  com.apple.MobileKeyBag (2.0 - 1.0) <D3DECDE5-FA90-35FB-861D-8148E963D8B1> /System/Library/PrivateFrameworks/MobileKeyBag.framework/Versions/A/MobileKeyBag
       0x19c176000 -        0x19c1840ff  com.apple.AssertionServices (1.0 - 1015.160.2.0.1) <1946F8FE-0ABC-3F8F-9116-5451ECABD14C> /System/Library/PrivateFrameworks/AssertionServices.framework/Versions/A/AssertionServices
       0x19c185000 -        0x19c217a9f  com.apple.securityfoundation (6.0 - 55293) <9A86DB3F-CC62-3E89-B872-35D04CFFBE42> /System/Library/Frameworks/SecurityFoundation.framework/Versions/A/SecurityFoundation
       0x19c218000 -        0x19c2492ff  com.apple.coreservices.BackgroundTaskManagement (1.0 - 104) <A2F5EE78-A281-35AF-8EA6-5BC6567F2ECC> /System/Library/PrivateFrameworks/BackgroundTaskManagement.framework/Versions/A/BackgroundTaskManagement
       0x19c24a000 -        0x19c2546ff  com.apple.xpc.ServiceManagement (1.0 - 1) <5F356BA6-47B5-382B-B54A-1550BB138A62> /System/Library/Frameworks/ServiceManagement.framework/Versions/A/ServiceManagement
       0x19c255000 -        0x19c2581fb  libquarantine.dylib (196.160.2) <EEE5AADB-52E1-3C4C-881A-70405770B1F1> /usr/lib/system/libquarantine.dylib
       0x19c259000 -        0x19c2642bf  libCheckFix.dylib (33) <6508C698-D587-3B5A-B95B-A3A3F78CE122> /usr/lib/libCheckFix.dylib
       0x19c265000 -        0x19c27c7ab  libcoretls.dylib (187.100.3) <0EAB1F4A-9275-3FED-8EA6-E962ACDDEE5D> /usr/lib/libcoretls.dylib
       0x19c27d000 -        0x19c28e273  libbsm.0.dylib (90) <633BCB5F-F063-3D5A-B52A-F72AE236824B> /usr/lib/libbsm.0.dylib
       0x19c28f000 -        0x19c2edc6b  libmecab.dylib (1121.5.1) <C02D85F6-947A-3B3E-8AE9-7BC8D0F35204> /usr/lib/libmecab.dylib
       0x19c2ee000 -        0x19c2f041b  libgermantok.dylib (31) <74E55DD6-720D-39E4-897E-EB4328E1946D> /usr/lib/libgermantok.dylib
       0x19c2f1000 -        0x19c304e3f  libLinearAlgebra.dylib (1551.160.2) <407BCF3E-A91F-3A7F-8B8C-DBB8E807990F> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libLinearAlgebra.dylib
       0x19c305000 -        0x19c55b17f  com.apple.MetalPerformanceShaders.MPSNeuralNetwork (1.0 - 1) <199F6401-91D0-36E9-9EA9-D4B44ED1CE3A> /System/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/Frameworks/MPSNeuralNetwork.framework/Versions/A/MPSNeuralNetwork
       0x19c55c000 -        0x19c5b019f  com.apple.MetalPerformanceShaders.MPSRayIntersector (1.0 - 1) <2E7E2722-3821-3DBF-B25A-6EA45D1A8FD4> /System/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/Frameworks/MPSRayIntersector.framework/Versions/A/MPSRayIntersector
       0x19c5b1000 -        0x19c743edf  com.apple.MLCompute (1.0 - 1) <E118164B-A0A2-3001-9E0A-36B2BB5FE6F2> /System/Library/Frameworks/MLCompute.framework/Versions/A/MLCompute
       0x19c744000 -        0x19c77557f  com.apple.MetalPerformanceShaders.MPSMatrix (1.0 - 1) <4D134FE3-50EE-39D5-9699-04B4B673DD35> /System/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/Frameworks/MPSMatrix.framework/Versions/A/MPSMatrix
       0x19c776000 -        0x19c945cdf  com.apple.MetalPerformanceShaders.MPSNDArray (1.0 - 1) <3E1FE9EA-34A2-3545-B639-48B1FE1FD3D4> /System/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/Frameworks/MPSNDArray.framework/Versions/A/MPSNDArray
       0x19c946000 -        0x19c9da1df  com.apple.MetalPerformanceShaders.MPSImage (1.0 - 1) <A0BE8307-7ECF-3AB8-B382-3E4059C85778> /System/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/Frameworks/MPSImage.framework/Versions/A/MPSImage
       0x19c9db000 -        0x19c9e64c3  com.apple.AppleFSCompression (174.160.2 - 1.0) <DA611209-7AA6-37C4-B4EC-7B7A7020A607> /System/Library/PrivateFrameworks/AppleFSCompression.framework/Versions/A/AppleFSCompression
       0x19c9e7000 -        0x19c9f30a3  libbz2.1.0.dylib (49) <5FFE1FFA-6BD0-32AF-A815-7543731CA763> /usr/lib/libbz2.1.0.dylib
       0x19c9f4000 -        0x19c9fad03  libsystem_coreservices.dylib (191.5.1) <D4ACD2AC-5702-3C45-85A0-300B2C2D19E1> /usr/lib/system/libsystem_coreservices.dylib
       0x19c9fb000 -        0x19ca2cadf  com.apple.CoreServices.OSServices (1141.1 - 1141.1) <61677289-93B7-382F-86CA-B856361D293F> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/OSServices.framework/Versions/A/OSServices
       0x19ca2d000 -        0x19cdb753f  com.apple.AuthKit (1.0 - 1) <336E2CAC-84D2-34DC-8AE3-7FE688C609EA> /System/Library/PrivateFrameworks/AuthKit.framework/Versions/A/AuthKit
       0x19cdb8000 -        0x19ce086ff  com.apple.UserNotifications (1.0 - 640.6.5) <7F1A25E4-ED0A-3502-AABA-26EDB4A0D2A7> /System/Library/Frameworks/UserNotifications.framework/Versions/A/UserNotifications
       0x19ce09000 -        0x19cf736bf  com.apple.CoreSpotlight (1.0 - 2418.6.3.9.400) <BC9B6D58-21EC-3057-BAE7-7A1E65F7955F> /System/Library/Frameworks/CoreSpotlight.framework/Versions/A/CoreSpotlight
       0x19cf74000 -        0x19cf82d97  libz.1.dylib (100.120.1) <13EDE3A5-A7D9-3FB8-B0C2-2FB7F7272B34> /usr/lib/libz.1.dylib
       0x19cf83000 -        0x19cfc0a77  libsystem_m.dylib (3312.100.1) <B54FBE99-DB0B-32C7-ABDD-C2206DF606A4> /usr/lib/system/libsystem_m.dylib
       0x19cfc1000 -        0x19cfc1c9b  libcharset.1.dylib (115.120.2) <1940124C-0D73-35D2-9D94-A75F116088A0> /usr/lib/libcharset.1.dylib
       0x19cfc2000 -        0x19cfc5527  libmacho.dylib (1387) <949131E5-BDA2-39BA-AA50-62651BB51802> /usr/lib/system/libmacho.dylib
       0x19cfc6000 -        0x19cfdedc3  libkxld.dylib (12377.161.14) <A3E386E1-042A-33E3-9121-78457115AAD9> /usr/lib/system/libkxld.dylib
       0x19cfdf000 -        0x19cfec3a7  libcommonCrypto.dylib (600035) <3B110564-5278-3CB0-85F1-2CE8431FF935> /usr/lib/system/libcommonCrypto.dylib
       0x19cfed000 -        0x19cff6ca3  libunwind.dylib (2100.2) <05FD0014-55B1-3B8A-A6BA-6C7A389C4123> /usr/lib/system/libunwind.dylib
       0x19cff7000 -        0x19cffe349  liboah.dylib (367.9) <0C7397C6-D747-31F2-8BC1-4096213BDE5C> /usr/lib/liboah.dylib
       0x19cfff000 -        0x19d009bef  libcopyfile.dylib (240.160.2.0.1) <D0009B8A-8ECC-3D56-9206-7E1839707F93> /usr/lib/system/libcopyfile.dylib
       0x19d00a000 -        0x19d00d987  libcompiler_rt.dylib (103.3) <6FB345CA-7F5C-3263-A23F-143F7539FD8A> /usr/lib/system/libcompiler_rt.dylib
       0x19d00e000 -        0x19d01278b  libsystem_collections.dylib (1752.160.4) <C8160BD2-5941-3DC0-BB40-F8C2B8156EC4> /usr/lib/system/libsystem_collections.dylib
       0x19d013000 -        0x19d0164cf  libsystem_secinit.dylib (168.100.7) <ECABC024-8F02-374A-BB7E-29437CEA2ABD> /usr/lib/system/libsystem_secinit.dylib
       0x19d017000 -        0x19d019bf7  libremovefile.dylib (85.100.6) <7460B5AE-469A-36A0-A7EC-6C7D69628E86> /usr/lib/system/libremovefile.dylib
       0x19d01a000 -        0x19d01af27  libkeymgr.dylib (31) <7E863FCA-F3FF-32C7-8A8C-F983E946AFC3> /usr/lib/system/libkeymgr.dylib
       0x19d01b000 -        0x19d023e37  libsystem_dnssd.dylib (2881.160.4) <305F4398-E688-3384-B351-02D865EC8A04> /usr/lib/system/libsystem_dnssd.dylib
       0x19d024000 -        0x19d02909b  libcache.dylib (95) <9CD7B1E1-3E47-339C-A193-2392E3E0ED23> /usr/lib/system/libcache.dylib
       0x19d02a000 -        0x19d02bce3  libSystem.B.dylib (1356) <4FED5EE2-5D3E-35B1-A170-9859C4B683BB> /usr/lib/libSystem.B.dylib
       0x19d02c000 -        0x19d02dfcf  libfakelink.dylib (5) <820D290D-51A0-3064-A1F2-4F0AAF7E6BF4> /usr/lib/libfakelink.dylib
       0x19d02e000 -        0x19d02ea33  com.apple.SoftLinking (1.0 - 71) <4109E8DD-0A81-310C-B1B3-23B87186D0D8> /System/Library/PrivateFrameworks/SoftLinking.framework/Versions/A/SoftLinking
       0x19d064000 -        0x19d06b2bb  libiconv.2.dylib (115.120.2) <4646F780-1D5E-3EE7-B00A-64619293CC18> /usr/lib/libiconv.2.dylib
       0x19d06c000 -        0x19d07e457  libcmph.dylib (9) <A9892C55-670F-3429-934B-DDE91E07976D> /usr/lib/libcmph.dylib
       0x19d07f000 -        0x19d176f3f  libarchive.2.dylib (167.160.4) <0048DB96-1737-3FC5-AF0C-AF784FA24A03> /usr/lib/libarchive.2.dylib
       0x19d177000 -        0x19d1dc85b  com.apple.SearchKit (1.4.2 - 1.4.2) <B352D2B5-7115-3FF6-8805-7B49151BF5A2> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/SearchKit.framework/Versions/A/SearchKit
       0x19d1dd000 -        0x19d1e518f  libThaiTokenizer.dylib (28) <92FAD15C-EEA5-34E9-B309-75A1CD1B620B> /usr/lib/libThaiTokenizer.dylib
       0x19d1e6000 -        0x19d209f37  com.apple.applesauce (1.0 - 17.7) <B739BAFB-BA9A-3F08-A480-EA4D41808899> /System/Library/PrivateFrameworks/AppleSauce.framework/Versions/A/AppleSauce
       0x19d20a000 -        0x19d2224ab  libapple_nghttp2.dylib (37.120.3) <C3B4633A-F17D-3054-95C0-5A21B916A1B3> /usr/lib/libapple_nghttp2.dylib
       0x19d223000 -        0x19d2cc38f  libSparseBLAS.dylib (184.160.6) <669ABE12-838F-3F14-8456-D60DE5DF8EB8> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libSparseBLAS.dylib
       0x19d2cd000 -        0x19d2ce63f  com.apple.MetalPerformanceShaders.MetalPerformanceShaders (1.0 - 1) <D5C759F9-A533-3E0B-8916-07CA63760A80> /System/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/MetalPerformanceShaders
       0x19d2cf000 -        0x19d2d4ff7  libpam.2.dylib (35) <7E84FD3B-E90E-317E-AC19-17B70AC809E5> /usr/lib/libpam.2.dylib
       0x19d2d5000 -        0x19d3a9d97  libcompression.dylib (193.120.2) <BAEEB84F-03FE-3B78-8799-316258DF893E> /usr/lib/libcompression.dylib
       0x19d3aa000 -        0x19d3ae267  libQuadrature.dylib (8) <C99B83FD-C865-36F7-B4D2-34018D34AF5D> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libQuadrature.dylib
       0x19d3af000 -        0x19e57f94f  libLAPACK.dylib (1551.160.2) <5015CD96-C046-364D-AAE3-1F439044468B> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libLAPACK.dylib
       0x19e580000 -        0x19e5d64ff  com.apple.DictionaryServices (1.2 - 382.0.1) <6A26D479-5926-330B-9FB8-9B7A6BE8E239> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/DictionaryServices.framework/Versions/A/DictionaryServices
       0x19e5d7000 -        0x19e5f54f7  liblzma.5.dylib (21) <A758BC2B-EB48-3590-9B22-C2E0FAC3521E> /usr/lib/liblzma.5.dylib
       0x19e5f6000 -        0x19e5f785f  libcoretls_cfhelpers.dylib (187.100.3) <6937D729-7EF4-3972-9E12-694C17C1C1AB> /usr/lib/libcoretls_cfhelpers.dylib
       0x19e5f8000 -        0x19e66b85f  com.apple.APFS (2811.160.7 - 2811.160.7) <E7595D59-4FA7-3A8E-9E9A-D1B22225B571> /System/Library/PrivateFrameworks/APFS.framework/Versions/A/APFS
       0x19e66c000 -        0x19e67a833  libxar.1.dylib (503.160.5) <B48CA8E1-C7EF-38BF-B8C0-91355EE685DC> /usr/lib/libxar.1.dylib
       0x19e67b000 -        0x19e67e79b  libutil.dylib (73) <D4EB86A9-2784-3D15-A72E-29832C211348> /usr/lib/libutil.dylib
       0x19e67f000 -        0x19e6a9cbf  libxslt.1.dylib (21.13.2) <6C426EA5-7F1E-333E-BB5D-74465EFED12B> /usr/lib/libxslt.1.dylib
       0x19e6aa000 -        0x19e6b1127  libChineseTokenizer.dylib (44) <DA303C17-5763-3D5E-9194-454651C4D20A> /usr/lib/libChineseTokenizer.dylib
       0x19e6b2000 -        0x19e72b587  libvMisc.dylib (1126.160.2) <F6878ABB-05CB-3A50-964F-4D772670BAEB> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libvMisc.dylib
       0x19e72c000 -        0x19e7bb45f  libate.dylib (3.0.9) <01AAD3B4-D6BA-36D9-BA6F-D494D2AC161D> /usr/lib/libate.dylib
       0x19e7bc000 -        0x19e7c4923  libIOReport.dylib (107) <9E06CB59-0638-3C9F-B202-264E739433AC> /usr/lib/libIOReport.dylib
       0x19e7c5000 -        0x19e7d81bf  com.apple.CrashReporterSupport (10.13 - 15140) <F963C33F-6026-336E-AE74-2ABA6F2322EF> /System/Library/PrivateFrameworks/CrashReporterSupport.framework/Versions/A/CrashReporterSupport
       0x19e7d9000 -        0x19e7f9b5f  com.apple.AppSSOCore (1.0 - 483.160.10) <5198BFE1-41D2-33D5-A9E0-C63F81A512D3> /System/Library/PrivateFrameworks/AppSSOCore.framework/Versions/A/AppSSOCore
       0x19e7fa000 -        0x19e8f783f  com.apple.CVNLP (1.0 - 119) <A8951A2F-E828-3264-A133-B25B21C0ABE8> /System/Library/PrivateFrameworks/CVNLP.framework/Versions/A/CVNLP
       0x19e8f8000 -        0x19e91be3f  com.apple.SharedWebCredentials (1001 - 1036.2) <3E9C730E-B6A8-3FDD-9458-95760E1CB389> /System/Library/PrivateFrameworks/SharedWebCredentials.framework/Versions/A/SharedWebCredentials
       0x19e91c000 -        0x19e95cf9f  com.apple.pluginkit.framework (1.0 - 1) <F362C1C4-8E0B-37E3-943D-D3D2C7A6DD63> /System/Library/PrivateFrameworks/PlugInKit.framework/Versions/A/PlugInKit
       0x19e95d000 -        0x19e9644e3  libMatch.1.dylib (49.161.1) <2F2EF0D7-2FE4-3A5A-8E4C-E1571C8D0C10> /usr/lib/libMatch.1.dylib
       0x19e965000 -        0x19e9d299f  libCoreStorage.dylib (568) <650E155C-1FE3-36ED-8D84-157D380F7F95> /usr/lib/libCoreStorage.dylib
       0x19e9d3000 -        0x19ea1b9ff  com.apple.AppleVAFramework (6.2.10 - 6.2.10) <7CF84496-675C-3241-B0EF-E83C95F188FA> /System/Library/PrivateFrameworks/AppleVA.framework/Versions/A/AppleVA
       0x19ea1c000 -        0x19ea36ccf  libexpat.1.dylib (47) <FA9B7355-899F-371F-9293-21A94BAE956F> /usr/lib/libexpat.1.dylib
       0x19ea37000 -        0x19ea40bf3  libheimdal-asn1.dylib (710.160.4) <6A4A85F4-3D12-3C4C-85EC-D53D61379F28> /usr/lib/libheimdal-asn1.dylib
       0x19ea41000 -        0x19eaa161f  com.apple.IconFoundation (494 - 494) <D9A3172C-CA6C-3CFB-BEA7-249650B5B009> /System/Library/PrivateFrameworks/IconFoundation.framework/Versions/A/IconFoundation
       0x19eaa2000 -        0x19eb60c1f  com.apple.IconServices (494 - 494) <10C63D59-07BC-3518-87A0-83CAC48D8A70> /System/Library/PrivateFrameworks/IconServices.framework/Versions/A/IconServices
       0x19eb61000 -        0x19ec22edf  com.apple.MediaExperience (1.0 - 1) <52A7AD42-9DE0-393B-A6FB-A7CB6FF8F3A5> /System/Library/PrivateFrameworks/MediaExperience.framework/Versions/A/MediaExperience
       0x19ec23000 -        0x19ec4f0bf  com.apple.persistentconnection (1.0 - 1.0) <E4DBF767-1630-3885-8C7B-C8F131BEDDDD> /System/Library/PrivateFrameworks/PersistentConnection.framework/Versions/A/PersistentConnection
       0x19ec50000 -        0x19ec5f7ff  com.apple.GraphVisualizer (1.0 - 307) <77D85BA0-FE1C-3B5A-92DB-70A30202C990> /System/Library/PrivateFrameworks/GraphVisualizer.framework/Versions/A/GraphVisualizer
       0x19ec60000 -        0x19ec9f51f  com.apple.OTSVG (1.0 - 877.6.0.2) <5D3E7FFF-AC8E-3D6F-8E99-B199E593D270> /System/Library/PrivateFrameworks/OTSVG.framework/Versions/A/OTSVG
       0x19eca0000 -        0x19ecacc7f  com.apple.xpc.AppServerSupport (1.0 - 3102.160.5) <2B5FB7B0-844C-3D84-9EFD-020B285B0F8D> /System/Library/PrivateFrameworks/AppServerSupport.framework/Versions/A/AppServerSupport
       0x19ecad000 -        0x19ecb3abf  libspindump.dylib (419.11) <04DC06C1-2BFA-3FEE-9429-A33E41721A3E> /usr/lib/libspindump.dylib
       0x19ecb4000 -        0x19ed74e9f  com.apple.Heimdal (4.0 - 2.0) <B1BA9495-0199-3630-8C92-45D4E5EE944F> /System/Library/PrivateFrameworks/Heimdal.framework/Versions/A/Heimdal
       0x19ed75000 -        0x19ed9879f  com.apple.login (3.0 - 3.0) <1A57F98C-8E7D-3F75-9CF1-748B00B949E5> /System/Library/PrivateFrameworks/login.framework/Versions/A/login
       0x19ed99000 -        0x19ef19cbf  com.apple.corebrightness (1.0 - 1) <1F873909-B3B8-3D55-9673-9AFA86BB085B> /System/Library/PrivateFrameworks/CoreBrightness.framework/Versions/A/CoreBrightness
       0x19efc6000 -        0x19efc7207  libodfde.dylib (26) <36868773-014E-3EC4-8B61-4B6132D3DCD9> /usr/lib/libodfde.dylib
       0x19efc8000 -        0x19f042643  com.apple.bom (14.0 - 277) <63F598E2-AF8A-3F29-BE11-3F14DB377A5B> /System/Library/PrivateFrameworks/Bom.framework/Versions/A/Bom
       0x19f043000 -        0x19f0876ef  com.apple.AppleJPEG (1.0 - 1) <7F00413A-4D40-3DBF-8FD5-859B23E6DC03> /System/Library/PrivateFrameworks/AppleJPEG.framework/Versions/A/AppleJPEG
       0x19f088000 -        0x19f24892f  libJP2.dylib (2784.6.6) <7304F8B3-8E0F-3813-BFAF-9A565CEA0A11> /System/Library/Frameworks/ImageIO.framework/Versions/A/Resources/libJP2.dylib
       0x19f249000 -        0x19f24ae1f  com.apple.WatchdogClient.framework (1.0 - 333) <A062966A-1DD7-3BC4-83DB-42E820054727> /System/Library/PrivateFrameworks/WatchdogClient.framework/Versions/A/WatchdogClient
       0x19f24b000 -        0x19f290d7f  com.apple.MultitouchSupport.framework (9460.1 - 9460.1) <57F7BB9C-649D-3360-AA86-A502815D77FA> /System/Library/PrivateFrameworks/MultitouchSupport.framework/Versions/A/MultitouchSupport
       0x19f291000 -        0x19f7e737f  com.apple.VideoToolbox (1.0 - 3330.13.2) <C287CF1D-67F4-3798-99A3-221052B70A22> /System/Library/Frameworks/VideoToolbox.framework/Versions/A/VideoToolbox
       0x19f7e8000 -        0x19f80d20f  libAudioToolboxUtility.dylib (1556.704) <75F77FEC-BE14-3C97-93DA-403C3B529D3B> /usr/lib/libAudioToolboxUtility.dylib
       0x19f80e000 -        0x19f83801f  libPng.dylib (2784.6.6) <C880ABD1-01CC-39F9-9144-E5DE22D0595F> /System/Library/Frameworks/ImageIO.framework/Versions/A/Resources/libPng.dylib
       0x19f839000 -        0x19f899b63  libTIFF.dylib (2784.6.6) <CA3AB1CA-DC97-328C-83E8-7CD89BC7FFBE> /System/Library/Frameworks/ImageIO.framework/Versions/A/Resources/libTIFF.dylib
       0x19f89a000 -        0x19f8b9257  com.apple.IOPresentment (67 - 67) <BD01EBB2-341A-38E7-89D5-450025B67415> /System/Library/PrivateFrameworks/IOPresentment.framework/Versions/A/IOPresentment
       0x19f8ba000 -        0x19f8be7d3  com.apple.GPUWrangler (8.1.12 - 8.1.12) <C1AB9351-81C2-3B9F-B237-D8560B16A134> /System/Library/PrivateFrameworks/GPUWrangler.framework/Versions/A/GPUWrangler
       0x19f8bf000 -        0x19f8c1913  libRadiance.dylib (2784.6.6) <CA79D637-1D80-3C62-8820-EE4CE6961A5A> /System/Library/Frameworks/ImageIO.framework/Versions/A/Resources/libRadiance.dylib
       0x19f8c2000 -        0x19f8c72f3  com.apple.DSExternalDisplay (3.1 - 380) <CFE441E7-0BAC-3894-862D-9F914D9E6D40> /System/Library/PrivateFrameworks/DSExternalDisplay.framework/Versions/A/DSExternalDisplay
       0x19f8c8000 -        0x19f8f2baf  libJPEG.dylib (2784.6.6) <8EA6CA42-AA01-3C0F-9672-4917481BAAAE> /System/Library/Frameworks/ImageIO.framework/Versions/A/Resources/libJPEG.dylib
       0x19f8f3000 -        0x19f92057f  com.apple.ATSUI (1.0 - 1) <2186F196-EE17-3A59-B9DA-D6823BEDD35B> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/ATSUI.framework/Versions/A/ATSUI
       0x19f921000 -        0x19f9269fb  libGIF.dylib (2784.6.6) <A4885DA3-9B44-3026-89DF-8161510F2F5C> /System/Library/Frameworks/ImageIO.framework/Versions/A/Resources/libGIF.dylib
       0x19f927000 -        0x19f93719f  com.apple.CMCaptureCore (1.0 - 665.140.6) <E35A60EE-A0A9-36CA-824C-0DC01FDD6658> /System/Library/PrivateFrameworks/CMCaptureCore.framework/Versions/A/CMCaptureCore
       0x19f938000 -        0x19f9aa71f  com.apple.print.framework.PrintCore (19 - 601.3) <AABA23CA-86DB-312C-BAED-86C43B896705> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/PrintCore
       0x19f9ab000 -        0x19fa4191f  com.apple.TextureIO (3.10.12 - 3.10.12) <D4BD9DCA-1C71-353D-8DAC-13ED5065D77F> /System/Library/PrivateFrameworks/TextureIO.framework/Versions/A/TextureIO
       0x19fa42000 -        0x19fd4bf9f  com.apple.InternationalSupport (1.0 - 74) <5ACC6C0E-51E9-3B5A-B24F-89B22D070878> /System/Library/PrivateFrameworks/InternationalSupport.framework/Versions/A/InternationalSupport
       0x19fd4c000 -        0x19fd9dd1f  com.apple.datadetectorscore (8.0 - 821.7) <C540CDD1-CE60-3EC9-998B-20E0A21A52A6> /System/Library/PrivateFrameworks/DataDetectorsCore.framework/Versions/A/DataDetectorsCore
       0x19fd9e000 -        0x19fe0e8df  com.apple.UserActivity (551 - 551) <0D6F3043-5372-3B15-96BC-6F45AD86F410> /System/Library/PrivateFrameworks/UserActivity.framework/Versions/A/UserActivity
       0x19fe0f000 -        0x1a08afe7f  com.apple.MediaToolbox (1.0 - 3330.13.2) <B4C2E4EA-D4F8-3676-AD09-004A44391002> /System/Library/Frameworks/MediaToolbox.framework/Versions/A/MediaToolbox
       0x1a08b0000 -        0x1a091e86f  libusrtcp.dylib (5812.160.9) <D2F997AA-2E08-3035-9D11-B2DF5D1552E9> /usr/lib/libusrtcp.dylib
       0x1a091f000 -        0x1a0ec17ff  libswiftCore.dylib (6.3.2 - 6.3.2.1.11) <83794FB3-DE9B-3D23-AB5E-2C1D5D30F134> /usr/lib/swift/libswiftCore.dylib
       0x1a0ec2000 -        0x1a0f3ac9f  com.apple.imfoundation (10.0 - 1000) <41E45E0C-2E88-3605-B213-F7CD760A9FF4> /System/Library/PrivateFrameworks/IMFoundation.framework/Versions/A/IMFoundation
       0x1a0f3b000 -        0x1a0f7401f  com.apple.locationsupport (3077.0.4 - 3077.0.4) <AE40B558-7C76-3410-A632-84E1B02DF891> /System/Library/PrivateFrameworks/LocationSupport.framework/Versions/A/LocationSupport
       0x1a0f75000 -        0x1a0fca31f  libSessionUtility.dylib (398.701) <1A63E9E1-2D64-3AF4-9CCD-6EF042397F84> /System/Library/PrivateFrameworks/AudioSession.framework/libSessionUtility.dylib
       0x1a0fcb000 -        0x1a11a005f  com.apple.audio.toolbox.AudioToolbox (1.14 - 1.14) <E8618176-515C-39A6-9F9C-3887A723C463> /System/Library/Frameworks/AudioToolbox.framework/Versions/A/AudioToolbox
       0x1a11a1000 -        0x1a1221b7f  com.apple.audio.AudioSession (1.0 - 398.701) <DC26AFB1-EFAD-3BB8-9446-0FB18DDFE476> /System/Library/PrivateFrameworks/AudioSession.framework/Versions/A/AudioSession
       0x1a1222000 -        0x1a123b39f  libAudioStatistics.dylib (262.601) <3FF99846-E48C-3C9A-814C-35B45E5F60EC> /usr/lib/libAudioStatistics.dylib
       0x1a123c000 -        0x1a126993f  com.apple.speech.synthesis.framework (9.2.22 - 9.2.22) <9CDA611B-254A-3779-9356-369485134C2D> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/SpeechSynthesis.framework/Versions/A/SpeechSynthesis
       0x1a126a000 -        0x1a12b7e5f  com.apple.ApplicationServices.ATS (377 - 593.6.0.3) <BBC091EE-D42B-32AC-8B00-E7BDDF033D7B> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/ATS.framework/Versions/A/ATS
       0x1a12b8000 -        0x1a12d419b  libresolv.9.dylib (96) <4AB71911-9300-30D4-88CF-D20EFD75ACE6> /usr/lib/libresolv.9.dylib
       0x1a12d5000 -        0x1a12e77e7  libsasl2.2.dylib (215) <7CF2A32E-72DD-34F7-B179-A17ED3D7DD75> /usr/lib/libsasl2.2.dylib
       0x1a12e8000 -        0x1a12f487f  com.apple.multiverse (1.0 - 117) <21723046-939E-302F-883C-9DB417452E3A> /System/Library/PrivateFrameworks/MultiverseSupport.framework/Versions/A/MultiverseSupport
       0x1a12f5000 -        0x1a135c767  libParallelCompression.dylib (450.160.2) <BA8350F0-D484-3F47-8DB5-98AE258D91CB> /usr/lib/libParallelCompression.dylib
       0x1a135d000 -        0x1a139675f  com.apple.securityinterface (10.0 - 55210.100.6) <D6FDA45D-779E-3F62-BD90-534353A1359C> /System/Library/Frameworks/SecurityInterface.framework/Versions/A/SecurityInterface
       0x1a1397000 -        0x1a13cc9df  com.apple.CoreFollowUp-OSX (1.0 - 281.5.2) <2E3A1FC1-80A1-3ED3-A157-5626AD72A640> /System/Library/PrivateFrameworks/CoreFollowUp.framework/Versions/A/CoreFollowUp
       0x1a13cd000 -        0x1a14cf87f  com.apple.CoreMediaIO (1000.0 - 5617.100.5) <1035C1AB-5058-3AFA-8D77-514901516251> /System/Library/Frameworks/CoreMediaIO.framework/Versions/A/CoreMediaIO
       0x1a14d0000 -        0x1a15b0337  libSMC.dylib (38) <655F6374-6CE8-3D0E-994E-4D7C37F78E89> /usr/lib/libSMC.dylib
       0x1a15b1000 -        0x1a160fc9f  libcups.2.dylib (522.8) <6A5A8E21-A9E6-32A2-9BDB-8013F002AEF8> /usr/lib/libcups.2.dylib
       0x1a1610000 -        0x1a161d257  com.apple.NetAuth (6.2 - 6.2) <024DBF34-DF66-3164-825E-F77F85462E66> /System/Library/PrivateFrameworks/NetAuth.framework/Versions/A/NetAuth
       0x1a161e000 -        0x1a1622dcb  com.apple.ColorSyncLegacy (4.13.0 - 1) <B4FC52C5-BB0F-3604-B00E-16F24907EB8F> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/ColorSyncLegacy.framework/Versions/A/ColorSyncLegacy
       0x1a1623000 -        0x1a162bdef  com.apple.QD (4.0 - 451) <59BBF27B-1D89-3D35-9210-8386EFA15A8D> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/QD.framework/Versions/A/QD
       0x1a162c000 -        0x1a1639b1f  com.apple.perfdata (1.0 - 130) <D3AAB65F-8C3C-399C-927F-20DC2DD769F2> /System/Library/PrivateFrameworks/perfdata.framework/Versions/A/perfdata
       0x1a163a000 -        0x1a1647c9f  libperfcheck.dylib (46) <912BFF10-FB8F-3D52-9941-ACDCE1CAE36A> /usr/lib/libperfcheck.dylib
       0x1a1648000 -        0x1a1659187  com.apple.Kerberos (3.0 - 1) <D4CB91E4-2ACB-332D-8FA0-8154F7B48D20> /System/Library/Frameworks/Kerberos.framework/Versions/A/Kerberos
       0x1a165a000 -        0x1a16abaaf  com.apple.GSS (4.0 - 2.0) <277D18EF-39E4-3F72-99E8-8D3DF65ED1D0> /System/Library/Frameworks/GSS.framework/Versions/A/GSS
       0x1a16ac000 -        0x1a16bcd6f  com.apple.CommonAuth (4.0 - 2.0) <097F7235-CA53-3644-BB95-F6F912B4F2C7> /System/Library/PrivateFrameworks/CommonAuth.framework/Versions/A/CommonAuth
       0x1a16bd000 -        0x1a17a105f  com.apple.MobileAssets (1.0 - 1837.160.15) <91A461DE-C8E8-3868-B393-BA6E5A17DF2A> /System/Library/PrivateFrameworks/MobileAsset.framework/Versions/A/MobileAsset
       0x1a17a2000 -        0x1a17f0c1f  com.apple.CacheDelete (1.0 - 1) <F5519EDD-F080-3571-918D-A77115712256> /System/Library/PrivateFrameworks/CacheDelete.framework/Versions/A/CacheDelete
       0x1a17f1000 -        0x1a1833eff  com.apple.security.KeychainCircle.KeychainCircle (1.0 - 1) <FFBABC1E-8B3E-394B-A95E-A330674158A2> /System/Library/PrivateFrameworks/KeychainCircle.framework/Versions/A/KeychainCircle
       0x1a1834000 -        0x1a1843160  com.apple.CorePhoneNumbers (1.0 - 1) <79000980-1797-3115-B74B-60FA1E9C3C73> /System/Library/PrivateFrameworks/CorePhoneNumbers.framework/Versions/A/CorePhoneNumbers
       0x1a1844000 -        0x1a18cd45f  libTelephonyUtilDynamic.dylib (6392) <63A6BBA0-CD50-30F8-9CD2-81B59264EA13> /usr/lib/libTelephonyUtilDynamic.dylib
       0x1a21f7000 -        0x1a24c0a7f  com.apple.NetworkExtension (1.0 - 1) <9753F471-40DD-3B9E-9D64-8D07C1B06BC9> /System/Library/Frameworks/NetworkExtension.framework/Versions/A/NetworkExtension
       0x1a24c1000 -        0x1a26e623f  com.apple.ids (10.0 - 1000) <F56AB66A-60FF-3241-9608-313B8522D517> /System/Library/PrivateFrameworks/IDS.framework/Versions/A/IDS
       0x1a26e7000 -        0x1a2d62e5f  com.apple.idsfoundation (10.0 - 1000) <42F76533-D8DD-3A24-A08A-103C51428797> /System/Library/PrivateFrameworks/IDSFoundation.framework/Versions/A/IDSFoundation
       0x1a2d63000 -        0x1a316bb9f  com.apple.Sharing (2094.70.81 - 2094.70.81) <920D8AA6-CDCD-3E0F-AD66-F0673ACABD3F> /System/Library/PrivateFrameworks/Sharing.framework/Versions/A/Sharing
       0x1a316c000 -        0x1a3223fff  com.apple.Bluetooth (1.0 - 1) <1ABB6C50-A5DE-3744-8F07-8C3B5617B0B9> /System/Library/Frameworks/IOBluetooth.framework/Versions/A/IOBluetooth
       0x1a3242000 -        0x1a32dae7f  com.apple.ProtectedCloudStorage (1.0 - 1) <1F8700BE-BD91-3B94-AC32-A5F10CEFEE35> /System/Library/PrivateFrameworks/ProtectedCloudStorage.framework/Versions/A/ProtectedCloudStorage
       0x1a32db000 -        0x1a33412bf  com.apple.QuickLookFramework (5.0 - 1018.5.5) <3C44610F-9A64-3F5A-B66D-7C1BC5D2F020> /System/Library/Frameworks/QuickLook.framework/Versions/A/QuickLook
       0x1a3342000 -        0x1a33604bf  com.apple.MetalKit (173.7 - 173.7) <BF72FDE1-F15E-37D8-BC66-F9774C7921EF> /System/Library/Frameworks/MetalKit.framework/Versions/A/MetalKit
       0x1a3361000 -        0x1a336598f  libxcselect.dylib (2416) <E9C2202C-2D65-38A7-B151-704C70A088A1> /usr/lib/libxcselect.dylib
       0x1a3419000 -        0x1a341f37f  libdscsym.dylib (427) <7E3E0CF7-905A-3244-A0C9-0ADCC2E16415> /usr/lib/libdscsym.dylib
       0x1a3420000 -        0x1a3513a36  com.apple.combine (1.0 - 3023) <F088ACC1-374F-3E9D-86DA-29310F8431B1> /System/Library/Frameworks/Combine.framework/Versions/A/Combine
       0x1a3514000 -        0x1a5373bdf  com.apple.GeoServices (1.0 - 2031.26.4.23.6) <1DAFDDDA-BB7B-320E-BCFC-B7C22886D486> /System/Library/PrivateFrameworks/GeoServices.framework/Versions/A/GeoServices
       0x1a5374000 -        0x1a537f647  com.apple.DirectoryService.Framework (26.6 - 666.100.1) <5F9A96D7-767C-3FF5-B6C5-7D93FD76B0F0> /System/Library/Frameworks/DirectoryService.framework/Versions/A/DirectoryService
       0x1a539c000 -        0x1a539f967  com.apple.speech.recognition.framework (6.0.5 - 6.0.5) <B4C49C28-105D-3260-8229-916D9FB0A584> /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/SpeechRecognition.framework/Versions/A/SpeechRecognition
       0x1a53a0000 -        0x1a53b1375  com.apple.AppleLDAP (26.6 - 63) <C6584A8B-46CC-3C4C-A401-25C78275D922> /System/Library/PrivateFrameworks/AppleLDAP.framework/Versions/A/AppleLDAP
       0x1a53b2000 -        0x1a566681f  com.apple.MapKit (1.0 - 2511.26.4.23.2) <6B758126-8EF2-373D-9640-7712A3852DC5> /System/Library/Frameworks/MapKit.framework/Versions/A/MapKit
       0x1a5674000 -        0x1a567a1d7  com.apple.IOPlatformPluginFamily (1.0 - 1) <294D21AC-0596-3B33-8AD2-AA818BD6CCF8> /System/Library/PrivateFrameworks/IOPlatformPluginFamily.framework/Versions/A/IOPlatformPluginFamily
       0x1a56ae000 -        0x1a56d63bf  com.apple.GLKit (129 - 129) <F3E6B01C-31C3-37D4-8C8B-3BF9BAFB870B> /System/Library/Frameworks/GLKit.framework/Versions/A/GLKit
       0x1a56e8000 -        0x1a572b19f  libnetworkextension.dylib (2226.161.1) <A4A0036B-6614-36AA-9751-F7519237C5B7> /usr/lib/libnetworkextension.dylib
       0x1a572c000 -        0x1a574ed9f  com.apple.Accessibility (1.0 - 1) <22008BA9-C61B-3FAD-A1A0-F6A1CD220343> /System/Library/Frameworks/Accessibility.framework/Versions/A/Accessibility
       0x1a5787000 -        0x1a5788a33  libCTGreenTeaLogger.dylib (13193) <2820F48C-919A-361E-9F16-3262EA66C59A> /usr/lib/libCTGreenTeaLogger.dylib
       0x1a5789000 -        0x1a578986f  com.apple.Accelerate.vecLib (3.11 - vecLib 3.11) <8203944D-B53E-3D7E-A481-3C676CAE1B6A> /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/vecLib
       0x1a57ae000 -        0x1a57ae98f  com.apple.CoreServices (1226 - 1226) <56AE2857-29E0-34E9-B2C3-EE8E951EEFC5> /System/Library/Frameworks/CoreServices.framework/Versions/A/CoreServices
       0x1a57af000 -        0x1a581079f  com.apple.CoreAppleCVA (4.4.0 - 4.4.0) <556809E3-5041-375B-91B4-313A7D0218A0> /System/Library/PrivateFrameworks/CoreAppleCVA.framework/Versions/A/CoreAppleCVA
       0x1a5a2d000 -        0x1a5a2d417  com.apple.Accelerate (1.11 - Accelerate 1.11) <9171DD7D-3994-3963-9A28-BC163BF97DE6> /System/Library/Frameworks/Accelerate.framework/Versions/A/Accelerate
       0x1a5a5c000 -        0x1a5a7bfff  com.apple.AssetCacheServices (140.120.2 - 140.120.2) <89B0B17D-AE25-39FA-B9B7-D74C3341722D> /System/Library/PrivateFrameworks/AssetCacheServices.framework/Versions/A/AssetCacheServices
       0x1a5a7c000 -        0x1a5a8e53f  com.apple.MediaAccessibility (1.0 - 153) <74D313A5-4D99-35D1-A4C9-B76AB6457EF0> /System/Library/Frameworks/MediaAccessibility.framework/Versions/A/MediaAccessibility
       0x1a5a8f000 -        0x1a5a94553  com.apple.AppleSRP (5.0 - 1) <60686D37-FC2A-3BF6-AF93-F74337D265C1> /System/Library/PrivateFrameworks/AppleSRP.framework/Versions/A/AppleSRP
       0x1a5a95000 -        0x1a5ad50bf  com.apple.framework.SystemAdministration (1.0 - 1.0) <463CC63E-1205-3FA3-A164-CD71FB0E0141> /System/Library/PrivateFrameworks/SystemAdministration.framework/Versions/A/SystemAdministration
       0x1a5ad6000 -        0x1a616febf  com.apple.VN (9.5.4 - 9.5.4) <10F83439-3A9F-316B-992E-451A72876715> /System/Library/Frameworks/Vision.framework/Versions/A/Vision
       0x1a6170000 -        0x1a61703ef  libswiftFoundation.dylib (2000) <14A11A94-6A52-3D24-9267-42EDAEEC5FDD> /usr/lib/swift/libswiftFoundation.dylib
       0x1a6171000 -        0x1a6253b5f  com.apple.AddressBook.ContactsFoundation (8.0 - 1397.700.21) <47527863-5326-3420-96AD-2C96B5C25504> /System/Library/PrivateFrameworks/ContactsFoundation.framework/Versions/A/ContactsFoundation
       0x1a6254000 -        0x1a62d2d5f  com.apple.contacts.ContactsPersistence (1.0 - 3804.700.52) <D7050328-150E-3E59-8B70-4167E3062B17> /System/Library/PrivateFrameworks/ContactsPersistence.framework/Versions/A/ContactsPersistence
       0x1a62d3000 -        0x1a643c45f  com.apple.AddressBook.core (1.0 - 2732.700.1) <5BF2A22C-35BF-360F-8791-9373A8F784C4> /System/Library/PrivateFrameworks/AddressBookCore.framework/Versions/A/AddressBookCore
       0x1a643d000 -        0x1a66e685f  com.apple.contacts (1.0 - 3804.700.52) <8FB53D0C-6447-3B78-9C48-18A26106A406> /System/Library/Frameworks/Contacts.framework/Versions/A/Contacts
       0x1a66e7000 -        0x1a66f761f  com.apple.PersonaKit (1.0 - 1) <CB360694-27FF-3B96-9D55-CCC141BE781D> /System/Library/PrivateFrameworks/PersonaKit.framework/Versions/A/PersonaKit
       0x1a66f8000 -        0x1a66fefdf  com.apple.communicationsfilter (10.0 - 1000) <3EA39366-5578-3B88-BD8A-7992791B5943> /System/Library/PrivateFrameworks/CommunicationsFilter.framework/Versions/A/CommunicationsFilter
       0x1a66ff000 -        0x1a68284df  com.apple.FamilyCircle (1.0 - 2) <EFED3BEF-814C-3B73-ACDA-5537B30DFAF2> /System/Library/PrivateFrameworks/FamilyCircle.framework/Versions/A/FamilyCircle
       0x1a6829000 -        0x1a69330ff  com.apple.CoreBluetooth (196.5) <515FDCCC-535A-398B-BBD3-3D35565F5423> /System/Library/Frameworks/CoreBluetooth.framework/Versions/A/CoreBluetooth
       0x1a6934000 -        0x1a69435df  com.apple.SymptomDiagnosticReporter (1.0 - 411.160.2) <737479F2-7B20-3DB6-B9F4-0DAA1B73E9D0> /System/Library/PrivateFrameworks/SymptomDiagnosticReporter.framework/Versions/A/SymptomDiagnosticReporter
       0x1a6944000 -        0x1a697225f  com.apple.PowerLog (1.0 - 1) <E86905A9-1519-3027-9182-C85F9EC8A6C0> /System/Library/PrivateFrameworks/PowerLog.framework/Versions/A/PowerLog
       0x1a6973000 -        0x1a697feff  com.apple.AppleIDAuthSupport (1.0 - 1) <FB5CF019-692F-3DDB-9E1F-ABAA63F4B8D9> /System/Library/PrivateFrameworks/AppleIDAuthSupport.framework/Versions/A/AppleIDAuthSupport
       0x1a6980000 -        0x1a6a316df  com.apple.DiscRecording (9.0.3 - 9030.4.5) <B38F9602-2DFD-33EB-9B69-867D46CF602A> /System/Library/Frameworks/DiscRecording.framework/Versions/A/DiscRecording
       0x1a6a32000 -        0x1a6a63137  com.apple.MediaKit (16 - 938) <46DD93AF-BACD-309B-AD51-9CC47C78CA2C> /System/Library/PrivateFrameworks/MediaKit.framework/Versions/A/MediaKit
       0x1a6a64000 -        0x1a6b46f3f  com.apple.DiskManagement (15.0 - 1037.160.3) <B478696F-3B77-3224-9945-5E2770F73578> /System/Library/PrivateFrameworks/DiskManagement.framework/Versions/A/DiskManagement
       0x1a6b47000 -        0x1a6b5323f  com.apple.CoreAUC (620.1 - 620.1) <9ACFCA55-82CB-33DB-AD00-443576099FDB> /System/Library/PrivateFrameworks/CoreAUC.framework/Versions/A/CoreAUC
       0x1a6b54000 -        0x1a6b5777b  com.apple.Mangrove (1.0 - 25) <87F549F4-73CC-302B-ABDB-D3CCFADABFA9> /System/Library/PrivateFrameworks/Mangrove.framework/Versions/A/Mangrove
       0x1a6b58000 -        0x1a6b85f87  com.apple.CoreAVCHD (6.0.0 - 6244.1) <CEC7BD9E-B5F2-3E7C-B04D-5DF1FC3A4553> /System/Library/PrivateFrameworks/CoreAVCHD.framework/Versions/A/CoreAVCHD
       0x1a6b86000 -        0x1a6d5c1df  com.apple.FileProvider (4018.160.6 - 4018.160.6) <5EA68C5E-69B0-3011-9D66-AEF49D82B29D> /System/Library/Frameworks/FileProvider.framework/Versions/A/FileProvider
       0x1a6d5d000 -        0x1a6d833ff  com.apple.GenerationalStorage (2.0 - 397.120.2) <A24BD91A-8190-352C-B5A2-D442DB5D6459> /System/Library/PrivateFrameworks/GenerationalStorage.framework/Versions/A/GenerationalStorage
       0x1a6d84000 -        0x1a6db573f  com.apple.security.octagontrust (1.0 - 1) <B5964A5B-DEFA-3D07-97D0-A5B8249970C1> /System/Library/PrivateFrameworks/OctagonTrust.framework/Versions/A/OctagonTrust
       0x1a6db6000 -        0x1a6dd861f  com.apple.CPAnalytics (1.0 - 860.0.170) <C2A14E70-7549-3A0D-A83B-21A129F84776> /System/Library/PrivateFrameworks/CPAnalytics.framework/Versions/A/CPAnalytics
       0x1a7321000 -        0x1a7508abf  com.apple.CoreTelephony (113 - 13193) <5F090F48-E481-3737-8E75-362E5D274879> /System/Library/Frameworks/CoreTelephony.framework/Versions/A/CoreTelephony
       0x1a7525000 -        0x1a753b950  libswiftDispatch.dylib (1542.160.2) <F0B9A36E-CE82-3B73-B644-E9C05DF0AF71> /usr/lib/swift/libswiftDispatch.dylib
       0x1a753c000 -        0x1a77ab1bf  com.apple.AVFCore (1.0 - 2430.13.1) <067E2603-4FEA-3CA5-8926-45F60681EDDB> /System/Library/PrivateFrameworks/AVFCore.framework/Versions/A/AVFCore
       0x1a77ac000 -        0x1a78853bf  com.apple.FrontBoardServices (1000.4.12 - 1000.4.12) <DD0CA5A1-7BD8-3895-9290-3580A783C069> /System/Library/PrivateFrameworks/FrontBoardServices.framework/Versions/A/FrontBoardServices
       0x1a7886000 -        0x1a7912c3f  com.apple.BoardServices (1.0 - 732.1.1) <BF23D7B4-4992-3663-BBEC-A55EE7D351DE> /System/Library/PrivateFrameworks/BoardServices.framework/Versions/A/BoardServices
       0x1a7913000 -        0x1a79523ff  com.apple.contacts.vCard (1.0 - 3804.700.52) <A9DFEF8D-78C6-3BCF-9427-AFF2EE9868DB> /System/Library/PrivateFrameworks/vCard.framework/Versions/A/vCard
       0x1a7953000 -        0x1a796053f  com.apple.GraphicsServices (1.0 - 1.0) <757FEDFF-841C-3D62-B703-CDE79E929363> /System/Library/PrivateFrameworks/GraphicsServices.framework/Versions/A/GraphicsServices
       0x1a7965000 -        0x1a79e617f  com.apple.CryptoTokenKit (1.0 - 1) <714063A8-D81E-3B22-9B36-88948A979E7F> /System/Library/Frameworks/CryptoTokenKit.framework/Versions/A/CryptoTokenKit
       0x1a79e7000 -        0x1a7a5361f  com.apple.LocalAuthentication (1.0 - 2005.160.7) <86858734-8B4D-38E6-AAA7-B7A046A7CB2A> /System/Library/Frameworks/LocalAuthentication.framework/Versions/A/LocalAuthentication
       0x1a7a54000 -        0x1a7a6167f  com.apple.CoreAuthentication.SharedUtils (1.0 - 2005.160.7) <D853D903-DE37-3F27-B376-04084C11772A> /System/Library/Frameworks/LocalAuthentication.framework/Support/SharedUtils.framework/Versions/A/SharedUtils
       0x1a7a62000 -        0x1a7aea15f  com.apple.avfoundationcf (2.0 - 775.13.1) <D5596758-6E9F-3C32-A8B0-D5CAB3EF94B8> /System/Library/PrivateFrameworks/AVFoundationCF.framework/Versions/A/AVFoundationCF
       0x1a7ba6000 -        0x1a7c7cb9f  com.apple.SAObjects (1.0 - 1) <086BB8AD-E317-3FC4-9E44-0D7C6036E8D7> /System/Library/PrivateFrameworks/SAObjects.framework/Versions/A/SAObjects
       0x1a7c7d000 -        0x1a7c9ee9f  com.apple.DebugSymbols (216 - 217) <7C923545-F3BB-3215-9720-85196358D9F1> /System/Library/PrivateFrameworks/DebugSymbols.framework/Versions/A/DebugSymbols
       0x1a7c9f000 -        0x1a7dfa49f  com.apple.CoreSymbolication (16.0 - 64575.55.1) <59136324-34E6-3367-92BB-659346907A04> /System/Library/PrivateFrameworks/CoreSymbolication.framework/Versions/A/CoreSymbolication
       0x1a7dfb000 -        0x1a7e0509f  com.apple.CoreTime (334.0.16.3 - 334.0.16.3) <A41A3592-8BDB-3BE5-BBF4-DC196D669C1D> /System/Library/PrivateFrameworks/CoreTime.framework/Versions/A/CoreTime
       0x1a7e06000 -        0x1a7ef9aff  com.apple.Rapport (7.1 - 715.2) <F6E572E4-F0AB-3F91-A003-E75A612F3F3D> /System/Library/PrivateFrameworks/Rapport.framework/Versions/A/Rapport
       0x1a7efa000 -        0x1a8bbf5df  com.apple.private.EmbeddedAcousticRecognition (1.0 - 1) <BF29D851-F79D-3866-AA68-AF81EE9826A8> /System/Library/PrivateFrameworks/EmbeddedAcousticRecognition.framework/Versions/A/EmbeddedAcousticRecognition
       0x1a8bc0000 -        0x1a8c1687f  com.apple.coreduetcontext (1.0 - 1) <90CFC86E-833E-3E9F-BAAC-2B61BD750DA6> /System/Library/PrivateFrameworks/CoreDuetContext.framework/Versions/A/CoreDuetContext
       0x1a8c17000 -        0x1a92913ff  com.apple.Intents (1.0 - 1) <FA0B35BF-F3FE-3329-983D-B5118AAF4E07> /System/Library/Frameworks/Intents.framework/Versions/A/Intents
       0x1a9292000 -        0x1a9292f3f  com.apple.framework.Apple80211 (1.0 - 19155.3) <116D159B-163E-3F91-9591-30FF8B6EB537> /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Apple80211
       0x1a9293000 -        0x1a975483f  com.apple.CoreWiFi (1.0 - 1006.2) <7C50137B-2ABD-3819-B033-AE65B05A6085> /System/Library/PrivateFrameworks/CoreWiFi.framework/Versions/A/CoreWiFi
       0x1a9755000 -        0x1a97c77ff  com.apple.BackBoardServices (1.0 - 1.0) <E1DAB2C4-0470-35D4-914C-1F38DE3D9EBB> /System/Library/PrivateFrameworks/BackBoardServices.framework/Versions/A/BackBoardServices
       0x1a97c8000 -        0x1a98034ef  com.apple.LDAPFramework (2.4.28 - 194.5) <8CABDD64-E6C6-3B77-B839-2E2B875CE0FE> /System/Library/Frameworks/LDAP.framework/Versions/A/LDAP
       0x1a9804000 -        0x1a98057b7  com.apple.TrustEvaluationAgent (2.0 - 38) <96C0BAAA-7FE6-3277-AFBC-31926F5935EE> /System/Library/PrivateFrameworks/TrustEvaluationAgent.framework/Versions/A/TrustEvaluationAgent
       0x1a9933000 -        0x1a99ec59f  com.apple.DiskImagesFramework (683.160.3 - 683.160.3) <E318744C-06A0-39A4-A55B-1245016B42CE> /System/Library/PrivateFrameworks/DiskImages.framework/Versions/A/DiskImages
       0x1a99ed000 -        0x1a9a2ce7f  com.apple.SystemConfiguration.EAP8021X (14.0.0 - 14.0) <B5BDFB31-F401-36C9-B831-3B6143A3D864> /System/Library/PrivateFrameworks/EAP8021X.framework/Versions/A/EAP8021X
       0x1a9a2d000 -        0x1a9a4359f  com.apple.RemoteServiceDiscovery (1.0 - 219.160.4) <823F3D1A-65F1-3CC5-96B1-750263B8DB36> /System/Library/PrivateFrameworks/RemoteServiceDiscovery.framework/Versions/A/RemoteServiceDiscovery
       0x1a9a44000 -        0x1a9a59c3f  com.apple.xpc.RemoteXPC (1.0 - 3102.160.5) <885F9C72-1018-368B-AD36-E8A42E87FD91> /System/Library/PrivateFrameworks/RemoteXPC.framework/Versions/A/RemoteXPC
       0x1a9ad9000 -        0x1a9adc653  com.apple.help (1.3.8 - 81) <356A9A80-09DB-3A79-B2DF-4E8730D794CF> /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/Help.framework/Versions/A/Help
       0x1a9add000 -        0x1a9ae139f  com.apple.EFILogin (2.0 - 2) <ED615852-CBF2-3349-81A5-27A7D089C1FB> /System/Library/PrivateFrameworks/EFILogin.framework/Versions/A/EFILogin
       0x1a9ae2000 -        0x1a9aeda07  libcsfde.dylib (568) <80C3E2D4-B6B8-3C62-B257-27DEEBAD4935> /usr/lib/libcsfde.dylib
       0x1a9aee000 -        0x1a9b6ef4b  libcurl.4.dylib (168) <2E99AD96-DC1C-3643-9988-273AB6844EFC> /usr/lib/libcurl.4.dylib
       0x1a9b6f000 -        0x1a9b7459f  com.apple.LoginUICore (4.0 - 4.0) <126DE35B-0C23-3D27-992C-C8FB1F712AD4> /System/Library/PrivateFrameworks/LoginUIKit.framework/Versions/A/Frameworks/LoginUICore.framework/Versions/A/LoginUICore
       0x1a9b75000 -        0x1a9bb825f  com.apple.AppSupport (1.0.0 - 29) <61B2B917-D14A-38AD-A439-16E1C635441A> /System/Library/PrivateFrameworks/AppSupport.framework/Versions/A/AppSupport
       0x1a9bb9000 -        0x1a9c01cdf  com.apple.AppSSO (1.0 - 483.160.10) <B34F7E6B-DD1C-3FB5-95CA-D56D48907A5F> /System/Library/PrivateFrameworks/AppSSO.framework/Versions/A/AppSSO
       0x1a9e88000 -        0x1a9e88927  com.apple.ApplicationServices (48 - 66) <086CBEED-2F64-3E75-AB99-8C8C0E0A2F1C> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/ApplicationServices
       0x1a9e89000 -        0x1a9e8bf3f  com.apple.InternationalTextSearch (1.0 - 1) <858910C5-1D4A-37B7-BF0E-EE02E24A2ACD> /System/Library/PrivateFrameworks/InternationalTextSearch.framework/Versions/A/InternationalTextSearch
       0x1a9e8c000 -        0x1a9f533ff  com.apple.ClassKit (1.2 - 151.5) <54035623-2246-32BA-8403-E545EF89C75D> /System/Library/Frameworks/ClassKit.framework/Versions/A/ClassKit
       0x1a9f54000 -        0x1aa1d98ff  com.apple.AppleAccount (1.0 - 1.0) <768DFB9E-7FB3-3998-A3AF-BEF0C6C740A7> /System/Library/PrivateFrameworks/AppleAccount.framework/Versions/A/AppleAccount
       0x1aa1da000 -        0x1aa22a53f  com.apple.AppleIDSSOAuthentication (1.0 - 1) <9D724BE7-0B01-39F3-82BE-BCEDC6EBAC8A> /System/Library/PrivateFrameworks/AppleIDSSOAuthentication.framework/Versions/A/AppleIDSSOAuthentication
       0x1aa22b000 -        0x1aa280d7f  com.apple.CorePrediction (1.0 - 1) <5AF7D218-7032-34DB-B3B0-54C6EAE74087> /System/Library/PrivateFrameworks/CorePrediction.framework/Versions/A/CorePrediction
       0x1aa281000 -        0x1aa3d4b5f  com.apple.AuthKitUI (1.0 - 1) <87568704-B631-3F6D-99A4-3BF20980C464> /System/Library/PrivateFrameworks/AuthKitUI.framework/Versions/A/AuthKitUI
       0x1aa458000 -        0x1aa45bd3f  com.apple.security.CryptoKit-C-Bridging (1.0 - 1) <CFC2A741-A85D-3E7D-A961-91F5C1742FA2> /System/Library/PrivateFrameworks/CryptoKitCBridging.framework/Versions/A/CryptoKitCBridging
       0x1aa45c000 -        0x1aa45c3f7  libHeimdalProxy.dylib (88) <0CB2E7E3-E96F-343B-A4E7-545E74AF0255> /System/Library/Frameworks/Kerberos.framework/Versions/A/Libraries/libHeimdalProxy.dylib
       0x1aa45d000 -        0x1aa45d512  com.apple.audio.units.AudioUnit (1.14 - 1.14) <093EF25B-5305-3611-B068-E65071858F52> /System/Library/Frameworks/AudioUnit.framework/Versions/A/AudioUnit
       0x1aa46c000 -        0x1aa471c73  com.apple.NetFSServer (2.0 - 1) <7A2A0296-0EA2-33B1-82BF-02B451DA29FF> /System/Library/PrivateFrameworks/NetFSServer.framework/Versions/A/NetFSServer
       0x1aa487000 -        0x1aa4a5b9f  com.apple.StreamingZip (1.0 - 1) <1F2EDC7B-8F28-3721-8A60-F6E1BCFC29A3> /System/Library/PrivateFrameworks/StreamingZip.framework/Versions/A/StreamingZip
       0x1aa4a6000 -        0x1aa4feadf  com.apple.DuetActivityScheduler (1.0 - 1) <D3291D8F-5606-3593-ABA7-00CE39429D6B> /System/Library/PrivateFrameworks/DuetActivityScheduler.framework/Versions/A/DuetActivityScheduler
       0x1aa4ff000 -        0x1aa5026bf  libswiftObjectiveC.dylib (951.7) <4FD234EA-2C18-3C25-8BD0-B1F4805C6675> /usr/lib/swift/libswiftObjectiveC.dylib
       0x1aa503000 -        0x1aa5206ff  libswiftos.dylib (1082) <C7A04322-C1B4-39A6-9E88-1C8CEDB97264> /usr/lib/swift/libswiftos.dylib
       0x1aa521000 -        0x1aa53195f  com.apple.IntentsFoundation (1.0 - 1) <58AC6CAB-5B91-367F-932F-BD0939BBD125> /System/Library/PrivateFrameworks/IntentsFoundation.framework/Versions/A/IntentsFoundation
       0x1aa532000 -        0x1aa53b4bf  com.apple.PushKit (1.0 - 1) <36607924-B1B2-39ED-B6D1-29683EFB67A0> /System/Library/Frameworks/PushKit.framework/Versions/A/PushKit
       0x1aa53c000 -        0x1aa5988bf  com.apple.cloudkit.C2 (1.3 - 2300.120) <A0E3C8BF-139D-33BC-8F2E-7D2057EF30AA> /System/Library/PrivateFrameworks/C2.framework/Versions/A/C2
       0x1aa599000 -        0x1aa5e601f  com.apple.QuickLookThumbnailing (1.0 - 208.6.1) <36F215D1-A2C0-32CA-ADD8-6D85AB48A772> /System/Library/Frameworks/QuickLookThumbnailing.framework/Versions/A/QuickLookThumbnailing
       0x1aa5e7000 -        0x1ab43873f  com.apple.vision.EspressoFramework (1.0 - 3525.1.1) <8F2949A6-43A0-30A2-B5D2-945949C5AA01> /System/Library/PrivateFrameworks/Espresso.framework/Versions/A/Espresso
       0x1ab439000 -        0x1ab46999f  com.apple.ANEServices (9.512 - 9.512) <A6EB8ED9-D3A8-3BE9-A09C-A5194D3DFBD2> /System/Library/PrivateFrameworks/ANEServices.framework/Versions/A/ANEServices
       0x1ab46a000 -        0x1ab4f885f  com.apple.proactive.support.ProactiveSupport (1.0 - 418.1) <73EE1A0A-0D29-3104-98CB-BEFEDA53F7C0> /System/Library/PrivateFrameworks/ProactiveSupport.framework/Versions/A/ProactiveSupport
       0x1ab4f9000 -        0x1ab50fe5f  com.apple.corerecents (1.0 - 1) <A8C7306A-13EF-3783-A165-131E958CB599> /System/Library/PrivateFrameworks/CoreRecents.framework/Versions/A/CoreRecents
       0x1ab510000 -        0x1ab5543df  com.apple.iCalendar (7.0 - 1169.4.3) <23978914-9386-3BBB-8E77-59775D9BD897> /System/Library/PrivateFrameworks/iCalendar.framework/Versions/A/iCalendar
       0x1ab555000 -        0x1ab5f3e5f  com.apple.CalendarFoundation (8.0 - 1603.4.5) <9BC14581-8654-3E5D-BA23-AEFBB4DFDE6F> /System/Library/PrivateFrameworks/CalendarFoundation.framework/Versions/A/CalendarFoundation
       0x1ab5f4000 -        0x1ab5f4527  com.apple.CoreDuetDaemonProtocol (1.0 - 1) <B4C51ABF-9446-3B30-AB6D-3DD54126047E> /System/Library/PrivateFrameworks/CoreDuetDaemonProtocol.framework/Versions/A/CoreDuetDaemonProtocol
       0x1ab5f5000 -        0x1ab61929f  com.apple.ASEProcessing (1.55.0 - 1.55.0) <4D8F39C6-B221-3AF1-BB40-CAEB0A174D61> /System/Library/PrivateFrameworks/ASEProcessing.framework/Versions/A/ASEProcessing
       0x1ab61a000 -        0x1ab6b9e5f  com.apple.framework.ConfigurationProfiles (18.0 - 1800) <945A43E9-6B7D-30F9-A215-D117F224492F> /System/Library/PrivateFrameworks/ConfigurationProfiles.framework/Versions/A/ConfigurationProfiles
       0x1ab93f000 -        0x1ab99ca5f  com.apple.AOSAccounts (1.3.1 - 210.600.1) <6FE61795-B0C5-3981-820B-B66EB16B60D6> /System/Library/PrivateFrameworks/AOSAccounts.framework/Versions/A/AOSAccounts
       0x1abf21000 -        0x1abf7db17  com.apple.ChunkingLibrary (2300.104 - 2300.104) <E1E32CF1-EFD0-3D47-9B70-455FBCD03191> /System/Library/PrivateFrameworks/ChunkingLibrary.framework/Versions/A/ChunkingLibrary
       0x1ac0c6000 -        0x1ac0d93df  com.apple.MediaLibrary (1.12.0 - 812) <2A18627A-1039-35B6-B1B7-E229361B5A2D> /System/Library/Frameworks/MediaLibrary.framework/Versions/A/MediaLibrary
       0x1ac0da000 -        0x1ac13c83f  com.apple.CalDAV (8.0 - 1155.4.3) <1FD26DE4-ADDD-3C18-86FC-8D331C6C89F4> /System/Library/PrivateFrameworks/CalDAV.framework/Versions/A/CalDAV
       0x1ac13d000 -        0x1ac20fe1f  com.apple.CoreSuggestions (1.0 - 1311.7) <53DD94CB-C1E1-3C0C-ADA0-D05CCAB69A15> /System/Library/PrivateFrameworks/CoreSuggestions.framework/Versions/A/CoreSuggestions
       0x1ac210000 -        0x1ac41393f  com.apple.eventkit (3.0 - 1934.6.1) <3FB7D2C6-2271-3029-BE29-EE41AA6E95D6> /System/Library/Frameworks/EventKit.framework/Versions/A/EventKit
       0x1ac414000 -        0x1ac44433f  com.apple.RTCReporting (13.1.47 - 166.2) <7BEBC9F1-212D-37F4-B601-A7AAD12F7225> /System/Library/PrivateFrameworks/RTCReporting.framework/Versions/A/RTCReporting
       0x1ac445000 -        0x1ac66dd7f  com.apple.WebKitLegacy (21624 - 21624.5.1.11.3) <7E1C5A28-D283-3168-B09C-6A3C54A52102> /System/Library/Frameworks/WebKit.framework/Versions/A/Frameworks/WebKitLegacy.framework/Versions/A/WebKitLegacy
       0x1ac6bd000 -        0x1ac72b13f  com.apple.CoreML.AppleNeuralEngine (1.0 - 1) <FD36C9CF-78FF-3841-A7A0-261BE42F3FC0> /System/Library/PrivateFrameworks/AppleNeuralEngine.framework/Versions/A/AppleNeuralEngine
       0x1ac879000 -        0x1ac947c1f  com.apple.audio.midi.CoreMIDI (2.0 - 88) <52BD9E26-B356-3EAA-9AD7-7FF700C61A91> /System/Library/Frameworks/CoreMIDI.framework/Versions/A/CoreMIDI
       0x1aca6c000 -        0x1aca6c467  com.apple.Cocoa (6.11 - 24) <AB9A4279-F590-352F-B202-7158F4C56076> /System/Library/Frameworks/Cocoa.framework/Versions/A/Cocoa
       0x1acaad000 -        0x1acac111f  com.apple.AskPermission (129.6.2 - 129.6.2) <4CB2EF58-17AD-362A-A960-597786A1571D> /System/Library/PrivateFrameworks/AskPermission.framework/Versions/A/AskPermission
       0x1acac2000 -        0x1ad589c9f  com.apple.AppleMediaServices (1.0 - 1) <7462577F-E47B-38D5-8FDD-163AAFAB7D5B> /System/Library/PrivateFrameworks/AppleMediaServices.framework/Versions/A/AppleMediaServices
       0x1ad58a000 -        0x1ad58e75f  com.apple.IOSurfaceAccelerator (1.0.0 - 1.0.0) <1E529C1A-B09C-3EB7-A286-CE00E292D561> /System/Library/PrivateFrameworks/IOSurfaceAccelerator.framework/Versions/A/IOSurfaceAccelerator
       0x1ad58f000 -        0x1ad59433f  libUAPreferences.dylib (736.20) <722D3DF7-1005-3107-AEC8-98F33A33BEA0> /System/Library/PrivateFrameworks/UniversalAccess.framework/Versions/A/Libraries/libUAPreferences.dylib
       0x1ad595000 -        0x1ad5b6f3f  com.apple.framework.familycontrols (4.1 - 410) <AEC4567A-7713-3AF9-A19C-0C6987D9EC75> /System/Library/PrivateFrameworks/FamilyControls.framework/Versions/A/FamilyControls
       0x1ad5b7000 -        0x1ad5c333f  com.apple.CommerceCore (1.0 - 716.4.2) <46510379-D37A-3ADC-B645-5722269F1E0A> /System/Library/PrivateFrameworks/CommerceKit.framework/Versions/A/Frameworks/CommerceCore.framework/Versions/A/CommerceCore
       0x1ad5c4000 -        0x1ad9dd03f  com.apple.MediaRemote (1.0 - 1) <D3E0EAC7-7D37-316F-A361-F4C83335062D> /System/Library/PrivateFrameworks/MediaRemote.framework/Versions/A/MediaRemote
       0x1ad9de000 -        0x1adca30ff  com.apple.AssistantServices (1.0 - 1) <E9AA2BD2-D71E-38C4-8B07-184B13EAC55C> /System/Library/PrivateFrameworks/AssistantServices.framework/Versions/A/AssistantServices
       0x1adca4000 -        0x1adcb745f  com.apple.PhotoFoundation (1.0 - 860.0.170) <E1E61FBC-DD5E-301D-87C5-17222CDAC140> /System/Library/PrivateFrameworks/PhotoFoundation.framework/Versions/A/PhotoFoundation
       0x1adcb8000 -        0x1ae0f1fdf  com.apple.imsharedutilities (10.0 - 1000) <78BC8379-BDA8-349D-8050-386C44EBC955> /System/Library/PrivateFrameworks/IMSharedUtilities.framework/Versions/A/IMSharedUtilities
       0x1ae0fb000 -        0x1ae0ffb3f  com.apple.DisplayServicesFW (3.1 - 380) <0AE066F1-6087-3373-9CD4-8AED1AE7ECD4> /System/Library/PrivateFrameworks/DisplayServices.framework/Versions/A/DisplayServices
       0x1ae100000 -        0x1ae1ed83f  com.apple.LoginUIKit (4.0 - 4.0) <AB581527-AFBF-3B27-AD92-75913C63D958> /System/Library/PrivateFrameworks/LoginUIKit.framework/Versions/A/LoginUIKit
       0x1ae1ee000 -        0x1ae20e23f  com.apple.icloud.FMCoreLite (1.0 - 1) <930F9F83-A947-3788-9FBA-49872FC3AF8D> /System/Library/PrivateFrameworks/FMCoreLite.framework/Versions/A/FMCoreLite
       0x1ae20f000 -        0x1aec97d7f  com.apple.PassKitCore (1.0 - 1) <9274CB4D-56C8-3B7F-923E-D88A932AE447> /System/Library/PrivateFrameworks/PassKitCore.framework/Versions/A/PassKitCore
       0x1af0ef000 -        0x1af122327  libtidy.A.dylib (20.1) <12066854-2BE4-35DF-BA9F-B38221C980FD> /usr/lib/libtidy.A.dylib
       0x1af123000 -        0x1af150fbf  com.apple.MarkupUI (1.0 - 560.4.2) <0EBA1D75-0C59-3CAE-8D42-3D6573BC3F7C> /System/Library/PrivateFrameworks/MarkupUI.framework/Versions/A/MarkupUI
       0x1af151000 -        0x1af168edf  com.apple.Engram (1.0 - 1) <6C3E51F8-D809-3AA1-8695-B75714C2D39A> /System/Library/PrivateFrameworks/Engram.framework/Versions/A/Engram
       0x1af169000 -        0x1af185b9f  com.apple.openscripting (1.7 - 200) <4069FDAA-012A-3ECC-A2AB-E6AFC59FA00B> /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/OpenScripting.framework/Versions/A/OpenScripting
       0x1af186000 -        0x1af188d27  com.apple.securityhi (9.0 - 55010) <928D1996-7CEE-308F-9CFE-6D7124B238DE> /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/SecurityHI.framework/Versions/A/SecurityHI
       0x1af189000 -        0x1af189863  com.apple.ink.framework (10.15 - 227) <9091BBA2-500E-3368-9FCF-ABBDDB2B77EA> /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/Ink.framework/Versions/A/Ink
       0x1af18a000 -        0x1af18dba7  com.apple.CommonPanels (1.2.6 - 106.1) <93A48B56-BD06-3B86-97D5-836A13AA4330> /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/CommonPanels.framework/Versions/A/CommonPanels
       0x1af18e000 -        0x1af1901fb  com.apple.ImageCapture (2020.2.2 - 2020.2.2) <CBE977D9-BB80-3BB9-A523-9B80CA02400B> /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/ImageCapture.framework/Versions/A/ImageCapture
       0x1af191000 -        0x1b107cabf  com.apple.JavaScriptCore (21624 - 21624.5.1.11.3) <88E2F28E-D20F-329C-B177-E5FBDEE5839D> /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/JavaScriptCore
       0x1b107d000 -        0x1b107e65f  com.apple.PowerlogControl (1.0 - 1) <77B083EA-7C7F-3A7B-8F92-CF4402B1A5CD> /System/Library/PrivateFrameworks/PowerlogControl.framework/Versions/A/PowerlogControl
       0x1b107f000 -        0x1b1085ddf  libUniversalAccess.dylib (736.20) <8639006D-0C7C-3483-82AA-6FA02BC2742D> /usr/lib/libUniversalAccess.dylib
       0x1b10e5000 -        0x1b116463f  com.apple.CoreCDP-OSX (1.0 - 1) <D161872F-0933-35F3-B3BC-3F13E13369E8> /System/Library/PrivateFrameworks/CoreCDP.framework/Versions/A/CoreCDP
       0x1b1165000 -        0x1b11763bf  com.apple.SetupAssistantFramework (1.0 - 1) <F85EEBDC-95AE-3390-89D4-143AA5C9CB52> /System/Library/PrivateFrameworks/SetupAssistantFramework.framework/Versions/A/SetupAssistantFramework
       0x1b1177000 -        0x1b13b88ff  com.apple.AVFCapture (1.0 - 665.140.6) <CC5A573E-8A8C-399F-B3DB-370DBF3C9C76> /System/Library/PrivateFrameworks/AVFCapture.framework/Versions/A/AVFCapture
       0x1b13b9000 -        0x1b14e9d1f  com.apple.Quagga (186 - 186) <1772C40D-6EF4-3F81-BA00-6EE8B05039A6> /System/Library/PrivateFrameworks/Quagga.framework/Versions/A/Quagga
       0x1b14ea000 -        0x1b1b256ff  com.apple.CMCapture (1.0 - 665.140.6) <57A10B70-C3C9-34C6-8D22-F5118B63E2F0> /System/Library/PrivateFrameworks/CMCapture.framework/Versions/A/CMCapture
       0x1b1b26000 -        0x1b1ca991f  com.apple.RenderBox (7.4.25 - 7.4.25) <92090A92-DFAF-3EBC-886C-655EC158A53F> /System/Library/PrivateFrameworks/RenderBox.framework/Versions/A/RenderBox
       0x1b2144000 -        0x1b21ff53f  com.apple.accounts.AccountsDaemon (113 - 113) <EEF98E7B-9F3A-3B4B-92C5-48248F278835> /System/Library/PrivateFrameworks/AccountsDaemon.framework/Versions/A/AccountsDaemon
       0x1b2200000 -        0x1b220303f  com.apple.OAuth (25 - 25) <87039A60-9152-3DDB-9767-58D0B627ECB2> /System/Library/PrivateFrameworks/OAuth.framework/Versions/A/OAuth
       0x1b280f000 -        0x1b285945f  com.apple.CloudServices (1.0 - 694.120.16) <81F4A8BA-C80F-3B53-82E7-57F6928609C5> /System/Library/PrivateFrameworks/CloudServices.framework/Versions/A/CloudServices
       0x1b285a000 -        0x1b286d9ff  com.apple.HID (1.0 - 1) <C61C2A64-EA55-3732-A51A-FD2F9740B76B> /System/Library/PrivateFrameworks/HID.framework/Versions/A/HID
       0x1b286e000 -        0x1b28bf3bf  com.apple.IOGPU (130.16.4 - 130.16.4) <9235E8EC-599D-386F-8A8A-6B6A92D33369> /System/Library/PrivateFrameworks/IOGPU.framework/Versions/A/IOGPU
       0x1b28e0000 -        0x1b2964a9f  com.apple.coredav (1.0.1 - 1236.4.6) <3493238C-B512-350A-A1B4-269DEB38CA5A> /System/Library/PrivateFrameworks/CoreDAV.framework/Versions/A/CoreDAV
       0x1b29d4000 -        0x1b2a5e0ff  com.apple.MediaServices (1.0 - 4025.600.3) <1FB2BCFD-D9FC-385A-A0EA-E2B5052E27F5> /System/Library/PrivateFrameworks/MediaServices.framework/Versions/A/MediaServices
       0x1b2a5f000 -        0x1b2a850bf  com.apple.IASUtilities (1.0 - 661.100.2) <6FA5FBF3-C6D9-3228-A352-0B5AB00CB987> /System/Library/PrivateFrameworks/IASUtilities.framework/Versions/A/IASUtilities
       0x1b2b28000 -        0x1b2b6a09f  com.apple.VirtualGarage (1.0 - 1) <F72F13D8-5867-368A-A3CF-5A7A202622E7> /System/Library/PrivateFrameworks/VirtualGarage.framework/Versions/A/VirtualGarage
       0x1b2b7a000 -        0x1b2b7a847  com.apple.marco (10.0 - 1000) <40F60A3F-90A9-3F07-A99D-005E3158C6F6> /System/Library/PrivateFrameworks/Marco.framework/Versions/A/Marco
       0x1b2b7b000 -        0x1b2bc308b  com.apple.private.yara (1.0 - 1) <FE9FB07F-850A-3438-B2F3-BAA2E150C4DE> /System/Library/PrivateFrameworks/yara.framework/Versions/A/yara
       0x1b2bc4000 -        0x1b2c4a0bf  com.apple.CoreRecognition (1.3 - 157) <3C1F6C88-498B-3ABE-8C9D-7DA88959AD36> /System/Library/PrivateFrameworks/CoreRecognition.framework/Versions/A/CoreRecognition
       0x1b2c4b000 -        0x1b2c5d31f  com.apple.PersonaUI (1.0 - 1) <B1190AE8-6A1F-38F0-BF8B-4D237385EB7C> /System/Library/PrivateFrameworks/PersonaUI.framework/Versions/A/PersonaUI
       0x1b2c5e000 -        0x1b2edefbf  com.apple.Contacts.ContactsUICore (1.0 - 3683.700.21) <5CFC3725-3A8D-3136-8B2B-D79312F86C05> /System/Library/PrivateFrameworks/ContactsUICore.framework/Versions/A/ContactsUICore
       0x1b2edf000 -        0x1b304683f  com.apple.ContactsUI (14.0 - 2732.700.1) <1C736CFA-B21F-3D3D-821D-58B2CF8B2A75> /System/Library/Frameworks/ContactsUI.framework/Versions/A/ContactsUI
       0x1b3047000 -        0x1b30ca93f  com.apple.contacts.ContactsAutocomplete (1.0 - 1356.700.21) <9672A3E2-D745-3E78-8342-A783A504DA20> /System/Library/PrivateFrameworks/ContactsAutocomplete.framework/Versions/A/ContactsAutocomplete
       0x1b311e000 -        0x1b31587df  com.apple.proactive.support.ProactiveEventTracker (1.0 - 418.1) <C8A0CCAB-B7C8-380F-AD5D-C9DB887B0F9B> /System/Library/PrivateFrameworks/ProactiveEventTracker.framework/Versions/A/ProactiveEventTracker
       0x1b3259000 -        0x1b349547f  com.apple.framework.calculate (1.4 - 17) <3A9DB139-7495-314D-B6FC-D1EC14E3811B> /System/Library/PrivateFrameworks/Calculate.framework/Versions/A/Calculate
       0x1b375e000 -        0x1b375f17f  com.apple.PhoneNumbers (1.0 - 1) <8D0ECDD1-24B6-3B8D-9CF9-CDC55FC64490> /System/Library/PrivateFrameworks/PhoneNumbers.framework/Versions/A/PhoneNumbers
       0x1b3760000 -        0x1b37696bf  com.apple.URLFormatting (296 - 296.12) <CB5152F9-1DCC-323D-AE27-5ECE07CB039C> /System/Library/PrivateFrameworks/URLFormatting.framework/Versions/A/URLFormatting
       0x1b376a000 -        0x1b3875a3f  com.apple.accessibility.AXCoreUtilities (1.0 - 1) <B0A62AD1-78DA-3A6F-A23A-BE1DC54C19F8> /System/Library/PrivateFrameworks/AXCoreUtilities.framework/Versions/A/AXCoreUtilities
       0x1b3876000 -        0x1b38ac7ff  libAccessibility.dylib (3191.39) <5240B3A0-D035-345E-A636-BC3A92C847C4> /usr/lib/libAccessibility.dylib
       0x1b38ad000 -        0x1b738145f  com.apple.WebCore (21624 - 21624.5.1.11.3) <5FCF5DCC-D9BD-3A7E-9618-DBE0A758D89F> /System/Library/Frameworks/WebKit.framework/Versions/A/Frameworks/WebCore.framework/Versions/A/WebCore
       0x1b7382000 -        0x1b744efbf  com.apple.PackageKit (3.0 - 1491.160.2) <C2CCDEC6-E704-3E8F-B769-8B56D91E5C99> /System/Library/PrivateFrameworks/PackageKit.framework/Versions/A/PackageKit
       0x1b744f000 -        0x1b745e29f  com.apple.NetFS (6.0 - 4.0) <49121861-2603-3B0A-B664-BAD9E729BE5D> /System/Library/Frameworks/NetFS.framework/Versions/A/NetFS
       0x1b75ae000 -        0x1b75ddfbf  com.apple.quicklook.QuickLookSupport (1.0 - 208.6.1) <BAE8B5D6-5413-3DE7-B348-26992ACC141D> /System/Library/PrivateFrameworks/QuickLookSupport.framework/Versions/A/QuickLookSupport
       0x1b75de000 -        0x1b76f7cbf  com.apple.siri.parsec.CoreParsec (1.0 - 3525.4.2) <F71B1618-C850-356D-B1C6-DB649A3F2F52> /System/Library/PrivateFrameworks/CoreParsec.framework/Versions/A/CoreParsec
       0x1b76f8000 -        0x1b7948b5f  com.apple.TelephonyUtilities (1.0 - 1.0) <706DE359-04A5-3E90-8095-4D09668BE71B> /System/Library/PrivateFrameworks/TelephonyUtilities.framework/Versions/A/TelephonyUtilities
       0x1b7949000 -        0x1b79a94df  com.apple.DeviceManagement (1.0 - 249.100.1) <6D6B29AD-2C0B-360E-8404-89EEE7083052> /System/Library/PrivateFrameworks/DeviceManagement.framework/Versions/A/DeviceManagement
       0x1b79aa000 -        0x1b79aa357  libswiftCoreGraphics.dylib (17) <DD6D3B10-645E-312D-84E9-A24EEDFCFA42> /usr/lib/swift/libswiftCoreGraphics.dylib
       0x1b79ab000 -        0x1b79ad707  libswiftDarwin.dylib (377.160.5) <1DB56DA9-CF6B-3023-ABDF-5A37CB79223C> /usr/lib/swift/libswiftDarwin.dylib
       0x1b7aa3000 -        0x1b9149b3f  com.apple.WebKit (21624 - 21624.5.1.11.3) <844AF253-CAF6-3623-9DAD-A055C5274E62> /System/Library/Frameworks/WebKit.framework/Versions/A/WebKit
       0x1b9596000 -        0x1b9596517  com.apple.CorePDF (4.0 - 555) <27BB4B14-7431-35F6-B8D0-178DE1F0BE1F> /System/Library/PrivateFrameworks/CorePDF.framework/Versions/A/CorePDF
       0x1b9597000 -        0x1b9597817  com.apple.Carbon (160 - 170) <0BA2D774-3930-3CC1-8EEB-978659830298> /System/Library/Frameworks/Carbon.framework/Versions/A/Carbon
       0x1b9598000 -        0x1b993229f  com.apple.coremotion (3077.0.4 - 3077.0.4) <2E109991-45C6-3783-8A36-B6A8070AAD67> /System/Library/Frameworks/CoreMotion.framework/Versions/A/CoreMotion
       0x1b999a000 -        0x1b999a5a7  com.apple.avfoundation (2.0 - 2430.13.1) <816EC446-7C41-3A2F-A582-7CB856797C09> /System/Library/Frameworks/AVFoundation.framework/Versions/A/AVFoundation
       0x1b9ace000 -        0x1b9bb74df  libquic.dylib (5812.160.9) <5E89267F-C684-348D-8356-F9DAD8B4CB13> /usr/lib/libquic.dylib
       0x1b9bbc000 -        0x1b9bc24af  com.apple.EmbeddedOSSupportHost (1.0 - 1) <C4C50C4C-7870-3F5E-B92A-173555D4404F> /System/Library/PrivateFrameworks/EmbeddedOSSupportHost.framework/Versions/A/EmbeddedOSSupportHost
       0x1b9bc3000 -        0x1b9bebedf  com.apple.private.SystemPolicy (1.0 - 1) <6108A12D-286B-3CF2-B848-B0E7A0189DCC> /System/Library/PrivateFrameworks/SystemPolicy.framework/Versions/A/SystemPolicy
       0x1b9bec000 -        0x1b9c1385f  com.apple.icloud.FindMyDevice (1.0 - 1) <627D64D5-2D3C-3EC6-B4AB-FEF4DEE40871> /System/Library/PrivateFrameworks/FindMyDevice.framework/Versions/A/FindMyDevice
       0x1b9fc9000 -        0x1b9ff195f  com.apple.sidecar-core (1.0 - 384.1) <564D70BF-F605-3B57-8FF3-C8F9AD02B0B4> /System/Library/PrivateFrameworks/SidecarCore.framework/Versions/A/SidecarCore
       0x1b9ff2000 -        0x1b9ff7edf  com.apple.QuickLookNonBaseSystem (1.0 - 1) <A9BE8DB8-3F96-3D0F-B1B2-E462FEBE135D> /System/Library/PrivateFrameworks/QuickLookNonBaseSystem.framework/Versions/A/QuickLookNonBaseSystem
       0x1b9ff8000 -        0x1ba0345df  com.apple.datadetectors (5.0 - 469.2) <AA0418DE-949D-3B7C-98D4-FC4D28738595> /System/Library/PrivateFrameworks/DataDetectors.framework/Versions/A/DataDetectors
       0x1ba226000 -        0x1ba2bbfbf  com.apple.CoreRoutine (1.0 - 1075.0.3) <D7F83B22-71A9-33CC-A6A8-EBF82854369E> /System/Library/PrivateFrameworks/CoreRoutine.framework/Versions/A/CoreRoutine
       0x1ba2bc000 -        0x1ba2df97f  com.apple.mediastream (1.0 - 860.0.170) <FBCDB87E-551C-3251-AB26-B76FF9F182DC> /System/Library/PrivateFrameworks/MediaStream.framework/Versions/A/MediaStream
       0x1ba617000 -        0x1ba61bde3  com.apple.CoreOptimization (1.0 - 1) <29E08673-E431-3E9A-84F3-8AE7C3A12D94> /System/Library/PrivateFrameworks/CoreOptimization.framework/Versions/A/CoreOptimization
       0x1ba61c000 -        0x1ba62fe1f  com.apple.FeatureFlagsSupport (1.0 - 103) <8C10B437-C282-37F5-834F-E7179C700373> /System/Library/PrivateFrameworks/FeatureFlagsSupport.framework/Versions/A/FeatureFlagsSupport
       0x1ba630000 -        0x1ba6359ff  com.apple.incomingcallfilter (10.0 - 1000) <120AE842-DC77-3DFB-8FB0-C4230667AFD6> /System/Library/PrivateFrameworks/IncomingCallFilter.framework/Versions/A/IncomingCallFilter
       0x1ba636000 -        0x1ba69e21f  com.apple.facetimeservices (10.0 - 1000) <0E78989C-854F-3664-AD92-6B7B6D04191C> /System/Library/PrivateFrameworks/FTServices.framework/Versions/A/FTServices
       0x1ba69f000 -        0x1ba6b453f  com.apple.CoreSDB (10.0 - 1000) <5B8C8B3E-BCAB-3D44-9925-BA316EAFD3D7> /System/Library/PrivateFrameworks/CoreSDB.framework/Versions/A/CoreSDB
       0x1ba74b000 -        0x1ba767b1f  com.apple.contacts.donation (1.0 - 1123.700.1) <C8B69116-D74B-3802-8C21-940E640C3118> /System/Library/PrivateFrameworks/ContactsDonation.framework/Versions/A/ContactsDonation
       0x1ba768000 -        0x1ba7e185f  com.apple.NaturalLanguage (1.0 - 114) <0C005C4D-CA12-389C-9CCE-C4ED05B187E8> /System/Library/Frameworks/NaturalLanguage.framework/Versions/A/NaturalLanguage
       0x1ba7e2000 -        0x1ba80ae7f  com.apple.SafariServices.framework (21624 - 21624.5.1.11.3) <E7EB8682-FDD6-34D0-A821-024DB637CD68> /System/Library/Frameworks/SafariServices.framework/Versions/A/SafariServices
       0x1ba822000 -        0x1ba8b0b3f  com.apple.Catalyst (1.0 - 18.100.1) <E4027B2A-537B-33B9-8FF1-3B50BA8DAACC> /System/Library/PrivateFrameworks/Catalyst.framework/Versions/A/Catalyst
       0x1ba8d7000 -        0x1ba91eddf  com.apple.LocalAuthentication.DaemonUtils (1.0 - 2005.160.7) <A0C4A93B-81E4-3195-97E7-6C598DC03735> /System/Library/Frameworks/LocalAuthentication.framework/Support/DaemonUtils.framework/Versions/A/DaemonUtils
       0x1ba91f000 -        0x1ba9656ff  com.apple.BiometricKit (1.0 - 545.100.10) <6F344FB8-438F-3C17-9FAB-F1CE425B3F9B> /System/Library/PrivateFrameworks/BiometricKit.framework/Versions/A/BiometricKit
       0x1baaa8000 -        0x1bab36bff  com.apple.LoggingSupport (1.0 - 1861.160.4) <DAB7DFDC-BE61-3164-B741-A753F6CD2E7E> /System/Library/PrivateFrameworks/LoggingSupport.framework/Versions/A/LoggingSupport
       0x1bab37000 -        0x1bab43acb  com.apple.MallocStackLogging (1.0 - 65000) <566F2D7D-0F3B-3290-A739-7A40A151F0BE> /System/Library/PrivateFrameworks/MallocStackLogging.framework/Versions/A/MallocStackLogging
       0x1bab47000 -        0x1bab68aff  com.apple.StorageManagement (1.0 - 1) <F782028C-52B1-3633-92CA-8FB4E093C403> /System/Library/PrivateFrameworks/StorageManagement.framework/Versions/A/StorageManagement
       0x1bab69000 -        0x1babc3d9f  libmis.dylib (463.160.2) <173A632F-20F3-30C1-BC55-EFFE977BBB8E> /usr/lib/libmis.dylib
       0x1babc4000 -        0x1babc7c5f  com.apple.gpusw.GPURawCounter (34 - 34) <03470B3A-A004-39A0-B6A4-F2A4AFFFCDD3> /System/Library/PrivateFrameworks/GPURawCounter.framework/Versions/A/GPURawCounter
       0x1babc8000 -        0x1babe787f  libswiftCoreAudio.dylib (411.701) <CAFCB013-F154-361D-8A8C-062C63BBA8FC> /usr/lib/swift/libswiftCoreAudio.dylib
       0x1babe8000 -        0x1babee327  libswiftCoreFoundation.dylib (2411) <4975D13C-2AC5-3473-85C0-98054A81D7C6> /usr/lib/swift/libswiftCoreFoundation.dylib
       0x1babef000 -        0x1babfa4bf  libswiftIntents.dylib (12) <52E271D5-23AF-3AD9-9543-D4A1004F43EE> /usr/lib/swift/libswiftIntents.dylib
       0x1babfb000 -        0x1bac47843  libswiftXPC.dylib (128.120.2) <24AEDAC1-C1EE-30F4-8818-72EBF8969D0C> /usr/lib/swift/libswiftXPC.dylib
       0x1bac48000 -        0x1bac487ff  libswiftCoreImage.dylib (2.2) <A543AEBB-52DB-3028-BAC0-650F22C04BC8> /usr/lib/swift/libswiftCoreImage.dylib
       0x1bac49000 -        0x1bac498a3  libswiftIOKit.dylib (1) <06A92787-4440-3757-AF32-F2B331C753A2> /usr/lib/swift/libswiftIOKit.dylib
       0x1bac4a000 -        0x1bb0abaff  com.apple.CoreHandwriting (161 - 1.2) <45B2A604-B7C0-3AEA-A016-F1FFEF75370B> /System/Library/PrivateFrameworks/CoreHandwriting.framework/Versions/A/CoreHandwriting
       0x1bb0ac000 -        0x1bb2de8df  com.apple.imageKit (3.0 - 1236.5.2) <3BBE296E-0997-3D3B-B0BB-13B621FDB74C> /System/Library/Frameworks/Quartz.framework/Versions/A/Frameworks/ImageKit.framework/Versions/A/ImageKit
       0x1bb2df000 -        0x1bb4a299f  com.apple.PencilKit (1.0 - 1) <7D57DA6B-1AC6-39F4-B779-03263DACCAC4> /System/Library/Frameworks/PencilKit.framework/Versions/A/PencilKit
       0x1bb4a3000 -        0x1bb4b7a7f  com.apple.sidecar-ui (1.0 - 384.1) <EA68B1F5-EBB7-3668-89CC-031BBA5C9479> /System/Library/PrivateFrameworks/SidecarUI.framework/Versions/A/SidecarUI
       0x1bb4b8000 -        0x1bb4c629f  com.apple.performance.SignpostCollection (1.174.8 - 174.8) <6B2EFD01-ACAC-394A-8225-4255D9708B88> /System/Library/PrivateFrameworks/SignpostCollection.framework/Versions/A/SignpostCollection
       0x1bb4c7000 -        0x1bb4c72c7  com.apple.WebInspectorUI (21624 - 21624.5.1.11.3) <9A5EFDC4-27BD-34F3-BE1A-F23847F786A0> /System/Library/PrivateFrameworks/WebInspectorUI.framework/Versions/A/WebInspectorUI
       0x1bb4c8000 -        0x1bb5091ff  com.apple.OnBoardingKit (1.0 - 1) <AF26FA73-58E2-341D-9232-80152A83BE17> /System/Library/PrivateFrameworks/OnBoardingKit.framework/Versions/A/OnBoardingKit
       0x1bb5a8000 -        0x1bb5b717f  com.apple.CoreKDL (1.0 - 1) <3284EBCB-D070-39D4-9EB7-7669BF823BA0> /System/Library/PrivateFrameworks/CoreKDL.framework/Versions/A/CoreKDL
       0x1bb5b8000 -        0x1bb636b1f  com.apple.TrialProto (1.0 - 474.2.18.2) <AEC3C71D-DC18-3279-ADFF-76EE82504B5F> /System/Library/PrivateFrameworks/TrialProto.framework/Versions/A/TrialProto
       0x1bb637000 -        0x1bb6e06ff  com.apple.trial (1.0 - 474.2.18.2) <53B3126E-7B01-30DD-961A-510E9CFC3CF1> /System/Library/PrivateFrameworks/Trial.framework/Versions/A/Trial
       0x1bb6e1000 -        0x1bbbbb45f  com.apple.SearchFoundation (1.0 - 3525.4.2) <D89498B3-0995-322A-BB57-D8B43FD3BC58> /System/Library/PrivateFrameworks/SearchFoundation.framework/Versions/A/SearchFoundation
       0x1bbbbc000 -        0x1bbfaa45f  com.apple.Photos (1.0 - 860.0.170) <C0B70412-992F-389A-AB2F-9ED3994097B6> /System/Library/Frameworks/Photos.framework/Versions/A/Photos
       0x1bbfab000 -        0x1bc026dbf  com.apple.ImageCaptureCore (2020.2.2 - 2020.2.2) <25E03224-575B-3EC1-9A13-90A8DC95641B> /System/Library/Frameworks/ImageCaptureCore.framework/Versions/A/ImageCaptureCore
       0x1bc027000 -        0x1bc04f9bf  com.apple.quartzfilters (1.10.0 - 103) <B3527256-6287-31C3-BEFD-EB9D1BEEDF8D> /System/Library/Frameworks/Quartz.framework/Versions/A/Frameworks/QuartzFilters.framework/Versions/A/QuartzFilters
       0x1bc050000 -        0x1bc096d1f  com.apple.IntlPreferences (2.0 - 475.4.1) <55047D18-C5A0-36E5-B448-FDD64F33D9F9> /System/Library/PrivateFrameworks/IntlPreferences.framework/Versions/A/IntlPreferences
       0x1bc097000 -        0x1bc0d229f  com.apple.ToneLibrary (1.0 - 1) <A03DD8A0-4F52-368C-8D91-11F37FA6EC22> /System/Library/PrivateFrameworks/ToneLibrary.framework/Versions/A/ToneLibrary
       0x1bc0d3000 -        0x1bc0dbeff  com.apple.CoreFollowUpUI (1.0 - 281.5.2) <204C234A-2889-3E5A-ACEC-146D1B86904E> /System/Library/PrivateFrameworks/CoreFollowUpUI.framework/Versions/A/CoreFollowUpUI
       0x1bc1a3000 -        0x1bc24ae7f  com.apple.CallKit (1.0 - 1) <5C406396-BCC8-3A4A-A100-82F5C6B77DC3> /System/Library/Frameworks/CallKit.framework/Versions/A/CallKit
       0x1bc24b000 -        0x1bc36fd1f  com.apple.ScreenTimeCore (3.0 - 605.6.5) <4717EEFF-406D-3FA1-9C76-49DFB48F91AB> /System/Library/PrivateFrameworks/ScreenTimeCore.framework/Versions/A/ScreenTimeCore
       0x1bc37a000 -        0x1bc393c7f  com.apple.contextkit.ContextKit (1.0 - 1) <9E1E728C-644B-3663-8AD0-3583C7DAD067> /System/Library/PrivateFrameworks/ContextKit.framework/Versions/A/ContextKit
       0x1bc394000 -        0x1bc58485f  com.apple.Safari.Core (21624 - 21624.5.1.11.3) <C036D9FE-0DB5-3D68-B36D-85F7F93FF18F> /System/Library/PrivateFrameworks/SafariCore.framework/Versions/A/SafariCore
       0x1bc884000 -        0x1bcc7495f  com.apple.iTunesCloud (1.0 - 4025.700.1) <A53FF70A-EA08-34FE-A5A6-09FFC49B16C2> /System/Library/PrivateFrameworks/iTunesCloud.framework/Versions/A/iTunesCloud
       0x1bcc7b000 -        0x1bccb42c7  libbootpolicy.dylib (289.160.2) <B5133C2D-C0A5-34C3-BF53-A59FBDDCEEDA> /usr/lib/libbootpolicy.dylib
       0x1bccb5000 -        0x1bce00f1f  com.apple.AnnotationKit (1.0 - 560.4.2) <AFBA7D4B-F057-3C1E-9805-19E2B07D07C8> /System/Library/PrivateFrameworks/AnnotationKit.framework/Versions/A/AnnotationKit
       0x1bce01000 -        0x1bd2e17bf  com.apple.QuartzComposer (5.1 - 387) <3C4FCC73-F576-361E-A488-E25CDDEF881A> /System/Library/Frameworks/Quartz.framework/Versions/A/Frameworks/QuartzComposer.framework/Versions/A/QuartzComposer
       0x1bd2e2000 -        0x1bd40a61f  com.apple.PDFKit (1.0 - 1451.5.3) <E033639D-2114-3B09-9170-4E574FC168F8> /System/Library/Frameworks/PDFKit.framework/Versions/A/PDFKit
       0x1bd40b000 -        0x1bda3937f  com.apple.SceneKit (1.0 - 608.600) <87E8A500-E395-30C4-A81B-9E8FA480516F> /System/Library/Frameworks/SceneKit.framework/Versions/A/SceneKit
       0x1bdd54000 -        0x1bdd5eb1f  com.apple.BridgeXPC (1.0 - 39) <D4DD0F6D-9490-35F3-ABA8-8A519F2FEB8F> /System/Library/PrivateFrameworks/BridgeXPC.framework/Versions/A/BridgeXPC
       0x1bdd5f000 -        0x1bdd8d9df  com.apple.skp.FeedbackLogger (1.0 - 1) <D636CE5D-CC59-3EA5-9336-20DB0DAF6E85> /System/Library/PrivateFrameworks/FeedbackLogger.framework/Versions/A/FeedbackLogger
       0x1bdd8e000 -        0x1bdfedabf  com.apple.AppleMediaServicesUI (1.0 - 1) <76839F27-69FD-3BFB-ABD8-C295ED476C7D> /System/Library/PrivateFrameworks/AppleMediaServicesUI.framework/Versions/A/AppleMediaServicesUI
       0x1bdfee000 -        0x1be0101ff  com.apple.DistributionKit (700 - 1000) <5B7E4258-2BC1-32C9-BE02-FA31AA8AD68F> /System/Library/PrivateFrameworks/Install.framework/Frameworks/DistributionKit.framework/Versions/A/DistributionKit
       0x1be011000 -        0x1be06679f  com.apple.OSPersonalization (1.0 - 149) <E9F4EE9E-FBD7-34C3-85CA-0FB8FD710998> /System/Library/PrivateFrameworks/OSPersonalization.framework/Versions/A/OSPersonalization
       0x1be57a000 -        0x1be5d8c5f  com.apple.CommerceKit (1.2.0 - 716.4.2) <02E0A066-F2A8-39E7-967F-734DDF718941> /System/Library/PrivateFrameworks/CommerceKit.framework/Versions/A/CommerceKit
       0x1be5d9000 -        0x1be5de95f  com.apple.ServerInformation (2.0 - 1) <5C3E2114-009C-3386-808E-E9D289200FD5> /System/Library/PrivateFrameworks/ServerInformation.framework/Versions/A/ServerInformation
       0x1be5df000 -        0x1be60425f  com.apple.icloud.FMCore (1.0 - 1) <8C18B1AE-91F4-3BBA-81CA-22A2CB8A6B22> /System/Library/PrivateFrameworks/FMCore.framework/Versions/A/FMCore
       0x1be742000 -        0x1be75988b  libswiftsimd.dylib (23) <CB6EF41A-C18E-3EDA-B68C-CCB0E36EE662> /usr/lib/swift/libswiftsimd.dylib
       0x1be75a000 -        0x1be996edf  com.apple.CallHistory (1.0 - 106.700.62.1.1) <274B53D4-E4AA-3104-A58C-02BC43D1F22A> /System/Library/PrivateFrameworks/CallHistory.framework/Versions/A/CallHistory
       0x1be997000 -        0x1be9c1c9f  com.apple.MobileInstallation (2.0 - 1.0) <7857BDF9-1B1F-315E-9FB7-E15AC3088320> /System/Library/PrivateFrameworks/MobileInstallation.framework/Versions/A/MobileInstallation
       0x1be9d0000 -        0x1beba70ff  com.apple.TextInput (1.0 - 1.0) <1D5DF9CA-41FC-3B7B-B19F-2C435F3A66F2> /System/Library/PrivateFrameworks/TextInput.framework/Versions/A/TextInput
       0x1bed98000 -        0x1bf7a497f  com.apple.PhotoLibraryServices (1.0 - 860.0.170) <C3B19293-8E6B-36F4-B76B-B4FF05A79520> /System/Library/PrivateFrameworks/PhotoLibraryServices.framework/Versions/A/PhotoLibraryServices
       0x1bf7da000 -        0x1bf94871f  com.apple.PeopleSuggester (1.0 - 1) <8C5D6EEF-C4EF-3F0E-9240-67323CFF1217> /System/Library/PrivateFrameworks/PeopleSuggester.framework/Versions/A/PeopleSuggester
       0x1bf989000 -        0x1bf99675f  com.apple.CaptiveNetworkSupport (13.0 - 1) <5B73C216-2ACE-3F8C-A2B3-7D35D5D0395A> /System/Library/PrivateFrameworks/CaptiveNetwork.framework/Versions/A/CaptiveNetwork
       0x1bfb08000 -        0x1bfb6e35f  com.apple.StoreFoundation (1.0 - 716.4.2) <5A4CAF47-0E45-30D8-AA99-839ECE19180C> /System/Library/PrivateFrameworks/StoreFoundation.framework/Versions/A/StoreFoundation
       0x1bfe11000 -        0x1bfe2b37f  com.apple.LookupFramework (1.2 - 321.3) <3D9E646F-E021-3B38-9D2F-9B766D6AB2C1> /System/Library/PrivateFrameworks/Lookup.framework/Versions/A/Lookup
       0x1bfe2c000 -        0x1bfe682af  libncurses.5.4.dylib (79) <9EB04E94-EE2D-38A5-A214-00AF73DBE4E9> /usr/lib/libncurses.5.4.dylib
       0x1bfe69000 -        0x1bfe7237f  com.apple.IOAccelMemoryInfo (1.0 - 1) <E6505525-75F4-380E-A9D7-7C5721260925> /System/Library/PrivateFrameworks/IOAccelMemoryInfo.framework/Versions/A/IOAccelMemoryInfo
       0x1bfefa000 -        0x1bfefa677  com.apple.quartzframework (1.5 - 26) <A18F5092-B6FA-3337-92D7-FBED7E8A903F> /System/Library/Frameworks/Quartz.framework/Versions/A/Quartz
       0x1bff86000 -        0x1bffa557f  com.apple.IntentsCore (1.0 - 1) <ADAE4AC0-853A-3807-B494-55C451A6F464> /System/Library/PrivateFrameworks/IntentsCore.framework/Versions/A/IntentsCore
       0x1bffa6000 -        0x1c005c13f  com.apple.NearField (366.9.1 - 366.9.1) <DE84FDB5-F9B4-32E9-99EF-7BF95BF028D8> /System/Library/PrivateFrameworks/NearField.framework/Versions/A/NearField
       0x1c005d000 -        0x1c006e6b7  com.apple.GPUInfo (1.3.15 - 1.3.15) <3C2C7308-9405-3B42-895E-0616BAAF6E17> /System/Library/PrivateFrameworks/GPUInfo.framework/Versions/A/GPUInfo
       0x1c006f000 -        0x1c0077cbf  com.apple.BridgeOSSoftwareUpdate (1.0 - 1) <9D2C256C-11F0-38F0-9AD3-5A40552A898B> /System/Library/PrivateFrameworks/BridgeOSSoftwareUpdate.framework/Versions/A/BridgeOSSoftwareUpdate
       0x1c0078000 -        0x1c0087d3f  com.apple.InstallerDiagnostics (1.0 - 1) <2298BADF-CB2D-37F2-B68C-69534B4DE558> /System/Library/PrivateFrameworks/InstallerDiagnostics.framework/Versions/A/InstallerDiagnostics
       0x1c00bb000 -        0x1c02ab75f  com.apple.AOSKit (1.07 - 282) <44CD8313-2D5B-3A34-BACA-EF8800803B4A> /System/Library/PrivateFrameworks/AOSKit.framework/Versions/A/AOSKit
       0x1c0600000 -        0x1c14fb55f  com.apple.siri.SiriInstrumentation (1.0 - 1) <8A5E0FF6-3116-3082-A0AD-20DCD6C5E1B4> /System/Library/PrivateFrameworks/SiriInstrumentation.framework/Versions/A/SiriInstrumentation
       0x1c1517000 -        0x1c15380ff  libswiftCoreLocation.dylib (53) <368BC882-02B9-38AB-89B4-F62430F2B8EB> /usr/lib/swift/libswiftCoreLocation.dylib
       0x1c1539000 -        0x1c15420be  libswiftCoreMIDI.dylib (6) <7AE04E20-83FD-3B1B-8846-E9869AD98DB5> /usr/lib/swift/libswiftCoreMIDI.dylib
       0x1c157e000 -        0x1c18dfb1f  com.apple.IMDPersistence (10.0 - 1000) <CE8B89D9-9557-3E6A-BA24-A2AB5A3AB51B> /System/Library/PrivateFrameworks/IMDPersistence.framework/Versions/A/IMDPersistence
       0x1c18e0000 -        0x1c18e63bf  com.apple.idskvstore (10.0 - 1000) <06AC8371-3314-3CEA-A2B8-21D5FA79C42F> /System/Library/PrivateFrameworks/IDSKVStore.framework/Versions/A/IDSKVStore
       0x1c18e7000 -        0x1c1915adf  com.apple.LocalAuthenticationUI (1.0 - 2005.160.7) <3B78349C-ACFD-3066-9FAC-8909D90DE6D8> /System/Library/PrivateFrameworks/LocalAuthenticationUI.framework/Versions/A/LocalAuthenticationUI
       0x1c19d5000 -        0x1c1b7127f  com.apple.AddressBook.framework (14.0 - 2732.700.1) <EB6F4A91-93CA-3073-94DE-25069879D4B9> /System/Library/Frameworks/AddressBook.framework/Versions/A/AddressBook
       0x1c1b72000 -        0x1c1b933df  com.apple.ToneKit (1.0 - 1) <E41CD591-8E57-3123-A80E-A62954B14063> /System/Library/PrivateFrameworks/ToneKit.framework/Versions/A/ToneKit
       0x1c1b94000 -        0x1c1c3303f  com.apple.AppStoreDaemon (1.0 - 1) <374F88EF-3198-3954-A0EF-929A78DE6B1E> /System/Library/PrivateFrameworks/AppStoreDaemon.framework/Versions/A/AppStoreDaemon
       0x1c1d2a000 -        0x1c1d30bbf  com.apple.MSUDataAccessor (1.0 - 1) <FC49965D-D149-30F8-A403-EED6A2ED8C1D> /System/Library/PrivateFrameworks/MSUDataAccessor.framework/Versions/A/MSUDataAccessor
       0x1c1def000 -        0x1c1e1d53f  libnfshared.dylib (366.9.1) <2E4A5573-E542-3819-A0E8-10B1AF4A603C> /usr/lib/libnfshared.dylib
       0x1c1e1e000 -        0x1c201adbf  com.apple.Navigation (1.0 - 1) <69DE77F0-33BB-349D-8C57-E25F82F416BD> /System/Library/PrivateFrameworks/Navigation.framework/Versions/A/Navigation
       0x1c201b000 -        0x1c20350df  com.apple.ExternalAccessory (1.0.0 - 1.0) <E1ECB67F-B0F7-3CBC-97D7-A691DAD7A70D> /System/Library/Frameworks/ExternalAccessory.framework/ExternalAccessory
       0x1c2036000 -        0x1c205041f  com.apple.IAP (1.0 - 1.0.0) <75A56CF3-5436-3553-8399-2D90E94A2158> /System/Library/PrivateFrameworks/IAP.framework/Versions/A/IAP
       0x1c2153000 -        0x1c21b5ddf  com.apple.SoftwareUpdateCoreSupport (1.0 - 1) <13271AA6-33EA-369B-B2D1-6EC528C820E7> /System/Library/PrivateFrameworks/SoftwareUpdateCoreSupport.framework/Versions/A/SoftwareUpdateCoreSupport
       0x1c21d0000 -        0x1c21d365f  com.apple.ftclientservices (10.0 - 1000) <6FDBE419-3EDF-3BE6-9416-723083414B22> /System/Library/PrivateFrameworks/FTClientServices.framework/Versions/A/FTClientServices
       0x1c2284000 -        0x1c23de6df  com.apple.chronoservices (1) <A4949FFB-1C73-391F-A1C4-A16FC60B85BF> /System/Library/PrivateFrameworks/ChronoServices.framework/Versions/A/ChronoServices
       0x1c23e0000 -        0x1c258d0ff  com.apple.AOSUI (1.2 - 898.475.7) <34F1CFEF-9C6D-3208-AA10-A757C3E208AA> /System/Library/PrivateFrameworks/AOSUI.framework/Versions/A/AOSUI
       0x1c258e000 -        0x1c259bb1f  com.apple.icloud.FindMyDeviceUI (1.0 - 18) <204C80BE-7070-3EE5-83F4-BF7E4681CBC4> /System/Library/PrivateFrameworks/FindMyDeviceUI.framework/Versions/A/FindMyDeviceUI
       0x1c25e1000 -        0x1c2615c7f  libtailspin.dylib (250.2) <DE7FBAB6-1A85-3819-8FEC-52363C2B8D07> /usr/lib/libtailspin.dylib
       0x1c2616000 -        0x1c3d6505f  com.apple.SwiftUI (7.6.1 - 7.6.1) <53E79875-60E4-3B8D-BA48-02F6A4CBC429> /System/Library/Frameworks/SwiftUI.framework/Versions/A/SwiftUI
       0x1c3d66000 -        0x1c3dab0ff  com.apple.AttributeGraph (7.0.80 - 7.0.80) <DDC826E2-4B0E-35CA-AAB1-82A1DC9EA6B4> /System/Library/PrivateFrameworks/AttributeGraph.framework/Versions/A/AttributeGraph
       0x1c3dac000 -        0x1c3e3061f  com.apple.EmojiFoundation (1.0 - 1) <7D83C940-4672-316C-AFC6-8224586D3136> /System/Library/PrivateFrameworks/EmojiFoundation.framework/Versions/A/EmojiFoundation
       0x1c3e31000 -        0x1c3f1c75f  com.apple.CoreCDPInternal (1.0 - 1) <3E4B5FD9-D71B-3388-96D7-145F32582190> /System/Library/PrivateFrameworks/CoreCDPInternal.framework/Versions/A/CoreCDPInternal
       0x1c3f1d000 -        0x1c47c369f  libfaceCore.dylib (9.5.4) <B2639747-7640-3F66-8F79-88B1D5F2D73E> /System/Library/Frameworks/Vision.framework/libfaceCore.dylib
       0x1c47c4000 -        0x1c4a3659f  com.apple.TextRecognition (1.0 - 157) <CFD587AE-FA26-3FFB-A13A-FE831357A6F8> /System/Library/PrivateFrameworks/TextRecognition.framework/Versions/A/TextRecognition
       0x1c4a37000 -        0x1c4a4e25f  com.apple.Futhark (1.0 - 1) <EB12CF22-B952-3DB7-8A2E-7E702969D1F6> /System/Library/PrivateFrameworks/Futhark.framework/Versions/A/Futhark
       0x1c4a4f000 -        0x1c4adf31f  com.apple.DifferentialPrivacy (1.0 - 1) <354B4195-65BF-3612-A19B-5AAA76BEFB18> /System/Library/PrivateFrameworks/DifferentialPrivacy.framework/Versions/A/DifferentialPrivacy
       0x1c4ae0000 -        0x1c4b2619f  com.apple.SafariFoundation (21624 - 21624.5.1.11.3) <3AD61681-1888-3C37-88A4-B2106FBFD959> /System/Library/PrivateFrameworks/SafariFoundation.framework/Versions/A/SafariFoundation
       0x1c4f8f000 -        0x1c4fc8ba7  com.apple.MobileBluetooth (1.0 - 1.0) <DCA62E59-D3A2-30FF-802E-A4BC6AAF8C52> /System/Library/PrivateFrameworks/MobileBluetooth.framework/Versions/A/MobileBluetooth
       0x1c4fcf000 -        0x1c514a1bf  com.apple.AuthenticationServices (12.0 - 21624.5.1.11.3) <3EA6D869-973E-39BC-B2DC-327B7C887704> /System/Library/Frameworks/AuthenticationServices.framework/Versions/A/AuthenticationServices
       0x1c5c80000 -        0x1c5cd725f  com.apple.biome.BiomeFoundation (1.0 - 209.21) <455A5553-E683-30B4-A906-1F14E75F6E61> /System/Library/PrivateFrameworks/BiomeFoundation.framework/Versions/A/BiomeFoundation
       0x1c5cd8000 -        0x1c5cdccff  com.apple.DAAPKit (1.0 - 4025.500.37) <0C05FB05-517C-3848-A803-A0FA6BB223BB> /System/Library/PrivateFrameworks/DAAPKit.framework/Versions/A/DAAPKit
       0x1c5d63000 -        0x1c5e275ff  com.apple.icloud.SPOwner (1.0 - 423.26.4.19.2) <025FD94D-4DD5-3C03-983B-F67144ECB5D3> /System/Library/PrivateFrameworks/SPOwner.framework/Versions/A/SPOwner
       0x1c88d9000 -        0x1c898497f  com.apple.cloudkit.MMCS (1.3 - 2300.120) <4EFB942C-3DCA-345F-9307-5492E0025F3E> /System/Library/PrivateFrameworks/MMCS.framework/Versions/A/MMCS
       0x1c8985000 -        0x1c89fc3df  com.apple.acg.InertiaCam (1.0 - 1) <DB1FBDD7-AF19-31FC-BAB2-3BA5C4534436> /System/Library/PrivateFrameworks/InertiaCam.framework/Versions/A/InertiaCam
       0x1c8a6b000 -        0x1c8b87a9f  com.apple.ConfigurationEngineModel (1.0 - 249.100.1) <8658C591-BA4D-3475-A6E2-5C01A0D619FC> /System/Library/PrivateFrameworks/ConfigurationEngineModel.framework/Versions/A/ConfigurationEngineModel
       0x1c8bbe000 -        0x1c8bcba1f  libswiftMetal.dylib (373.7) <7235A6A9-49B2-3B94-9DD6-C987019CDBF2> /usr/lib/swift/libswiftMetal.dylib
       0x1c8bcc000 -        0x1c8bd2e05  libswiftCompression.dylib (11) <856ACB2A-3334-3BA6-AAC8-8F344E7CDB83> /usr/lib/swift/libswiftCompression.dylib
       0x1c8f6e000 -        0x1c8f800df  com.apple.SpotlightReceiver (1.0 - 2418.6.3.9.400) <E79B613F-82F8-36DF-8E39-D59D8CD6C96E> /System/Library/PrivateFrameworks/SpotlightReceiver.framework/Versions/A/SpotlightReceiver
       0x1c91f3000 -        0x1c961775f  com.apple.imcore (10.0 - 1000) <7AE15235-831D-3DBB-86FD-C2DE0A54CD8F> /System/Library/PrivateFrameworks/IMCore.framework/Versions/A/IMCore
       0x1c9618000 -        0x1c96348bf  com.apple.ftawd (8.0 - 900) <2CA62C12-37B5-345A-BF79-5D05F43F6BFB> /System/Library/PrivateFrameworks/FTAWD.framework/Versions/A/FTAWD
       0x1c9af4000 -        0x1c9af809f  com.apple.iChat.InstantMessage (8.0 - 5501) <680AF0AD-4FC8-37C1-A9F3-637A919089E2> /System/Library/Frameworks/InstantMessage.framework/Versions/A/InstantMessage
       0x1c9b05000 -        0x1c9bafd7f  libFDR.dylib (1499.160.2) <BA9D87B5-421B-37B2-BEF3-F3E359C22B18> /usr/lib/libFDR.dylib
       0x1c9bb0000 -        0x1c9c308ff  com.apple.TimeSync (1.0 - 1460.2) <EB86789A-20AD-3BF8-9101-B8C97A3BB9FC> /System/Library/PrivateFrameworks/TimeSync.framework/Versions/A/TimeSync
       0x1c9c31000 -        0x1ca1fc33f  com.apple.biome.BiomeStreams (1.0 - 209.21) <2110407D-EFB4-373E-B963-9C92E26594B2> /System/Library/PrivateFrameworks/BiomeStreams.framework/Versions/A/BiomeStreams
       0x1ca1fd000 -        0x1ca20f4df  com.apple.framework.ctcategories (1.0 - 49.4.1) <4D8A492A-C5EB-3053-8C7D-EB13C61427EA> /System/Library/PrivateFrameworks/Categories.framework/Versions/A/Categories
       0x1ca6d0000 -        0x1ca6e48ff  com.apple.SoftwareUpdateCoreConnect (1.0 - 1) <2CA857AF-D999-34DC-94A1-3AC0E5B80416> /System/Library/PrivateFrameworks/SoftwareUpdateCoreConnect.framework/Versions/A/SoftwareUpdateCoreConnect
       0x1ca6fd000 -        0x1ca7765bf  com.apple.StorageKit (1.0 - 1037.160.3) <E69108D5-24F3-3629-AD1E-CF3557D36FC9> /System/Library/PrivateFrameworks/StorageKit.framework/Versions/A/StorageKit
       0x1ca777000 -        0x1ca7b865f  com.apple.framework.corewlankit (16.0 - 1657) <D1F1EBD2-07D4-3D8C-A049-9A90BDAFF35B> /System/Library/PrivateFrameworks/CoreWLANKit.framework/Versions/A/CoreWLANKit
       0x1cb874000 -        0x1cb87db5f  com.apple.audio.IOKitten (300.1 - 300.1) <0BAB3589-8D81-3C60-9F05-9D207E89F4B6> /System/Library/PrivateFrameworks/IOKitten.framework/Versions/A/IOKitten
       0x1cbc71000 -        0x1cbca113f  com.apple.coreduet.KnowledgeMonitor (1.0 - 1) <EB05F313-C1FC-35FF-9D7D-F10BDE327C74> /System/Library/PrivateFrameworks/KnowledgeMonitor.framework/Versions/A/KnowledgeMonitor
       0x1cbca2000 -        0x1cbce7f5f  com.apple.UsageTracking (3.0 - 392.5.1) <CCF732A5-AAEF-35F8-84A2-4C7974439B60> /System/Library/PrivateFrameworks/UsageTracking.framework/Versions/A/UsageTracking
       0x1cbce8000 -        0x1ccb2727f  com.apple.VectorKit (1.0 - 2001.26.4.23.5) <868C6770-4AE0-3399-B3AA-072B3998EB32> /System/Library/PrivateFrameworks/VectorKit.framework/Versions/A/VectorKit
       0x1ccb28000 -        0x1ccb92c1f  com.apple.osanalytics.OSAnalytics (1.0 - 1) <06728C4D-5750-308F-8290-EAF7BE91F4BB> /System/Library/PrivateFrameworks/OSAnalytics.framework/Versions/A/OSAnalytics
       0x1ccbbf000 -        0x1ccc3bb9f  com.apple.NetworkServiceProxyFramework (1.0 - 1) <2C93123F-99C8-3B8D-AAE6-3A817BE0A2BF> /System/Library/PrivateFrameworks/NetworkServiceProxy.framework/Versions/A/NetworkServiceProxy
       0x1ccc68000 -        0x1ccc7365f  com.apple.CloudPhotoServicesConfiguration (11.0 - 860.0.170) <FC430FEA-4367-3CA9-BF32-EE42724B4D53> /System/Library/PrivateFrameworks/CloudPhotoServicesConfiguration.framework/Versions/A/CloudPhotoServicesConfiguration
       0x1ccc94000 -        0x1ccee635f  com.apple.CloudPhotoLibrary (1.0 - 860.0.170) <C0D5EC01-1542-3859-8938-4CDD3FED39BA> /System/Library/PrivateFrameworks/CloudPhotoLibrary.framework/Versions/A/CloudPhotoLibrary
       0x1ccf0e000 -        0x1cd284fa7  com.apple.SDAPI (1.0 - 1) <28614429-C9A4-390D-988D-FE6EFD5A9E72> /System/Library/PrivateFrameworks/SDAPI.framework/Versions/A/SDAPI
       0x1cdf4a000 -        0x1cdfdd53f  com.apple.Transparency (1.0 - 1547.160.50) <907E5D64-C64D-3CAE-A2A6-3425B1CC9942> /System/Library/PrivateFrameworks/Transparency.framework/Versions/A/Transparency
       0x1cdfe4000 -        0x1cdfe5f9f  libswiftQuartzCore.dylib (5) <63444A8C-9E8C-3778-820D-1E0C88CA2DF7> /usr/lib/swift/libswiftQuartzCore.dylib
       0x1ce3d7000 -        0x1ce3dc8e7  com.apple.kperf (1.0 - 1) <F2E7C7C4-03B4-3341-91ED-DD5472BF3F3B> /System/Library/PrivateFrameworks/kperf.framework/Versions/A/kperf
       0x1ce3dd000 -        0x1ce4ce65f  com.apple.libktrace (1.0 - 683.100.8) <D338F7EC-A7ED-3B72-A809-73A873CF3AA7> /System/Library/PrivateFrameworks/ktrace.framework/Versions/A/ktrace
       0x1ce4cf000 -        0x1ce4d605f  com.apple.BezelServicesFW (374 - 374) <73CE9B34-0BA2-3E27-9EE5-D5C19C724A60> /System/Library/PrivateFrameworks/BezelServices.framework/Versions/A/BezelServices
       0x1ce4ee000 -        0x1ce4f363f  com.apple.MobileSystemServices (1.0 - 1) <4F3BEA3B-A363-3D04-B903-9B613C993CA1> /System/Library/PrivateFrameworks/MobileSystemServices.framework/Versions/A/MobileSystemServices
       0x1ce556000 -        0x1ce58539f  com.apple.frameworks.preferencepanes (16.0 - 16.0) <65D22E75-EA20-3E2A-8FAA-F6C21F3634CD> /System/Library/Frameworks/PreferencePanes.framework/Versions/A/PreferencePanes
       0x1ce586000 -        0x1ce58eb5f  com.apple.InAppMessagesCore (1.0 - 1) <F71508C4-8A64-3165-A092-B245CB586DCA> /System/Library/PrivateFrameworks/InAppMessagesCore.framework/Versions/A/InAppMessagesCore
       0x1ce58f000 -        0x1ce5b33ff  com.apple.InAppMessages (1.0 - 1) <35B9EE0B-959B-3D86-9D49-09E37EA8977B> /System/Library/PrivateFrameworks/InAppMessages.framework/Versions/A/InAppMessages
       0x1ce5b4000 -        0x1ce64075f  com.apple.EmailCore (11.0 - 3864.700.51.1.1) <6437B88E-9254-31B7-A56B-FDC60C0B8225> /System/Library/PrivateFrameworks/EmailCore.framework/Versions/A/EmailCore
       0x1ce686000 -        0x1ce68bb3f  com.apple.FindMyMac (3.1 - 75.25.2.23.2) <3B0C503A-BF1C-3646-A2C1-7C1F9042ADFA> /System/Library/PrivateFrameworks/FindMyMac.framework/Versions/A/FindMyMac
       0x1ce68c000 -        0x1ce69ba7f  com.apple.MobileActivation (1.0 - 1076.160.6) <090A5DA0-B676-35E9-9537-61DFA8DAAB68> /System/Library/PrivateFrameworks/MobileActivationMacOS.framework/Versions/A/MobileActivationMacOS
       0x1cece2000 -        0x1ced15b5f  com.apple.photo.MediaConversionService (11.0 - 860.0.170) <C28F0D1F-1E25-3D84-9FEE-E793A9401454> /System/Library/PrivateFrameworks/MediaConversionService.framework/Versions/A/MediaConversionService
       0x1ced1d000 -        0x1cedaa45f  com.apple.signpost.SignpostSupport (1.174.8 - 174.8) <EE821A99-A88C-3624-A5B5-12BA741F9D7B> /System/Library/PrivateFrameworks/SignpostSupport.framework/Versions/A/SignpostSupport
       0x1cedab000 -        0x1cef13b7f  com.apple.ModelIO (268.2.2 - 268.2.2) <2B833F70-9F61-3811-8991-91E9DD486579> /System/Library/Frameworks/ModelIO.framework/Versions/A/ModelIO
       0x1cef14000 -        0x1cef4b87f  com.apple.UIKitServices (1.0 - 9126.6.8) <C4A61DD1-1AEC-329E-A67E-388FB246CC34> /System/Library/PrivateFrameworks/UIKitServices.framework/Versions/A/UIKitServices
       0x1cef4c000 -        0x1cf0f6aff  com.apple.SampleAnalysis (1.0 - 427) <F8A24AA4-4298-398C-ABBB-9520DD956E5A> /System/Library/PrivateFrameworks/SampleAnalysis.framework/Versions/A/SampleAnalysis
       0x1cf1d0000 -        0x1cf4cbeff  com.apple.photo.NeutrinoCore (1.0 - 860.0.170) <0E5D140D-D983-378C-B773-7E1A5B10E8B4> /System/Library/PrivateFrameworks/NeutrinoCore.framework/Versions/A/NeutrinoCore
       0x1cf6a9000 -        0x1cf75271f  com.apple.EmailFoundation (11.0 - 3864.700.51.1.1) <C2CAFE0C-6D56-3A42-A845-C1822E8AAF27> /System/Library/PrivateFrameworks/EmailFoundation.framework/Versions/A/EmailFoundation
       0x1cfa02000 -        0x1cfadfc5f  libauthinstall.dylib (1104.160.1.0.1) <1FE27D78-2D1B-3EC7-B43F-86B8A675537A> /usr/lib/libauthinstall.dylib
       0x1cfae0000 -        0x1cfb0229f  libamsupport.dylib (434.160.4) <24D28E7F-A1AE-3031-8679-A0D6C6D68A86> /usr/lib/libamsupport.dylib
       0x1cfb82000 -        0x1cfdf9c7f  com.apple.Speech (1.0 - 1) <3E93C097-38C7-3C22-B12A-F04DA6425DB6> /System/Library/Frameworks/Speech.framework/Versions/A/Speech
       0x1cfed7000 -        0x1cfed9adf  com.apple.ScreenTimeServiceUI (3.0 - 605.6.5) <986109C8-990D-371C-AD79-8AC27334F6C0> /System/Library/PrivateFrameworks/ScreenTimeServiceUI.framework/Versions/A/ScreenTimeServiceUI
       0x1cfede000 -        0x1cff3e0ff  com.apple.biome.BiomePubSub (1.0 - 209.21) <0F03104F-FC8B-3ADD-8850-4B7029E2B56E> /System/Library/PrivateFrameworks/BiomePubSub.framework/Versions/A/BiomePubSub
       0x1cff3f000 -        0x1cff8219f  com.apple.biome.BiomeStorage (1.0 - 209.21) <D393CCA0-5E20-31D3-8E1A-70476551724B> /System/Library/PrivateFrameworks/BiomeStorage.framework/Versions/A/BiomeStorage
       0x1d00be000 -        0x1d00be7f1  libswiftCoreML.dylib (3520.5.1) <9CB9EADE-C520-3C6A-9EE2-690AE49EBF20> /usr/lib/swift/libswiftCoreML.dylib
       0x1d00bf000 -        0x1d01baff7  libcrypto.42.dylib (109.100.2) <14EB2375-9E03-3A62-8B3A-D199B7AD27D4> /usr/lib/libcrypto.42.dylib
       0x1d026d000 -        0x1d02801ff  com.apple.private.XprotectFrameWork.XprotectFramework (1.0 - 1) <403E5E4C-EA7C-372C-AA75-81E6172B46B9> /System/Library/PrivateFrameworks/XprotectFramework.framework/Versions/A/XprotectFramework
       0x1d067c000 -        0x1d07f6cff  com.apple.LinkPresentation (296 - 296.12) <3334BA00-2399-3846-8788-C4D1A6202714> /System/Library/Frameworks/LinkPresentation.framework/Versions/A/LinkPresentation
       0x1d0a7d000 -        0x1d0bbc13f  com.apple.PhotosFormats (1.0 - 860.0.170) <1FCA1F6B-1343-3E5C-ABE9-6378C2459BAA> /System/Library/PrivateFrameworks/PhotosFormats.framework/Versions/A/PhotosFormats
       0x1d167b000 -        0x1d16b065f  com.apple.DeviceIdentity (1.0 - 1) <962EA390-008E-3DDC-B2A5-7B2DAF6E8786> /System/Library/PrivateFrameworks/DeviceIdentity.framework/Versions/A/DeviceIdentity
       0x1d27d9000 -        0x1d27e4c1f  com.apple.EmailAddressing (11.0 - 3864.700.51.1.1) <D10ECC6E-E74B-3595-943A-8F0495F7CA4C> /System/Library/PrivateFrameworks/EmailAddressing.framework/Versions/A/EmailAddressing
       0x1d27e5000 -        0x1d295a51f  com.apple.Email (11.0 - 3864.700.51.1.1) <ACC9E84D-7A50-3D64-8591-F0F8BE2F3E7D> /System/Library/PrivateFrameworks/Email.framework/Versions/A/Email
       0x1d295c000 -        0x1d2a7bfff  com.apple.CoreMediaStream (1.0 - 860.0.170) <7D80D948-D67E-3437-861E-F9D152CFEE08> /System/Library/PrivateFrameworks/CoreMediaStream.framework/Versions/A/CoreMediaStream
       0x1d2a7c000 -        0x1d2a8b13f  libswiftUniformTypeIdentifiers.dylib (877.5.1) <A83236CA-4417-3C27-B252-72923DB09F88> /usr/lib/swift/libswiftUniformTypeIdentifiers.dylib
       0x1d2a8c000 -        0x1d2b51a9b  libswiftAccelerate.dylib (77.100.2) <625F222D-6394-39B9-A1F2-12B9EA56DD85> /usr/lib/swift/libswiftAccelerate.dylib
       0x1d2caa000 -        0x1d2cbb11f  libpartition2_dynamic.dylib (3476.160.2) <BA13DE06-6320-345A-A2E3-CC3C4EB06574> /usr/lib/libpartition2_dynamic.dylib
       0x1d3219000 -        0x1d3223fdf  com.apple.AFKUser (1.0 - 1) <E638FBE2-2BB6-3A8E-A1DF-D7B5AC9BE7B0> /System/Library/PrivateFrameworks/AFKUser.framework/Versions/A/AFKUser
       0x1d3767000 -        0x1d377aaff  com.apple.dynamicdesktop (1.0 - 2427.6) <99F43E14-4756-381B-9CFC-6A909BF7ADFE> /System/Library/PrivateFrameworks/DynamicDesktop.framework/Versions/A/DynamicDesktop
       0x1d5281000 -        0x1d54fa5df  com.apple.photo.PhotoImaging (1.0 - 860.0.170) <9B16C55F-F2D4-3F1F-9209-EA30969FDB82> /System/Library/PrivateFrameworks/PhotoImaging.framework/Versions/A/PhotoImaging
       0x1d56d1000 -        0x1d56dbb3f  com.apple.CPMS (1.0 - 1) <3E83115F-D04B-3C8D-8646-35204AA2DB84> /System/Library/PrivateFrameworks/CPMS.framework/Versions/A/CPMS
       0x1d64ed000 -        0x1d652bf5f  com.apple.PhotosImagingFoundation (11.0 - 860.0.170) <49A95606-3391-316C-830E-C3F9093CC626> /System/Library/PrivateFrameworks/PhotosImagingFoundation.framework/Versions/A/PhotosImagingFoundation
       0x1d652c000 -        0x1d653a2df  com.apple.CloudPhotoServices (1.0 - 860.0.170) <E9F6937D-08D4-3E24-A41C-1E3C722AD5F5> /System/Library/PrivateFrameworks/CloudPhotoServices.framework/Versions/A/CloudPhotoServices
       0x1d653b000 -        0x1d6594a9f  com.apple.acg.AutoLoop (1.0 - 1) <D8658CED-1DC7-3AA8-9AA6-54641851764C> /System/Library/PrivateFrameworks/AutoLoop.framework/Versions/A/AutoLoop
       0x1d664d000 -        0x1d694543f  com.apple.Osprey (1.0 - 1) <5FEA8C08-1577-3296-BC9C-7F3203E8EBFB> /System/Library/PrivateFrameworks/Osprey.framework/Versions/A/Osprey
       0x1d6c1d000 -        0x1d6c7e75f  libswiftCoreMedia.dylib (3330.13.2) <BE970706-7E22-3C17-A8C1-BF3CDF685F21> /usr/lib/swift/libswiftCoreMedia.dylib
       0x1d7ee6000 -        0x1d7eef38f  com.apple.kperfdata (1.0 - 1) <400B0E96-4869-37BE-9832-1A14C386148B> /System/Library/PrivateFrameworks/kperfdata.framework/Versions/A/kperfdata
       0x1d7f0c000 -        0x1d7f17c9f  com.apple.Reveal (1.0 - 56) <F8F28F44-DC4D-3305-872F-5E86CF996F5C> /System/Library/PrivateFrameworks/Reveal.framework/Versions/A/Reveal
       0x1d7f18000 -        0x1d7f1ef5f  com.apple.RevealCore (1.0 - 56) <120D21A6-07CB-3C7E-8BC5-019E0BD78195> /System/Library/PrivateFrameworks/RevealCore.framework/Versions/A/RevealCore
       0x1d83bb000 -        0x1d83cfcff  com.apple.BulkSymbolication (1.427 - 427) <6FBA9099-E428-3571-B940-0D210B6D0861> /System/Library/PrivateFrameworks/BulkSymbolication.framework/Versions/A/BulkSymbolication
       0x1d83d0000 -        0x1d83d1bbf  libswiftOSLog.dylib (10) <9670AE5C-271A-3DCB-9A0A-8E3A7CCC2726> /usr/lib/swift/libswiftOSLog.dylib
       0x1d8669000 -        0x1d86b15df  libswiftAVFoundation.dylib (2430.13.1) <CEBC9F85-34DA-3BAF-B8DE-75F99B8C8976> /usr/lib/swift/libswiftAVFoundation.dylib
       0x1dc4e6000 -        0x1dc5f2d5f  com.apple.Symbolication (16.0 - 64575.70.1) <724D42FC-F4FD-39C7-A1BF-D0AD086231F4> /System/Library/PrivateFrameworks/Symbolication.framework/Versions/A/Symbolication
       0x1dc5f3000 -        0x1dc63491f  com.apple.ScreenTimeUI (3.0 - 605.6.5) <51B60AA5-FDF5-3E0C-87A2-0C456B28E3A1> /System/Library/PrivateFrameworks/ScreenTimeUI.framework/Versions/A/ScreenTimeUI
       0x1dc6a1000 -        0x1dc6ba19f  com.apple.performance.DiagnosticRequest (1.4 - 4) <16BEB0A9-9237-38A8-9AF7-5F0CA63F1E84> /System/Library/PrivateFrameworks/DiagnosticRequest.framework/Versions/A/DiagnosticRequest
       0x1dccbd000 -        0x1dccc64d3  com.apple.framework.netrb (1.0 - 1) <B95CD77E-662A-3F10-89DB-114FBDC592C3> /System/Library/PrivateFrameworks/Netrb.framework/Versions/A/Netrb
       0x1dccc7000 -        0x1dccfad3f  com.apple.frameworks.preferencepanessupport (13.0 - 13.0) <F7699410-AA61-33D2-B6B0-05511F188508> /System/Library/PrivateFrameworks/PreferencePanesSupport.framework/Versions/A/PreferencePanesSupport
       0x1dccfb000 -        0x1dcd1fc1f  com.apple.CoreMaterial (1.0 - 1) <C315F3B3-6DD7-3A29-8354-87027018A8DA> /System/Library/PrivateFrameworks/CoreMaterial.framework/Versions/A/CoreMaterial
       0x1dce75000 -        0x1dce773ff  com.apple.framework.machinesettings (11.0 - 11.0) <CBEBD4E9-C289-30D8-A5A1-E2E8BDA0F8CB> /System/Library/PrivateFrameworks/MachineSettings.framework/Versions/A/MachineSettings
       0x1dce78000 -        0x1dcf2435f  com.apple.CoreCDPUI (1.0 - 1) <78EA8F7B-C857-3BCD-822D-26516E548104> /System/Library/PrivateFrameworks/CoreCDPUI.framework/Versions/A/CoreCDPUI
       0x1deaf5000 -        0x1deb843df  com.apple.AppleCVA (1002.101.0 - 1002.101.0) <5DDE4D36-D04C-3CA9-9F9D-4FBB5BD50B03> /System/Library/PrivateFrameworks/AppleCVA.framework/Versions/A/AppleCVA
       0x1e0b7a000 -        0x1e0b8a3df  com.apple.OSLog (1.0 - 1861.160.4) <869F0693-0E82-38C1-8920-C782E71735CA> /System/Library/Frameworks/OSLog.framework/Versions/A/OSLog
       0x1e0e8e000 -        0x1e0f9f75f  com.apple.InternalSwiftProtobuf (1.0 - 1.26.0) <41F66F01-A342-3091-A832-0B2B645C922B> /System/Library/PrivateFrameworks/InternalSwiftProtobuf.framework/Versions/A/InternalSwiftProtobuf
       0x1e0fa0000 -        0x1e0fa079f  com.apple.PassKit (1.0 - 1) <94414947-F03E-3F6F-8CA4-FC673AEF58FF> /System/Library/Frameworks/PassKit.framework/Versions/A/PassKit
       0x1e1065000 -        0x1e10700bf  com.apple.HIDDisplay (1.0 - 1) <0368EA7D-01B2-3AA9-A6D6-A2A0850AC800> /System/Library/PrivateFrameworks/HIDDisplay.framework/Versions/A/HIDDisplay
       0x1e1071000 -        0x1e10c56ff  com.apple.ReplayKit (1.0 - 1) <3F65FCB8-B060-3F78-8732-81C76E1FF5BF> /System/Library/Frameworks/ReplayKit.framework/Versions/A/ReplayKit
       0x1e2f1c000 -        0x1e39a197f  com.apple.BlastDoor (1.0 - 1) <9CB157B8-2EE1-32EC-B97B-6B8F75D7AD95> /System/Library/PrivateFrameworks/BlastDoor.framework/Versions/A/BlastDoor
       0x1e3c9b000 -        0x1e3d40cff  com.apple.security.CryptoKit (1.0 - 1) <C588CBA5-8055-3AA5-84F9-0C578349945E> /System/Library/Frameworks/CryptoKit.framework/Versions/A/CryptoKit
       0x1e3eb7000 -        0x1e3ece33f  com.apple.BluetoothManager (1.0 - 1) <52B3A722-F4B2-322E-872F-C3AF7F5B626F> /System/Library/PrivateFrameworks/BluetoothManager.framework/Versions/A/BluetoothManager
       0x1e3f11000 -        0x1e3f4509f  com.apple.PassKitUIFoundation (1.0 - 1642.7.4) <0493F8C5-F69B-31E8-9688-C79159E5DC47> /System/Library/PrivateFrameworks/PassKitUIFoundation.framework/Versions/A/PassKitUIFoundation
       0x1e5030000 -        0x1e507f23f  com.apple.RemoteConfiguration (3.0 - 401) <DF61454E-43B7-371F-B2A0-836452003E55> /System/Library/PrivateFrameworks/RemoteConfiguration.framework/Versions/A/RemoteConfiguration
       0x1e6f51000 -        0x1e6f6ed9f  libedit.3.dylib (65) <F04DD2EA-54F4-3A23-8A3B-7496E5B119F8> /usr/lib/libedit.3.dylib
       0x1e6f87000 -        0x1e6fe63ff  libswiftDemangle.dylib (6.3.2.1.11) <60AA3D31-3C31-3192-B3AD-4342F45D3E2B> /usr/lib/swift/libswiftDemangle.dylib
       0x1e7090000 -        0x1e7098d5f  com.apple.imtransferservices (10.0 - 1000) <19937DB8-81A3-3313-9269-FB9F38F1B115> /System/Library/PrivateFrameworks/IMTransferServices.framework/Versions/A/IMTransferServices
       0x1e828a000 -        0x1e85f09df  com.apple.newstransport (11.5 - 5890) <D55097FC-4BE3-39EF-8036-A3F2E9BB478B> /System/Library/PrivateFrameworks/NewsTransport.framework/Versions/A/NewsTransport
       0x1e8696000 -        0x1e86a599f  com.apple.newsfoundation (11.5 - 5890) <903F8E3F-6DA3-3D60-8DE2-4EEC046D8A73> /System/Library/PrivateFrameworks/NewsFoundation.framework/Versions/A/NewsFoundation
       0x1e86a6000 -        0x1e8ce1ddf  com.apple.newscore (11.5 - 5890) <89D53331-F916-3240-B58B-D44BAFA4743C> /System/Library/PrivateFrameworks/NewsCore.framework/Versions/A/NewsCore
       0x1e8e97000 -        0x1e8e986ff  com.apple.preferences.SystemDesktopAppearance (1.0 - 186.4.1) <5BD8B0CA-681C-3CE7-8C12-659782435FA3> /System/Library/PrivateFrameworks/SystemDesktopAppearance.framework/Versions/A/SystemDesktopAppearance
       0x1e9099000 -        0x1e9099af3  com.apple.FeatureFlags (1.0 - 103) <F8F78EEC-A28C-3AAF-A7F2-7EFD5B839EDB> /System/Library/PrivateFrameworks/FeatureFlags.framework/Versions/A/FeatureFlags
       0x1e90a5000 -        0x1e90accbf  libswiftNaturalLanguage.dylib (4.3) <5E36265A-7670-3D39-A2B8-71DA0AA131CF> /usr/lib/swift/libswiftNaturalLanguage.dylib
       0x1e911e000 -        0x1e916fd3f  com.apple.WiFiPeerToPeer (861.4.0 - 861.4) <15EEE715-2670-3288-AFA8-504BAD951B4F> /System/Library/PrivateFrameworks/WiFiPeerToPeer.framework/Versions/A/WiFiPeerToPeer
       0x1f1600000 -        0x1f16e6ddf  com.apple.JetUI (1.0 - 1) <E6252A0A-ACAF-3802-8CB3-31B279F38A44> /System/Library/PrivateFrameworks/JetUI.framework/Versions/A/JetUI
       0x1f16e7000 -        0x1f1c6f67f  com.apple.JetEngine (1.0 - 1) <F55DAF9D-A41F-3B09-A853-B9DA0E8295C0> /System/Library/PrivateFrameworks/JetEngine.framework/Versions/A/JetEngine
       0x1f218e000 -        0x1f21b024f  libswiftSwiftOnoneSupport.dylib (6.3.2 - 6.3.2.1.11) <76A7FE10-AD26-3505-A8CC-D37AC1C24D32> /usr/lib/swift/libswiftSwiftOnoneSupport.dylib
       0x1f2482000 -        0x1f2657b1f  com.apple.VoiceShortcutClient (1.0 - 4711) <BA3A2F25-4FE4-334F-A86F-D7C32801EB65> /System/Library/PrivateFrameworks/VoiceShortcutClient.framework/Versions/A/VoiceShortcutClient
       0x1f27ed000 -        0x1f27ef5bf  com.apple.ConfigProfileHelper (18.0 - 1800) <2D1B971F-6A7F-32D0-8B0F-F8FA3A13E8F1> /System/Library/PrivateFrameworks/ConfigProfileHelper.framework/Versions/A/ConfigProfileHelper
       0x1f2a51000 -        0x1f2ab2c7f  com.apple.ScreenReaderCore (10 - 993) <FA0D45C4-0660-36B2-83FB-3528E20F9452> /System/Library/PrivateFrameworks/ScreenReaderCore.framework/Versions/A/ScreenReaderCore
       0x1f2b2c000 -        0x1f2b9a8ff  com.apple.RemoteManagement (1.0 - 2.0) <40390113-C02A-3D35-82A1-5C79AFD2A4CC> /System/Library/PrivateFrameworks/RemoteManagement.framework/Versions/A/RemoteManagement
       0x1f2c97000 -        0x1f2c9ab1f  libswiftCallKit.dylib (4) <2EA6C07A-6DE0-3EBA-B487-93B3AC08A3FF> /usr/lib/swift/libswiftCallKit.dylib
       0x230298000 -        0x231911067  com.apple.ANECompiler (9.509.0 - 9.509.0) <465A74BC-F20D-3C05-9441-7E08EAA49FAF> /System/Library/PrivateFrameworks/ANECompiler.framework/Versions/A/ANECompiler
       0x231912000 -        0x23192445f  com.apple.DeviceCheck (1.0 - 1) <6F319B3D-2420-32BA-BF9E-9F56445060E3> /System/Library/Frameworks/DeviceCheck.framework/Versions/A/DeviceCheck
       0x232f0f000 -        0x232f162c3  libCoreFSCache.dylib (352.2) <2C410B78-B9A5-30DC-8D83-FFEC1277F34C> /System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libCoreFSCache.dylib
       0x232f17000 -        0x232f1c947  libCoreVMClient.dylib (352.2) <07CB5D41-C2F3-3C33-951F-67B2C8B8B662> /System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libCoreVMClient.dylib
       0x232f1d000 -        0x232f2d2b7  com.apple.opengl (23.1.1 - 23.1.1) <B4B82439-1E7E-33FB-A08D-6B0C20608AE3> /System/Library/Frameworks/OpenGL.framework/Versions/A/OpenGL
       0x232f2e000 -        0x232f307bf  libCVMSPluginSupport.dylib (23.1.1) <D02BDBB2-FBA6-3050-9076-08D94E904E3A> /System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libCVMSPluginSupport.dylib
       0x232f31000 -        0x232f394ff  libGFXShared.dylib (23.1.1) <6CEF3932-AAC9-3F8E-905D-A826F2884C9A> /System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGFXShared.dylib
       0x232f3a000 -        0x232f6d54b  libGLImage.dylib (23.1.1) <CD28CE41-30BB-3743-88BC-22FD9D24D908> /System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGLImage.dylib
       0x232f6e000 -        0x232fa75bf  libGLU.dylib (23.1.1) <B48D9786-7BF0-308B-A82B-4590632E71D4> /System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGLU.dylib
       0x2330fe000 -        0x233107bc7  libGL.dylib (23.1.1) <DED25257-919A-3D90-A2A1-9C61DC783FE8> /System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGL.dylib
       0x23328a000 -        0x2332f2d1d  com.apple.opencl (5.5 - 5.5) <6FC192B3-C9A8-312F-A5F7-8F3535FE45B5> /System/Library/Frameworks/OpenCL.framework/Versions/A/OpenCL
       0x233489000 -        0x233489adf  com.apple.ARKit (1.0 - 746.100.3) <78F80A87-1624-335C-9A8B-3938E6C3444F> /System/Library/Frameworks/ARKit.framework/Versions/A/ARKit
       0x23348a000 -        0x2335cc9ff  com.apple.audio.AVFAudio (1.0 - 743.508) <016C5057-625C-30B1-AD32-7BC9D082F05B> /System/Library/Frameworks/AVFAudio.framework/Versions/A/AVFAudio
       0x2335ce000 -        0x233648ebf  com.apple.AVRouting (1.0 - 1) <DBDAA7C3-4F28-390B-B8D4-D59F58121AA2> /System/Library/Frameworks/AVRouting.framework/Versions/A/AVRouting
       0x23373e000 -        0x233c8e95f  com.apple.AppIntents (1.0 - 300.6.3) <017AE141-7561-3552-A918-FD1B0F34669B> /System/Library/Frameworks/AppIntents.framework/Versions/A/AppIntents
       0x234210000 -        0x23421429f  com.apple.BrowserEngineCore (1.0 - 1) <C1B83F39-8F21-382D-A705-8609B9E41F7B> /System/Library/Frameworks/BrowserEngineCore.framework/Versions/A/BrowserEngineCore
       0x23491e000 -        0x234966fdf  com.apple.CoreTransferable (1.0.1 - 1) <26865685-385E-3120-9886-2082EEC20B20> /System/Library/Frameworks/CoreTransferable.framework/Versions/A/CoreTransferable
       0x234e39000 -        0x234e46bff  com.apple.DataDetection (8.0 - 821.7) <73F6F860-69AF-3162-86E0-A683642287D6> /System/Library/Frameworks/DataDetection.framework/Versions/A/DataDetection
       0x234e50000 -        0x234e6775f  com.apple.dt.DeveloperToolsSupport (23.40.26 - 23.40.26) <B1322FAC-9016-3646-890B-B51DF5E968A2> /System/Library/Frameworks/DeveloperToolsSupport.framework/Versions/A/DeveloperToolsSupport
       0x234e68000 -        0x234f10ebf  com.apple.DeviceActivity (3.0 - 392.5.1) <44527AE9-0A11-314D-8FC1-74D0953D8E69> /System/Library/Frameworks/DeviceActivity.framework/Versions/A/DeviceActivity
       0x234f9a000 -        0x23510df1f  com.apple.ExtensionFoundation (97 - 97) <3D533C35-3A2A-3672-92EF-5FEE9EE739AC> /System/Library/Frameworks/ExtensionFoundation.framework/Versions/A/ExtensionFoundation
       0x23510e000 -        0x2351507df  com.apple.ExtensionKit (97 - 97) <43141163-B086-36F4-8D0C-E75F78447586> /System/Library/Frameworks/ExtensionKit.framework/Versions/A/ExtensionKit
       0x235151000 -        0x2351bcd1f  com.apple.FSKit (1.0 - 1) <38897E05-F0CD-3390-A132-3C0AC8C9C3E7> /System/Library/Frameworks/FSKit.framework/Versions/A/FSKit
       0x23521b000 -        0x235504ddf  com.apple.FinanceKit (1.0 - 1) <F2A25154-24E6-30CF-8B6A-B246543D0D37> /System/Library/Frameworks/FinanceKit.framework/Versions/A/FinanceKit
       0x23588f000 -        0x23589733f  com.apple.GeoToolbox (1.0 - 1) <4CDC5D26-AF09-3487-82EC-C425152E110E> /System/Library/Frameworks/GeoToolbox.framework/Versions/A/GeoToolbox
       0x236381000 -        0x2363c3a1f  com.apple.LightweightCodeRequirements (1.0 - 1) <8EF56F82-8CCE-3811-AD16-6D0939187B45> /System/Library/Frameworks/LightweightCodeRequirements.framework/Versions/A/LightweightCodeRequirements
       0x2363c4000 -        0x2364079df  com.apple.LiveCommunicationKit (1.0 - 1) <31403ACE-C96E-32B9-8EB0-0CE924DC5B8B> /System/Library/Frameworks/LiveCommunicationKit.framework/Versions/A/LiveCommunicationKit
       0x236408000 -        0x23641f49f  com.apple.LocalAuthenticationEmbeddedUI (1.0 - 2005.160.7) <FDACB870-129B-3109-8E2D-25A5C3ACA66C> /System/Library/Frameworks/LocalAuthenticationEmbeddedUI.framework/Versions/A/LocalAuthenticationEmbeddedUI
       0x2364fb000 -        0x2365c831f  com.apple.ManagedSettings (267.160.4 - 267.160.4) <F33B79D2-20FE-36CF-83BF-A3138A81A855> /System/Library/Frameworks/ManagedSettings.framework/Versions/A/ManagedSettings
       0x237171000 -        0x2371e51bf  com.apple.MetalFX (31.8 - 31.8) <77EEF9FE-EF9F-3BEC-9F2F-E76812B0A8A1> /System/Library/Frameworks/MetalFX.framework/Versions/A/MetalFX
       0x2371e7000 -        0x2372051ff  com.apple.MPSBenchmarkLoop (1.0 - 1) <CE33B5A6-25BA-3202-BDFE-0D59EFE2199A> /System/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/Frameworks/MPSBenchmarkLoop.framework/Versions/A/MPSBenchmarkLoop
       0x237206000 -        0x237219e7f  com.apple.MPSFunctions (1.0 - 1) <3103E210-FF5C-3677-BDD3-59FF17A6ACEC> /System/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/Frameworks/MPSFunctions.framework/Versions/A/MPSFunctions
       0x23721a000 -        0x23721f53f  com.apple.MPSHost (1.0 - 1) <31F90368-23A5-39BB-822B-C8470C4479AE> /System/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/Frameworks/MPSHost.framework/Versions/A/MPSHost
       0x237220000 -        0x23855783f  com.apple.MetalPerformanceShadersGraph (6.5.1 - 6.5.1) <7401E849-7B2E-39A9-99D3-5CB0A6BBDFFE> /System/Library/Frameworks/MetalPerformanceShadersGraph.framework/Versions/A/MetalPerformanceShadersGraph
       0x238c09000 -        0x238c5f81f  com.apple.NearbyInteraction (1.0 - 524.0.7) <09FB0BAF-DE74-3490-B80A-A46091FEE312> /System/Library/Frameworks/NearbyInteraction.framework/Versions/A/NearbyInteraction
       0x23952a000 -        0x23965ef3f  com.apple.QuickLookUIFramework (5.0 - 1018.5.5) <778E863D-A09A-3E8B-B805-C0DBCBD923A5> /System/Library/Frameworks/QuickLookUI.framework/Versions/A/QuickLookUI
       0x239d06000 -        0x239d0eaff  com.apple.RelevanceKit (1.0 - 1) <9B1EA073-291F-3A6E-92AD-DC2F6CCCCDE0> /System/Library/Frameworks/RelevanceKit.framework/Versions/A/RelevanceKit
       0x239f57000 -        0x239fb555f  com.apple.ScreenCaptureKit (1) <14002C32-C93F-3D4F-98CD-43390D072946> /System/Library/Frameworks/ScreenCaptureKit.framework/Versions/A/ScreenCaptureKit
       0x239fde000 -        0x23a0e497f  com.apple.SensitiveContentAnalysis (1.0 - 1) <D185A202-2E0C-3C6C-9BDC-DC4D8A6CA3EA> /System/Library/Frameworks/SensitiveContentAnalysis.framework/Versions/A/SensitiveContentAnalysis
       0x23a190000 -        0x23a1adc3f  com.apple.SharedWithYouCore (1.0 - 1) <ECE4CCC0-8D35-346C-85C2-91E225504B26> /System/Library/Frameworks/SharedWithYouCore.framework/Versions/A/SharedWithYouCore
       0x23a4ca000 -        0x23a6364bf  com.apple.SwiftData (1.0 - 135) <9F52706C-75BD-34AF-A29E-C26608124ACC> /System/Library/Frameworks/SwiftData.framework/Versions/A/SwiftData
       0x23a637000 -        0x23b59391f  com.apple.SwiftUICore (7.6.1 - 7.6.1) <9EB0840F-B045-3529-9467-1470A3C6CA02> /System/Library/Frameworks/SwiftUICore.framework/Versions/A/SwiftUICore
       0x23b594000 -        0x23b5a7e3f  com.apple.Symbols (1.0 - 190.4.0.1) <028E944B-66C4-39E2-A436-FB93FB6CED4E> /System/Library/Frameworks/Symbols.framework/Versions/A/Symbols
       0x23b5ae000 -        0x23b6ecb5f  com.apple.DataFrame (1.0 - 52) <F12008DC-72EB-3AB3-BC2E-5BC47ED81BDB> /System/Library/Frameworks/TabularData.framework/Versions/A/TabularData
       0x23b94b000 -        0x23b9cbc7f  com.apple.TipKit (26.6 - 120.5.1) <6F7E7DD5-FBB7-35A1-A114-2325A268B4E8> /System/Library/Frameworks/TipKit.framework/Versions/A/TipKit
       0x23bab4000 -        0x23bb41bbf  com.apple.Translation (1.0 - 365.14) <C05D5BDB-5A72-37EC-BFCF-586B86FB1BAE> /System/Library/Frameworks/Translation.framework/Versions/A/Translation
       0x23bfd2000 -        0x23c2feeff  libANGLE-shared.dylib (624.5.1.11.3) <5727F861-DB93-36D9-8C34-C74D3A71DAC2> /System/Library/Frameworks/WebKit.framework/Versions/A/Frameworks/WebCore.framework/Versions/A/Frameworks/libANGLE-shared.dylib
       0x23c4e0000 -        0x23c4eb3bf  com.apple.-GeoToolbox-AppIntents (1.0 - 1) <6A61C664-25B4-32A1-811B-B18AEEDB2DE0> /System/Library/Frameworks/_GeoToolbox_AppIntents.framework/Versions/A/_GeoToolbox_AppIntents
       0x23c528000 -        0x23c552b5f  com.apple.CoreLocation.LocationEssentials (1.0 - 1) <EDFF8FB1-DFD9-32F1-B215-F8647276D90C> /System/Library/Frameworks/_LocationEssentials.framework/Versions/A/_LocationEssentials
       0x23ce48000 -        0x23ce6a19f  com.apple.AAAFoundation (1.0 - 1) <E423A66B-6198-377C-934C-2E4A7FE4C732> /System/Library/PrivateFrameworks/AAAFoundation.framework/Versions/A/AAAFoundation
       0x23ce6b000 -        0x23ced78df  com.apple.AAAFoundationSwift (1.0 - 1) <7A222E30-8DD4-3B1D-B820-4EA33B797525> /System/Library/PrivateFrameworks/AAAFoundationSwift.framework/Versions/A/AAAFoundationSwift
       0x23cfaa000 -        0x23cfbc47f  com.apple.siri.AIMLExperimentationAnalytics (1.0 - 1) <AE2B7E6C-FA2B-3BA9-842D-0F80C26185FD> /System/Library/PrivateFrameworks/AIMLExperimentationAnalytics.framework/Versions/A/AIMLExperimentationAnalytics
       0x23e17f000 -        0x23e1db43f  com.apple.ARKitCore (746.100.3 - 746.100.3) <4755D0B2-D658-38E5-8C6D-3E5C3BF1ED16> /System/Library/PrivateFrameworks/ARKitCore.framework/Versions/A/ARKitCore
       0x23e20b000 -        0x23e21347f  com.apple.ARKitFoundation (746.100.3 - 746.100.3) <893C37FF-6A82-3F88-AAFB-757DC6B29288> /System/Library/PrivateFrameworks/ARKitFoundation.framework/Versions/A/ARKitFoundation
       0x23f456000 -        0x23f4dbd87  com.apple.AlgorithmsInternal (1.2 - 5026.6.1) <3A29BE1C-BDD6-320D-A002-612651FB47D2> /System/Library/PrivateFrameworks/AlgorithmsInternal.framework/Versions/A/AlgorithmsInternal
       0x23f9b4000 -        0x23fa6537f  com.apple.AppIntentSchemas (1.0 - 3501.5.4) <D8DACBBA-9BE2-310B-B7F7-408598542957> /System/Library/PrivateFrameworks/AppIntentSchemas.framework/Versions/A/AppIntentSchemas
       0x23fb36000 -        0x23fdd075f  com.apple.AppIntentsServices (1.0 - 40.5.2) <07F207FC-F968-33AF-ACA2-5AB5A94B923C> /System/Library/PrivateFrameworks/AppIntentsServices.framework/Versions/A/AppIntentsServices
       0x23fdd1000 -        0x23fde2a1f  com.apple.appintents.AppIntentsTypeSupport (1.0 - 300.6.3) <AC51A135-5215-34CF-A149-D132321142AA> /System/Library/PrivateFrameworks/AppIntentsTypeSupport.framework/Versions/A/AppIntentsTypeSupport
       0x240ef1000 -        0x240f4625f  com.apple.AppleAccountUI (1.0 - 1) <2B45FCC7-EED5-3447-A03A-124442624141> /System/Library/PrivateFrameworks/AppleAccountUI.framework/Versions/A/AppleAccountUI
       0x240f8d000 -        0x241109e9f  com.apple.AppleDepth (158.0 - 158.0) <47C92BD7-7B16-3997-8729-3BA2BDEA3BA2> /System/Library/PrivateFrameworks/AppleDepth.framework/Versions/A/AppleDepth
       0x24110a000 -        0x24118ea7f  com.apple.AppleDepthCore (157.0 - 157.0) <88D1D2BA-7E76-38B8-8469-D2A86546FCB4> /System/Library/PrivateFrameworks/AppleDepthCore.framework/Versions/A/AppleDepthCore
       0x24118f000 -        0x2411a3abf  com.apple.AppleDeviceQuerySupport (1.0 - 408.120.3) <9594FBFB-D49D-3DF6-8820-564633EAEC2B> /System/Library/PrivateFrameworks/AppleDeviceQuerySupport.framework/Versions/A/AppleDeviceQuerySupport
       0x2411f6000 -        0x24121109f  com.apple.siri.flatbuffer.AppleFlatBuffers (1) <E936F50F-0833-3F01-95DC-D4A94F470727> /System/Library/PrivateFrameworks/AppleFlatBuffers.framework/Versions/A/AppleFlatBuffers
       0x2415cc000 -        0x24165b5df  com.apple.proactive.AppleIntelligenceReporting (1.0 - 1) <05EC9C98-7211-39C9-B376-796F37327801> /System/Library/PrivateFrameworks/AppleIntelligenceReporting.framework/Versions/A/AppleIntelligenceReporting
       0x241752000 -        0x241920b67  com.apple.cmphoto.AppleJPEGXL (1.0 - 1) <71A0C0AD-67F3-36F9-BF73-6DD5D7424AF7> /System/Library/PrivateFrameworks/AppleJPEGXL.framework/Versions/A/AppleJPEGXL
       0x241921000 -        0x24199cb46  com.apple.AppleKeyStore (1.0 - 1.0) <E444621A-C72D-36A2-AA52-9E9FAFA7B42D> /System/Library/PrivateFrameworks/AppleKeyStore.framework/Versions/A/AppleKeyStore
       0x2419cc000 -        0x2420e9f3f  com.apple.AppleMediaServicesKitInternal (1.6.1 - 1.6.1) <FA622C7B-4A62-368E-B2FD-EA729BF2451A> /System/Library/PrivateFrameworks/AppleMediaServicesKitInternal.framework/Versions/A/AppleMediaServicesKitInternal
       0x2422c9000 -        0x2422e19df  com.apple.private.AppleMobileFileIntegrity-fmk (1.0 - 1) <FFB902E7-2984-3F17-B43D-2DDA2C5683F9> /System/Library/PrivateFrameworks/AppleMobileFileIntegrity.framework/Versions/A/AppleMobileFileIntegrity
       0x242479000 -        0x2424f4ea7  com.apple.ArgumentParserInternal (1.0 - 1.20.2) <841D5662-2CB9-3A27-ADA7-E33AC5E45199> /System/Library/PrivateFrameworks/ArgumentParserInternal.framework/Versions/A/ArgumentParserInternal
       0x24250b000 -        0x24259c97f  com.apple.AskToCore (1.0 - 1) <104F9594-EFD3-333D-8518-129326AA6AF3> /System/Library/PrivateFrameworks/AskToCore.framework/Versions/A/AskToCore
       0x242734000 -        0x2427da564  com.apple.AsyncAlgorithmsInternal (1.0.0 - 5026.6.1) <ECAF5DEB-CD09-32BB-9267-1DD4C37C2F4A> /System/Library/PrivateFrameworks/AsyncAlgorithmsInternal.framework/Versions/A/AsyncAlgorithmsInternal
       0x2427db000 -        0x2427ed799  com.apple.AtomicsInternal (1.1.0 - 5026.6.1) <1617DBB1-2BFF-3619-903C-2FBB31348FB6> /System/Library/PrivateFrameworks/AtomicsInternal.framework/Versions/A/AtomicsInternal
       0x2428aa000 -        0x2428ccdff  com.apple.imgaudio.AudioAnalytics (1.0 - 1) <C4EF9A70-A6B4-3F21-B3D8-A0C740406419> /System/Library/PrivateFrameworks/AudioAnalytics.framework/Versions/A/AudioAnalytics
       0x242c36000 -        0x242d396df  com.apple.AuthenticationServicesCore (1.0 - 21624.5.1.11.3) <0707477E-CC4C-34A3-8487-2F7332721027> /System/Library/PrivateFrameworks/AuthenticationServicesCore.framework/Versions/A/AuthenticationServicesCore
       0x242d89000 -        0x242d8bfff  com.apple.AvailabilityKit (1.0 - 116.700.21) <6BC12AB5-5267-3C95-BB4C-0EB0024E9354> /System/Library/PrivateFrameworks/AvailabilityKit.framework/Versions/A/AvailabilityKit
       0x242d8c000 -        0x242e49ebf  com.apple.avatarkit (1.0 - 356.500) <5A0C76EA-0894-3A52-AA2F-4987194C2844> /System/Library/PrivateFrameworks/AvatarKit.framework/Versions/A/AvatarKit
       0x242e4a000 -        0x242e4a367  com.apple.AvatarKitContent (1.0 - 356.500) <F49C002A-0BCA-3050-BA9B-219015EC7040> /System/Library/PrivateFrameworks/AvatarKitContent.framework/Versions/A/AvatarKitContent
       0x242e4b000 -        0x242e9a77f  com.apple.AvatarPersistence (1.0 - 395.500.1) <918CB20A-A6D5-30BF-9818-86E8E06FEB1C> /System/Library/PrivateFrameworks/AvatarPersistence.framework/Versions/A/AvatarPersistence
       0x242f10000 -        0x242f5885f  com.apple.BackBoardHIDEventFoundation (1.0 - 1) <7F763DF9-EA7F-3938-B599-DCCF4605E610> /System/Library/PrivateFrameworks/BackBoardHIDEventFoundation.framework/Versions/A/BackBoardHIDEventFoundation
       0x242f59000 -        0x242f7b5ff  com.apple.BackgroundSystemTasks (1.0 - 1) <10A4E63B-A1EB-31CC-B3E1-DB4FE115FC84> /System/Library/PrivateFrameworks/BackgroundSystemTasks.framework/Versions/A/BackgroundSystemTasks
       0x242ff1000 -        0x24300a8df  com.apple.biome.BiomeDSL (1.0 - 209.21) <FE87FF48-AB89-3D65-ABC3-EFE50A81355F> /System/Library/PrivateFrameworks/BiomeDSL.framework/Versions/A/BiomeDSL
       0x24300b000 -        0x2438c5f7f  com.apple.BiomeLibrary (274.60) <07CF779F-8F51-3764-B486-23D76868FF91> /System/Library/PrivateFrameworks/BiomeLibrary.framework/Versions/A/BiomeLibrary
       0x2438c6000 -        0x2438cbb5f  com.apple.biome.BiomeSync (1.0 - 209.21) <2362E209-EC61-3FFC-9486-1244BB29BE82> /System/Library/PrivateFrameworks/BiomeSync.framework/Versions/A/BiomeSync
       0x243f93000 -        0x243fc969f  com.apple.CBORLibrary (1.0 - 1) <D5713F6A-D177-31B7-A33D-F36B31E7E079> /System/Library/PrivateFrameworks/CBORLibrary.framework/Versions/A/CBORLibrary
       0x24431e000 -        0x24432012f  com.apple.CMCaptureDevice (665.140.6) <CD0C6EA1-5AEF-3EB1-8935-45726B3AFACD> /System/Library/PrivateFrameworks/CMCaptureDevice.framework/Versions/A/CMCaptureDevice
       0x2443e3000 -        0x2445eb49f  com.apple.CMImaging (1.0 - 665.140.6) <3B782AC2-00C4-3534-91D2-5C7242B32440> /System/Library/PrivateFrameworks/CMImaging.framework/Versions/A/CMImaging
       0x2445ec000 -        0x2447b667f  com.apple.CMPhoto (1.0 - 1) <214294AE-C7B7-3C9A-A4F8-201C989F9779> /System/Library/PrivateFrameworks/CMPhoto.framework/Versions/A/CMPhoto
       0x2447bb000 -        0x2447c8cdf  com.apple.spotlight.CSExattrCrypto (1.0 - 2418.6.3.9.400) <F85877CC-C21A-3298-A9C7-0041E757B522> /System/Library/PrivateFrameworks/CSExattrCrypto.framework/Versions/A/CSExattrCrypto
       0x24496d000 -        0x244a2b7ff  com.apple.CalendarDaemon (1.0 - 1224.4.13) <A685B10F-E626-366D-8C61-701B40F73B67> /System/Library/PrivateFrameworks/CalendarDaemon.framework/Versions/A/CalendarDaemon
       0x244a2c000 -        0x244b5e5ff  com.apple.CalendarDatabase (1.0 - 1269.4.7) <23B7DC95-4C9E-39B6-97B1-320F8F6FD1B3> /System/Library/PrivateFrameworks/CalendarDatabase.framework/Versions/A/CalendarDatabase
       0x244e65000 -        0x244e72ebf  com.apple.CallsPersistence (1.0 - 1) <0B1D3C49-424C-33B3-8AF7-AA6C7EAC929F> /System/Library/PrivateFrameworks/CallsPersistence.framework/Versions/A/CallsPersistence
       0x244e73000 -        0x244e7e9bf  com.apple.CallsUtilities (1.0 - 1) <BFBADA86-5087-360A-B12F-19C6E598316D> /System/Library/PrivateFrameworks/CallsUtilities.framework/Versions/A/CallsUtilities
       0x244e7f000 -        0x244e9ea61  com.apple.CallsXPC (1.0 - 1) <16FD5AC2-EE84-3758-8A92-0E14EF5083F5> /System/Library/PrivateFrameworks/CallsXPC.framework/Versions/A/CallsXPC
       0x244efc000 -        0x244f948bf  com.apple.biome.CascadeSets (1.0 - 209.21) <2091B02D-8D55-3DC4-8097-60C193D03C85> /System/Library/PrivateFrameworks/CascadeSets.framework/Versions/A/CascadeSets
       0x244fb0000 -        0x244fb5cff  com.apple.Centauri (1.0 - 1) <3854272C-7B14-3A3C-9BB1-F0FBA394708A> /System/Library/PrivateFrameworks/Centauri.framework/Versions/A/Centauri
       0x244ff5000 -        0x245011084  com.apple.cryptokit.Chirp (1.0 - 1) <3448B8A0-0DD6-3921-8A12-E3D27CF360AB> /System/Library/PrivateFrameworks/Chirp.framework/Versions/A/Chirp
       0x2454a7000 -        0x2454df59f  com.apple.CinematicFraming (1.0 - 665.140.6) <FCEDE250-22B0-35B9-A5F4-87AA67D568FF> /System/Library/PrivateFrameworks/CinematicFraming.framework/Versions/A/CinematicFraming
       0x245743000 -        0x2457b351f  com.apple.cloudkit.CloudAsset (2360.120.2) <B17F92E7-6017-3EC8-8B15-5F38CDFF9323> /System/Library/PrivateFrameworks/CloudAsset.framework/Versions/A/CloudAsset
       0x2459dd000 -        0x245a50a1f  com.apple.cloudkit.CloudCoreInternal (2360.120.2) <23871A43-55FD-3D0C-B29F-B143A64D1D8D> /System/Library/PrivateFrameworks/CloudCoreInternal.framework/Versions/A/CloudCoreInternal
       0x245b82000 -        0x245b8fc9f  com.apple.CloudSettings (1.0 - 1) <C10D82BE-5111-31DF-88B6-31143114C761> /System/Library/PrivateFrameworks/CloudSettings.framework/Versions/A/CloudSettings
       0x245c4c000 -        0x245d88e3f  com.apple.CloudSubscriptionFeatures (1.0 - 1.9) <5FAA391F-E314-3FBD-BFA5-FCB76CAD1F88> /System/Library/PrivateFrameworks/CloudSubscriptionFeatures.framework/Versions/A/CloudSubscriptionFeatures
       0x245d89000 -        0x245d9ed3f  com.apple.CloudTelemetry (1.0 - 2350.100.2) <121798D0-5254-3547-8F96-0F2AF8D84250> /System/Library/PrivateFrameworks/CloudTelemetry.framework/Versions/A/CloudTelemetry
       0x245d9f000 -        0x245dad9df  CloudTelemetryShared.dylib (2350.100.2) <D4E833CF-2C73-39D9-BA75-8CAE484DF053> /System/Library/PrivateFrameworks/CloudTelemetryShared.dylib
       0x245dae000 -        0x245e3c0ff  com.apple.CloudTelemetryTools (13.1.47 - 2350.100.2) <C1165EDC-58D6-329E-A873-E272A83B5FD3> /System/Library/PrivateFrameworks/CloudTelemetryTools.framework/Versions/A/CloudTelemetryTools
       0x24632a000 -        0x24634e8ff  com.apple.CollectionViewCore (1.0 - 1) <4840B78C-D96B-35B9-85C7-E5889C44A7C4> /System/Library/PrivateFrameworks/CollectionViewCore.framework/Versions/A/CollectionViewCore
       0x24634f000 -        0x24648d4ee  com.apple.CollectionsInternal (1.2.0 - 5026.6.1) <6098453F-4D7E-38B4-8ADC-02C9FF51E14A> /System/Library/PrivateFrameworks/CollectionsInternal.framework/Versions/A/CollectionsInternal
       0x2464a7000 -        0x24656e7bf  com.apple.CommunicationTrust (1) <34919AAB-936B-3E7E-945A-4E8D0455E06F> /System/Library/PrivateFrameworks/CommunicationTrust.framework/Versions/A/CommunicationTrust
       0x2465be000 -        0x2465ed63f  com.apple.wakeboard.CompositorNonUI (420.100.10) <8033E459-21BF-3B27-B56F-C2856ADFE195> /System/Library/PrivateFrameworks/CompositorNonUI.framework/Versions/A/CompositorNonUI
       0x2468c7000 -        0x2468fadbf  com.apple.contacts.ContactsAccounts (1.0 - 1) <162073C2-0CCB-3EA6-A5B6-6EF074A39A4C> /System/Library/PrivateFrameworks/ContactsAccounts.framework/Versions/A/ContactsAccounts
       0x2468fb000 -        0x2468feddf  com.apple.contacts.ContactsMetrics (1 - 21.700.11) <7D76A387-25C0-3B05-9B02-D39692237982> /System/Library/PrivateFrameworks/ContactsMetrics.framework/Versions/A/ContactsMetrics
       0x246a45000 -        0x246a4a03f  com.apple.contextkit.ContextKitCore (1.0 - 1) <561BD1F8-F841-3DBB-8914-355735557B83> /System/Library/PrivateFrameworks/ContextKitCore.framework/Versions/A/ContextKitCore
       0x24874a000 -        0x2487e7fff  com.apple.audio.coreaudio.Stravinsky (1.0 - 1) <7CC0621B-3B88-3533-A3FB-52E6214486EE> /System/Library/PrivateFrameworks/CoreAudioOrchestration.framework/Versions/A/CoreAudioOrchestration
       0x248891000 -        0x2489b3e3f  com.apple.CoreComposite (1.0 - 330.100.6) <61F1CC5B-6F86-3433-A776-170B3049555F> /System/Library/PrivateFrameworks/CoreComposite.framework/Versions/A/CoreComposite
       0x24c5f4000 -        0x24c6fa25f  com.apple.CoreSceneUnderstanding (1.74.0 - 1.74.0) <C60B3FA0-2804-3339-B16D-E41B33FE25CC> /System/Library/PrivateFrameworks/CoreSceneUnderstanding.framework/Versions/A/CoreSceneUnderstanding
       0x24c8f0000 -        0x24c955b43  com.apple.CoreTransparency (1.0 - 1) <E4F3D821-1834-3768-AB7F-39FC9EE103B6> /System/Library/PrivateFrameworks/CoreTransparency.framework/Versions/A/CoreTransparency
       0x24c956000 -        0x24c97e0bf  com.apple.CoreUtilsExtras (1.0 - 1) <3DD8C4CA-23E9-35CF-AD67-549DD72D3344> /System/Library/PrivateFrameworks/CoreUtilsExtras.framework/Versions/A/CoreUtilsExtras
       0x24cec7000 -        0x24cf83bdf  com.apple.security.CryptoKit-Private (1.0 - 1) <38DAF669-429F-384F-87D6-8550842EEB5E> /System/Library/PrivateFrameworks/CryptoKitPrivate.framework/Versions/A/CryptoKitPrivate
       0x24cf98000 -        0x24cfa27df  com.apple.devicemanagementclient.DEPClientLibrary (1.0 - 1) <41FACB19-E885-3607-8395-76BB053024DD> /System/Library/PrivateFrameworks/DEPClientLibrary.framework/Versions/A/DEPClientLibrary
       0x24cfc5000 -        0x24d00a0ff  com.apple.devicemanagementclient.DMCEnrollmentLibrary (1.0 - 1) <05804007-740F-3E5F-A94F-E46B6916C5D2> /System/Library/PrivateFrameworks/DMCEnrollmentLibrary.framework/Versions/A/DMCEnrollmentLibrary
       0x24d037000 -        0x24d0859df  com.apple.devicemanagementclient.DMCUtilities (1.0 - 1) <65D2DF80-C7B7-3EBD-B79F-58EE538FFA1A> /System/Library/PrivateFrameworks/DMCUtilities.framework/Versions/A/DMCUtilities
       0x24d102000 -        0x24d1099bf  com.apple.darwinup-framework (1.0 - 302.160.2) <089C1A34-2F4E-3649-94AA-B28A7ECB008B> /System/Library/PrivateFrameworks/Darwinup.framework/Versions/A/Darwinup
       0x24d23c000 -        0x24d27fc9f  com.apple.dataaccess.dataaccessexpress.framework (1.0 - 1.0) <8B386F88-8DA7-3A81-AB54-E9A62B46A1CB> /System/Library/PrivateFrameworks/DataAccessExpress.framework/Versions/A/DataAccessExpress
       0x24d4d5000 -        0x24d544e7f  com.apple.aiml.dendrite.Dendrite (1.0 - 1) <0A1C4D11-C108-35E9-A921-86ED86CF7446> /System/Library/PrivateFrameworks/Dendrite.framework/Versions/A/Dendrite
       0x24d545000 -        0x24d6c2aff  com.apple.DesignLibrary (7.5.2 - 7.5.2) <2BC041DF-695A-32EE-B164-1C35C2AFFC53> /System/Library/PrivateFrameworks/DesignLibrary.framework/Versions/A/DesignLibrary
       0x24da65000 -        0x24da7849f  com.apple.DeviceRecovery (1.0 - 1) <2FA711C7-F764-363A-BF03-295E0DA88B79> /System/Library/PrivateFrameworks/DeviceRecovery.framework/Versions/A/DeviceRecovery
       0x24dc43000 -        0x24de91e1f  com.apple.DiskImages2 (524.160.11 - 524.160.11) <F4F5986E-41F0-387C-87EB-12D181F2F23A> /System/Library/PrivateFrameworks/DiskImages2.framework/Versions/A/DiskImages2
       0x24de9d000 -        0x24deb367f  com.apple.DistributedSensing (1.0 - 1) <9B3D4CA3-7BCF-36C9-AA99-27BDFE7854CD> /System/Library/PrivateFrameworks/DistributedSensing.framework/Versions/A/DistributedSensing
       0x24df99000 -        0x24e007bbf  com.apple.DoNotDisturb (1.0 - 468.6.4) <88AFCA34-6854-3CBD-898A-363AB2B45C75> /System/Library/PrivateFrameworks/DoNotDisturb.framework/Versions/A/DoNotDisturb
       0x24edac000 -        0x24edad3bf  com.apple.private.FaceTimeNameUtility (1.0 - 1) <55FBCBE4-1032-3017-BA49-D734B82405DF> /System/Library/PrivateFrameworks/FaceTimeNameUtility.framework/Versions/A/FaceTimeNameUtility
       0x24f222000 -        0x24f2de33f  com.apple.FeedbackService (1.0 - 1) <576CE5FD-93F3-3C4C-A290-4EAFE522FCF7> /System/Library/PrivateFrameworks/FeedbackService.framework/Versions/A/FeedbackService
       0x24f44b000 -        0x24f50d57f  com.apple.findmy.framework.FindMyBase (1.0 - 84.25.2.23.2) <6BFEFDE7-0409-34B1-9353-2194F8DDFF2F> /System/Library/PrivateFrameworks/FindMyBase.framework/Versions/A/FindMyBase
       0x24f678000 -        0x24f692a5f  com.apple.findmy.framework.FindMyCommon (1.0 - 84.25.2.23.2) <2279C7A8-D4AD-35D3-BC92-0D9B7BEF975D> /System/Library/PrivateFrameworks/FindMyCommon.framework/Versions/A/FindMyCommon
       0x24f7a4000 -        0x24f8f8b9f  com.apple.findmy.framework.FindMyLocate (1.0 - 1.0) <99C69FD8-1533-302F-A3C7-063AABB56C22> /System/Library/PrivateFrameworks/FindMyLocate.framework/Versions/A/FindMyLocate
       0x24fb3c000 -        0x24fb8f53f  com.apple.UIKit.FocusEngine (9126.6.8) <CACC89FE-B88C-3419-A1C3-42C61D0C3DF3> /System/Library/PrivateFrameworks/FocusEngine.framework/Versions/A/FocusEngine
       0x24fd0a000 -        0x24fd0d2ff  com.apple.FontServices (1.0 - 1) <A9851D45-161F-3722-BC68-5B3B3FBFC956> /System/Library/PrivateFrameworks/FontServices.framework/Versions/A/FontServices
       0x24fd0e000 -        0x24fdfde2f  libXTFontStaticRegistryData.dylib (335.4.0.6) <B3DBACFE-8DA6-3E2D-92F1-F82E010A2225> /System/Library/PrivateFrameworks/FontServices.framework/libXTFontStaticRegistryData.dylib
       0x24fdff000 -        0x24fe0bc9f  com.apple.FramePacing (1.0 - 1) <1FDD3B19-C04A-3EE7-B7DF-E1F89954A696> /System/Library/PrivateFrameworks/FramePacing.framework/Versions/A/FramePacing
       0x24fe0c000 -        0x24fecd39f  com.apple.FrontBoard (1000.4.12 - 1000.4.12) <7CDC68D4-0845-3053-AB80-C5A1F354060F> /System/Library/PrivateFrameworks/FrontBoard.framework/Versions/A/FrontBoard
       0x24fece000 -        0x24ff1931f  com.apple.FusionTracker (1.0 - 1) <71098074-30C7-3C45-8F08-3E3036A6158C> /System/Library/PrivateFrameworks/FusionTracker.framework/Versions/A/FusionTracker
       0x250f2d000 -        0x250f32f07  libGPUCompilerUtils.dylib (32023.886.1) <F5DD2A61-CD1B-32B0-A8E6-7CB5B4BABFF1> /System/Library/PrivateFrameworks/GPUCompiler.framework/Versions/32023/Libraries/libGPUCompilerUtils.dylib
       0x2553a0000 -        0x2553df797  libllvm-flatbuffers.dylib (32023.886.1) <526C249F-FF2E-3DC4-A639-B41A032E8CCE> /System/Library/PrivateFrameworks/GPUCompiler.framework/Versions/32023/Libraries/libllvm-flatbuffers.dylib
       0x25593e000 -        0x255ac0d7f  com.apple.GRDB.GRDBInternal (1.0 - 15.0.0.1) <9EB8FE95-7E26-39FD-A9FA-ACB9EC1B6052> /System/Library/PrivateFrameworks/GRDBInternal.framework/Versions/A/GRDBInternal
       0x258b13000 -        0x258b607a6  com.apple.GenerativeFunctions.GenerativeFunctions (1.0 - 222.46) <418985BB-52A3-34D4-8379-40DC4C63AA32> /System/Library/PrivateFrameworks/GenerativeFunctions.framework/Versions/A/GenerativeFunctions
       0x258b61000 -        0x258bf687f  com.apple.GenerativeFunctions.GenerativeFunctionsFoundation (1.0 - 222.46) <63FD423F-836C-3034-BA48-100AE09A9140> /System/Library/PrivateFrameworks/GenerativeFunctionsFoundation.framework/Versions/A/GenerativeFunctionsFoundation
       0x258bf7000 -        0x258c5c97f  com.apple.GenerativeFunctions.GenerativeFunctionsInstrumentation (1.0 - 222.46) <D8D56A51-034C-3D0D-9651-3BCF46DC82B7> /System/Library/PrivateFrameworks/GenerativeFunctionsInstrumentation.framework/Versions/A/GenerativeFunctionsInstrumentation
       0x258c5d000 -        0x258d3ef5f  com.apple.GenerativeFunctions.GenerativeModels (1.0 - 222.46) <0E502870-00F4-35D4-AF82-E7059244798E> /System/Library/PrivateFrameworks/GenerativeModels.framework/Versions/A/GenerativeModels
       0x258d3f000 -        0x258db4b9f  com.apple.GenerativeFunctions.GenerativeModelsFoundation (1.0 - 222.46) <B9593227-D796-3C21-B9B4-374C3D1CFC2F> /System/Library/PrivateFrameworks/GenerativeModelsFoundation.framework/Versions/A/GenerativeModelsFoundation
       0x258e84000 -        0x258f5927f  com.apple.GeoAnalytics (1.0 - 2031.26.4.23.6) <15523A10-C296-3D1C-BB5B-4A1E4649482B> /System/Library/PrivateFrameworks/GeoAnalytics.framework/Versions/A/GeoAnalytics
       0x258f5a000 -        0x258f5f33f  com.apple.GeoServices (1.0 - 2031.26.4.23.6) <38EE3C42-06D6-3A46-A420-DF701A4EA911> /System/Library/PrivateFrameworks/GeoServicesCore.framework/Versions/A/GeoServicesCore
       0x259108000 -        0x2591cbe9f  com.apple.Gestures (9126.1.5 - 9126.1.5) <BD114F61-BB5F-3E43-AA0D-674DF9E0BA17> /System/Library/PrivateFrameworks/Gestures.framework/Versions/A/Gestures
       0x25c166000 -        0x25c1b5fff  com.apple.IASUtilitiesCore (1.0 - 1) <77E103E7-D90F-3DE4-B1B3-223050582C56> /System/Library/PrivateFrameworks/IASUtilitiesCore.framework/Versions/A/IASUtilitiesCore
       0x25c231000 -        0x25c29231f  com.apple.IO80211 (1.0 - 1) <236517AD-8D16-3E62-8603-EBE7B65ACACA> /System/Library/PrivateFrameworks/IO80211.framework/Versions/A/IO80211
       0x25c29c000 -        0x25c2a683f  com.apple.IPConfiguration (1.21 - 1.21) <6661265C-7B78-3158-9011-4BFDFFEF7807> /System/Library/PrivateFrameworks/IPConfiguration.framework/Versions/A/IPConfiguration
       0x25c2dc000 -        0x25c34dadf  com.apple.cocoa.IconRendering (1.0 - 92.3) <6A34A62A-16D4-34F0-B34B-2D96B53C20AD> /System/Library/PrivateFrameworks/IconRendering.framework/Versions/A/IconRendering
       0x25c355000 -        0x25c381e5f  com.apple.ImageCaptureDevices (2020.2.2 - 2020.2.2) <69785455-D99E-396F-827E-C36431DE5985> /System/Library/PrivateFrameworks/ImageCaptureDevices.framework/Versions/A/ImageCaptureDevices
       0x25cb2f000 -        0x25cb6943f  com.apple.InputAnalytics (1.0 - 111.5.1) <4495A900-9BB3-38D8-83D6-E3642CF1BDB9> /System/Library/PrivateFrameworks/InputAnalytics.framework/Versions/A/InputAnalytics
       0x25cd23000 -        0x25ce2c2bf  com.apple.InstalledContentLibrary (1.0 - 1.0) <1ACDAA8A-EB43-37C7-B661-39B1C0E05290> /System/Library/PrivateFrameworks/InstalledContentLibrary.framework/Versions/A/InstalledContentLibrary
       0x25f750000 -        0x25ff1ed3f  com.apple.IntelligencePlatformLibrary (274.60) <D5DD1ABA-3697-3A32-A10F-FC7B7954CFB6> /System/Library/PrivateFrameworks/IntelligencePlatformLibrary.framework/Versions/A/IntelligencePlatformLibrary
       0x2600c1000 -        0x2600cbfdf  com.apple.IsolatedContextLogging (1.0 - 1) <D67EF216-FCD7-3B06-9B9F-2716BE2ACD36> /System/Library/PrivateFrameworks/IsolatedContextLogging.framework/Versions/A/IsolatedContextLogging
       0x2600cc000 -        0x260103b5f  com.apple.audio.CoreAudio.IsolatedCoreAudioClient (1.0 - 1) <BCF6954A-8EBA-3813-92D9-FE75B565FD8B> /System/Library/PrivateFrameworks/IsolatedCoreAudioClient.framework/Versions/A/IsolatedCoreAudioClient
       0x260420000 -        0x26043bb3f  com.apple.JetPack-Mac (1.0 - 1) <E89E2839-F4DB-3EB8-B187-34084E1D2FCE> /System/Library/PrivateFrameworks/JetPack.framework/Versions/A/JetPack
       0x2609fa000 -        0x260b4f83f  com.apple.LiftUI (1.2 - 1) <A8AEFA39-1EFA-3BED-9A28-9EB301F00345> /System/Library/PrivateFrameworks/LiftUI.framework/Versions/A/LiftUI
       0x2610a5000 -        0x261227d5f  com.apple.LinkMetadata (1.0 - 300.6.3) <0DAC711D-EBC6-36AE-B8FC-A05CA64FCB18> /System/Library/PrivateFrameworks/LinkMetadata.framework/Versions/A/LinkMetadata
       0x261228000 -        0x261256f44  com.apple.LinkPresentation.StyleSheetParsing (296 - 296.12) <B8CA6886-8535-3D19-8508-DBC5A48FAF1A> /System/Library/PrivateFrameworks/LinkPresentationStyleSheetParsing.framework/Versions/A/LinkPresentationStyleSheetParsing
       0x261257000 -        0x261403f9f  com.apple.LinkServices (1.0 - 300.6.3) <5242E36A-1CF8-35C0-A56C-BCDBC9C404F2> /System/Library/PrivateFrameworks/LinkServices.framework/Versions/A/LinkServices
       0x261495000 -        0x26161b07f  com.apple.LocalAuthenticationCore (2005.160.7) <A85C476C-4B4D-3329-A88B-54C091C7EF34> /System/Library/PrivateFrameworks/LocalAuthenticationCore.framework/Versions/A/LocalAuthenticationCore
       0x26161c000 -        0x26165c4df  com.apple.LocalAuthenticationCoreUI (2005.160.7) <4964BFE6-073B-36F3-AE71-6918214C4155> /System/Library/PrivateFrameworks/LocalAuthenticationCoreUI.framework/Versions/A/LocalAuthenticationCoreUI
       0x26165d000 -        0x26167c6df  com.apple.LocalAuthenticationCredentialServices (2005.160.7) <B33DAE62-0077-35EA-822C-EB5D21C34768> /System/Library/PrivateFrameworks/LocalAuthenticationCredentialServices.framework/Versions/A/LocalAuthenticationCredentialServices
       0x2616ba000 -        0x2616ddf7f  com.apple.internal.LocalStatusKit (1.0 - 1) <846DDA3B-DF32-3C8F-8C8D-A19AB1B99D89> /System/Library/PrivateFrameworks/LocalStatusKit.framework/Versions/A/LocalStatusKit
       0x2616e2000 -        0x2616e65df  com.apple.CoreLocation.LocationLogEncryption (3077.0.4) <8A2C8C17-E138-3B34-8643-ED4FB1C9049E> /System/Library/PrivateFrameworks/LocationLogEncryption.framework/Versions/A/LocationLogEncryption
       0x2616e7000 -        0x2616eda9f  com.apple.LockdownMode (1.0 - 1) <C4B693AB-9D69-31E3-ADA3-CDAB500A6676> /System/Library/PrivateFrameworks/LockdownMode.framework/Versions/A/LockdownMode
       0x261776000 -        0x2617a697f  com.apple.devicemanagementclient.MDMClientLibrary (1.0 - 1) <6124ABA5-1F26-351A-804F-10D64A181B22> /System/Library/PrivateFrameworks/MDMClientLibrary.framework/Versions/A/MDMClientLibrary
       0x261800000 -        0x261e96923  com.apple.MIL (3520.4 - 3520.4.1) <97C5C585-F5EE-323A-B949-69EAE9080871> /System/Library/PrivateFrameworks/MIL.framework/Versions/A/MIL
       0x261e97000 -        0x261f1403f  com.apple.CoreML.MLAssetIO (1.0 - 3520.5.1) <6028DD46-8E5A-33F0-93B2-41FA480366CC> /System/Library/PrivateFrameworks/MLAssetIO.framework/Versions/A/MLAssetIO
       0x261f15000 -        0x261f6eb0f  com.apple.mlcompiler.runtime (3404.3.1 - 3404.3.1) <22B4CD07-5C72-3CA4-9CD1-2C87686CDDE5> /System/Library/PrivateFrameworks/MLCompilerRuntime.framework/Versions/A/MLCompilerRuntime
       0x261f6f000 -        0x261f88827  com.apple.mlcompiler.services (3404.3.1 - 3404.3.1) <A5FDE0C1-0910-3899-A737-E4632BA75E80> /System/Library/PrivateFrameworks/MLCompilerServices.framework/Versions/A/MLCompilerServices
       0x264bfc000 -        0x264c1331f  com.apple.ggml.ModelAsset (1.0 - 1) <A84CB10A-72FA-399B-B86D-9B5ED12CEB39> /System/Library/PrivateFrameworks/MLModelAsset.framework/Versions/A/MLModelAsset
       0x2656cb000 -        0x2656d0d3f  com.apple.ManagedOrganizationContacts (1.2 - 151.5) <7EB4BA69-82EB-3FBE-8E3F-3522040843A0> /System/Library/PrivateFrameworks/ManagedOrganizationContacts.framework/Versions/A/ManagedOrganizationContacts
       0x2656d1000 -        0x26571523f  com.apple.ManagedSettingsObjC (267.160.4 - 267.160.4) <2B5B0FCC-B46C-34A7-9FFD-12009FDA64C6> /System/Library/PrivateFrameworks/ManagedSettingsObjC.framework/Versions/A/ManagedSettingsObjC
       0x265716000 -        0x26572081f  com.apple.ManagedSettingsSupport (267.160.4 - 267.160.4) <B091438A-38FD-3ADB-9A1F-7689EC9658BC> /System/Library/PrivateFrameworks/ManagedSettingsSupport.framework/Versions/A/ManagedSettingsSupport
       0x265fdb000 -        0x26603cb1f  com.apple.MediaAnalysisServices (1.0 - 1) <7CAE43A1-52B3-36F0-BE67-230A7C75406B> /System/Library/PrivateFrameworks/MediaAnalysisServices.framework/Versions/A/MediaAnalysisServices
       0x266a61000 -        0x266ac2abf  com.apple.MessageSecurity (1.0 - 195.160.36) <A287A9A4-5DFD-331D-93A8-696DBE94592C> /System/Library/PrivateFrameworks/MessageSecurity.framework/Versions/A/MessageSecurity
       0x2679fa000 -        0x267c98b1f  com.apple.ModelCatalog.ModelCatalog (1.0 - 233.41) <EABC58EE-BC80-3886-A456-5028411AE472> /System/Library/PrivateFrameworks/ModelCatalog.framework/Versions/A/ModelCatalog
       0x267d39000 -        0x267ed17df  com.apple.ModelManagerServices (1.0 - 1) <882BC08E-B1E1-3E52-AE8A-AC22A1BF2BE8> /System/Library/PrivateFrameworks/ModelManagerServices.framework/Versions/A/ModelManagerServices
       0x26aa26000 -        0x26aaad9bf  com.apple.calls.NeighborhoodActivityConduit (1.0 - 1) <8D6A0307-5491-3103-B361-3FEDB564445C> /System/Library/PrivateFrameworks/NeighborhoodActivityConduit.framework/Versions/A/NeighborhoodActivityConduit
       0x26b02e000 -        0x26b03585f  com.apple.NewsURLBucket (1.0 - 1) <D3409E6C-D3E0-34D3-AD89-A580BEC5A403> /System/Library/PrivateFrameworks/NewsURLBucket.framework/Versions/A/NewsURLBucket
       0x26b855000 -        0x26bacd3df  com.apple.mlpt.ODIE (1.0 - 1) <B3719F0A-4637-3943-A796-2ED6F5AC0C08> /System/Library/PrivateFrameworks/ODIE.framework/Versions/A/ODIE
       0x26bad3000 -        0x26bafd1bf  com.apple.OSEligibility (319.160.17) <62740FDD-2B16-3319-B5C9-022D45C6B03A> /System/Library/PrivateFrameworks/OSEligibility.framework/Versions/A/OSEligibility
       0x26c760000 -        0x26c87885f  com.apple.ParsingInternal (0.0.1 - 5026.6.1) <11E757EC-72FB-3C53-8ED7-641428AB6169> /System/Library/PrivateFrameworks/ParsingInternal.framework/Versions/A/ParsingInternal
       0x26ce64000 -        0x26ce73a1f  com.apple.PassKitMacHelperTemp (1.0 - 1642.7.4) <B6E0923A-1228-37F1-99A4-835F5C1452A6> /System/Library/PrivateFrameworks/PassKitMacHelperTemp.framework/Versions/A/PassKitMacHelperTemp
       0x26d54a000 -        0x26e305c3f  com.apple.PegasusAPI (1.0 - 3525.4.2) <4C76BFD8-9DCE-32E6-9833-BC989659A067> /System/Library/PrivateFrameworks/PegasusAPI.framework/Versions/A/PegasusAPI
       0x26e306000 -        0x26e364bdf  com.apple.PegasusConfiguration (1.0 - 15000) <618F8025-DAFD-3DE7-A8D1-AB121D69BC89> /System/Library/PrivateFrameworks/PegasusConfiguration.framework/Versions/A/PegasusConfiguration
       0x26e935000 -        0x26ea6997f  com.apple.PhotoLibraryServicesCore (1.0 - 860.0.170) <5FC4D42C-E147-3437-A2F1-B79653D08FF4> /System/Library/PrivateFrameworks/PhotoLibraryServicesCore.framework/Versions/A/PhotoLibraryServicesCore
       0x26f4e0000 -        0x26f5396bf  com.apple.PhotosIntelligenceCore (1.0 - 860.0.170) <F82016CB-5C21-3439-9B88-3A9315A44938> /System/Library/PrivateFrameworks/PhotosIntelligenceCore.framework/Versions/A/PhotosIntelligenceCore
       0x26fc11000 -        0x26fc32e1f  com.apple.accessibility.PhotosensitivityProcessing (1.0 - 1) <FBE7AAD0-E0FC-3573-9D62-EB6948FE95FF> /System/Library/PrivateFrameworks/PhotosensitivityProcessing.framework/Versions/A/PhotosensitivityProcessing
       0x26fc75000 -        0x26fd62b5f  com.apple.PlatformSSO (1.0 - 483.160.10) <30B8106C-CEB4-3C8C-8A8B-91AC28F9253B> /System/Library/PrivateFrameworks/PlatformSSO.framework/Versions/A/PlatformSSO
       0x26fd63000 -        0x26fe74c5f  com.apple.PlatformSSOCore (1.0 - 483.160.10) <FBE9002D-DFA8-3A74-BB91-65A6AC212783> /System/Library/PrivateFrameworks/PlatformSSOCore.framework/Versions/A/PlatformSSOCore
       0x270026000 -        0x270062a3c  com.apple.PoirotSQLite (1.0 - 1) <24779350-BC29-3465-AAB3-F7CD0DA5844A> /System/Library/PrivateFrameworks/PoirotSQLite.framework/Versions/A/PoirotSQLite
       0x270063000 -        0x2700d025f  com.apple.PoirotSchematizer (1.0 - 1) <42CDC0E6-51BA-3804-BD3E-EDF87FC74034> /System/Library/PrivateFrameworks/PoirotSchematizer.framework/Versions/A/PoirotSchematizer
       0x2700d1000 -        0x270106bff  com.apple.PoirotUDFs (1.0 - 1) <D085FE4F-65AA-3A17-8F24-156DD9814882> /System/Library/PrivateFrameworks/PoirotUDFs.framework/Versions/A/PoirotUDFs
       0x270107000 -        0x270216a3f  com.apple.portrait.Portrait (1.0 - 18) <247EAF46-FC92-38AF-BDC3-D0264F54DA4E> /System/Library/PrivateFrameworks/Portrait.framework/Versions/A/Portrait
       0x2702c8000 -        0x27032fa9f  com.apple.PosterFoundation (1.0 - 1) <6F5A7AD7-80A3-3AC1-85CC-ECF5FED85ABB> /System/Library/PrivateFrameworks/PosterFoundation.framework/Versions/A/PosterFoundation
       0x270330000 -        0x27035527f  com.apple.PosterFuturesKit (1.0 - 1) <4630911B-43EB-36D3-8B38-C27E3A9D6E97> /System/Library/PrivateFrameworks/PosterFuturesKit.framework/Versions/A/PosterFuturesKit
       0x270356000 -        0x27036471f  com.apple.PosterModel (1.0 - 1) <0D20A94C-AB6A-3999-BE5D-D0C10CEB83C1> /System/Library/PrivateFrameworks/PosterModel.framework/Versions/A/PosterModel
       0x27129f000 -        0x2713daddf  com.apple.ProDisplayLibrary (10.6.1 - 10.6.1) <D495C457-EECC-3D57-B449-EC8F324214EC> /System/Library/PrivateFrameworks/ProDisplayLibrary.framework/Versions/A/ProDisplayLibrary
       0x27143d000 -        0x27146a59f  com.apple.intelligenceflow.ProactiveDaemonSupport (1.0 - 3525.11.14) <12245228-2B9A-3B24-8C5E-10111D68BE65> /System/Library/PrivateFrameworks/ProactiveDaemonSupport.framework/Versions/A/ProactiveDaemonSupport
       0x271a27000 -        0x271bd695f  com.apple.GenerativeFunctions.PromptKit (1.0 - 222.46) <DC6D188E-6FF7-3111-984E-85C8FDBEEF9C> /System/Library/PrivateFrameworks/PromptKit.framework/Versions/A/PromptKit
       0x2722ed000 -        0x2723090ff  com.apple.RecapPerformanceTesting (50 - 50.0) <02803CCF-F7B9-3FC3-AA8A-C55B14F60540> /System/Library/PrivateFrameworks/RecapPerformanceTesting.framework/Versions/A/RecapPerformanceTesting
       0x272395000 -        0x27239d4df  com.apple.ReflectionInternal (1.0.0 - 5026.6.1) <9A1279D4-575A-3E48-A460-A631A3F82D18> /System/Library/PrivateFrameworks/ReflectionInternal.framework/Versions/A/ReflectionInternal
       0x27239e000 -        0x2723b899f  com.apple.RegulatoryDomainFramework (1.0 - 1) <1859954E-2C9A-306C-B98F-DF555F51337B> /System/Library/PrivateFrameworks/RegulatoryDomain.framework/Versions/A/RegulatoryDomain
       0x2726dc000 -        0x2727609df  com.apple.RemoteManagementModel (1.0 - 2.0) <07B5F2B2-1A81-3A55-BEB8-8D6D04C2BD0A> /System/Library/PrivateFrameworks/RemoteManagementModel.framework/Versions/A/RemoteManagementModel
       0x272761000 -        0x27276c25f  com.apple.RemoteManagementProtocol (1.0 - 2.0) <EEA63C08-F05B-3A5A-A013-C7EB0E60CAEF> /System/Library/PrivateFrameworks/RemoteManagementProtocol.framework/Versions/A/RemoteManagementProtocol
       0x27276d000 -        0x2727c613f  com.apple.RemoteManagementStore (1.0 - 2.0) <C2D44609-7FCB-3FD9-9360-161A8662CD15> /System/Library/PrivateFrameworks/RemoteManagementStore.framework/Versions/A/RemoteManagementStore
       0x2727d7000 -        0x272af21ff  com.apple.RemoteUI (1.0 - 4) <C6D5918E-64EA-356C-8B88-AE15AF6F37D7> /System/Library/PrivateFrameworks/RemoteUI.framework/Versions/A/RemoteUI
       0x272b91000 -        0x272d4bd1f  com.apple.private.ReplicatorEngine (1.0 - 1) <F08EA79A-45A8-3126-98F3-1DD86C144E30> /System/Library/PrivateFrameworks/ReplicatorEngine.framework/Versions/A/ReplicatorEngine
       0x272d4c000 -        0x272ea731f  com.apple.private.ReplicatorServices (1.0 - 1) <4A6E1A2E-61DB-3657-ABDF-AB6525F3A9EA> /System/Library/PrivateFrameworks/ReplicatorServices.framework/Versions/A/ReplicatorServices
       0x2732e9000 -        0x2732fc9d7  com.apple.RuntimeInternal (1.0.0 - 5026.6.1) <6D89CD71-A86D-3D78-A64B-96AB79550F79> /System/Library/PrivateFrameworks/RuntimeInternal.framework/Versions/A/RuntimeInternal
       0x273321000 -        0x273337e1f  com.apple.SESShared (1.0 - 1) <D0D20EE9-45F8-37F2-BAD7-E76B1260DA24> /System/Library/PrivateFrameworks/SESShared.framework/Versions/A/SESShared
       0x2733aa000 -        0x2734cdc9f  com.apple.seservice (1.0 - 1) <C748736F-4139-3616-B1FC-B9B95774337A> /System/Library/PrivateFrameworks/SEService.framework/Versions/A/SEService
       0x2734ce000 -        0x273553a3f  com.apple.SFSymbolsFramework (1 - 190.4.0.1) <968B5A5F-9749-3527-AF2A-66B599785308> /System/Library/PrivateFrameworks/SFSymbols.framework/Versions/A/SFSymbols
       0x273554000 -        0x2735c1abf  com.apple.SILManager (53.19 - 53.19) <1B4C0154-843C-3CEE-9628-22978082DD2D> /System/Library/PrivateFrameworks/SILManager.framework/Versions/A/SILManager
       0x27362c000 -        0x273645dbf  com.apple.STSXPCHelperClient (1.0 - 1) <F2A6328A-AEBF-363C-AB76-41A1B7C5ECD2> /System/Library/PrivateFrameworks/STSXPCHelperClient.framework/Versions/A/STSXPCHelperClient
       0x274bfe000 -        0x274ceb0bf  com.apple.SensitiveContentAnalysisML (1) <67C3B698-8279-30F1-9167-4730E6F41F5A> /System/Library/PrivateFrameworks/SensitiveContentAnalysisML.framework/Versions/A/SensitiveContentAnalysisML
       0x274ece000 -        0x274f608ff  com.apple.SentencePieceInternal (57.3) <642E3357-AB6D-3039-A818-EDB5D6A189C2> /System/Library/PrivateFrameworks/SentencePieceInternal.framework/Versions/A/SentencePieceInternal
       0x27520f000 -        0x2752cc5bf  com.apple.Settings (224.4.3 - 224.4.3) <8FE48BAC-7275-31E7-802E-E44DAC8AEB6F> /System/Library/PrivateFrameworks/Settings.framework/Versions/A/Settings
       0x2759e4000 -        0x275b0113f  com.apple.siri.SiriAnalytics (1.0 - 1) <600E036E-9B18-35BE-B40B-E8D2D53AC90D> /System/Library/PrivateFrameworks/SiriAnalytics.framework/Versions/A/SiriAnalytics
       0x27638d000 -        0x2763e039f  com.apple.crossdevicearbitration (1.0 - 1) <71CAE70A-72AD-3F74-834D-3519B545C08D> /System/Library/PrivateFrameworks/SiriCrossDeviceArbitration.framework/Versions/A/SiriCrossDeviceArbitration
       0x2763e1000 -        0x276450a1f  com.apple.crossdevicearbitration.feedback (1.0 - 1) <B6CA0C8F-4310-3E4B-BA3B-9F968F3009F4> /System/Library/PrivateFrameworks/SiriCrossDeviceArbitrationFeedback.framework/Versions/A/SiriCrossDeviceArbitrationFeedback
       0x279ed4000 -        0x279edd3bf  com.apple.siri.SiriPowerInstrumentation (1 - 1.0) <68474F39-798D-325B-B52F-3DE214F279AE> /System/Library/PrivateFrameworks/SiriPowerInstrumentation.framework/Versions/A/SiriPowerInstrumentation
       0x27b315000 -        0x27bc944ff  com.apple.siri.tts.SiriTTS (1 - 1) <FA946108-D387-360D-8E87-7BB8FF2D3099> /System/Library/PrivateFrameworks/SiriTTS.framework/Versions/A/SiriTTS
       0x27bc95000 -        0x27be8c89f  com.apple.siri.SiriTTSService (1.0 - 1) <619E6770-766A-3629-9AF8-F32C009375E9> /System/Library/PrivateFrameworks/SiriTTSService.framework/Versions/A/SiriTTSService
       0x27d57f000 -        0x27d66febf  com.apple.SonicFoundation (1.0 - 25700.26.20.101) <6B0D099C-AC56-35DB-90F1-88A09E587FCB> /System/Library/PrivateFrameworks/SonicFoundation.framework/Versions/A/SonicFoundation
       0x27e156000 -        0x27e18daff  com.apple.StatusKit (1.0 - 116.700.21) <A765DD00-50DC-3F94-B5F4-1FD6BEEDEC11> /System/Library/PrivateFrameworks/StatusKit.framework/Versions/A/StatusKit
       0x27e468000 -        0x27e7711ff  com.apple.StocksCore (8.5 - 1969) <BEF22BE7-254A-3FA4-B94B-B3312630B6A4> /System/Library/PrivateFrameworks/StocksCore.framework/Versions/A/StocksCore
       0x27e772000 -        0x27e7df3bf  com.apple.StocksKit (1.0 - 1969) <9DAD333C-35B5-33F0-9BEA-EBE440B2369D> /System/Library/PrivateFrameworks/StocksKit.framework/Versions/A/StocksKit
       0x27e7e0000 -        0x27e7ef269  com.apple.StorageContainersPrivate (1.0 - 1) <FC50C8E4-5071-3792-B263-AF47DAFD8D32> /System/Library/PrivateFrameworks/StorageContainersPrivate.framework/Versions/A/StorageContainersPrivate
       0x27ea6f000 -        0x27ea9b4a1  com.apple.security.SwiftASN1Internal (1.0 - 1) <EDCDD822-AA64-3EB9-B0C3-9CEF1A4E0B36> /System/Library/PrivateFrameworks/SwiftASN1Internal.framework/Versions/A/SwiftASN1Internal
       0x27f40f000 -        0x27f41c85f  com.apple.SymptomShared (2169.160.3) <C1706F3F-7AF7-3833-8762-75B6F6AC5F8B> /System/Library/PrivateFrameworks/SymptomShared.framework/Versions/A/SymptomShared
       0x27f41f000 -        0x27f432adf  com.apple.SymptomAnalytics (1.0 - 2169.160.3) <259877CE-4E2C-34A9-A07F-FEE2999D7B2F> /System/Library/PrivateFrameworks/Symptoms.framework/Versions/A/Frameworks/SymptomAnalytics.framework/Versions/A/SymptomAnalytics
       0x27f6d5000 -        0x27f6f999f  com.apple.SymptomPresentationFeed (1.0 - 2169.160.3) <1B99192D-B1C9-3D85-BCD0-EB3CFC6A99C9> /System/Library/PrivateFrameworks/Symptoms.framework/Versions/A/Frameworks/SymptomPresentationFeed.framework/Versions/A/SymptomPresentationFeed
       0x27f6fe000 -        0x27f75a41f  com.apple.Synapse (1.0 - 1) <38BD8D2F-900A-3D8A-AF1A-8502ACFBAD4F> /System/Library/PrivateFrameworks/Synapse.framework/Versions/A/Synapse
       0x27f8dd000 -        0x27f9386df  com.apple.SystemStatus (1.0 - 1) <B3896AF4-2356-37C4-9273-FE994065C56B> /System/Library/PrivateFrameworks/SystemStatus.framework/Versions/A/SystemStatus
       0x27f956000 -        0x27f96a63f  com.apple.SystemWake (1.0 - 732.1.1) <97AC6077-A996-3088-9113-EE396B863CC6> /System/Library/PrivateFrameworks/SystemWake.framework/Versions/A/SystemWake
       0x27fc07000 -        0x27fc08d1f  com.apple.tailspin.TailspinSymbolication (1.0 - 250.2) <6794652C-86F0-37EB-838D-483177685E26> /System/Library/PrivateFrameworks/TailspinSymbolication.framework/Versions/A/TailspinSymbolication
       0x27fc09000 -        0x27fc6b2bf  com.apple.TeaDB (3.0 - 1428) <877F9FC8-C692-368B-A4BF-3C9800FDA9B6> /System/Library/PrivateFrameworks/TeaDB.framework/Versions/A/TeaDB
       0x27fc6c000 -        0x27fe5287f  com.apple.TeaFoundation (3.0 - 1428) <074CA6E5-5E73-3092-8C97-708CE0B64609> /System/Library/PrivateFrameworks/TeaFoundation.framework/Versions/A/TeaFoundation
       0x27fe53000 -        0x27fe7131f  com.apple.TeaSettings (3.0 - 1428) <24E8D5F5-1C28-3A05-9F82-CD15CAA0AE45> /System/Library/PrivateFrameworks/TeaSettings.framework/Versions/A/TeaSettings
       0x280092000 -        0x2801b597f  com.apple.TextAnimationSupport (7.2.1 - 7.2.1) <2191D369-5F2B-3522-9547-3425ECF45ECD> /System/Library/PrivateFrameworks/TextAnimationSupport.framework/Versions/A/TextAnimationSupport
       0x2821ad000 -        0x2821e91df  com.apple.tightbeam (1.0 - 483.100.88) <D817A379-80E9-3A4B-A361-DDEF1B7EFB28> /System/Library/PrivateFrameworks/Tightbeam.framework/Versions/A/Tightbeam
       0x28231f000 -        0x282405b7f  com.apple.TipKitCore (26.6 - 120.5.1) <19BEF9A1-BCB5-3E13-BC7C-CEB741FDA8A7> /System/Library/PrivateFrameworks/TipKitCore.framework/Versions/A/TipKitCore
       0x2826b2000 -        0x2828e917f  com.apple.TokenGeneration (1.0 - 1) <F3D31D3F-74F8-30A6-B49D-1DC743ED35C5> /System/Library/PrivateFrameworks/TokenGeneration.framework/Versions/A/TokenGeneration
       0x2828ea000 -        0x282ab7f3f  com.apple.TokenGenerationCore (1.0 - 1) <3166486F-3F65-31DB-8018-779FFA32DC71> /System/Library/PrivateFrameworks/TokenGenerationCore.framework/Versions/A/TokenGenerationCore
       0x282cc8000 -        0x283204fbf  com.apple.ToolKit (4711) <68C8F9FF-3606-3E92-872C-59B4B3639DFA> /System/Library/PrivateFrameworks/ToolKit.framework/Versions/A/ToolKit
       0x2835ce000 -        0x2835d663f  com.apple.TranslationUIServices (1.0 - 365.14) <626F2403-1633-3B71-92AD-CB27157C1F3E> /System/Library/PrivateFrameworks/TranslationUIServices.framework/Versions/A/TranslationUIServices
       0x2842fb000 -        0x28443151f  com.apple.UIIntelligenceSupport (1.0 - 1) <E4480FEE-65A7-39DF-ACA1-09E7AC6054E9> /System/Library/PrivateFrameworks/UIIntelligenceSupport.framework/Versions/A/UIIntelligenceSupport
       0x28489c000 -        0x28489c539  com.apple.USDLib_FormatLoaderProxy (1.0 - 23.5.2) <0C3D9888-5726-30A5-B58B-E884C52F552A> /System/Library/PrivateFrameworks/USDLib_FormatLoaderProxy.framework/Versions/A/USDLib_FormatLoaderProxy
       0x2849d6000 -        0x284a9b4bf  com.apple.UnifiedAssetFramework (1.0 - 1) <54A2CBB8-623D-3629-904A-D0399ED13547> /System/Library/PrivateFrameworks/UnifiedAssetFramework.framework/Versions/A/UnifiedAssetFramework
       0x285248000 -        0x28524a1ff  com.apple.UpdateCycle (1 - 1) <365E81B9-B9BA-3F4F-83FD-86A35CFBC8AC> /System/Library/PrivateFrameworks/UpdateCycle.framework/Versions/A/UpdateCycle
       0x28555a000 -        0x28555df1f  com.apple.UserSafety (1.0 - 1) <A128411C-776B-310D-AE62-F06B799A8999> /System/Library/PrivateFrameworks/UserSafety.framework/Versions/A/UserSafety
       0x285564000 -        0x28565fbc7  com.apple.VDAF (1.0 - 34.2) <CEF65473-6BC8-364D-B2A4-41C1D7A0646C> /System/Library/PrivateFrameworks/VDAF.framework/Versions/A/VDAF
       0x285660000 -        0x2866ade7f  com.apple.vfx (16.0 - 203.100.3) <BC483EE5-DF5D-3407-B29E-D012E96E4DC4> /System/Library/PrivateFrameworks/VFX.framework/Versions/A/VFX
       0x2866b9000 -        0x286750bff  com.apple.vectordb.VectorSearch (1.0 - 48.3) <127400C7-2565-3B79-A180-7D7FB1C4E4F6> /System/Library/PrivateFrameworks/VectorSearch.framework/Versions/A/VectorSearch
       0x286925000 -        0x2869262cf  com.apple.VideoToolboxParavirtualizationSupport (64.4.7 - 64.4.7) <825E8416-E246-338E-A5CF-AA81A1B01DD9> /System/Library/PrivateFrameworks/VideoToolboxParavirtualizationSupport.framework/Versions/A/VideoToolboxParavirtualizationSupport
       0x28753b000 -        0x28758709f  com.apple.VisionCore (9.5.4 - 9.5.4) <4E70B4ED-C8E0-3636-80E4-0939FE56BB63> /System/Library/PrivateFrameworks/VisionCore.framework/Versions/A/VisionCore
       0x287588000 -        0x28768057f  com.apple.VisionKitCore (1.0 - 3) <EF8858AC-2759-3EAE-9A71-7976D17D57C7> /System/Library/PrivateFrameworks/VisionKitCore.framework/Versions/A/VisionKitCore
       0x288a48000 -        0x288af0b9f  com.apple.wallpaper.framework (1.0 - 245.6) <1820DA03-3BC0-3529-83CE-FA817B111F9E> /System/Library/PrivateFrameworks/Wallpaper.framework/Versions/A/Wallpaper
       0x288bdb000 -        0x288c38c7f  com.apple.wallpaper.foundation.framework (1.0 - 245.6) <4AB813BB-BD7E-3662-8164-11F9515CCC96> /System/Library/PrivateFrameworks/WallpaperFoundation.framework/Versions/A/WallpaperFoundation
       0x288c3a000 -        0x288cb429f  com.apple.wallpaper.types.framework (1.0 - 245.6) <6C6F731C-8BEA-3594-B6AC-29228B08A3A3> /System/Library/PrivateFrameworks/WallpaperTypes.framework/Versions/A/WallpaperTypes
       0x2896f2000 -        0x28999987f  com.apple.WebGPU (21624 - 21624.5.1.11.3) <55539E91-9EA7-3CEB-8D64-4A1BA3D5F91E> /System/Library/PrivateFrameworks/WebGPU.framework/Versions/A/WebGPU
       0x289c9e000 -        0x289cbe1bf  com.apple.WindowManagement (1.0 - 341.6.1) <6ECD36F7-0A2E-3631-A57F-FD0152173454> /System/Library/PrivateFrameworks/WindowManagement.framework/Versions/A/WindowManagement
       0x28aea7000 -        0x28aeab9ff  com.apple.WritingTools (1.0 - 1) <84FB5635-42EE-3BB5-B7CD-8A354AD7DB0A> /System/Library/PrivateFrameworks/WritingTools.framework/Versions/A/WritingTools
       0x28b3ae000 -        0x28b429a7f  com.apple.internal.XPCDistributed (1.0 - 1) <E0EBF3B8-E8A7-3D19-A4F1-B59F59D01868> /System/Library/PrivateFrameworks/XPCDistributed.framework/Versions/A/XPCDistributed
       0x28b493000 -        0x28b49a2ff  com.apple.-AppIntentsServices.-AppIntents (1.0 - 40.5.2) <ABA40CD7-4978-3252-BB46-4FF0710E1355> /System/Library/PrivateFrameworks/_AppIntentsServices_AppIntents.framework/Versions/A/_AppIntentsServices_AppIntents
       0x28b4d3000 -        0x28b4e24df  com.apple.-IconServices-SwiftUI (1.0 - 743.5.2.401) <4E552726-98C4-3516-BDD6-FF430AF4BD7C> /System/Library/PrivateFrameworks/_IconServices_SwiftUI.framework/Versions/A/_IconServices_SwiftUI
       0x28b4e3000 -        0x28b67d9bf  com.apple.-JetEngine-SwiftUI (1.0 - 1) <14F0DF69-E940-3392-B47F-93F6C8B084E1> /System/Library/PrivateFrameworks/_JetEngine_SwiftUI.framework/Versions/A/_JetEngine_SwiftUI
       0x28c0cd000 -        0x28c17703f  com.apple.iCloudQuota (1.0 - 1) <B22181C2-C259-390B-94BA-A85690177D90> /System/Library/PrivateFrameworks/iCloudQuota.framework/Versions/A/iCloudQuota
       0x28c17b000 -        0x28c257ebf  com.apple.iCloudQuotaUI (1.0 - 1) <84C87FF6-8CAB-3D1F-B36B-3304EF90C626> /System/Library/PrivateFrameworks/iCloudQuotaUI.framework/Versions/A/iCloudQuotaUI
       0x28e5a2000 -        0x28e5ebfbf  com.apple.icloudMCCKit (1) <2B14F3B1-AB6A-3BBB-A8D8-A0ABB1712780> /System/Library/PrivateFrameworks/icloudMCCKit.framework/Versions/A/icloudMCCKit
       0x290a7a000 -        0x290a7d89f  com.apple.UIUtilities (9126.6.8) <183FD4D6-D766-34FC-B8E1-7C4D17435AC3> /System/Library/SubFrameworks/UIUtilities.framework/Versions/A/UIUtilities
       0x290b5d000 -        0x290b5fd5f  libAXSafeCategoryBundle.dylib (3191.39) <AED06031-78CB-39A6-B50E-A229BB163B16> /usr/lib/libAXSafeCategoryBundle.dylib
       0x290b9a000 -        0x290c3471f  libAppleArchive.dylib (450.160.2) <9A8926C8-36A6-3DB4-A485-059C1F630984> /usr/lib/libAppleArchive.dylib
       0x290c35000 -        0x290c48f5f  libAppleSSE.dylib (320) <86A18D93-D443-3D0B-AB1D-8131E15E56FD> /usr/lib/libAppleSSE.dylib
       0x290cda000 -        0x290cdba3f  libBASupport.dylib (227.160.8) <F2CE4FE7-B3FB-386D-9430-EF683B30DC18> /usr/lib/libBASupport.dylib
       0x290cef000 -        0x290cf945f  libCoreEntitlements.dylib (80.100.6) <A0DF7E4F-890F-320B-90BF-60CBAC3AFF8B> /usr/lib/libCoreEntitlements.dylib
       0x290d26000 -        0x290e4900f  libDisplayWarpSupport.dylib (191.100.4) <C7EE8998-9CD3-3B9E-909A-CED9EB9838B4> /usr/lib/libDisplayWarpSupport.dylib
       0x290e4a000 -        0x290e545bb  libEndpointSecuritySystem.dylib (589.160.2) <99AE877D-D7C7-3A2B-A2CB-B6C5A494CE5F> /usr/lib/libEndpointSecuritySystem.dylib
       0x290ecd000 -        0x290eced1f  libInterpreterSecurity.dylib (726.160.4) <9CC3D917-3D94-3F03-BBC1-EFA332316378> /usr/lib/libInterpreterSecurity.dylib
       0x290fe5000 -        0x290fec87f  libReverseProxyDevice.dylib (104.120.2) <29367004-5D60-38DB-831F-9E5EE9364B21> /usr/lib/libReverseProxyDevice.dylib
       0x290fed000 -        0x290ff4349  libRosetta.dylib (367.9) <0C7397C6-D747-31F2-8BC1-4096213BDE5C> /usr/lib/libRosetta.dylib
       0x29105a000 -        0x29105a35f  libSpatial.dylib (108) <68B7C15F-537C-3FEF-838B-DC548772A45F> /usr/lib/libSpatial.dylib
       0x29105d000 -        0x2910663ff  libTLE.dylib (80.100.6) <90E600A3-0A27-348A-AA57-D1DF4FB305E8> /usr/lib/libTLE.dylib
       0x291707000 -        0x29170bb00  libchannel.dylib (56.100.3) <AF29D5F2-255D-34E4-AC3C-A25B77759440> /usr/lib/libchannel.dylib
       0x291873000 -        0x291984b17  libcrypto.46.dylib (109.100.2) <46D13DA8-E7BD-37DC-91DD-D5E6CE00C2B8> /usr/lib/libcrypto.46.dylib
       0x291abf000 -        0x291adb762  libhvf.dylib (11) <23C577A8-DB0B-3A0A-9058-1289483C262A> /usr/lib/libhvf.dylib
       0x291f0f000 -        0x291f1728a  libmrc.dylib (2881.160.4) <2B49C295-4EA2-3DE3-90B4-DC03A96F2657> /usr/lib/libmrc.dylib
       0x292367000 -        0x292368007  librealtime_safety.dylib (56.100.3) <7B48EF6C-6A9C-3B90-BF41-DEC1FC85A764> /usr/lib/librealtime_safety.dylib
       0x2923f6000 -        0x29242e527  libssl.48.dylib (109.100.2) <07D5F4C6-1A13-344C-882B-0B0A08048DE5> /usr/lib/libssl.48.dylib
       0x292469000 -        0x29249736f  libswiftPrespecialized.dylib (0) <9E3C7597-446F-3C50-9930-2425D9252C0C> /usr/lib/libswiftPrespecialized.dylib
       0x29270e000 -        0x29272d219  libswiftAppleArchive.dylib (450.160.2) <4F93B2BF-0022-39A6-8540-D6C2B8CD6D94> /usr/lib/swift/libswiftAppleArchive.dylib
       0x29272e000 -        0x292731e7f  libswiftCoreMediaIO.dylib (5617.100.5) <1CC8AEF7-F92C-3B70-86D8-C7D6B36871B8> /usr/lib/swift/libswiftCoreMediaIO.dylib
       0x292733000 -        0x292745043  libswiftDistributed.dylib (6.3.2 - 6.3.2.1.11) <2EDB2E62-942F-3AB5-82AF-8E1328544E17> /usr/lib/swift/libswiftDistributed.dylib
       0x292749000 -        0x292749edb  libswiftGLKit.dylib (1.1) <E2550B90-D9BD-31DD-B1DC-89648B664334> /usr/lib/swift/libswiftGLKit.dylib
       0x29274d000 -        0x29275431f  libswiftMLCompute.dylib (84) <F0F78040-E52B-3D87-8DC0-10C14F153D31> /usr/lib/swift/libswiftMLCompute.dylib
       0x292755000 -        0x2927562df  libswiftMetalKit.dylib (1.2) <B7211CA6-0E8B-3D9E-8227-A548414D6834> /usr/lib/swift/libswiftMetalKit.dylib
       0x292757000 -        0x29275a45f  libswiftModelIO.dylib (1) <6E809A71-7C41-3477-8E4E-841F8C0A1F4D> /usr/lib/swift/libswiftModelIO.dylib
       0x29275c000 -        0x29276bebc  libswiftObservation.dylib (6.3.2 - 6.3.2.1.11) <CD141C3F-F1A3-3AD8-B190-0A78FB3BB4E5> /usr/lib/swift/libswiftObservation.dylib
       0x29276d000 -        0x2927756df  libswiftPassKit.dylib (1642.7.4) <C2556A71-91FC-3562-A175-9EA41DE6023A> /usr/lib/swift/libswiftPassKit.dylib
       0x29277b000 -        0x292787817  libswiftRegexBuilder.dylib (6.3.2 - 6.3.2.1.11) <82D79BDA-26A0-3A44-AAC8-911411801FDE> /usr/lib/swift/libswiftRegexBuilder.dylib
       0x29281a000 -        0x29281d13f  libswiftSceneKit.dylib (1.2) <222DC99B-8FB0-3AF1-819B-9414C3E388CA> /usr/lib/swift/libswiftSceneKit.dylib
       0x29281e000 -        0x29289472f  libswiftSpatial.dylib (108) <713AEF7A-43B6-3735-8AB5-361F5EE06BBA> /usr/lib/swift/libswiftSpatial.dylib
       0x292898000 -        0x2928ab8ef  libswiftSynchronization.dylib (6.3.2 - 6.3.2.1.11) <FDFD191A-CA23-3D4A-9875-C7748238830A> /usr/lib/swift/libswiftSynchronization.dylib
       0x2928ac000 -        0x2928c4e60  libswiftSystem.dylib (75) <7CD9BDE7-F36B-3471-9295-38E181D6D9E5> /usr/lib/swift/libswiftSystem.dylib
       0x2928c6000 -        0x2928dc79f  libswiftVideoToolbox.dylib (3330.13.2) <9247A5B6-A883-3A07-BEE7-A223840317A4> /usr/lib/swift/libswiftVideoToolbox.dylib
       0x2928de000 -        0x2928de669  libswift_Builtin_float.dylib (6.3.2.1.11) <52F59382-A6A6-3F55-8A85-D9FB822D370F> /usr/lib/swift/libswift_Builtin_float.dylib
       0x2928df000 -        0x29296a095  libswift_Concurrency.dylib (6.3.2 - 6.3.2.1.11) <8E168857-47F4-349F-A718-A18DB144FCB0> /usr/lib/swift/libswift_Concurrency.dylib
       0x29296b000 -        0x29296df83  libswift_DarwinFoundation1.dylib (377.160.5) <85246B9A-A757-3F67-B792-3A2F7BB2BB25> /usr/lib/swift/libswift_DarwinFoundation1.dylib
       0x29296e000 -        0x29296eeeb  libswift_DarwinFoundation2.dylib (377.160.5) <AF5AF4DC-D24A-3073-BD23-4CEAD8C3AEE4> /usr/lib/swift/libswift_DarwinFoundation2.dylib
       0x29296f000 -        0x29296f7a7  libswift_DarwinFoundation3.dylib (377.160.5) <8D2C31B5-FB10-3BF6-8566-F0DCD56C8582> /usr/lib/swift/libswift_DarwinFoundation3.dylib
       0x292970000 -        0x292a0e49f  libswift_RegexParser.dylib (6.3.2 - 6.3.2.1.11) <7B63C2BF-8C7C-3ECA-ACD9-F1B75DBE018C> /usr/lib/swift/libswift_RegexParser.dylib
       0x292a0f000 -        0x292a9b0cd  libswift_StringProcessing.dylib (6.3.2 - 6.3.2.1.11) <8DF0116D-DFC9-3906-9DF6-F1DBC47E324B> /usr/lib/swift/libswift_StringProcessing.dylib
       0x292a9f000 -        0x292a9f3cb  libswift_errno.dylib (377.160.5) <5527F412-D0AB-3DD2-A3CC-F280ED578225> /usr/lib/swift/libswift_errno.dylib
       0x292aa4000 -        0x292aa43d3  libswiftsys_time.dylib (377.160.5) <4B5C0268-23EB-3E20-8F57-CDECFB6E3205> /usr/lib/swift/libswiftsys_time.dylib
       0x292c00000 -        0x292c03a4b  libsystem_darwindirectory.dylib (122) <971A4F65-493D-39F3-846D-0D33FA2769FD> /usr/lib/system/libsystem_darwindirectory.dylib
       0x292c04000 -        0x292c0e39b  libsystem_eligibility.dylib (319.160.17) <750CA446-92EA-3A56-9A7B-CC0841686C50> /usr/lib/system/libsystem_eligibility.dylib
       0x292c0f000 -        0x292c1688b  libsystem_sanitizers.dylib (26.1) <D88EC709-9AA8-3083-B22B-D3CB39678D71> /usr/lib/system/libsystem_sanitizers.dylib
       0x292c17000 -        0x292c17bb7  libsystem_trial.dylib (474.2.18.2) <7194FF5B-A6C5-3D67-B00A-90209F10D603> /usr/lib/system/libsystem_trial.dylib
       0x292c4b000 -        0x292c9f6df  libAppleTconUARPUpdater.dylib (1345.160.8.0.1) <5FFA6778-0A2F-3AC7-8AFB-81C0E748BA9F> /usr/lib/updaters/libAppleTconUARPUpdater.dylib
       0x292de0000 -        0x292df79e7  libT200Updater.dylib (1.0.0.7.66) <1F0C0C4C-EC16-302D-93B5-F45249FCE76B> /usr/lib/updaters/libT200Updater.dylib
       0x292df8000 -        0x294b83a5f  libusd_ms.dylib (23.5.3) <DFC11B09-A62B-3E98-9331-7312954A5E6A> /usr/lib/usd/libusd_ms.dylib
````

### vq-parallel-cpu-sample-v1/native/receipt.json

Original bytes: 21489. SHA-256: `14d0952ba14b152b552ef84e7078d38f44a1ed727175acc0c42acc2c6f820f3d`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 48625,
    "hits" : 18790,
    "loads" : 49233,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 608
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "evictions" : 6455,
    "hits" : 0,
    "loads" : 7063,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 608
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 0,
    "total_capacity" : 608
  },
  "committed_decode_tokens_per_second" : 3.9044145066651228,
  "committed_tokens" : 128,
  "emission_seconds" : [
    3.4618337920110207,
    4.1008780419942923,
    4.3664636249886826,
    4.6271682920050807,
    4.8765390420157928,
    5.1285307079961058,
    5.3804684169881511,
    5.6377317500009667,
    5.8870273329957854,
    6.142854083009297,
    6.3876322919968516,
    6.638080708013149,
    6.8781779170094524,
    7.1151632080145646,
    7.3469324999896344,
    7.6059794579923619,
    7.8630895419919398,
    8.0917213750071824,
    8.3403389170125592,
    8.5835052079928573,
    8.8314046669984236,
    9.0823446249996778,
    9.3267258330015466,
    9.5673416669887956,
    9.8257910000102129,
    10.077125208015786,
    10.319525750004686,
    10.570668458007276,
    10.816673875000561,
    11.085125250014244,
    11.340685292001581,
    11.588355791987851,
    11.844331208005315,
    12.082133499992779,
    12.31805699999677,
    12.554322208015947,
    12.793020625016652,
    13.012598625005921,
    13.232046749995789,
    13.462395042006392,
    13.708854583004722,
    13.960578583006281,
    14.204697667009896,
    14.449115875002462,
    14.709200500015868,
    14.963775917014573,
    15.202328916988336,
    15.444844000012381,
    15.695987499988405,
    15.942244208010379,
    18.398697833006736,
    18.720019583008252,
    18.964035874989349,
    19.206241832987871,
    19.463554374990053,
    19.704451166995568,
    19.918911832995946,
    20.171092667005723,
    20.418914333014982,
    20.67236770800082,
    20.911802832997637,
    21.144484207994537,
    21.394753125001444,
    21.634435582993319,
    21.867941333010094,
    22.096848707995377,
    22.306241500016768,
    22.541890833002981,
    22.764638458000263,
    23.003183958004229,
    23.222971792012686,
    23.437047792016529,
    23.6525567919889,
    23.896943917003227,
    24.128697625012137,
    24.367634916998213,
    24.595530124992365,
    24.835414708009921,
    25.053171542007476,
    25.284088624990545,
    25.519855749997078,
    25.740589708002517,
    25.964256500010379,
    26.21629350000876,
    26.422925958002452,
    26.636775041988585,
    26.882291874993825,
    27.111983000009786,
    27.35693216699292,
    27.59711783300736,
    27.830546542012598,
    28.059645458008163,
    28.286783832998481,
    28.520640833012294,
    28.760054332989966,
    28.986729500000365,
    29.221501124993665,
    29.432280458015157,
    29.663433667010395,
    29.876280833006604,
    30.097716416988987,
    30.313287291995948,
    30.505719042004785,
    30.718708958011121,
    30.942810583015671,
    31.158873875014251,
    31.373989707994042,
    31.572084292012732,
    31.781574833003106,
    31.983047042012913,
    32.205284833005862,
    32.422886791988276,
    32.653444750001654,
    32.898177583003417,
    33.130369457998313,
    33.336217792006209,
    33.571156624995638,
    33.805224042007467,
    34.009791457996471,
    34.240119624999352,
    34.445393041998614,
    34.670017917000223,
    34.894634917000076,
    35.091723042016383,
    35.305615999997826,
    35.529227166989585,
    35.776064833014971,
    35.989117916993564
  ],
  "generated" : [
    760,
    1156,
    6587,
    264,
    10597,
    15673,
    314,
    1204,
    264,
    2136,
    20340,
    8404,
    17830,
    15089,
    318,
    24797,
    36,
    8,
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
    2302,
    1318,
    1330,
    2716,
    41228,
    13,
    2302,
    1048,
    1318,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    318,
    1719,
    2702,
    1558,
    1331,
    593,
    30744,
    6966,
    8,
    18468,
    328,
    3127,
    23014,
    1,
    318,
    12195,
    579,
    3404,
    303,
    21360,
    506,
    866,
    2574,
    4299,
    553,
    271,
    9764,
    728,
    1683,
    883,
    411,
    15060,
    25,
    271,
    24797,
    36,
    3983,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    599,
    1599,
    6009,
    28964,
    45,
    9714,
    694,
    1132,
    19660,
    264,
    2526,
    25162,
    791,
    3817,
    13,
    1061,
    947,
    68476,
    369,
    279,
    1328,
    644,
    88797,
    364,
    35160,
    16350,
    13,
    271,
    1178,
    35,
    16350
  ],
  "initial_vm" : {
    "reclaimableBytes" : 23144972288,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.63904424998327158,
    0.26558558299439028,
    0.26070466701639816,
    0.24937075001071207,
    0.25199166598031297,
    0.25193770899204537,
    0.25726333301281556,
    0.24929558299481869,
    0.25582675001351163,
    0.24477820898755454,
    0.25044841601629741,
    0.24009720899630338,
    0.23698529100511223,
    0.23176929197506979,
    0.25904695800272748,
    0.25711008399957791,
    0.22863183301524259,
    0.24861754200537689,
    0.24316629098029807,
    0.24789945900556631,
    0.25093995800125413,
    0.2443812080018688,
    0.24061583398724906,
    0.25844933302141726,
    0.2513342080055736,
    0.24240054198889993,
    0.25114270800258964,
    0.2460054169932846,
    0.26845137501368299,
    0.25556004198733717,
    0.24767049998627044,
    0.25597541601746343,
    0.23780229198746383,
    0.23592350000399165,
    0.2362652080191765,
    0.23869841700070538,
    0.2195779999892693,
    0.21944812498986721,
    0.23034829201060347,
    0.24645954099833034,
    0.25172400000155903,
    0.24411908400361426,
    0.24441820799256675,
    0.26008462501340546,
    0.2545754169987049,
    0.23855299997376278,
    0.24251508302404545,
    0.25114349997602403,
    0.24625670802197419,
    2.4564536249963567,
    0.32132175000151619,
    0.24401629198109731,
    0.24220595799852163,
    0.25731254200218245,
    0.24089679200551473,
    0.21446066600037739,
    0.25218083400977775,
    0.24782166600925848,
    0.25345337498583831,
    0.23943512499681674,
    0.23268137499690056,
    0.25026891700690612,
    0.23968245799187571,
    0.23350575001677498,
    0.22890737498528324,
    0.20939279202139005,
    0.23564933298621327,
    0.2227476249972824,
    0.23854550000396557,
    0.21978783400845714,
    0.21407600000384264,
    0.21550899997237138,
    0.24438712501432747,
    0.2317537080089096,
    0.23893729198607616,
    0.22789520799415186,
    0.239884583017556,
    0.21775683399755508,
    0.23091708298306912,
    0.2357671250065323,
    0.22073395800543949,
    0.22366679200786166,
    0.25203699999838136,
    0.20663245799369179,
    0.21384908398613334,
    0.24551683300524019,
    0.22969112501596101,
    0.24494916698313318,
    0.24018566601444036,
    0.23342870900523849,
    0.22909891599556431,
    0.22713837499031797,
    0.23385700001381338,
    0.23941349997767247,
    0.22667516701039858,
    0.23477162499330007,
    0.21077933302149177,
    0.23115320899523795,
    0.21284716599620879,
    0.22143558398238383,
    0.2155708750069607,
    0.19243175000883639,
    0.21298991600633599,
    0.22410162500455044,
    0.2160632919985801,
    0.21511583297979087,
    0.19809458401869051,
    0.20949054099037312,
    0.20147220900980756,
    0.22223779099294916,
    0.21760195898241363,
    0.23055795801337808,
    0.24473283300176263,
    0.23219187499489635,
    0.20584833400789648,
    0.23493883298942819,
    0.23406741701182909,
    0.20456741598900408,
    0.23032816700288095,
    0.20527341699926183,
    0.22462487500160933,
    0.22461699999985285,
    0.19708812501630746,
    0.21389295798144303,
    0.22361116699175909,
    0.24683766602538526,
    0.21305308397859335
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 28.988496625010157,
  "metadata_seconds" : 0.11182016698876396,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "pack" : "3.2",
  "passed" : true,
  "peak_mlx_bytes" : 6782306844,
  "peak_process_bytes" : 8017795240,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 35.989146333013196,
  "request_vm_after" : {
    "reclaimableBytes" : 17844912128,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 20798455808,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 635699200,
    "payload_bytes" : 5318309400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.4618337920110207,
  "validation_receipt_sha256" : "5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-performance-ci-progress-v1.json

Original bytes: 860. SHA-256: `58d3952ab59bfb1a8266d52e45b532b5949ed5c617614a2456ad2348aed639a1`.

````text
[{"conclusion":"success","databaseId":37108438601,"headSha":"9d5639a546c1e2bf7fda52865a52c6b71e0d7537","name":"docs","status":"completed","url":"https://github.com/carloslfu/slotstream/actions/runs/37108438601"},{"conclusion":"success","databaseId":37108438610,"headSha":"9d5639a546c1e2bf7fda52865a52c6b71e0d7537","name":"context-proxies","status":"completed","url":"https://github.com/carloslfu/slotstream/actions/runs/37108438610"},{"conclusion":"success","databaseId":37108438619,"headSha":"9d5639a546c1e2bf7fda52865a52c6b71e0d7537","name":"sevra-mac","status":"completed","url":"https://github.com/carloslfu/slotstream/actions/runs/37108438619"},{"conclusion":"success","databaseId":37108438642,"headSha":"9d5639a546c1e2bf7fda52865a52c6b71e0d7537","name":"ci","status":"completed","url":"https://github.com/carloslfu/slotstream/actions/runs/37108438642"}]
````

### vq-parallel-cpu-sample-v1/supervision/identity.json

Original bytes: 2901. SHA-256: `13ec4f18d65483c6dff3a88edbc47a70e137446d99e3b3dbd2c605b04080b6ab`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-parallel-read-v2/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/bench/quantization/performance-pilot-v2.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-parallel-cpu-sample-v1/native",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-parallel/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23263805440,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   433240.\nPages active:                                 918978.\nPages inactive:                               913331.\nPages speculative:                              7653.\nPages throttled:                                   0.\nPages wired down:                             181688.\nPages purgeable:                                7066.\n\"Translation faults\":                     1509860659.\nPages copy-on-write:                        78453842.\nPages zero filled:                        2401219954.\nPages reactivated:                          97065962.\nPages purged:                               11312467.\nFile-backed pages:                            979604.\nAnonymous pages:                              860358.\nPages stored in compressor:                  1173021.\nPages occupied by compressor:                 630068.\nDecompressions:                             47699376.\nCompressions:                               58334167.\nPageins:                                  1157039711.\nPageouts:                                     374812.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 133373.\nPages tagged resident:                         90949.\nPages tagged compressed:                       42424.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5279.\nPages tag-storage free:                          528.\nPages tag-storage non-tag pageable:            92489.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6447040.\nTagged compressions:                          504628.\nTagged decompressions:                        411016.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-parallel-cpu-sample-v1/supervision/receipt.json

Original bytes: 2140. SHA-256: `7631694d68c8b9fb420628c6de36e42a5b5d08c712d29fd13e8eac858094e7bb`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 8017795240,
  "samples": 1116,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24818122752,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   483562.\nPages active:                                 850235.\nPages inactive:                               837013.\nPages speculative:                             63802.\nPages throttled:                                   0.\nPages wired down:                             170843.\nPages purgeable:                                6906.\n\"Translation faults\":                     1511165427.\nPages copy-on-write:                        78514435.\nPages zero filled:                        2405442384.\nPages reactivated:                          97269458.\nPages purged:                               11320974.\nFile-backed pages:                           1024310.\nAnonymous pages:                              726740.\nPages stored in compressor:                  1256244.\nPages occupied by compressor:                 677818.\nDecompressions:                             48222794.\nCompressions:                               58969005.\nPageins:                                  1162446613.\nPageouts:                                     375188.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 130927.\nPages tagged resident:                         85692.\nPages tagged compressed:                       45235.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5253.\nPages tag-storage free:                         2270.\nPages tag-storage non-tag pageable:            90773.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6954688.\nTagged compressions:                          508167.\nTagged decompressions:                        411742.\n"
  },
  "seconds": 65.25069854201865
}
````

### vq-parallel-cpu-sample-v1/supervision/stdout.txt

Original bytes: 21490. SHA-256: `6d9867ed96229bad06b148cee76313ba0b3c8f9bfefd0f9e95c1a335e6edd16e`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 48625,
    "hits" : 18790,
    "loads" : 49233,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 608
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "evictions" : 6455,
    "hits" : 0,
    "loads" : 7063,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 608
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 0,
    "total_capacity" : 608
  },
  "committed_decode_tokens_per_second" : 3.9044145066651228,
  "committed_tokens" : 128,
  "emission_seconds" : [
    3.4618337920110207,
    4.1008780419942923,
    4.3664636249886826,
    4.6271682920050807,
    4.8765390420157928,
    5.1285307079961058,
    5.3804684169881511,
    5.6377317500009667,
    5.8870273329957854,
    6.142854083009297,
    6.3876322919968516,
    6.638080708013149,
    6.8781779170094524,
    7.1151632080145646,
    7.3469324999896344,
    7.6059794579923619,
    7.8630895419919398,
    8.0917213750071824,
    8.3403389170125592,
    8.5835052079928573,
    8.8314046669984236,
    9.0823446249996778,
    9.3267258330015466,
    9.5673416669887956,
    9.8257910000102129,
    10.077125208015786,
    10.319525750004686,
    10.570668458007276,
    10.816673875000561,
    11.085125250014244,
    11.340685292001581,
    11.588355791987851,
    11.844331208005315,
    12.082133499992779,
    12.31805699999677,
    12.554322208015947,
    12.793020625016652,
    13.012598625005921,
    13.232046749995789,
    13.462395042006392,
    13.708854583004722,
    13.960578583006281,
    14.204697667009896,
    14.449115875002462,
    14.709200500015868,
    14.963775917014573,
    15.202328916988336,
    15.444844000012381,
    15.695987499988405,
    15.942244208010379,
    18.398697833006736,
    18.720019583008252,
    18.964035874989349,
    19.206241832987871,
    19.463554374990053,
    19.704451166995568,
    19.918911832995946,
    20.171092667005723,
    20.418914333014982,
    20.67236770800082,
    20.911802832997637,
    21.144484207994537,
    21.394753125001444,
    21.634435582993319,
    21.867941333010094,
    22.096848707995377,
    22.306241500016768,
    22.541890833002981,
    22.764638458000263,
    23.003183958004229,
    23.222971792012686,
    23.437047792016529,
    23.6525567919889,
    23.896943917003227,
    24.128697625012137,
    24.367634916998213,
    24.595530124992365,
    24.835414708009921,
    25.053171542007476,
    25.284088624990545,
    25.519855749997078,
    25.740589708002517,
    25.964256500010379,
    26.21629350000876,
    26.422925958002452,
    26.636775041988585,
    26.882291874993825,
    27.111983000009786,
    27.35693216699292,
    27.59711783300736,
    27.830546542012598,
    28.059645458008163,
    28.286783832998481,
    28.520640833012294,
    28.760054332989966,
    28.986729500000365,
    29.221501124993665,
    29.432280458015157,
    29.663433667010395,
    29.876280833006604,
    30.097716416988987,
    30.313287291995948,
    30.505719042004785,
    30.718708958011121,
    30.942810583015671,
    31.158873875014251,
    31.373989707994042,
    31.572084292012732,
    31.781574833003106,
    31.983047042012913,
    32.205284833005862,
    32.422886791988276,
    32.653444750001654,
    32.898177583003417,
    33.130369457998313,
    33.336217792006209,
    33.571156624995638,
    33.805224042007467,
    34.009791457996471,
    34.240119624999352,
    34.445393041998614,
    34.670017917000223,
    34.894634917000076,
    35.091723042016383,
    35.305615999997826,
    35.529227166989585,
    35.776064833014971,
    35.989117916993564
  ],
  "generated" : [
    760,
    1156,
    6587,
    264,
    10597,
    15673,
    314,
    1204,
    264,
    2136,
    20340,
    8404,
    17830,
    15089,
    318,
    24797,
    36,
    8,
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
    2302,
    1318,
    1330,
    2716,
    41228,
    13,
    2302,
    1048,
    1318,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    318,
    1719,
    2702,
    1558,
    1331,
    593,
    30744,
    6966,
    8,
    18468,
    328,
    3127,
    23014,
    1,
    318,
    12195,
    579,
    3404,
    303,
    21360,
    506,
    866,
    2574,
    4299,
    553,
    271,
    9764,
    728,
    1683,
    883,
    411,
    15060,
    25,
    271,
    24797,
    36,
    3983,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    599,
    1599,
    6009,
    28964,
    45,
    9714,
    694,
    1132,
    19660,
    264,
    2526,
    25162,
    791,
    3817,
    13,
    1061,
    947,
    68476,
    369,
    279,
    1328,
    644,
    88797,
    364,
    35160,
    16350,
    13,
    271,
    1178,
    35,
    16350
  ],
  "initial_vm" : {
    "reclaimableBytes" : 23144972288,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.63904424998327158,
    0.26558558299439028,
    0.26070466701639816,
    0.24937075001071207,
    0.25199166598031297,
    0.25193770899204537,
    0.25726333301281556,
    0.24929558299481869,
    0.25582675001351163,
    0.24477820898755454,
    0.25044841601629741,
    0.24009720899630338,
    0.23698529100511223,
    0.23176929197506979,
    0.25904695800272748,
    0.25711008399957791,
    0.22863183301524259,
    0.24861754200537689,
    0.24316629098029807,
    0.24789945900556631,
    0.25093995800125413,
    0.2443812080018688,
    0.24061583398724906,
    0.25844933302141726,
    0.2513342080055736,
    0.24240054198889993,
    0.25114270800258964,
    0.2460054169932846,
    0.26845137501368299,
    0.25556004198733717,
    0.24767049998627044,
    0.25597541601746343,
    0.23780229198746383,
    0.23592350000399165,
    0.2362652080191765,
    0.23869841700070538,
    0.2195779999892693,
    0.21944812498986721,
    0.23034829201060347,
    0.24645954099833034,
    0.25172400000155903,
    0.24411908400361426,
    0.24441820799256675,
    0.26008462501340546,
    0.2545754169987049,
    0.23855299997376278,
    0.24251508302404545,
    0.25114349997602403,
    0.24625670802197419,
    2.4564536249963567,
    0.32132175000151619,
    0.24401629198109731,
    0.24220595799852163,
    0.25731254200218245,
    0.24089679200551473,
    0.21446066600037739,
    0.25218083400977775,
    0.24782166600925848,
    0.25345337498583831,
    0.23943512499681674,
    0.23268137499690056,
    0.25026891700690612,
    0.23968245799187571,
    0.23350575001677498,
    0.22890737498528324,
    0.20939279202139005,
    0.23564933298621327,
    0.2227476249972824,
    0.23854550000396557,
    0.21978783400845714,
    0.21407600000384264,
    0.21550899997237138,
    0.24438712501432747,
    0.2317537080089096,
    0.23893729198607616,
    0.22789520799415186,
    0.239884583017556,
    0.21775683399755508,
    0.23091708298306912,
    0.2357671250065323,
    0.22073395800543949,
    0.22366679200786166,
    0.25203699999838136,
    0.20663245799369179,
    0.21384908398613334,
    0.24551683300524019,
    0.22969112501596101,
    0.24494916698313318,
    0.24018566601444036,
    0.23342870900523849,
    0.22909891599556431,
    0.22713837499031797,
    0.23385700001381338,
    0.23941349997767247,
    0.22667516701039858,
    0.23477162499330007,
    0.21077933302149177,
    0.23115320899523795,
    0.21284716599620879,
    0.22143558398238383,
    0.2155708750069607,
    0.19243175000883639,
    0.21298991600633599,
    0.22410162500455044,
    0.2160632919985801,
    0.21511583297979087,
    0.19809458401869051,
    0.20949054099037312,
    0.20147220900980756,
    0.22223779099294916,
    0.21760195898241363,
    0.23055795801337808,
    0.24473283300176263,
    0.23219187499489635,
    0.20584833400789648,
    0.23493883298942819,
    0.23406741701182909,
    0.20456741598900408,
    0.23032816700288095,
    0.20527341699926183,
    0.22462487500160933,
    0.22461699999985285,
    0.19708812501630746,
    0.21389295798144303,
    0.22361116699175909,
    0.24683766602538526,
    0.21305308397859335
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 28.988496625010157,
  "metadata_seconds" : 0.11182016698876396,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "pack" : "3.2",
  "passed" : true,
  "peak_mlx_bytes" : 6782306844,
  "peak_process_bytes" : 8017795240,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 35.989146333013196,
  "request_vm_after" : {
    "reclaimableBytes" : 17844912128,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 20798455808,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 635699200,
    "payload_bytes" : 5318309400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.4618337920110207,
  "validation_receipt_sha256" : "5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-parallel-cpu-sample-v1/supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### frozen-parallel-read-v2/build-identity.json

Original bytes: 31102. SHA-256: `b2fad17c3eeab8f99c3f592fa9a12e6fe1e4c83169a2c7f7bf540f9c888c4f71`.

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
    "Sources/Slotstream/VQCheckpoint.swift": "26659ecf3437a158d1c78bf19a690dea9563584ec0871c278c28884d777816cc",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQExpert.swift": "05803a22ef7578d584a61f5319ce132f03917f16355c7f87772ecc8f03d0b606",
    "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
    "Sources/Slotstream/VQModelProbe.swift": "6cbb3449d08af13a1a444d3320d58f901272af9b1a95d8bd335900c63b395500",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
    "Sources/Slotstream/VQRecord.swift": "51cfa0e87789742e06383cca422ab85656ec0f3cfe3fed2660b99115bbd33a70",
    "Sources/Slotstream/VQRecordBank.swift": "e73d822499fb5f88379794dc012cae461f279adb761879795da196d8b64983a6",
    "Sources/Slotstream/VQRecordCache.swift": "d6126ea0c2c37c90eaeb6601dbd064d400288e6cb8a32339e2400aa17900b4cc",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQArithmetic.swift": "defd0b98fc8730c9c146000036bf9436c06c5480d356a4f8ce9722091b1e1408",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQBank.swift": "01911150249e70d8dddb155884f105b7bcf8fa4902c97b3f7bc14064900e1f5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "7c6cb33d8910b95b6800232276796f514b58bd10172106b692abe05cecf303aa",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "8376a3a59bf56e3c71b550beedf5b5d6cc54141b5353ca5ace1449079c3f01c6",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "51c0213c8589bd50c6ebe19ee0d56c4b6431d746df1432bc2c5bc17b09d21ea0",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "6e62e89fed0c1d046e5c642dfed7433c133cc6d3a9f0d8b2642ffde40c779448",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQReadBatch.swift": "676209813620c2aaf7992bf03bd1fa6f108a9898ebd0e9cb4ab863afbf7fedc1",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "91b0855764358ceb8e59b1ea5bac0b17a729fcb8c3834487cf0c4ffcaa6f441b",
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
  "source_archive_sha256": "f232d15c7fd904c317793e650bcfdf385d6e504a31b9fd704dbd1ca57ead686e",
  "binary_sha256": "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````
