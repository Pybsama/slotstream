---
type: run
created: 2026-10-03T10:54:20.219204+00:00
updated: 2026-10-03T10:54:20.219204+00:00
summary: VQ allocator CPU profile and dense four-bit overlay hypothesis
binary: 2f7020b03c17dbc7ab3de52018af2ee96445a9445c094356ef3037c5dc946a1a
captured_at: 2026-10-03
command: Exact sequential commands are preserved in the driver and supervision identities below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: VQ allocator CPU profile and dense four-bit overlay hypothesis
tool: bounded VQ research diagnostics
---

One extra owned process is sampled for ten seconds after its load. Every timing value from this instrumented run is excluded, regardless of the native eligibility flag. The observer rechecks the exact parent and executable before attachment and joins before exit. All sampled main-thread stacks are inside the generation loop. Of 5,790 main-thread samples, 1,620 are in the demanded-record read subtree, 1,128 in bank output evaluation and 1,265 in route evaluation. PLE has a much smaller 107-sample block. These nested counts are attribution, not independent process-wide percentages or exact elapsed-time fractions. Memory supervision passes; global paging is unchanged.

A separate header-only feasibility audit identifies 498 candidate dense modules whose three packed arrays can map to the installed same-checkpoint four-bit group-64 representation. Together their stored payload could fall from 5,152,768,000 to 2,727,936,000 bytes, recovering 2,424,832,000 bytes. The corresponding resident payload arithmetic is 2,893,477,400 bytes. These are header-derived storage sums, not authenticated replacement payloads, process-memory measurements or demonstrated speed. Preserve the VQ routed experts, n-gram tables, normalization and unmatched tensors. A composite must get a new identity, full hashes, independent traversal proof and new quality measurements before any native integration.

The first audit incorrectly matched canonical keys directly to the baseline's language_model-prefixed index and found zero matches. Both that failed instrument and its corrected explicit prefix mapping are preserved. The correction does not remove a candidate failure. No model forward or artifact activation occurred in either header audit. The hypothesis remains unproven.

Local home prefixes are replaced with <HOME>. Original byte lengths and hashes identify the unmodified local files. For large transcripts, the normalized UTF-8 bytes are stored losslessly as zlib-compressed base64 inside this Markdown source. Decode with `zlib.decompress(base64.b64decode(block))` and verify the listed normalized byte length and SHA-256. Every encoded block was round-trip checked before writing. This changes storage only, not the captured evidence. Small transcripts remain plain text. Raw tensor fixtures and source-bound executables remain in the bounded research directory; manifests bind their hashes. No model is installed or activated.

### vq-allocator-cpu-sample-v1.py

Original bytes: 2836. SHA-256: `aae9a3aefc032224e219f5eb81be81fac98910f4bdb18f9f340907b3289accee`.

Normalized bytes: 2836. SHA-256: `aae9a3aefc032224e219f5eb81be81fac98910f4bdb18f9f340907b3289accee`.

````text
from pathlib import Path
import sys,json,threading,subprocess,time,os
sys.path.insert(0,'Tools')
from quantization_logit_run import supervise,digest
r=Path('.build/quantization-research').resolve();f=r/'frozen-allocator-reuse-v1';out=r/'vq-allocator-cpu-sample-v1';out.mkdir()
profile=Path('bench/quantization/performance-pilot-v2.json').resolve();validation=r/'vq-allocator-pair-v1/validation-after/receipt.json'
cmd=[str(f/'slotstream'),'quantization-performance-pilot','--source-directory',str(r/'candidate-3.2'),'--source-inventory',str(r/'inventory-3.2/inventory.json'),'--profile',str(profile),'--output',str(out/'native'),'--measure','--validation-receipt',str(validation)]
protocol={'scope':'CPU stack diagnosis only; all timing discarded because sampling perturbs execution','extra_model_runs':1,'pack':'3.2','maximum_process_bytes':10000000000,'minimum_reclaimable_bytes':13000000000,'run_seconds':1800,'sampling_seconds':10,'sample_interval_ms':1,'sampling_delay_seconds':37,'binary_sha256':digest(f/'slotstream'),'metallib_sha256':digest(f/'mlx.metallib'),'profile_sha256':digest(profile),'command':cmd}
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
  if found and time.monotonic()-found[1]>=37:
   # Recheck exact direct-child identity immediately before attaching.
   parent=subprocess.check_output(['ps','-p',str(found[0]),'-o','ppid=,comm='],text=True).strip().split(None,1)
   if parent != [str(os.getpid()),str(f/'slotstream')]:
    observations.append({'failure':'owned child identity changed before sampling'});return
   command=['/usr/bin/sample',str(found[0]),'10','1','-file',str(out/'sample.txt')]
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

### vq-allocator-cpu-sample-v1.log

Original bytes: 2219. SHA-256: `ae0a242a2c8d5f28590677b69046354807b1815a30231d715962000257fdebb6`.

Normalized bytes: 2219. SHA-256: `ae0a242a2c8d5f28590677b69046354807b1815a30231d715962000257fdebb6`.

````text
{"complete": true, "discarded_timing": true, "reason": "CPU sample observer", "sample_exists": true, "supervision": {"exit_code": 0, "failure": null, "sampled_peak_bytes": 8117639456, "samples": 1018, "after": {"page_bytes": 16384, "reclaimable_bytes": 24869322752, "swapins": 16, "swapouts": 2904, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   490785.\nPages active:                                 809361.\nPages inactive:                               794157.\nPages speculative:                             68316.\nPages throttled:                                   0.\nPages wired down:                             184829.\nPages purgeable:                                 391.\n\"Translation faults\":                     1681416979.\nPages copy-on-write:                        86193739.\nPages zero filled:                        2613831928.\nPages reactivated:                          99940616.\nPages purged:                               11597126.\nFile-backed pages:                           1026727.\nAnonymous pages:                              645107.\nPages stored in compressor:                  1348035.\nPages occupied by compressor:                 736282.\nDecompressions:                             72788496.\nCompressions:                               84291945.\nPageins:                                  1462605846.\nPageouts:                                     405232.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 132889.\nPages tagged resident:                         89904.\nPages tagged compressed:                       42985.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5220.\nPages tag-storage free:                         1803.\nPages tag-storage non-tag pageable:            91273.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6460864.\nTagged compressions:                          550014.\nTagged decompressions:                        449158.\n"}, "seconds": 59.00119933398673}}
````

### vq-allocator-cpu-sample-v1/protocol.json

Original bytes: 1386. SHA-256: `1925bca3bf9efe06edfa22d1fcd15c9b0f37ec73fbd6eb137eedcd551ab395a4`.

Normalized bytes: 1344. SHA-256: `1fdde5b7fd419756d3c917050d197410cc65ce2d481a23054032787442caa17c`.

````text
{
  "scope": "CPU stack diagnosis only; all timing discarded because sampling perturbs execution",
  "extra_model_runs": 1,
  "pack": "3.2",
  "maximum_process_bytes": 10000000000,
  "minimum_reclaimable_bytes": 13000000000,
  "run_seconds": 1800,
  "sampling_seconds": 10,
  "sample_interval_ms": 1,
  "sampling_delay_seconds": 37,
  "binary_sha256": "2f7020b03c17dbc7ab3de52018af2ee96445a9445c094356ef3037c5dc946a1a",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed",
  "profile_sha256": "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-allocator-reuse-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/bench/quantization/performance-pilot-v2.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-allocator-cpu-sample-v1/native",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-allocator-pair-v1/validation-after/receipt.json"
  ]
}
````

### vq-allocator-cpu-sample-v1/observer.json

Original bytes: 609. SHA-256: `7d22f4e2d4859c1604b5fb4609ea54c2007028370d0024d317fa71206891de49`.

Normalized bytes: 595. SHA-256: `b74384dc38116eecbe9accc851c35560e1f9de7408441ea29daf82fe88930d8f`.

````text
[
  {
    "command": [
      "/usr/bin/sample",
      "54497",
      "10",
      "1",
      "-file",
      "<HOME>/Projects/slotstream/.build/quantization-research/vq-allocator-cpu-sample-v1/sample.txt"
    ],
    "code": 0,
    "stdout": "",
    "stderr": "Sampling process 54497 for 10 seconds with 1 millisecond of run time between samples\nSampling completed, processing symbols...\nSample analysis of process 54497 written to file <HOME>/Projects/slotstream/.build/quantization-research/vq-allocator-cpu-sample-v1/sample.txt\n",
    "elapsed_since_child_observed": 47.692623500013724
  }
]
````

### vq-allocator-cpu-sample-v1/sample.txt

Original bytes: 969383. SHA-256: `2e3f5a2dc362f8f67052d00290243fbed383af61fe57eb5d84716494f194c04f`.

Normalized bytes: 969383. SHA-256: `2e3f5a2dc362f8f67052d00290243fbed383af61fe57eb5d84716494f194c04f`.

````zlib-base64
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
avnbpLKb/x+R3Z5A
````

### vq-allocator-cpu-sample-v1/native/receipt.json

Original bytes: 21486. SHA-256: `10177abee377763ae983d29d44e4da7f61276d34278def8464384a9d6af438a5`.

Normalized bytes: 21486. SHA-256: `10177abee377763ae983d29d44e4da7f61276d34278def8464384a9d6af438a5`.

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
  "committed_decode_tokens_per_second" : 4.7541661621438163,
  "committed_tokens" : 128,
  "emission_seconds" : [
    3.2338010829989798,
    3.9204657079826575,
    4.1382773749937769,
    4.3532721659867093,
    4.5509326659957878,
    4.748565415997291,
    4.9431322909949813,
    5.1487251659855247,
    5.3366859999950975,
    5.5426830829819664,
    5.7291576249990612,
    5.928003874985734,
    6.1066924580081832,
    6.2774847079999745,
    6.4502154999936465,
    6.6614187500090338,
    6.8569571659900248,
    7.0198958749824669,
    7.2128280409961008,
    7.3992815829988103,
    7.5929528329870664,
    7.7850895829906221,
    7.9674890000023879,
    8.1479063750011846,
    8.3744268330046907,
    10.784953833004693,
    11.043809124996187,
    11.270715541002573,
    11.481908457993995,
    11.709948500007158,
    11.922622249985579,
    12.119276832992909,
    12.333542832988314,
    12.518924041010905,
    12.698835124989273,
    12.884214416000759,
    13.074092416005442,
    13.245225207996555,
    13.419402915984392,
    13.596844749990851,
    13.797615874995245,
    14.011363166006049,
    14.199988207983552,
    14.396425624989206,
    14.613933957996778,
    14.829633707995526,
    15.014131500007352,
    15.20920762498281,
    15.410224833001848,
    15.606211457983591,
    15.806800916005159,
    16.057554416009225,
    16.298363125009928,
    16.549970082996879,
    16.762994290998904,
    16.948047707992373,
    17.110537833010312,
    17.315097290993435,
    17.518887082987931,
    17.72376720799366,
    17.910305583005538,
    18.085327790991869,
    18.266551540989894,
    18.433651208004449,
    18.606360915990081,
    18.774701040994842,
    18.951005374983652,
    19.137714332988253,
    19.309775790985441,
    19.496859125007177,
    19.657368374988437,
    19.823421250010142,
    19.991008790995693,
    20.190082916000392,
    20.365590915986104,
    20.551002583000809,
    20.732258500007447,
    20.920017916010693,
    21.086766583001008,
    21.259989207988838,
    21.450480125000468,
    21.623221124988049,
    21.875002290995326,
    22.153656790993409,
    22.4072140409844,
    22.675547249993542,
    22.895966040989151,
    23.071676749998005,
    23.270036832982441,
    23.464817000000039,
    23.647542207996594,
    23.830518832983216,
    24.005606541002635,
    24.187517165992176,
    24.373969375010347,
    24.549750707985368,
    24.758991832990432,
    24.921329707984114,
    25.096148499986157,
    25.257950583007187,
    25.430625125009101,
    25.590027375001227,
    25.732779165991815,
    25.891802790982183,
    26.067062332993373,
    26.225764083006652,
    26.387752665992593,
    26.54407158299,
    26.696623541007284,
    26.849973500007764,
    27.023583540983964,
    27.187478415988153,
    27.371574666001834,
    27.564799165993463,
    27.756384125008481,
    27.906385290989419,
    28.089713207999012,
    28.266897958004847,
    28.422564457985573,
    28.596219750004821,
    28.751362707989756,
    28.92787433299236,
    29.101282957999501,
    29.251531082991278,
    29.41662037500646,
    29.583051791007165,
    29.784866125002736,
    29.947213207982713
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
    "reclaimableBytes" : 23044358144,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.68666462498367764,
    0.21781166701111943,
    0.21499479099293239,
    0.19766050000907853,
    0.19763275000150315,
    0.19456687499769032,
    0.20559287499054335,
    0.18796083400957286,
    0.20599708298686892,
    0.18647454201709479,
    0.19884624998667277,
    0.17868858302244917,
    0.17079224999179132,
    0.17273079199367203,
    0.21120325001538731,
    0.19553841598099098,
    0.16293870899244212,
    0.19293216601363383,
    0.18645354200270958,
    0.19367124998825602,
    0.19213675000355579,
    0.18239941701176576,
    0.18041737499879673,
    0.22652045800350606,
    2.4105270000000019,
    0.2588552919914946,
    0.22690641600638628,
    0.21119291699142195,
    0.22804004201316275,
    0.21267374997842126,
    0.19665458300733007,
    0.21426599999540485,
    0.18538120802259073,
    0.17991108397836797,
    0.1853792910114862,
    0.18987800000468269,
    0.17113279199111275,
    0.17417770798783749,
    0.17744183400645852,
    0.20077112500439398,
    0.21374729101080447,
    0.18862504197750241,
    0.19643741700565442,
    0.21750833300757222,
    0.2156997499987483,
    0.18449779201182537,
    0.19507612497545779,
    0.20101720801903866,
    0.19598662498174235,
    0.20058945802156813,
    0.25075350000406615,
    0.24080870900070295,
    0.25160695798695087,
    0.21302420800202526,
    0.185053416993469,
    0.16249012501793914,
    0.20455945798312314,
    0.20378979199449532,
    0.2048801250057295,
    0.18653837501187809,
    0.17502220798633061,
    0.1812237499980256,
    0.16709966701455414,
    0.17270970798563212,
    0.16834012500476092,
    0.17630433398880996,
    0.1867089580046013,
    0.17206145799718797,
    0.18708333402173594,
    0.16050924998125993,
    0.1660528750217054,
    0.16758754098555073,
    0.19907412500469945,
    0.17550799998571165,
    0.18541166701470502,
    0.1812559170066379,
    0.18775941600324586,
    0.16674866699031554,
    0.17322262498782948,
    0.19049091701162979,
    0.17274099998758174,
    0.25178116600727662,
    0.27865449999808334,
    0.25355724999099039,
    0.26833320900914259,
    0.22041879099560902,
    0.17571070900885388,
    0.1983600829844363,
    0.19478016701759771,
    0.18272520799655467,
    0.18297662498662248,
    0.17508770801941864,
    0.18191062498954125,
    0.18645220901817083,
    0.17578133297502063,
    0.20924112500506453,
    0.16233787499368191,
    0.17481879200204276,
    0.16180208302102983,
    0.17267454200191423,
    0.1594022499921266,
    0.14275179099058732,
    0.15902362499036826,
    0.17525954201119021,
    0.1587017500132788,
    0.16198858298594132,
    0.15631891699740663,
    0.15255195801728405,
    0.15334995900047943,
    0.17361004097620025,
    0.16389487500418909,
    0.18409625001368113,
    0.19322449999162927,
    0.19158495901501738,
    0.15000116598093882,
    0.18332791700959206,
    0.17718475000583567,
    0.15566649998072535,
    0.17365529201924801,
    0.15514295798493549,
    0.17651162500260398,
    0.17340862500714138,
    0.15024812499177642,
    0.16508929201518185,
    0.16643141600070521,
    0.20181433399557136,
    0.16234708297997713
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 28.763045708008576,
  "metadata_seconds" : 0.11193554199417122,
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
  "peak_mlx_bytes" : 6782307824,
  "peak_process_bytes" : 8117639456,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "2f7020b03c17dbc7ab3de52018af2ee96445a9445c094356ef3037c5dc946a1a",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 29.947232540987898,
  "request_vm_after" : {
    "reclaimableBytes" : 17966841856,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18169839616,
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
  "ttft_seconds" : 3.2338010829989798,
  "validation_receipt_sha256" : "bceac6c983a8ab97ae98afaf748b9d6b5201d4f55fee93b361c64fad93f262fc",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-allocator-cpu-sample-v1/supervision/identity.json

Original bytes: 2906. SHA-256: `9b2a648a9084d4ee2fd71d0d60231f2f30cc53d0fbdbcef528b60e579fa8a536`.

Normalized bytes: 2864. SHA-256: `aa47d74c99bc3fe65041b940d9d5e8710dc9cdd97c2d56446cefbf54f6a0a3c4`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-allocator-reuse-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/bench/quantization/performance-pilot-v2.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-allocator-cpu-sample-v1/native",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-allocator-pair-v1/validation-after/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22821339136,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   440069.\nPages active:                                 903912.\nPages inactive:                               885159.\nPages speculative:                             28543.\nPages throttled:                                   0.\nPages wired down:                             184456.\nPages purgeable:                                4292.\n\"Translation faults\":                     1679964860.\nPages copy-on-write:                        86130190.\nPages zero filled:                        2612906750.\nPages reactivated:                          99737444.\nPages purged:                               11591816.\nFile-backed pages:                            948543.\nAnonymous pages:                              869071.\nPages stored in compressor:                  1187602.\nPages occupied by compressor:                 642755.\nDecompressions:                             72149914.\nCompressions:                               83460324.\nPageins:                                  1456858247.\nPageouts:                                     404841.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 143770.\nPages tagged resident:                        101799.\nPages tagged compressed:                       41971.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5220.\nPages tag-storage free:                          544.\nPages tag-storage non-tag pageable:            92532.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6342208.\nTagged compressions:                          547147.\nTagged decompressions:                        447307.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-allocator-cpu-sample-v1/supervision/receipt.json

Original bytes: 2140. SHA-256: `1d1643ee259625c0fd63697b5e7236f16e71b5b49ae888bfe84615307a9f1d27`.

Normalized bytes: 2140. SHA-256: `1d1643ee259625c0fd63697b5e7236f16e71b5b49ae888bfe84615307a9f1d27`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 8117639456,
  "samples": 1018,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24869322752,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   490785.\nPages active:                                 809361.\nPages inactive:                               794157.\nPages speculative:                             68316.\nPages throttled:                                   0.\nPages wired down:                             184829.\nPages purgeable:                                 391.\n\"Translation faults\":                     1681416979.\nPages copy-on-write:                        86193739.\nPages zero filled:                        2613831928.\nPages reactivated:                          99940616.\nPages purged:                               11597126.\nFile-backed pages:                           1026727.\nAnonymous pages:                              645107.\nPages stored in compressor:                  1348035.\nPages occupied by compressor:                 736282.\nDecompressions:                             72788496.\nCompressions:                               84291945.\nPageins:                                  1462605846.\nPageouts:                                     405232.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 132889.\nPages tagged resident:                         89904.\nPages tagged compressed:                       42985.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5220.\nPages tag-storage free:                         1803.\nPages tag-storage non-tag pageable:            91273.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6460864.\nTagged compressions:                          550014.\nTagged decompressions:                        449158.\n"
  },
  "seconds": 59.00119933398673
}
````

### vq-allocator-cpu-sample-v1/supervision/stdout.txt

Original bytes: 21487. SHA-256: `c7e4bed08016f1b0f16b306bba3f494ca4435f4f91589d608e55d54c7859d120`.

Normalized bytes: 21487. SHA-256: `c7e4bed08016f1b0f16b306bba3f494ca4435f4f91589d608e55d54c7859d120`.

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
  "committed_decode_tokens_per_second" : 4.7541661621438163,
  "committed_tokens" : 128,
  "emission_seconds" : [
    3.2338010829989798,
    3.9204657079826575,
    4.1382773749937769,
    4.3532721659867093,
    4.5509326659957878,
    4.748565415997291,
    4.9431322909949813,
    5.1487251659855247,
    5.3366859999950975,
    5.5426830829819664,
    5.7291576249990612,
    5.928003874985734,
    6.1066924580081832,
    6.2774847079999745,
    6.4502154999936465,
    6.6614187500090338,
    6.8569571659900248,
    7.0198958749824669,
    7.2128280409961008,
    7.3992815829988103,
    7.5929528329870664,
    7.7850895829906221,
    7.9674890000023879,
    8.1479063750011846,
    8.3744268330046907,
    10.784953833004693,
    11.043809124996187,
    11.270715541002573,
    11.481908457993995,
    11.709948500007158,
    11.922622249985579,
    12.119276832992909,
    12.333542832988314,
    12.518924041010905,
    12.698835124989273,
    12.884214416000759,
    13.074092416005442,
    13.245225207996555,
    13.419402915984392,
    13.596844749990851,
    13.797615874995245,
    14.011363166006049,
    14.199988207983552,
    14.396425624989206,
    14.613933957996778,
    14.829633707995526,
    15.014131500007352,
    15.20920762498281,
    15.410224833001848,
    15.606211457983591,
    15.806800916005159,
    16.057554416009225,
    16.298363125009928,
    16.549970082996879,
    16.762994290998904,
    16.948047707992373,
    17.110537833010312,
    17.315097290993435,
    17.518887082987931,
    17.72376720799366,
    17.910305583005538,
    18.085327790991869,
    18.266551540989894,
    18.433651208004449,
    18.606360915990081,
    18.774701040994842,
    18.951005374983652,
    19.137714332988253,
    19.309775790985441,
    19.496859125007177,
    19.657368374988437,
    19.823421250010142,
    19.991008790995693,
    20.190082916000392,
    20.365590915986104,
    20.551002583000809,
    20.732258500007447,
    20.920017916010693,
    21.086766583001008,
    21.259989207988838,
    21.450480125000468,
    21.623221124988049,
    21.875002290995326,
    22.153656790993409,
    22.4072140409844,
    22.675547249993542,
    22.895966040989151,
    23.071676749998005,
    23.270036832982441,
    23.464817000000039,
    23.647542207996594,
    23.830518832983216,
    24.005606541002635,
    24.187517165992176,
    24.373969375010347,
    24.549750707985368,
    24.758991832990432,
    24.921329707984114,
    25.096148499986157,
    25.257950583007187,
    25.430625125009101,
    25.590027375001227,
    25.732779165991815,
    25.891802790982183,
    26.067062332993373,
    26.225764083006652,
    26.387752665992593,
    26.54407158299,
    26.696623541007284,
    26.849973500007764,
    27.023583540983964,
    27.187478415988153,
    27.371574666001834,
    27.564799165993463,
    27.756384125008481,
    27.906385290989419,
    28.089713207999012,
    28.266897958004847,
    28.422564457985573,
    28.596219750004821,
    28.751362707989756,
    28.92787433299236,
    29.101282957999501,
    29.251531082991278,
    29.41662037500646,
    29.583051791007165,
    29.784866125002736,
    29.947213207982713
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
    "reclaimableBytes" : 23044358144,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.68666462498367764,
    0.21781166701111943,
    0.21499479099293239,
    0.19766050000907853,
    0.19763275000150315,
    0.19456687499769032,
    0.20559287499054335,
    0.18796083400957286,
    0.20599708298686892,
    0.18647454201709479,
    0.19884624998667277,
    0.17868858302244917,
    0.17079224999179132,
    0.17273079199367203,
    0.21120325001538731,
    0.19553841598099098,
    0.16293870899244212,
    0.19293216601363383,
    0.18645354200270958,
    0.19367124998825602,
    0.19213675000355579,
    0.18239941701176576,
    0.18041737499879673,
    0.22652045800350606,
    2.4105270000000019,
    0.2588552919914946,
    0.22690641600638628,
    0.21119291699142195,
    0.22804004201316275,
    0.21267374997842126,
    0.19665458300733007,
    0.21426599999540485,
    0.18538120802259073,
    0.17991108397836797,
    0.1853792910114862,
    0.18987800000468269,
    0.17113279199111275,
    0.17417770798783749,
    0.17744183400645852,
    0.20077112500439398,
    0.21374729101080447,
    0.18862504197750241,
    0.19643741700565442,
    0.21750833300757222,
    0.2156997499987483,
    0.18449779201182537,
    0.19507612497545779,
    0.20101720801903866,
    0.19598662498174235,
    0.20058945802156813,
    0.25075350000406615,
    0.24080870900070295,
    0.25160695798695087,
    0.21302420800202526,
    0.185053416993469,
    0.16249012501793914,
    0.20455945798312314,
    0.20378979199449532,
    0.2048801250057295,
    0.18653837501187809,
    0.17502220798633061,
    0.1812237499980256,
    0.16709966701455414,
    0.17270970798563212,
    0.16834012500476092,
    0.17630433398880996,
    0.1867089580046013,
    0.17206145799718797,
    0.18708333402173594,
    0.16050924998125993,
    0.1660528750217054,
    0.16758754098555073,
    0.19907412500469945,
    0.17550799998571165,
    0.18541166701470502,
    0.1812559170066379,
    0.18775941600324586,
    0.16674866699031554,
    0.17322262498782948,
    0.19049091701162979,
    0.17274099998758174,
    0.25178116600727662,
    0.27865449999808334,
    0.25355724999099039,
    0.26833320900914259,
    0.22041879099560902,
    0.17571070900885388,
    0.1983600829844363,
    0.19478016701759771,
    0.18272520799655467,
    0.18297662498662248,
    0.17508770801941864,
    0.18191062498954125,
    0.18645220901817083,
    0.17578133297502063,
    0.20924112500506453,
    0.16233787499368191,
    0.17481879200204276,
    0.16180208302102983,
    0.17267454200191423,
    0.1594022499921266,
    0.14275179099058732,
    0.15902362499036826,
    0.17525954201119021,
    0.1587017500132788,
    0.16198858298594132,
    0.15631891699740663,
    0.15255195801728405,
    0.15334995900047943,
    0.17361004097620025,
    0.16389487500418909,
    0.18409625001368113,
    0.19322449999162927,
    0.19158495901501738,
    0.15000116598093882,
    0.18332791700959206,
    0.17718475000583567,
    0.15566649998072535,
    0.17365529201924801,
    0.15514295798493549,
    0.17651162500260398,
    0.17340862500714138,
    0.15024812499177642,
    0.16508929201518185,
    0.16643141600070521,
    0.20181433399557136,
    0.16234708297997713
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 28.763045708008576,
  "metadata_seconds" : 0.11193554199417122,
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
  "peak_mlx_bytes" : 6782307824,
  "peak_process_bytes" : 8117639456,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "2f7020b03c17dbc7ab3de52018af2ee96445a9445c094356ef3037c5dc946a1a",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 29.947232540987898,
  "request_vm_after" : {
    "reclaimableBytes" : 17966841856,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18169839616,
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
  "ttft_seconds" : 3.2338010829989798,
  "validation_receipt_sha256" : "bceac6c983a8ab97ae98afaf748b9d6b5201d4f55fee93b361c64fad93f262fc",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-allocator-cpu-sample-v1/supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-dense-affine-hybrid-audit-v1.py

Original bytes: 3409. SHA-256: `609c80dea2650fd39409b07c171feafc853c1b3145ecc045ac618f605ecf9264`.

Normalized bytes: 3402. SHA-256: `cd0f7f4cbdeb82ff4ad7fcbef6966c7f8564f2a932d85947b00dc212bc462dd9`.

````text
from pathlib import Path
import json,hashlib,sys
sys.path.insert(0,'Tools')
from quantization_inventory import unique_json,validate_header
r=Path('.build/quantization-research');base=Path('<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit');vq=r/'candidate-3.2'
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
assert digest(base/'config.json')=='0da22a8ed4323fbe969bf982aeb054743b315206791f28ef74a309c707080ba5'
assert digest(base/'model.safetensors.index.json')=='072cc2c60b8af6cce82a387f62e39ca88754c3a6fccae0816dd21bb89d27470d'
assert digest(vq/'config.json')=='75d7d9b1bfa7762e46ef7c512f6779b43fbd1a1a7f9715684a79f6b01f07cfe5'
indexes=[unique_json((p/'model.safetensors.index.json').read_bytes())['weight_map'] for p in (base,vq)]
configs=[unique_json((p/'config.json').read_bytes()) for p in (base,vq)]
headers={};receipts=[]
def tensor(which,key):
 path=(base if which==0 else vq)/indexes[which][key]
 if path not in headers:
  with path.open('rb') as f:
   before=path.stat();prefix=f.read(8);n=int.from_bytes(prefix,'little');assert 0<n<4000000
   raw=f.read(n);assert len(raw)==n;header=unique_json(raw);validate_header(header,before.st_size-8-n)
   assert path.stat().st_mtime_ns==before.st_mtime_ns
  headers[path]=header;receipts.append({'arm':'base' if which==0 else 'vq','file':path.name,'file_bytes':before.st_size,'header_bytes':n,'header_sha256':hashlib.sha256(prefix+raw).hexdigest()})
 return headers[path][key]
def size(t):return t['data_offsets'][1]-t['data_offsets'][0]
modules=[];missing=[]
for scale in sorted(indexes[1]):
 if not scale.endswith('.scales') or any(x in scale for x in ('switch_mlp','ngram_embedding','vision','visual','mtp.')):continue
 name=scale[:-len('.scales')]
 keys=[name+'.'+x for x in ('weight','scales','biases')]
 if not all(k in indexes[0] for k in keys):missing.append(name);continue
 q=configs[0]['quantization'];recipe=q.get(name,{k:q[k] for k in ('bits','group_size')})
 assert recipe['bits']==4 and recipe['group_size']==64,(name,recipe)
 old=[tensor(1,k) for k in keys];new=[tensor(0,k) for k in keys]
 assert old[0]['dtype']==new[0]['dtype']=='U32' and old[0]['shape'][:-1]==new[0]['shape'][:-1]
 assert old[0]['shape'][-1]==2*new[0]['shape'][-1]
 assert old[1]['shape']==new[1]['shape']==old[2]['shape']==new[2]['shape']
 modules.append({'module':name,'recipe':recipe,'vq_bytes':sum(map(size,old)),'affine_bytes':sum(map(size,new)),'tensors':keys})
before=sum(m['vq_bytes'] for m in modules);after=sum(m['affine_bytes'] for m in modules)
result={'schema':1,'scope':'Header-only same-checkpoint dense affine overlay feasibility; no candidate execution or payload qualification','modules':modules,'unmatched_vq_modules':missing,'headers':receipts,'replaced_vq_bytes':before,'replacement_affine_bytes':after,'recoverable_payload_bytes':before-after,'resident_payload_estimate_bytes':5318309400-before+after,'unchanged':'VQ routed experts, VQ PLE tables, raw norm tensors and all other non-matched tensors. Preserve corrected BF16 norm folding.','status':'hypothesis only; independent composite identity, full digest verification, traversal proof and fresh quality pilot required'}
(r/'vq-dense-affine-hybrid-audit-v1.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in ('modules','headers','unmatched_vq_modules')}));print('modules',len(modules),'unmatched',missing)
````

### vq-dense-affine-hybrid-audit-v1.json

Original bytes: 39648. SHA-256: `86c63285f65ae7c70df0495c10d768a76fccbc004b83c26a412a343e927924e3`.

Normalized bytes: 39648. SHA-256: `86c63285f65ae7c70df0495c10d768a76fccbc004b83c26a412a343e927924e3`.

````text
{
  "schema": 1,
  "scope": "Header-only same-checkpoint dense affine overlay feasibility; no candidate execution or payload qualification",
  "modules": [],
  "unmatched_vq_modules": [
    "lm_head",
    "model.embed_tokens",
    "model.hyper_connection_mixer.input_mix_weight_down",
    "model.hyper_connection_mixer.input_mix_weight_up",
    "model.layers.0.attn_hyper_connection.block_inject_weight",
    "model.layers.0.attn_hyper_connection.input_mix_weight_down",
    "model.layers.0.attn_hyper_connection.input_mix_weight_up",
    "model.layers.0.linear_attn.in_proj_a",
    "model.layers.0.linear_attn.in_proj_b",
    "model.layers.0.linear_attn.in_proj_qkv",
    "model.layers.0.linear_attn.in_proj_z",
    "model.layers.0.linear_attn.out_proj",
    "model.layers.0.mlp.shared_expert.down_proj",
    "model.layers.0.mlp.shared_expert.gate_proj",
    "model.layers.0.mlp.shared_expert.up_proj",
    "model.layers.0.mlp.shared_expert_gate",
    "model.layers.0.mlp_hyper_connection.block_inject_weight",
    "model.layers.0.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.0.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.1.attn_hyper_connection.block_inject_weight",
    "model.layers.1.attn_hyper_connection.input_mix_weight_down",
    "model.layers.1.attn_hyper_connection.input_mix_weight_up",
    "model.layers.1.linear_attn.in_proj_a",
    "model.layers.1.linear_attn.in_proj_b",
    "model.layers.1.linear_attn.in_proj_qkv",
    "model.layers.1.linear_attn.in_proj_z",
    "model.layers.1.linear_attn.out_proj",
    "model.layers.1.mlp.shared_expert.down_proj",
    "model.layers.1.mlp.shared_expert.gate_proj",
    "model.layers.1.mlp.shared_expert.up_proj",
    "model.layers.1.mlp.shared_expert_gate",
    "model.layers.1.mlp_hyper_connection.block_inject_weight",
    "model.layers.1.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.1.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.1.ple.key_proj",
    "model.layers.1.ple.value_proj",
    "model.layers.10.attn_hyper_connection.block_inject_weight",
    "model.layers.10.attn_hyper_connection.input_mix_weight_down",
    "model.layers.10.attn_hyper_connection.input_mix_weight_up",
    "model.layers.10.linear_attn.in_proj_a",
    "model.layers.10.linear_attn.in_proj_b",
    "model.layers.10.linear_attn.in_proj_qkv",
    "model.layers.10.linear_attn.in_proj_z",
    "model.layers.10.linear_attn.out_proj",
    "model.layers.10.mlp.shared_expert.down_proj",
    "model.layers.10.mlp.shared_expert.gate_proj",
    "model.layers.10.mlp.shared_expert.up_proj",
    "model.layers.10.mlp.shared_expert_gate",
    "model.layers.10.mlp_hyper_connection.block_inject_weight",
    "model.layers.10.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.10.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.11.attn_hyper_connection.block_inject_weight",
    "model.layers.11.attn_hyper_connection.input_mix_weight_down",
    "model.layers.11.attn_hyper_connection.input_mix_weight_up",
    "model.layers.11.mlp.shared_expert.down_proj",
    "model.layers.11.mlp.shared_expert.gate_proj",
    "model.layers.11.mlp.shared_expert.up_proj",
    "model.layers.11.mlp.shared_expert_gate",
    "model.layers.11.mlp_hyper_connection.block_inject_weight",
    "model.layers.11.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.11.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.11.self_attn.indexer.index_qk_proj",
    "model.layers.11.self_attn.k_proj",
    "model.layers.11.self_attn.o_proj",
    "model.layers.11.self_attn.q_proj",
    "model.layers.11.self_attn.v_proj",
    "model.layers.12.attn_hyper_connection.block_inject_weight",
    "model.layers.12.attn_hyper_connection.input_mix_weight_down",
    "model.layers.12.attn_hyper_connection.input_mix_weight_up",
    "model.layers.12.linear_attn.in_proj_a",
    "model.layers.12.linear_attn.in_proj_b",
    "model.layers.12.linear_attn.in_proj_qkv",
    "model.layers.12.linear_attn.in_proj_z",
    "model.layers.12.linear_attn.out_proj",
    "model.layers.12.mlp.shared_expert.down_proj",
    "model.layers.12.mlp.shared_expert.gate_proj",
    "model.layers.12.mlp.shared_expert.up_proj",
    "model.layers.12.mlp.shared_expert_gate",
    "model.layers.12.mlp_hyper_connection.block_inject_weight",
    "model.layers.12.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.12.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.13.attn_hyper_connection.block_inject_weight",
    "model.layers.13.attn_hyper_connection.input_mix_weight_down",
    "model.layers.13.attn_hyper_connection.input_mix_weight_up",
    "model.layers.13.linear_attn.in_proj_a",
    "model.layers.13.linear_attn.in_proj_b",
    "model.layers.13.linear_attn.in_proj_qkv",
    "model.layers.13.linear_attn.in_proj_z",
    "model.layers.13.linear_attn.out_proj",
    "model.layers.13.mlp.shared_expert.down_proj",
    "model.layers.13.mlp.shared_expert.gate_proj",
    "model.layers.13.mlp.shared_expert.up_proj",
    "model.layers.13.mlp.shared_expert_gate",
    "model.layers.13.mlp_hyper_connection.block_inject_weight",
    "model.layers.13.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.13.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.14.attn_hyper_connection.block_inject_weight",
    "model.layers.14.attn_hyper_connection.input_mix_weight_down",
    "model.layers.14.attn_hyper_connection.input_mix_weight_up",
    "model.layers.14.linear_attn.in_proj_a",
    "model.layers.14.linear_attn.in_proj_b",
    "model.layers.14.linear_attn.in_proj_qkv",
    "model.layers.14.linear_attn.in_proj_z",
    "model.layers.14.linear_attn.out_proj",
    "model.layers.14.mlp.shared_expert.down_proj",
    "model.layers.14.mlp.shared_expert.gate_proj",
    "model.layers.14.mlp.shared_expert.up_proj",
    "model.layers.14.mlp.shared_expert_gate",
    "model.layers.14.mlp_hyper_connection.block_inject_weight",
    "model.layers.14.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.14.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.15.attn_hyper_connection.block_inject_weight",
    "model.layers.15.attn_hyper_connection.input_mix_weight_down",
    "model.layers.15.attn_hyper_connection.input_mix_weight_up",
    "model.layers.15.mlp.shared_expert.down_proj",
    "model.layers.15.mlp.shared_expert.gate_proj",
    "model.layers.15.mlp.shared_expert.up_proj",
    "model.layers.15.mlp.shared_expert_gate",
    "model.layers.15.mlp_hyper_connection.block_inject_weight",
    "model.layers.15.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.15.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.15.self_attn.indexer.index_qk_proj",
    "model.layers.15.self_attn.k_proj",
    "model.layers.15.self_attn.o_proj",
    "model.layers.15.self_attn.q_proj",
    "model.layers.15.self_attn.v_proj",
    "model.layers.16.attn_hyper_connection.block_inject_weight",
    "model.layers.16.attn_hyper_connection.input_mix_weight_down",
    "model.layers.16.attn_hyper_connection.input_mix_weight_up",
    "model.layers.16.linear_attn.in_proj_a",
    "model.layers.16.linear_attn.in_proj_b",
    "model.layers.16.linear_attn.in_proj_qkv",
    "model.layers.16.linear_attn.in_proj_z",
    "model.layers.16.linear_attn.out_proj",
    "model.layers.16.mlp.shared_expert.down_proj",
    "model.layers.16.mlp.shared_expert.gate_proj",
    "model.layers.16.mlp.shared_expert.up_proj",
    "model.layers.16.mlp.shared_expert_gate",
    "model.layers.16.mlp_hyper_connection.block_inject_weight",
    "model.layers.16.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.16.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.17.attn_hyper_connection.block_inject_weight",
    "model.layers.17.attn_hyper_connection.input_mix_weight_down",
    "model.layers.17.attn_hyper_connection.input_mix_weight_up",
    "model.layers.17.linear_attn.in_proj_a",
    "model.layers.17.linear_attn.in_proj_b",
    "model.layers.17.linear_attn.in_proj_qkv",
    "model.layers.17.linear_attn.in_proj_z",
    "model.layers.17.linear_attn.out_proj",
    "model.layers.17.mlp.shared_expert.down_proj",
    "model.layers.17.mlp.shared_expert.gate_proj",
    "model.layers.17.mlp.shared_expert.up_proj",
    "model.layers.17.mlp.shared_expert_gate",
    "model.layers.17.mlp_hyper_connection.block_inject_weight",
    "model.layers.17.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.17.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.18.attn_hyper_connection.block_inject_weight",
    "model.layers.18.attn_hyper_connection.input_mix_weight_down",
    "model.layers.18.attn_hyper_connection.input_mix_weight_up",
    "model.layers.18.linear_attn.in_proj_a",
    "model.layers.18.linear_attn.in_proj_b",
    "model.layers.18.linear_attn.in_proj_qkv",
    "model.layers.18.linear_attn.in_proj_z",
    "model.layers.18.linear_attn.out_proj",
    "model.layers.18.mlp.shared_expert.down_proj",
    "model.layers.18.mlp.shared_expert.gate_proj",
    "model.layers.18.mlp.shared_expert.up_proj",
    "model.layers.18.mlp.shared_expert_gate",
    "model.layers.18.mlp_hyper_connection.block_inject_weight",
    "model.layers.18.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.18.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.19.attn_hyper_connection.block_inject_weight",
    "model.layers.19.attn_hyper_connection.input_mix_weight_down",
    "model.layers.19.attn_hyper_connection.input_mix_weight_up",
    "model.layers.19.mlp.shared_expert.down_proj",
    "model.layers.19.mlp.shared_expert.gate_proj",
    "model.layers.19.mlp.shared_expert.up_proj",
    "model.layers.19.mlp.shared_expert_gate",
    "model.layers.19.mlp_hyper_connection.block_inject_weight",
    "model.layers.19.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.19.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.19.self_attn.indexer.index_qk_proj",
    "model.layers.19.self_attn.k_proj",
    "model.layers.19.self_attn.o_proj",
    "model.layers.19.self_attn.q_proj",
    "model.layers.19.self_attn.v_proj",
    "model.layers.2.attn_hyper_connection.block_inject_weight",
    "model.layers.2.attn_hyper_connection.input_mix_weight_down",
    "model.layers.2.attn_hyper_connection.input_mix_weight_up",
    "model.layers.2.linear_attn.in_proj_a",
    "model.layers.2.linear_attn.in_proj_b",
    "model.layers.2.linear_attn.in_proj_qkv",
    "model.layers.2.linear_attn.in_proj_z",
    "model.layers.2.linear_attn.out_proj",
    "model.layers.2.mlp.shared_expert.down_proj",
    "model.layers.2.mlp.shared_expert.gate_proj",
    "model.layers.2.mlp.shared_expert.up_proj",
    "model.layers.2.mlp.shared_expert_gate",
    "model.layers.2.mlp_hyper_connection.block_inject_weight",
    "model.layers.2.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.2.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.20.attn_hyper_connection.block_inject_weight",
    "model.layers.20.attn_hyper_connection.input_mix_weight_down",
    "model.layers.20.attn_hyper_connection.input_mix_weight_up",
    "model.layers.20.linear_attn.in_proj_a",
    "model.layers.20.linear_attn.in_proj_b",
    "model.layers.20.linear_attn.in_proj_qkv",
    "model.layers.20.linear_attn.in_proj_z",
    "model.layers.20.linear_attn.out_proj",
    "model.layers.20.mlp.shared_expert.down_proj",
    "model.layers.20.mlp.shared_expert.gate_proj",
    "model.layers.20.mlp.shared_expert.up_proj",
    "model.layers.20.mlp.shared_expert_gate",
    "model.layers.20.mlp_hyper_connection.block_inject_weight",
    "model.layers.20.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.20.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.21.attn_hyper_connection.block_inject_weight",
    "model.layers.21.attn_hyper_connection.input_mix_weight_down",
    "model.layers.21.attn_hyper_connection.input_mix_weight_up",
    "model.layers.21.linear_attn.in_proj_a",
    "model.layers.21.linear_attn.in_proj_b",
    "model.layers.21.linear_attn.in_proj_qkv",
    "model.layers.21.linear_attn.in_proj_z",
    "model.layers.21.linear_attn.out_proj",
    "model.layers.21.mlp.shared_expert.down_proj",
    "model.layers.21.mlp.shared_expert.gate_proj",
    "model.layers.21.mlp.shared_expert.up_proj",
    "model.layers.21.mlp.shared_expert_gate",
    "model.layers.21.mlp_hyper_connection.block_inject_weight",
    "model.layers.21.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.21.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.22.attn_hyper_connection.block_inject_weight",
    "model.layers.22.attn_hyper_connection.input_mix_weight_down",
    "model.layers.22.attn_hyper_connection.input_mix_weight_up",
    "model.layers.22.linear_attn.in_proj_a",
    "model.layers.22.linear_attn.in_proj_b",
    "model.layers.22.linear_attn.in_proj_qkv",
    "model.layers.22.linear_attn.in_proj_z",
    "model.layers.22.linear_attn.out_proj",
    "model.layers.22.mlp.shared_expert.down_proj",
    "model.layers.22.mlp.shared_expert.gate_proj",
    "model.layers.22.mlp.shared_expert.up_proj",
    "model.layers.22.mlp.shared_expert_gate",
    "model.layers.22.mlp_hyper_connection.block_inject_weight",
    "model.layers.22.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.22.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.23.attn_hyper_connection.block_inject_weight",
    "model.layers.23.attn_hyper_connection.input_mix_weight_down",
    "model.layers.23.attn_hyper_connection.input_mix_weight_up",
    "model.layers.23.mlp.shared_expert.down_proj",
    "model.layers.23.mlp.shared_expert.gate_proj",
    "model.layers.23.mlp.shared_expert.up_proj",
    "model.layers.23.mlp.shared_expert_gate",
    "model.layers.23.mlp_hyper_connection.block_inject_weight",
    "model.layers.23.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.23.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.23.self_attn.indexer.index_qk_proj",
    "model.layers.23.self_attn.k_proj",
    "model.layers.23.self_attn.o_proj",
    "model.layers.23.self_attn.q_proj",
    "model.layers.23.self_attn.v_proj",
    "model.layers.24.attn_hyper_connection.block_inject_weight",
    "model.layers.24.attn_hyper_connection.input_mix_weight_down",
    "model.layers.24.attn_hyper_connection.input_mix_weight_up",
    "model.layers.24.linear_attn.in_proj_a",
    "model.layers.24.linear_attn.in_proj_b",
    "model.layers.24.linear_attn.in_proj_qkv",
    "model.layers.24.linear_attn.in_proj_z",
    "model.layers.24.linear_attn.out_proj",
    "model.layers.24.mlp.shared_expert.down_proj",
    "model.layers.24.mlp.shared_expert.gate_proj",
    "model.layers.24.mlp.shared_expert.up_proj",
    "model.layers.24.mlp.shared_expert_gate",
    "model.layers.24.mlp_hyper_connection.block_inject_weight",
    "model.layers.24.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.24.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.25.attn_hyper_connection.block_inject_weight",
    "model.layers.25.attn_hyper_connection.input_mix_weight_down",
    "model.layers.25.attn_hyper_connection.input_mix_weight_up",
    "model.layers.25.linear_attn.in_proj_a",
    "model.layers.25.linear_attn.in_proj_b",
    "model.layers.25.linear_attn.in_proj_qkv",
    "model.layers.25.linear_attn.in_proj_z",
    "model.layers.25.linear_attn.out_proj",
    "model.layers.25.mlp.shared_expert.down_proj",
    "model.layers.25.mlp.shared_expert.gate_proj",
    "model.layers.25.mlp.shared_expert.up_proj",
    "model.layers.25.mlp.shared_expert_gate",
    "model.layers.25.mlp_hyper_connection.block_inject_weight",
    "model.layers.25.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.25.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.26.attn_hyper_connection.block_inject_weight",
    "model.layers.26.attn_hyper_connection.input_mix_weight_down",
    "model.layers.26.attn_hyper_connection.input_mix_weight_up",
    "model.layers.26.linear_attn.in_proj_a",
    "model.layers.26.linear_attn.in_proj_b",
    "model.layers.26.linear_attn.in_proj_qkv",
    "model.layers.26.linear_attn.in_proj_z",
    "model.layers.26.linear_attn.out_proj",
    "model.layers.26.mlp.shared_expert.down_proj",
    "model.layers.26.mlp.shared_expert.gate_proj",
    "model.layers.26.mlp.shared_expert.up_proj",
    "model.layers.26.mlp.shared_expert_gate",
    "model.layers.26.mlp_hyper_connection.block_inject_weight",
    "model.layers.26.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.26.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.27.attn_hyper_connection.block_inject_weight",
    "model.layers.27.attn_hyper_connection.input_mix_weight_down",
    "model.layers.27.attn_hyper_connection.input_mix_weight_up",
    "model.layers.27.mlp.shared_expert.down_proj",
    "model.layers.27.mlp.shared_expert.gate_proj",
    "model.layers.27.mlp.shared_expert.up_proj",
    "model.layers.27.mlp.shared_expert_gate",
    "model.layers.27.mlp_hyper_connection.block_inject_weight",
    "model.layers.27.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.27.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.27.self_attn.indexer.index_qk_proj",
    "model.layers.27.self_attn.k_proj",
    "model.layers.27.self_attn.o_proj",
    "model.layers.27.self_attn.q_proj",
    "model.layers.27.self_attn.v_proj",
    "model.layers.28.attn_hyper_connection.block_inject_weight",
    "model.layers.28.attn_hyper_connection.input_mix_weight_down",
    "model.layers.28.attn_hyper_connection.input_mix_weight_up",
    "model.layers.28.linear_attn.in_proj_a",
    "model.layers.28.linear_attn.in_proj_b",
    "model.layers.28.linear_attn.in_proj_qkv",
    "model.layers.28.linear_attn.in_proj_z",
    "model.layers.28.linear_attn.out_proj",
    "model.layers.28.mlp.shared_expert.down_proj",
    "model.layers.28.mlp.shared_expert.gate_proj",
    "model.layers.28.mlp.shared_expert.up_proj",
    "model.layers.28.mlp.shared_expert_gate",
    "model.layers.28.mlp_hyper_connection.block_inject_weight",
    "model.layers.28.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.28.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.29.attn_hyper_connection.block_inject_weight",
    "model.layers.29.attn_hyper_connection.input_mix_weight_down",
    "model.layers.29.attn_hyper_connection.input_mix_weight_up",
    "model.layers.29.linear_attn.in_proj_a",
    "model.layers.29.linear_attn.in_proj_b",
    "model.layers.29.linear_attn.in_proj_qkv",
    "model.layers.29.linear_attn.in_proj_z",
    "model.layers.29.linear_attn.out_proj",
    "model.layers.29.mlp.shared_expert.down_proj",
    "model.layers.29.mlp.shared_expert.gate_proj",
    "model.layers.29.mlp.shared_expert.up_proj",
    "model.layers.29.mlp.shared_expert_gate",
    "model.layers.29.mlp_hyper_connection.block_inject_weight",
    "model.layers.29.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.29.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.3.attn_hyper_connection.block_inject_weight",
    "model.layers.3.attn_hyper_connection.input_mix_weight_down",
    "model.layers.3.attn_hyper_connection.input_mix_weight_up",
    "model.layers.3.mlp.shared_expert.down_proj",
    "model.layers.3.mlp.shared_expert.gate_proj",
    "model.layers.3.mlp.shared_expert.up_proj",
    "model.layers.3.mlp.shared_expert_gate",
    "model.layers.3.mlp_hyper_connection.block_inject_weight",
    "model.layers.3.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.3.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.3.self_attn.indexer.index_qk_proj",
    "model.layers.3.self_attn.k_proj",
    "model.layers.3.self_attn.o_proj",
    "model.layers.3.self_attn.q_proj",
    "model.layers.3.self_attn.v_proj",
    "model.layers.30.attn_hyper_connection.block_inject_weight",
    "model.layers.30.attn_hyper_connection.input_mix_weight_down",
    "model.layers.30.attn_hyper_connection.input_mix_weight_up",
    "model.layers.30.linear_attn.in_proj_a",
    "model.layers.30.linear_attn.in_proj_b",
    "model.layers.30.linear_attn.in_proj_qkv",
    "model.layers.30.linear_attn.in_proj_z",
    "model.layers.30.linear_attn.out_proj",
    "model.layers.30.mlp.shared_expert.down_proj",
    "model.layers.30.mlp.shared_expert.gate_proj",
    "model.layers.30.mlp.shared_expert.up_proj",
    "model.layers.30.mlp.shared_expert_gate",
    "model.layers.30.mlp_hyper_connection.block_inject_weight",
    "model.layers.30.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.30.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.31.attn_hyper_connection.block_inject_weight",
    "model.layers.31.attn_hyper_connection.input_mix_weight_down",
    "model.layers.31.attn_hyper_connection.input_mix_weight_up",
    "model.layers.31.mlp.shared_expert.down_proj",
    "model.layers.31.mlp.shared_expert.gate_proj",
    "model.layers.31.mlp.shared_expert.up_proj",
    "model.layers.31.mlp.shared_expert_gate",
    "model.layers.31.mlp_hyper_connection.block_inject_weight",
    "model.layers.31.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.31.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.31.self_attn.indexer.index_qk_proj",
    "model.layers.31.self_attn.k_proj",
    "model.layers.31.self_attn.o_proj",
    "model.layers.31.self_attn.q_proj",
    "model.layers.31.self_attn.v_proj",
    "model.layers.32.attn_hyper_connection.block_inject_weight",
    "model.layers.32.attn_hyper_connection.input_mix_weight_down",
    "model.layers.32.attn_hyper_connection.input_mix_weight_up",
    "model.layers.32.linear_attn.in_proj_a",
    "model.layers.32.linear_attn.in_proj_b",
    "model.layers.32.linear_attn.in_proj_qkv",
    "model.layers.32.linear_attn.in_proj_z",
    "model.layers.32.linear_attn.out_proj",
    "model.layers.32.mlp.shared_expert.down_proj",
    "model.layers.32.mlp.shared_expert.gate_proj",
    "model.layers.32.mlp.shared_expert.up_proj",
    "model.layers.32.mlp.shared_expert_gate",
    "model.layers.32.mlp_hyper_connection.block_inject_weight",
    "model.layers.32.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.32.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.33.attn_hyper_connection.block_inject_weight",
    "model.layers.33.attn_hyper_connection.input_mix_weight_down",
    "model.layers.33.attn_hyper_connection.input_mix_weight_up",
    "model.layers.33.linear_attn.in_proj_a",
    "model.layers.33.linear_attn.in_proj_b",
    "model.layers.33.linear_attn.in_proj_qkv",
    "model.layers.33.linear_attn.in_proj_z",
    "model.layers.33.linear_attn.out_proj",
    "model.layers.33.mlp.shared_expert.down_proj",
    "model.layers.33.mlp.shared_expert.gate_proj",
    "model.layers.33.mlp.shared_expert.up_proj",
    "model.layers.33.mlp.shared_expert_gate",
    "model.layers.33.mlp_hyper_connection.block_inject_weight",
    "model.layers.33.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.33.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.34.attn_hyper_connection.block_inject_weight",
    "model.layers.34.attn_hyper_connection.input_mix_weight_down",
    "model.layers.34.attn_hyper_connection.input_mix_weight_up",
    "model.layers.34.linear_attn.in_proj_a",
    "model.layers.34.linear_attn.in_proj_b",
    "model.layers.34.linear_attn.in_proj_qkv",
    "model.layers.34.linear_attn.in_proj_z",
    "model.layers.34.linear_attn.out_proj",
    "model.layers.34.mlp.shared_expert.down_proj",
    "model.layers.34.mlp.shared_expert.gate_proj",
    "model.layers.34.mlp.shared_expert.up_proj",
    "model.layers.34.mlp.shared_expert_gate",
    "model.layers.34.mlp_hyper_connection.block_inject_weight",
    "model.layers.34.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.34.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.35.attn_hyper_connection.block_inject_weight",
    "model.layers.35.attn_hyper_connection.input_mix_weight_down",
    "model.layers.35.attn_hyper_connection.input_mix_weight_up",
    "model.layers.35.mlp.shared_expert.down_proj",
    "model.layers.35.mlp.shared_expert.gate_proj",
    "model.layers.35.mlp.shared_expert.up_proj",
    "model.layers.35.mlp.shared_expert_gate",
    "model.layers.35.mlp_hyper_connection.block_inject_weight",
    "model.layers.35.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.35.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.35.self_attn.indexer.index_qk_proj",
    "model.layers.35.self_attn.k_proj",
    "model.layers.35.self_attn.o_proj",
    "model.layers.35.self_attn.q_proj",
    "model.layers.35.self_attn.v_proj",
    "model.layers.36.attn_hyper_connection.block_inject_weight",
    "model.layers.36.attn_hyper_connection.input_mix_weight_down",
    "model.layers.36.attn_hyper_connection.input_mix_weight_up",
    "model.layers.36.linear_attn.in_proj_a",
    "model.layers.36.linear_attn.in_proj_b",
    "model.layers.36.linear_attn.in_proj_qkv",
    "model.layers.36.linear_attn.in_proj_z",
    "model.layers.36.linear_attn.out_proj",
    "model.layers.36.mlp.shared_expert.down_proj",
    "model.layers.36.mlp.shared_expert.gate_proj",
    "model.layers.36.mlp.shared_expert.up_proj",
    "model.layers.36.mlp.shared_expert_gate",
    "model.layers.36.mlp_hyper_connection.block_inject_weight",
    "model.layers.36.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.36.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.37.attn_hyper_connection.block_inject_weight",
    "model.layers.37.attn_hyper_connection.input_mix_weight_down",
    "model.layers.37.attn_hyper_connection.input_mix_weight_up",
    "model.layers.37.linear_attn.in_proj_a",
    "model.layers.37.linear_attn.in_proj_b",
    "model.layers.37.linear_attn.in_proj_qkv",
    "model.layers.37.linear_attn.in_proj_z",
    "model.layers.37.linear_attn.out_proj",
    "model.layers.37.mlp.shared_expert.down_proj",
    "model.layers.37.mlp.shared_expert.gate_proj",
    "model.layers.37.mlp.shared_expert.up_proj",
    "model.layers.37.mlp.shared_expert_gate",
    "model.layers.37.mlp_hyper_connection.block_inject_weight",
    "model.layers.37.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.37.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.38.attn_hyper_connection.block_inject_weight",
    "model.layers.38.attn_hyper_connection.input_mix_weight_down",
    "model.layers.38.attn_hyper_connection.input_mix_weight_up",
    "model.layers.38.linear_attn.in_proj_a",
    "model.layers.38.linear_attn.in_proj_b",
    "model.layers.38.linear_attn.in_proj_qkv",
    "model.layers.38.linear_attn.in_proj_z",
    "model.layers.38.linear_attn.out_proj",
    "model.layers.38.mlp.shared_expert.down_proj",
    "model.layers.38.mlp.shared_expert.gate_proj",
    "model.layers.38.mlp.shared_expert.up_proj",
    "model.layers.38.mlp.shared_expert_gate",
    "model.layers.38.mlp_hyper_connection.block_inject_weight",
    "model.layers.38.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.38.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.39.attn_hyper_connection.block_inject_weight",
    "model.layers.39.attn_hyper_connection.input_mix_weight_down",
    "model.layers.39.attn_hyper_connection.input_mix_weight_up",
    "model.layers.39.mlp.shared_expert.down_proj",
    "model.layers.39.mlp.shared_expert.gate_proj",
    "model.layers.39.mlp.shared_expert.up_proj",
    "model.layers.39.mlp.shared_expert_gate",
    "model.layers.39.mlp_hyper_connection.block_inject_weight",
    "model.layers.39.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.39.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.39.self_attn.indexer.index_qk_proj",
    "model.layers.39.self_attn.k_proj",
    "model.layers.39.self_attn.o_proj",
    "model.layers.39.self_attn.q_proj",
    "model.layers.39.self_attn.v_proj",
    "model.layers.4.attn_hyper_connection.block_inject_weight",
    "model.layers.4.attn_hyper_connection.input_mix_weight_down",
    "model.layers.4.attn_hyper_connection.input_mix_weight_up",
    "model.layers.4.linear_attn.in_proj_a",
    "model.layers.4.linear_attn.in_proj_b",
    "model.layers.4.linear_attn.in_proj_qkv",
    "model.layers.4.linear_attn.in_proj_z",
    "model.layers.4.linear_attn.out_proj",
    "model.layers.4.mlp.shared_expert.down_proj",
    "model.layers.4.mlp.shared_expert.gate_proj",
    "model.layers.4.mlp.shared_expert.up_proj",
    "model.layers.4.mlp.shared_expert_gate",
    "model.layers.4.mlp_hyper_connection.block_inject_weight",
    "model.layers.4.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.4.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.40.attn_hyper_connection.block_inject_weight",
    "model.layers.40.attn_hyper_connection.input_mix_weight_down",
    "model.layers.40.attn_hyper_connection.input_mix_weight_up",
    "model.layers.40.linear_attn.in_proj_a",
    "model.layers.40.linear_attn.in_proj_b",
    "model.layers.40.linear_attn.in_proj_qkv",
    "model.layers.40.linear_attn.in_proj_z",
    "model.layers.40.linear_attn.out_proj",
    "model.layers.40.mlp.shared_expert.down_proj",
    "model.layers.40.mlp.shared_expert.gate_proj",
    "model.layers.40.mlp.shared_expert.up_proj",
    "model.layers.40.mlp.shared_expert_gate",
    "model.layers.40.mlp_hyper_connection.block_inject_weight",
    "model.layers.40.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.40.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.41.attn_hyper_connection.block_inject_weight",
    "model.layers.41.attn_hyper_connection.input_mix_weight_down",
    "model.layers.41.attn_hyper_connection.input_mix_weight_up",
    "model.layers.41.linear_attn.in_proj_a",
    "model.layers.41.linear_attn.in_proj_b",
    "model.layers.41.linear_attn.in_proj_qkv",
    "model.layers.41.linear_attn.in_proj_z",
    "model.layers.41.linear_attn.out_proj",
    "model.layers.41.mlp.shared_expert.down_proj",
    "model.layers.41.mlp.shared_expert.gate_proj",
    "model.layers.41.mlp.shared_expert.up_proj",
    "model.layers.41.mlp.shared_expert_gate",
    "model.layers.41.mlp_hyper_connection.block_inject_weight",
    "model.layers.41.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.41.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.42.attn_hyper_connection.block_inject_weight",
    "model.layers.42.attn_hyper_connection.input_mix_weight_down",
    "model.layers.42.attn_hyper_connection.input_mix_weight_up",
    "model.layers.42.linear_attn.in_proj_a",
    "model.layers.42.linear_attn.in_proj_b",
    "model.layers.42.linear_attn.in_proj_qkv",
    "model.layers.42.linear_attn.in_proj_z",
    "model.layers.42.linear_attn.out_proj",
    "model.layers.42.mlp.shared_expert.down_proj",
    "model.layers.42.mlp.shared_expert.gate_proj",
    "model.layers.42.mlp.shared_expert.up_proj",
    "model.layers.42.mlp.shared_expert_gate",
    "model.layers.42.mlp_hyper_connection.block_inject_weight",
    "model.layers.42.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.42.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.43.attn_hyper_connection.block_inject_weight",
    "model.layers.43.attn_hyper_connection.input_mix_weight_down",
    "model.layers.43.attn_hyper_connection.input_mix_weight_up",
    "model.layers.43.mlp.shared_expert.down_proj",
    "model.layers.43.mlp.shared_expert.gate_proj",
    "model.layers.43.mlp.shared_expert.up_proj",
    "model.layers.43.mlp.shared_expert_gate",
    "model.layers.43.mlp_hyper_connection.block_inject_weight",
    "model.layers.43.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.43.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.43.self_attn.indexer.index_qk_proj",
    "model.layers.43.self_attn.k_proj",
    "model.layers.43.self_attn.o_proj",
    "model.layers.43.self_attn.q_proj",
    "model.layers.43.self_attn.v_proj",
    "model.layers.44.attn_hyper_connection.block_inject_weight",
    "model.layers.44.attn_hyper_connection.input_mix_weight_down",
    "model.layers.44.attn_hyper_connection.input_mix_weight_up",
    "model.layers.44.linear_attn.in_proj_a",
    "model.layers.44.linear_attn.in_proj_b",
    "model.layers.44.linear_attn.in_proj_qkv",
    "model.layers.44.linear_attn.in_proj_z",
    "model.layers.44.linear_attn.out_proj",
    "model.layers.44.mlp.shared_expert.down_proj",
    "model.layers.44.mlp.shared_expert.gate_proj",
    "model.layers.44.mlp.shared_expert.up_proj",
    "model.layers.44.mlp.shared_expert_gate",
    "model.layers.44.mlp_hyper_connection.block_inject_weight",
    "model.layers.44.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.44.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.45.attn_hyper_connection.block_inject_weight",
    "model.layers.45.attn_hyper_connection.input_mix_weight_down",
    "model.layers.45.attn_hyper_connection.input_mix_weight_up",
    "model.layers.45.linear_attn.in_proj_a",
    "model.layers.45.linear_attn.in_proj_b",
    "model.layers.45.linear_attn.in_proj_qkv",
    "model.layers.45.linear_attn.in_proj_z",
    "model.layers.45.linear_attn.out_proj",
    "model.layers.45.mlp.shared_expert.down_proj",
    "model.layers.45.mlp.shared_expert.gate_proj",
    "model.layers.45.mlp.shared_expert.up_proj",
    "model.layers.45.mlp.shared_expert_gate",
    "model.layers.45.mlp_hyper_connection.block_inject_weight",
    "model.layers.45.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.45.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.46.attn_hyper_connection.block_inject_weight",
    "model.layers.46.attn_hyper_connection.input_mix_weight_down",
    "model.layers.46.attn_hyper_connection.input_mix_weight_up",
    "model.layers.46.linear_attn.in_proj_a",
    "model.layers.46.linear_attn.in_proj_b",
    "model.layers.46.linear_attn.in_proj_qkv",
    "model.layers.46.linear_attn.in_proj_z",
    "model.layers.46.linear_attn.out_proj",
    "model.layers.46.mlp.shared_expert.down_proj",
    "model.layers.46.mlp.shared_expert.gate_proj",
    "model.layers.46.mlp.shared_expert.up_proj",
    "model.layers.46.mlp.shared_expert_gate",
    "model.layers.46.mlp_hyper_connection.block_inject_weight",
    "model.layers.46.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.46.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.47.attn_hyper_connection.block_inject_weight",
    "model.layers.47.attn_hyper_connection.input_mix_weight_down",
    "model.layers.47.attn_hyper_connection.input_mix_weight_up",
    "model.layers.47.mlp.shared_expert.down_proj",
    "model.layers.47.mlp.shared_expert.gate_proj",
    "model.layers.47.mlp.shared_expert.up_proj",
    "model.layers.47.mlp.shared_expert_gate",
    "model.layers.47.mlp_hyper_connection.block_inject_weight",
    "model.layers.47.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.47.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.47.self_attn.indexer.index_qk_proj",
    "model.layers.47.self_attn.k_proj",
    "model.layers.47.self_attn.o_proj",
    "model.layers.47.self_attn.q_proj",
    "model.layers.47.self_attn.v_proj",
    "model.layers.5.attn_hyper_connection.block_inject_weight",
    "model.layers.5.attn_hyper_connection.input_mix_weight_down",
    "model.layers.5.attn_hyper_connection.input_mix_weight_up",
    "model.layers.5.linear_attn.in_proj_a",
    "model.layers.5.linear_attn.in_proj_b",
    "model.layers.5.linear_attn.in_proj_qkv",
    "model.layers.5.linear_attn.in_proj_z",
    "model.layers.5.linear_attn.out_proj",
    "model.layers.5.mlp.shared_expert.down_proj",
    "model.layers.5.mlp.shared_expert.gate_proj",
    "model.layers.5.mlp.shared_expert.up_proj",
    "model.layers.5.mlp.shared_expert_gate",
    "model.layers.5.mlp_hyper_connection.block_inject_weight",
    "model.layers.5.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.5.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.6.attn_hyper_connection.block_inject_weight",
    "model.layers.6.attn_hyper_connection.input_mix_weight_down",
    "model.layers.6.attn_hyper_connection.input_mix_weight_up",
    "model.layers.6.linear_attn.in_proj_a",
    "model.layers.6.linear_attn.in_proj_b",
    "model.layers.6.linear_attn.in_proj_qkv",
    "model.layers.6.linear_attn.in_proj_z",
    "model.layers.6.linear_attn.out_proj",
    "model.layers.6.mlp.shared_expert.down_proj",
    "model.layers.6.mlp.shared_expert.gate_proj",
    "model.layers.6.mlp.shared_expert.up_proj",
    "model.layers.6.mlp.shared_expert_gate",
    "model.layers.6.mlp_hyper_connection.block_inject_weight",
    "model.layers.6.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.6.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.7.attn_hyper_connection.block_inject_weight",
    "model.layers.7.attn_hyper_connection.input_mix_weight_down",
    "model.layers.7.attn_hyper_connection.input_mix_weight_up",
    "model.layers.7.mlp.shared_expert.down_proj",
    "model.layers.7.mlp.shared_expert.gate_proj",
    "model.layers.7.mlp.shared_expert.up_proj",
    "model.layers.7.mlp.shared_expert_gate",
    "model.layers.7.mlp_hyper_connection.block_inject_weight",
    "model.layers.7.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.7.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.7.self_attn.indexer.index_qk_proj",
    "model.layers.7.self_attn.k_proj",
    "model.layers.7.self_attn.o_proj",
    "model.layers.7.self_attn.q_proj",
    "model.layers.7.self_attn.v_proj",
    "model.layers.8.attn_hyper_connection.block_inject_weight",
    "model.layers.8.attn_hyper_connection.input_mix_weight_down",
    "model.layers.8.attn_hyper_connection.input_mix_weight_up",
    "model.layers.8.linear_attn.in_proj_a",
    "model.layers.8.linear_attn.in_proj_b",
    "model.layers.8.linear_attn.in_proj_qkv",
    "model.layers.8.linear_attn.in_proj_z",
    "model.layers.8.linear_attn.out_proj",
    "model.layers.8.mlp.shared_expert.down_proj",
    "model.layers.8.mlp.shared_expert.gate_proj",
    "model.layers.8.mlp.shared_expert.up_proj",
    "model.layers.8.mlp.shared_expert_gate",
    "model.layers.8.mlp_hyper_connection.block_inject_weight",
    "model.layers.8.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.8.mlp_hyper_connection.input_mix_weight_up",
    "model.layers.9.attn_hyper_connection.block_inject_weight",
    "model.layers.9.attn_hyper_connection.input_mix_weight_down",
    "model.layers.9.attn_hyper_connection.input_mix_weight_up",
    "model.layers.9.linear_attn.in_proj_a",
    "model.layers.9.linear_attn.in_proj_b",
    "model.layers.9.linear_attn.in_proj_qkv",
    "model.layers.9.linear_attn.in_proj_z",
    "model.layers.9.linear_attn.out_proj",
    "model.layers.9.mlp.shared_expert.down_proj",
    "model.layers.9.mlp.shared_expert.gate_proj",
    "model.layers.9.mlp.shared_expert.up_proj",
    "model.layers.9.mlp.shared_expert_gate",
    "model.layers.9.mlp_hyper_connection.block_inject_weight",
    "model.layers.9.mlp_hyper_connection.input_mix_weight_down",
    "model.layers.9.mlp_hyper_connection.input_mix_weight_up"
  ],
  "headers": [],
  "replaced_vq_bytes": 0,
  "replacement_affine_bytes": 0,
  "recoverable_payload_bytes": 0,
  "resident_payload_estimate_bytes": 5318309400,
  "unchanged": "VQ routed experts, VQ PLE tables, raw norm tensors and all other non-matched tensors. Preserve corrected BF16 norm folding.",
  "status": "hypothesis only; independent composite identity, full digest verification, traversal proof and fresh quality pilot required"
}
````

### vq-dense-affine-hybrid-audit-v1.log

Original bytes: 36681. SHA-256: `3535ac8195cc9704e11cbb535d6a324bf8e91b71a7ee9f7f9b89845570e0e9b0`.

Normalized bytes: 36681. SHA-256: `3535ac8195cc9704e11cbb535d6a324bf8e91b71a7ee9f7f9b89845570e0e9b0`.

````text
{"schema": 1, "scope": "Header-only same-checkpoint dense affine overlay feasibility; no candidate execution or payload qualification", "replaced_vq_bytes": 0, "replacement_affine_bytes": 0, "recoverable_payload_bytes": 0, "resident_payload_estimate_bytes": 5318309400, "unchanged": "VQ routed experts, VQ PLE tables, raw norm tensors and all other non-matched tensors. Preserve corrected BF16 norm folding.", "status": "hypothesis only; independent composite identity, full digest verification, traversal proof and fresh quality pilot required"}
modules 0 unmatched ['lm_head', 'model.embed_tokens', 'model.hyper_connection_mixer.input_mix_weight_down', 'model.hyper_connection_mixer.input_mix_weight_up', 'model.layers.0.attn_hyper_connection.block_inject_weight', 'model.layers.0.attn_hyper_connection.input_mix_weight_down', 'model.layers.0.attn_hyper_connection.input_mix_weight_up', 'model.layers.0.linear_attn.in_proj_a', 'model.layers.0.linear_attn.in_proj_b', 'model.layers.0.linear_attn.in_proj_qkv', 'model.layers.0.linear_attn.in_proj_z', 'model.layers.0.linear_attn.out_proj', 'model.layers.0.mlp.shared_expert.down_proj', 'model.layers.0.mlp.shared_expert.gate_proj', 'model.layers.0.mlp.shared_expert.up_proj', 'model.layers.0.mlp.shared_expert_gate', 'model.layers.0.mlp_hyper_connection.block_inject_weight', 'model.layers.0.mlp_hyper_connection.input_mix_weight_down', 'model.layers.0.mlp_hyper_connection.input_mix_weight_up', 'model.layers.1.attn_hyper_connection.block_inject_weight', 'model.layers.1.attn_hyper_connection.input_mix_weight_down', 'model.layers.1.attn_hyper_connection.input_mix_weight_up', 'model.layers.1.linear_attn.in_proj_a', 'model.layers.1.linear_attn.in_proj_b', 'model.layers.1.linear_attn.in_proj_qkv', 'model.layers.1.linear_attn.in_proj_z', 'model.layers.1.linear_attn.out_proj', 'model.layers.1.mlp.shared_expert.down_proj', 'model.layers.1.mlp.shared_expert.gate_proj', 'model.layers.1.mlp.shared_expert.up_proj', 'model.layers.1.mlp.shared_expert_gate', 'model.layers.1.mlp_hyper_connection.block_inject_weight', 'model.layers.1.mlp_hyper_connection.input_mix_weight_down', 'model.layers.1.mlp_hyper_connection.input_mix_weight_up', 'model.layers.1.ple.key_proj', 'model.layers.1.ple.value_proj', 'model.layers.10.attn_hyper_connection.block_inject_weight', 'model.layers.10.attn_hyper_connection.input_mix_weight_down', 'model.layers.10.attn_hyper_connection.input_mix_weight_up', 'model.layers.10.linear_attn.in_proj_a', 'model.layers.10.linear_attn.in_proj_b', 'model.layers.10.linear_attn.in_proj_qkv', 'model.layers.10.linear_attn.in_proj_z', 'model.layers.10.linear_attn.out_proj', 'model.layers.10.mlp.shared_expert.down_proj', 'model.layers.10.mlp.shared_expert.gate_proj', 'model.layers.10.mlp.shared_expert.up_proj', 'model.layers.10.mlp.shared_expert_gate', 'model.layers.10.mlp_hyper_connection.block_inject_weight', 'model.layers.10.mlp_hyper_connection.input_mix_weight_down', 'model.layers.10.mlp_hyper_connection.input_mix_weight_up', 'model.layers.11.attn_hyper_connection.block_inject_weight', 'model.layers.11.attn_hyper_connection.input_mix_weight_down', 'model.layers.11.attn_hyper_connection.input_mix_weight_up', 'model.layers.11.mlp.shared_expert.down_proj', 'model.layers.11.mlp.shared_expert.gate_proj', 'model.layers.11.mlp.shared_expert.up_proj', 'model.layers.11.mlp.shared_expert_gate', 'model.layers.11.mlp_hyper_connection.block_inject_weight', 'model.layers.11.mlp_hyper_connection.input_mix_weight_down', 'model.layers.11.mlp_hyper_connection.input_mix_weight_up', 'model.layers.11.self_attn.indexer.index_qk_proj', 'model.layers.11.self_attn.k_proj', 'model.layers.11.self_attn.o_proj', 'model.layers.11.self_attn.q_proj', 'model.layers.11.self_attn.v_proj', 'model.layers.12.attn_hyper_connection.block_inject_weight', 'model.layers.12.attn_hyper_connection.input_mix_weight_down', 'model.layers.12.attn_hyper_connection.input_mix_weight_up', 'model.layers.12.linear_attn.in_proj_a', 'model.layers.12.linear_attn.in_proj_b', 'model.layers.12.linear_attn.in_proj_qkv', 'model.layers.12.linear_attn.in_proj_z', 'model.layers.12.linear_attn.out_proj', 'model.layers.12.mlp.shared_expert.down_proj', 'model.layers.12.mlp.shared_expert.gate_proj', 'model.layers.12.mlp.shared_expert.up_proj', 'model.layers.12.mlp.shared_expert_gate', 'model.layers.12.mlp_hyper_connection.block_inject_weight', 'model.layers.12.mlp_hyper_connection.input_mix_weight_down', 'model.layers.12.mlp_hyper_connection.input_mix_weight_up', 'model.layers.13.attn_hyper_connection.block_inject_weight', 'model.layers.13.attn_hyper_connection.input_mix_weight_down', 'model.layers.13.attn_hyper_connection.input_mix_weight_up', 'model.layers.13.linear_attn.in_proj_a', 'model.layers.13.linear_attn.in_proj_b', 'model.layers.13.linear_attn.in_proj_qkv', 'model.layers.13.linear_attn.in_proj_z', 'model.layers.13.linear_attn.out_proj', 'model.layers.13.mlp.shared_expert.down_proj', 'model.layers.13.mlp.shared_expert.gate_proj', 'model.layers.13.mlp.shared_expert.up_proj', 'model.layers.13.mlp.shared_expert_gate', 'model.layers.13.mlp_hyper_connection.block_inject_weight', 'model.layers.13.mlp_hyper_connection.input_mix_weight_down', 'model.layers.13.mlp_hyper_connection.input_mix_weight_up', 'model.layers.14.attn_hyper_connection.block_inject_weight', 'model.layers.14.attn_hyper_connection.input_mix_weight_down', 'model.layers.14.attn_hyper_connection.input_mix_weight_up', 'model.layers.14.linear_attn.in_proj_a', 'model.layers.14.linear_attn.in_proj_b', 'model.layers.14.linear_attn.in_proj_qkv', 'model.layers.14.linear_attn.in_proj_z', 'model.layers.14.linear_attn.out_proj', 'model.layers.14.mlp.shared_expert.down_proj', 'model.layers.14.mlp.shared_expert.gate_proj', 'model.layers.14.mlp.shared_expert.up_proj', 'model.layers.14.mlp.shared_expert_gate', 'model.layers.14.mlp_hyper_connection.block_inject_weight', 'model.layers.14.mlp_hyper_connection.input_mix_weight_down', 'model.layers.14.mlp_hyper_connection.input_mix_weight_up', 'model.layers.15.attn_hyper_connection.block_inject_weight', 'model.layers.15.attn_hyper_connection.input_mix_weight_down', 'model.layers.15.attn_hyper_connection.input_mix_weight_up', 'model.layers.15.mlp.shared_expert.down_proj', 'model.layers.15.mlp.shared_expert.gate_proj', 'model.layers.15.mlp.shared_expert.up_proj', 'model.layers.15.mlp.shared_expert_gate', 'model.layers.15.mlp_hyper_connection.block_inject_weight', 'model.layers.15.mlp_hyper_connection.input_mix_weight_down', 'model.layers.15.mlp_hyper_connection.input_mix_weight_up', 'model.layers.15.self_attn.indexer.index_qk_proj', 'model.layers.15.self_attn.k_proj', 'model.layers.15.self_attn.o_proj', 'model.layers.15.self_attn.q_proj', 'model.layers.15.self_attn.v_proj', 'model.layers.16.attn_hyper_connection.block_inject_weight', 'model.layers.16.attn_hyper_connection.input_mix_weight_down', 'model.layers.16.attn_hyper_connection.input_mix_weight_up', 'model.layers.16.linear_attn.in_proj_a', 'model.layers.16.linear_attn.in_proj_b', 'model.layers.16.linear_attn.in_proj_qkv', 'model.layers.16.linear_attn.in_proj_z', 'model.layers.16.linear_attn.out_proj', 'model.layers.16.mlp.shared_expert.down_proj', 'model.layers.16.mlp.shared_expert.gate_proj', 'model.layers.16.mlp.shared_expert.up_proj', 'model.layers.16.mlp.shared_expert_gate', 'model.layers.16.mlp_hyper_connection.block_inject_weight', 'model.layers.16.mlp_hyper_connection.input_mix_weight_down', 'model.layers.16.mlp_hyper_connection.input_mix_weight_up', 'model.layers.17.attn_hyper_connection.block_inject_weight', 'model.layers.17.attn_hyper_connection.input_mix_weight_down', 'model.layers.17.attn_hyper_connection.input_mix_weight_up', 'model.layers.17.linear_attn.in_proj_a', 'model.layers.17.linear_attn.in_proj_b', 'model.layers.17.linear_attn.in_proj_qkv', 'model.layers.17.linear_attn.in_proj_z', 'model.layers.17.linear_attn.out_proj', 'model.layers.17.mlp.shared_expert.down_proj', 'model.layers.17.mlp.shared_expert.gate_proj', 'model.layers.17.mlp.shared_expert.up_proj', 'model.layers.17.mlp.shared_expert_gate', 'model.layers.17.mlp_hyper_connection.block_inject_weight', 'model.layers.17.mlp_hyper_connection.input_mix_weight_down', 'model.layers.17.mlp_hyper_connection.input_mix_weight_up', 'model.layers.18.attn_hyper_connection.block_inject_weight', 'model.layers.18.attn_hyper_connection.input_mix_weight_down', 'model.layers.18.attn_hyper_connection.input_mix_weight_up', 'model.layers.18.linear_attn.in_proj_a', 'model.layers.18.linear_attn.in_proj_b', 'model.layers.18.linear_attn.in_proj_qkv', 'model.layers.18.linear_attn.in_proj_z', 'model.layers.18.linear_attn.out_proj', 'model.layers.18.mlp.shared_expert.down_proj', 'model.layers.18.mlp.shared_expert.gate_proj', 'model.layers.18.mlp.shared_expert.up_proj', 'model.layers.18.mlp.shared_expert_gate', 'model.layers.18.mlp_hyper_connection.block_inject_weight', 'model.layers.18.mlp_hyper_connection.input_mix_weight_down', 'model.layers.18.mlp_hyper_connection.input_mix_weight_up', 'model.layers.19.attn_hyper_connection.block_inject_weight', 'model.layers.19.attn_hyper_connection.input_mix_weight_down', 'model.layers.19.attn_hyper_connection.input_mix_weight_up', 'model.layers.19.mlp.shared_expert.down_proj', 'model.layers.19.mlp.shared_expert.gate_proj', 'model.layers.19.mlp.shared_expert.up_proj', 'model.layers.19.mlp.shared_expert_gate', 'model.layers.19.mlp_hyper_connection.block_inject_weight', 'model.layers.19.mlp_hyper_connection.input_mix_weight_down', 'model.layers.19.mlp_hyper_connection.input_mix_weight_up', 'model.layers.19.self_attn.indexer.index_qk_proj', 'model.layers.19.self_attn.k_proj', 'model.layers.19.self_attn.o_proj', 'model.layers.19.self_attn.q_proj', 'model.layers.19.self_attn.v_proj', 'model.layers.2.attn_hyper_connection.block_inject_weight', 'model.layers.2.attn_hyper_connection.input_mix_weight_down', 'model.layers.2.attn_hyper_connection.input_mix_weight_up', 'model.layers.2.linear_attn.in_proj_a', 'model.layers.2.linear_attn.in_proj_b', 'model.layers.2.linear_attn.in_proj_qkv', 'model.layers.2.linear_attn.in_proj_z', 'model.layers.2.linear_attn.out_proj', 'model.layers.2.mlp.shared_expert.down_proj', 'model.layers.2.mlp.shared_expert.gate_proj', 'model.layers.2.mlp.shared_expert.up_proj', 'model.layers.2.mlp.shared_expert_gate', 'model.layers.2.mlp_hyper_connection.block_inject_weight', 'model.layers.2.mlp_hyper_connection.input_mix_weight_down', 'model.layers.2.mlp_hyper_connection.input_mix_weight_up', 'model.layers.20.attn_hyper_connection.block_inject_weight', 'model.layers.20.attn_hyper_connection.input_mix_weight_down', 'model.layers.20.attn_hyper_connection.input_mix_weight_up', 'model.layers.20.linear_attn.in_proj_a', 'model.layers.20.linear_attn.in_proj_b', 'model.layers.20.linear_attn.in_proj_qkv', 'model.layers.20.linear_attn.in_proj_z', 'model.layers.20.linear_attn.out_proj', 'model.layers.20.mlp.shared_expert.down_proj', 'model.layers.20.mlp.shared_expert.gate_proj', 'model.layers.20.mlp.shared_expert.up_proj', 'model.layers.20.mlp.shared_expert_gate', 'model.layers.20.mlp_hyper_connection.block_inject_weight', 'model.layers.20.mlp_hyper_connection.input_mix_weight_down', 'model.layers.20.mlp_hyper_connection.input_mix_weight_up', 'model.layers.21.attn_hyper_connection.block_inject_weight', 'model.layers.21.attn_hyper_connection.input_mix_weight_down', 'model.layers.21.attn_hyper_connection.input_mix_weight_up', 'model.layers.21.linear_attn.in_proj_a', 'model.layers.21.linear_attn.in_proj_b', 'model.layers.21.linear_attn.in_proj_qkv', 'model.layers.21.linear_attn.in_proj_z', 'model.layers.21.linear_attn.out_proj', 'model.layers.21.mlp.shared_expert.down_proj', 'model.layers.21.mlp.shared_expert.gate_proj', 'model.layers.21.mlp.shared_expert.up_proj', 'model.layers.21.mlp.shared_expert_gate', 'model.layers.21.mlp_hyper_connection.block_inject_weight', 'model.layers.21.mlp_hyper_connection.input_mix_weight_down', 'model.layers.21.mlp_hyper_connection.input_mix_weight_up', 'model.layers.22.attn_hyper_connection.block_inject_weight', 'model.layers.22.attn_hyper_connection.input_mix_weight_down', 'model.layers.22.attn_hyper_connection.input_mix_weight_up', 'model.layers.22.linear_attn.in_proj_a', 'model.layers.22.linear_attn.in_proj_b', 'model.layers.22.linear_attn.in_proj_qkv', 'model.layers.22.linear_attn.in_proj_z', 'model.layers.22.linear_attn.out_proj', 'model.layers.22.mlp.shared_expert.down_proj', 'model.layers.22.mlp.shared_expert.gate_proj', 'model.layers.22.mlp.shared_expert.up_proj', 'model.layers.22.mlp.shared_expert_gate', 'model.layers.22.mlp_hyper_connection.block_inject_weight', 'model.layers.22.mlp_hyper_connection.input_mix_weight_down', 'model.layers.22.mlp_hyper_connection.input_mix_weight_up', 'model.layers.23.attn_hyper_connection.block_inject_weight', 'model.layers.23.attn_hyper_connection.input_mix_weight_down', 'model.layers.23.attn_hyper_connection.input_mix_weight_up', 'model.layers.23.mlp.shared_expert.down_proj', 'model.layers.23.mlp.shared_expert.gate_proj', 'model.layers.23.mlp.shared_expert.up_proj', 'model.layers.23.mlp.shared_expert_gate', 'model.layers.23.mlp_hyper_connection.block_inject_weight', 'model.layers.23.mlp_hyper_connection.input_mix_weight_down', 'model.layers.23.mlp_hyper_connection.input_mix_weight_up', 'model.layers.23.self_attn.indexer.index_qk_proj', 'model.layers.23.self_attn.k_proj', 'model.layers.23.self_attn.o_proj', 'model.layers.23.self_attn.q_proj', 'model.layers.23.self_attn.v_proj', 'model.layers.24.attn_hyper_connection.block_inject_weight', 'model.layers.24.attn_hyper_connection.input_mix_weight_down', 'model.layers.24.attn_hyper_connection.input_mix_weight_up', 'model.layers.24.linear_attn.in_proj_a', 'model.layers.24.linear_attn.in_proj_b', 'model.layers.24.linear_attn.in_proj_qkv', 'model.layers.24.linear_attn.in_proj_z', 'model.layers.24.linear_attn.out_proj', 'model.layers.24.mlp.shared_expert.down_proj', 'model.layers.24.mlp.shared_expert.gate_proj', 'model.layers.24.mlp.shared_expert.up_proj', 'model.layers.24.mlp.shared_expert_gate', 'model.layers.24.mlp_hyper_connection.block_inject_weight', 'model.layers.24.mlp_hyper_connection.input_mix_weight_down', 'model.layers.24.mlp_hyper_connection.input_mix_weight_up', 'model.layers.25.attn_hyper_connection.block_inject_weight', 'model.layers.25.attn_hyper_connection.input_mix_weight_down', 'model.layers.25.attn_hyper_connection.input_mix_weight_up', 'model.layers.25.linear_attn.in_proj_a', 'model.layers.25.linear_attn.in_proj_b', 'model.layers.25.linear_attn.in_proj_qkv', 'model.layers.25.linear_attn.in_proj_z', 'model.layers.25.linear_attn.out_proj', 'model.layers.25.mlp.shared_expert.down_proj', 'model.layers.25.mlp.shared_expert.gate_proj', 'model.layers.25.mlp.shared_expert.up_proj', 'model.layers.25.mlp.shared_expert_gate', 'model.layers.25.mlp_hyper_connection.block_inject_weight', 'model.layers.25.mlp_hyper_connection.input_mix_weight_down', 'model.layers.25.mlp_hyper_connection.input_mix_weight_up', 'model.layers.26.attn_hyper_connection.block_inject_weight', 'model.layers.26.attn_hyper_connection.input_mix_weight_down', 'model.layers.26.attn_hyper_connection.input_mix_weight_up', 'model.layers.26.linear_attn.in_proj_a', 'model.layers.26.linear_attn.in_proj_b', 'model.layers.26.linear_attn.in_proj_qkv', 'model.layers.26.linear_attn.in_proj_z', 'model.layers.26.linear_attn.out_proj', 'model.layers.26.mlp.shared_expert.down_proj', 'model.layers.26.mlp.shared_expert.gate_proj', 'model.layers.26.mlp.shared_expert.up_proj', 'model.layers.26.mlp.shared_expert_gate', 'model.layers.26.mlp_hyper_connection.block_inject_weight', 'model.layers.26.mlp_hyper_connection.input_mix_weight_down', 'model.layers.26.mlp_hyper_connection.input_mix_weight_up', 'model.layers.27.attn_hyper_connection.block_inject_weight', 'model.layers.27.attn_hyper_connection.input_mix_weight_down', 'model.layers.27.attn_hyper_connection.input_mix_weight_up', 'model.layers.27.mlp.shared_expert.down_proj', 'model.layers.27.mlp.shared_expert.gate_proj', 'model.layers.27.mlp.shared_expert.up_proj', 'model.layers.27.mlp.shared_expert_gate', 'model.layers.27.mlp_hyper_connection.block_inject_weight', 'model.layers.27.mlp_hyper_connection.input_mix_weight_down', 'model.layers.27.mlp_hyper_connection.input_mix_weight_up', 'model.layers.27.self_attn.indexer.index_qk_proj', 'model.layers.27.self_attn.k_proj', 'model.layers.27.self_attn.o_proj', 'model.layers.27.self_attn.q_proj', 'model.layers.27.self_attn.v_proj', 'model.layers.28.attn_hyper_connection.block_inject_weight', 'model.layers.28.attn_hyper_connection.input_mix_weight_down', 'model.layers.28.attn_hyper_connection.input_mix_weight_up', 'model.layers.28.linear_attn.in_proj_a', 'model.layers.28.linear_attn.in_proj_b', 'model.layers.28.linear_attn.in_proj_qkv', 'model.layers.28.linear_attn.in_proj_z', 'model.layers.28.linear_attn.out_proj', 'model.layers.28.mlp.shared_expert.down_proj', 'model.layers.28.mlp.shared_expert.gate_proj', 'model.layers.28.mlp.shared_expert.up_proj', 'model.layers.28.mlp.shared_expert_gate', 'model.layers.28.mlp_hyper_connection.block_inject_weight', 'model.layers.28.mlp_hyper_connection.input_mix_weight_down', 'model.layers.28.mlp_hyper_connection.input_mix_weight_up', 'model.layers.29.attn_hyper_connection.block_inject_weight', 'model.layers.29.attn_hyper_connection.input_mix_weight_down', 'model.layers.29.attn_hyper_connection.input_mix_weight_up', 'model.layers.29.linear_attn.in_proj_a', 'model.layers.29.linear_attn.in_proj_b', 'model.layers.29.linear_attn.in_proj_qkv', 'model.layers.29.linear_attn.in_proj_z', 'model.layers.29.linear_attn.out_proj', 'model.layers.29.mlp.shared_expert.down_proj', 'model.layers.29.mlp.shared_expert.gate_proj', 'model.layers.29.mlp.shared_expert.up_proj', 'model.layers.29.mlp.shared_expert_gate', 'model.layers.29.mlp_hyper_connection.block_inject_weight', 'model.layers.29.mlp_hyper_connection.input_mix_weight_down', 'model.layers.29.mlp_hyper_connection.input_mix_weight_up', 'model.layers.3.attn_hyper_connection.block_inject_weight', 'model.layers.3.attn_hyper_connection.input_mix_weight_down', 'model.layers.3.attn_hyper_connection.input_mix_weight_up', 'model.layers.3.mlp.shared_expert.down_proj', 'model.layers.3.mlp.shared_expert.gate_proj', 'model.layers.3.mlp.shared_expert.up_proj', 'model.layers.3.mlp.shared_expert_gate', 'model.layers.3.mlp_hyper_connection.block_inject_weight', 'model.layers.3.mlp_hyper_connection.input_mix_weight_down', 'model.layers.3.mlp_hyper_connection.input_mix_weight_up', 'model.layers.3.self_attn.indexer.index_qk_proj', 'model.layers.3.self_attn.k_proj', 'model.layers.3.self_attn.o_proj', 'model.layers.3.self_attn.q_proj', 'model.layers.3.self_attn.v_proj', 'model.layers.30.attn_hyper_connection.block_inject_weight', 'model.layers.30.attn_hyper_connection.input_mix_weight_down', 'model.layers.30.attn_hyper_connection.input_mix_weight_up', 'model.layers.30.linear_attn.in_proj_a', 'model.layers.30.linear_attn.in_proj_b', 'model.layers.30.linear_attn.in_proj_qkv', 'model.layers.30.linear_attn.in_proj_z', 'model.layers.30.linear_attn.out_proj', 'model.layers.30.mlp.shared_expert.down_proj', 'model.layers.30.mlp.shared_expert.gate_proj', 'model.layers.30.mlp.shared_expert.up_proj', 'model.layers.30.mlp.shared_expert_gate', 'model.layers.30.mlp_hyper_connection.block_inject_weight', 'model.layers.30.mlp_hyper_connection.input_mix_weight_down', 'model.layers.30.mlp_hyper_connection.input_mix_weight_up', 'model.layers.31.attn_hyper_connection.block_inject_weight', 'model.layers.31.attn_hyper_connection.input_mix_weight_down', 'model.layers.31.attn_hyper_connection.input_mix_weight_up', 'model.layers.31.mlp.shared_expert.down_proj', 'model.layers.31.mlp.shared_expert.gate_proj', 'model.layers.31.mlp.shared_expert.up_proj', 'model.layers.31.mlp.shared_expert_gate', 'model.layers.31.mlp_hyper_connection.block_inject_weight', 'model.layers.31.mlp_hyper_connection.input_mix_weight_down', 'model.layers.31.mlp_hyper_connection.input_mix_weight_up', 'model.layers.31.self_attn.indexer.index_qk_proj', 'model.layers.31.self_attn.k_proj', 'model.layers.31.self_attn.o_proj', 'model.layers.31.self_attn.q_proj', 'model.layers.31.self_attn.v_proj', 'model.layers.32.attn_hyper_connection.block_inject_weight', 'model.layers.32.attn_hyper_connection.input_mix_weight_down', 'model.layers.32.attn_hyper_connection.input_mix_weight_up', 'model.layers.32.linear_attn.in_proj_a', 'model.layers.32.linear_attn.in_proj_b', 'model.layers.32.linear_attn.in_proj_qkv', 'model.layers.32.linear_attn.in_proj_z', 'model.layers.32.linear_attn.out_proj', 'model.layers.32.mlp.shared_expert.down_proj', 'model.layers.32.mlp.shared_expert.gate_proj', 'model.layers.32.mlp.shared_expert.up_proj', 'model.layers.32.mlp.shared_expert_gate', 'model.layers.32.mlp_hyper_connection.block_inject_weight', 'model.layers.32.mlp_hyper_connection.input_mix_weight_down', 'model.layers.32.mlp_hyper_connection.input_mix_weight_up', 'model.layers.33.attn_hyper_connection.block_inject_weight', 'model.layers.33.attn_hyper_connection.input_mix_weight_down', 'model.layers.33.attn_hyper_connection.input_mix_weight_up', 'model.layers.33.linear_attn.in_proj_a', 'model.layers.33.linear_attn.in_proj_b', 'model.layers.33.linear_attn.in_proj_qkv', 'model.layers.33.linear_attn.in_proj_z', 'model.layers.33.linear_attn.out_proj', 'model.layers.33.mlp.shared_expert.down_proj', 'model.layers.33.mlp.shared_expert.gate_proj', 'model.layers.33.mlp.shared_expert.up_proj', 'model.layers.33.mlp.shared_expert_gate', 'model.layers.33.mlp_hyper_connection.block_inject_weight', 'model.layers.33.mlp_hyper_connection.input_mix_weight_down', 'model.layers.33.mlp_hyper_connection.input_mix_weight_up', 'model.layers.34.attn_hyper_connection.block_inject_weight', 'model.layers.34.attn_hyper_connection.input_mix_weight_down', 'model.layers.34.attn_hyper_connection.input_mix_weight_up', 'model.layers.34.linear_attn.in_proj_a', 'model.layers.34.linear_attn.in_proj_b', 'model.layers.34.linear_attn.in_proj_qkv', 'model.layers.34.linear_attn.in_proj_z', 'model.layers.34.linear_attn.out_proj', 'model.layers.34.mlp.shared_expert.down_proj', 'model.layers.34.mlp.shared_expert.gate_proj', 'model.layers.34.mlp.shared_expert.up_proj', 'model.layers.34.mlp.shared_expert_gate', 'model.layers.34.mlp_hyper_connection.block_inject_weight', 'model.layers.34.mlp_hyper_connection.input_mix_weight_down', 'model.layers.34.mlp_hyper_connection.input_mix_weight_up', 'model.layers.35.attn_hyper_connection.block_inject_weight', 'model.layers.35.attn_hyper_connection.input_mix_weight_down', 'model.layers.35.attn_hyper_connection.input_mix_weight_up', 'model.layers.35.mlp.shared_expert.down_proj', 'model.layers.35.mlp.shared_expert.gate_proj', 'model.layers.35.mlp.shared_expert.up_proj', 'model.layers.35.mlp.shared_expert_gate', 'model.layers.35.mlp_hyper_connection.block_inject_weight', 'model.layers.35.mlp_hyper_connection.input_mix_weight_down', 'model.layers.35.mlp_hyper_connection.input_mix_weight_up', 'model.layers.35.self_attn.indexer.index_qk_proj', 'model.layers.35.self_attn.k_proj', 'model.layers.35.self_attn.o_proj', 'model.layers.35.self_attn.q_proj', 'model.layers.35.self_attn.v_proj', 'model.layers.36.attn_hyper_connection.block_inject_weight', 'model.layers.36.attn_hyper_connection.input_mix_weight_down', 'model.layers.36.attn_hyper_connection.input_mix_weight_up', 'model.layers.36.linear_attn.in_proj_a', 'model.layers.36.linear_attn.in_proj_b', 'model.layers.36.linear_attn.in_proj_qkv', 'model.layers.36.linear_attn.in_proj_z', 'model.layers.36.linear_attn.out_proj', 'model.layers.36.mlp.shared_expert.down_proj', 'model.layers.36.mlp.shared_expert.gate_proj', 'model.layers.36.mlp.shared_expert.up_proj', 'model.layers.36.mlp.shared_expert_gate', 'model.layers.36.mlp_hyper_connection.block_inject_weight', 'model.layers.36.mlp_hyper_connection.input_mix_weight_down', 'model.layers.36.mlp_hyper_connection.input_mix_weight_up', 'model.layers.37.attn_hyper_connection.block_inject_weight', 'model.layers.37.attn_hyper_connection.input_mix_weight_down', 'model.layers.37.attn_hyper_connection.input_mix_weight_up', 'model.layers.37.linear_attn.in_proj_a', 'model.layers.37.linear_attn.in_proj_b', 'model.layers.37.linear_attn.in_proj_qkv', 'model.layers.37.linear_attn.in_proj_z', 'model.layers.37.linear_attn.out_proj', 'model.layers.37.mlp.shared_expert.down_proj', 'model.layers.37.mlp.shared_expert.gate_proj', 'model.layers.37.mlp.shared_expert.up_proj', 'model.layers.37.mlp.shared_expert_gate', 'model.layers.37.mlp_hyper_connection.block_inject_weight', 'model.layers.37.mlp_hyper_connection.input_mix_weight_down', 'model.layers.37.mlp_hyper_connection.input_mix_weight_up', 'model.layers.38.attn_hyper_connection.block_inject_weight', 'model.layers.38.attn_hyper_connection.input_mix_weight_down', 'model.layers.38.attn_hyper_connection.input_mix_weight_up', 'model.layers.38.linear_attn.in_proj_a', 'model.layers.38.linear_attn.in_proj_b', 'model.layers.38.linear_attn.in_proj_qkv', 'model.layers.38.linear_attn.in_proj_z', 'model.layers.38.linear_attn.out_proj', 'model.layers.38.mlp.shared_expert.down_proj', 'model.layers.38.mlp.shared_expert.gate_proj', 'model.layers.38.mlp.shared_expert.up_proj', 'model.layers.38.mlp.shared_expert_gate', 'model.layers.38.mlp_hyper_connection.block_inject_weight', 'model.layers.38.mlp_hyper_connection.input_mix_weight_down', 'model.layers.38.mlp_hyper_connection.input_mix_weight_up', 'model.layers.39.attn_hyper_connection.block_inject_weight', 'model.layers.39.attn_hyper_connection.input_mix_weight_down', 'model.layers.39.attn_hyper_connection.input_mix_weight_up', 'model.layers.39.mlp.shared_expert.down_proj', 'model.layers.39.mlp.shared_expert.gate_proj', 'model.layers.39.mlp.shared_expert.up_proj', 'model.layers.39.mlp.shared_expert_gate', 'model.layers.39.mlp_hyper_connection.block_inject_weight', 'model.layers.39.mlp_hyper_connection.input_mix_weight_down', 'model.layers.39.mlp_hyper_connection.input_mix_weight_up', 'model.layers.39.self_attn.indexer.index_qk_proj', 'model.layers.39.self_attn.k_proj', 'model.layers.39.self_attn.o_proj', 'model.layers.39.self_attn.q_proj', 'model.layers.39.self_attn.v_proj', 'model.layers.4.attn_hyper_connection.block_inject_weight', 'model.layers.4.attn_hyper_connection.input_mix_weight_down', 'model.layers.4.attn_hyper_connection.input_mix_weight_up', 'model.layers.4.linear_attn.in_proj_a', 'model.layers.4.linear_attn.in_proj_b', 'model.layers.4.linear_attn.in_proj_qkv', 'model.layers.4.linear_attn.in_proj_z', 'model.layers.4.linear_attn.out_proj', 'model.layers.4.mlp.shared_expert.down_proj', 'model.layers.4.mlp.shared_expert.gate_proj', 'model.layers.4.mlp.shared_expert.up_proj', 'model.layers.4.mlp.shared_expert_gate', 'model.layers.4.mlp_hyper_connection.block_inject_weight', 'model.layers.4.mlp_hyper_connection.input_mix_weight_down', 'model.layers.4.mlp_hyper_connection.input_mix_weight_up', 'model.layers.40.attn_hyper_connection.block_inject_weight', 'model.layers.40.attn_hyper_connection.input_mix_weight_down', 'model.layers.40.attn_hyper_connection.input_mix_weight_up', 'model.layers.40.linear_attn.in_proj_a', 'model.layers.40.linear_attn.in_proj_b', 'model.layers.40.linear_attn.in_proj_qkv', 'model.layers.40.linear_attn.in_proj_z', 'model.layers.40.linear_attn.out_proj', 'model.layers.40.mlp.shared_expert.down_proj', 'model.layers.40.mlp.shared_expert.gate_proj', 'model.layers.40.mlp.shared_expert.up_proj', 'model.layers.40.mlp.shared_expert_gate', 'model.layers.40.mlp_hyper_connection.block_inject_weight', 'model.layers.40.mlp_hyper_connection.input_mix_weight_down', 'model.layers.40.mlp_hyper_connection.input_mix_weight_up', 'model.layers.41.attn_hyper_connection.block_inject_weight', 'model.layers.41.attn_hyper_connection.input_mix_weight_down', 'model.layers.41.attn_hyper_connection.input_mix_weight_up', 'model.layers.41.linear_attn.in_proj_a', 'model.layers.41.linear_attn.in_proj_b', 'model.layers.41.linear_attn.in_proj_qkv', 'model.layers.41.linear_attn.in_proj_z', 'model.layers.41.linear_attn.out_proj', 'model.layers.41.mlp.shared_expert.down_proj', 'model.layers.41.mlp.shared_expert.gate_proj', 'model.layers.41.mlp.shared_expert.up_proj', 'model.layers.41.mlp.shared_expert_gate', 'model.layers.41.mlp_hyper_connection.block_inject_weight', 'model.layers.41.mlp_hyper_connection.input_mix_weight_down', 'model.layers.41.mlp_hyper_connection.input_mix_weight_up', 'model.layers.42.attn_hyper_connection.block_inject_weight', 'model.layers.42.attn_hyper_connection.input_mix_weight_down', 'model.layers.42.attn_hyper_connection.input_mix_weight_up', 'model.layers.42.linear_attn.in_proj_a', 'model.layers.42.linear_attn.in_proj_b', 'model.layers.42.linear_attn.in_proj_qkv', 'model.layers.42.linear_attn.in_proj_z', 'model.layers.42.linear_attn.out_proj', 'model.layers.42.mlp.shared_expert.down_proj', 'model.layers.42.mlp.shared_expert.gate_proj', 'model.layers.42.mlp.shared_expert.up_proj', 'model.layers.42.mlp.shared_expert_gate', 'model.layers.42.mlp_hyper_connection.block_inject_weight', 'model.layers.42.mlp_hyper_connection.input_mix_weight_down', 'model.layers.42.mlp_hyper_connection.input_mix_weight_up', 'model.layers.43.attn_hyper_connection.block_inject_weight', 'model.layers.43.attn_hyper_connection.input_mix_weight_down', 'model.layers.43.attn_hyper_connection.input_mix_weight_up', 'model.layers.43.mlp.shared_expert.down_proj', 'model.layers.43.mlp.shared_expert.gate_proj', 'model.layers.43.mlp.shared_expert.up_proj', 'model.layers.43.mlp.shared_expert_gate', 'model.layers.43.mlp_hyper_connection.block_inject_weight', 'model.layers.43.mlp_hyper_connection.input_mix_weight_down', 'model.layers.43.mlp_hyper_connection.input_mix_weight_up', 'model.layers.43.self_attn.indexer.index_qk_proj', 'model.layers.43.self_attn.k_proj', 'model.layers.43.self_attn.o_proj', 'model.layers.43.self_attn.q_proj', 'model.layers.43.self_attn.v_proj', 'model.layers.44.attn_hyper_connection.block_inject_weight', 'model.layers.44.attn_hyper_connection.input_mix_weight_down', 'model.layers.44.attn_hyper_connection.input_mix_weight_up', 'model.layers.44.linear_attn.in_proj_a', 'model.layers.44.linear_attn.in_proj_b', 'model.layers.44.linear_attn.in_proj_qkv', 'model.layers.44.linear_attn.in_proj_z', 'model.layers.44.linear_attn.out_proj', 'model.layers.44.mlp.shared_expert.down_proj', 'model.layers.44.mlp.shared_expert.gate_proj', 'model.layers.44.mlp.shared_expert.up_proj', 'model.layers.44.mlp.shared_expert_gate', 'model.layers.44.mlp_hyper_connection.block_inject_weight', 'model.layers.44.mlp_hyper_connection.input_mix_weight_down', 'model.layers.44.mlp_hyper_connection.input_mix_weight_up', 'model.layers.45.attn_hyper_connection.block_inject_weight', 'model.layers.45.attn_hyper_connection.input_mix_weight_down', 'model.layers.45.attn_hyper_connection.input_mix_weight_up', 'model.layers.45.linear_attn.in_proj_a', 'model.layers.45.linear_attn.in_proj_b', 'model.layers.45.linear_attn.in_proj_qkv', 'model.layers.45.linear_attn.in_proj_z', 'model.layers.45.linear_attn.out_proj', 'model.layers.45.mlp.shared_expert.down_proj', 'model.layers.45.mlp.shared_expert.gate_proj', 'model.layers.45.mlp.shared_expert.up_proj', 'model.layers.45.mlp.shared_expert_gate', 'model.layers.45.mlp_hyper_connection.block_inject_weight', 'model.layers.45.mlp_hyper_connection.input_mix_weight_down', 'model.layers.45.mlp_hyper_connection.input_mix_weight_up', 'model.layers.46.attn_hyper_connection.block_inject_weight', 'model.layers.46.attn_hyper_connection.input_mix_weight_down', 'model.layers.46.attn_hyper_connection.input_mix_weight_up', 'model.layers.46.linear_attn.in_proj_a', 'model.layers.46.linear_attn.in_proj_b', 'model.layers.46.linear_attn.in_proj_qkv', 'model.layers.46.linear_attn.in_proj_z', 'model.layers.46.linear_attn.out_proj', 'model.layers.46.mlp.shared_expert.down_proj', 'model.layers.46.mlp.shared_expert.gate_proj', 'model.layers.46.mlp.shared_expert.up_proj', 'model.layers.46.mlp.shared_expert_gate', 'model.layers.46.mlp_hyper_connection.block_inject_weight', 'model.layers.46.mlp_hyper_connection.input_mix_weight_down', 'model.layers.46.mlp_hyper_connection.input_mix_weight_up', 'model.layers.47.attn_hyper_connection.block_inject_weight', 'model.layers.47.attn_hyper_connection.input_mix_weight_down', 'model.layers.47.attn_hyper_connection.input_mix_weight_up', 'model.layers.47.mlp.shared_expert.down_proj', 'model.layers.47.mlp.shared_expert.gate_proj', 'model.layers.47.mlp.shared_expert.up_proj', 'model.layers.47.mlp.shared_expert_gate', 'model.layers.47.mlp_hyper_connection.block_inject_weight', 'model.layers.47.mlp_hyper_connection.input_mix_weight_down', 'model.layers.47.mlp_hyper_connection.input_mix_weight_up', 'model.layers.47.self_attn.indexer.index_qk_proj', 'model.layers.47.self_attn.k_proj', 'model.layers.47.self_attn.o_proj', 'model.layers.47.self_attn.q_proj', 'model.layers.47.self_attn.v_proj', 'model.layers.5.attn_hyper_connection.block_inject_weight', 'model.layers.5.attn_hyper_connection.input_mix_weight_down', 'model.layers.5.attn_hyper_connection.input_mix_weight_up', 'model.layers.5.linear_attn.in_proj_a', 'model.layers.5.linear_attn.in_proj_b', 'model.layers.5.linear_attn.in_proj_qkv', 'model.layers.5.linear_attn.in_proj_z', 'model.layers.5.linear_attn.out_proj', 'model.layers.5.mlp.shared_expert.down_proj', 'model.layers.5.mlp.shared_expert.gate_proj', 'model.layers.5.mlp.shared_expert.up_proj', 'model.layers.5.mlp.shared_expert_gate', 'model.layers.5.mlp_hyper_connection.block_inject_weight', 'model.layers.5.mlp_hyper_connection.input_mix_weight_down', 'model.layers.5.mlp_hyper_connection.input_mix_weight_up', 'model.layers.6.attn_hyper_connection.block_inject_weight', 'model.layers.6.attn_hyper_connection.input_mix_weight_down', 'model.layers.6.attn_hyper_connection.input_mix_weight_up', 'model.layers.6.linear_attn.in_proj_a', 'model.layers.6.linear_attn.in_proj_b', 'model.layers.6.linear_attn.in_proj_qkv', 'model.layers.6.linear_attn.in_proj_z', 'model.layers.6.linear_attn.out_proj', 'model.layers.6.mlp.shared_expert.down_proj', 'model.layers.6.mlp.shared_expert.gate_proj', 'model.layers.6.mlp.shared_expert.up_proj', 'model.layers.6.mlp.shared_expert_gate', 'model.layers.6.mlp_hyper_connection.block_inject_weight', 'model.layers.6.mlp_hyper_connection.input_mix_weight_down', 'model.layers.6.mlp_hyper_connection.input_mix_weight_up', 'model.layers.7.attn_hyper_connection.block_inject_weight', 'model.layers.7.attn_hyper_connection.input_mix_weight_down', 'model.layers.7.attn_hyper_connection.input_mix_weight_up', 'model.layers.7.mlp.shared_expert.down_proj', 'model.layers.7.mlp.shared_expert.gate_proj', 'model.layers.7.mlp.shared_expert.up_proj', 'model.layers.7.mlp.shared_expert_gate', 'model.layers.7.mlp_hyper_connection.block_inject_weight', 'model.layers.7.mlp_hyper_connection.input_mix_weight_down', 'model.layers.7.mlp_hyper_connection.input_mix_weight_up', 'model.layers.7.self_attn.indexer.index_qk_proj', 'model.layers.7.self_attn.k_proj', 'model.layers.7.self_attn.o_proj', 'model.layers.7.self_attn.q_proj', 'model.layers.7.self_attn.v_proj', 'model.layers.8.attn_hyper_connection.block_inject_weight', 'model.layers.8.attn_hyper_connection.input_mix_weight_down', 'model.layers.8.attn_hyper_connection.input_mix_weight_up', 'model.layers.8.linear_attn.in_proj_a', 'model.layers.8.linear_attn.in_proj_b', 'model.layers.8.linear_attn.in_proj_qkv', 'model.layers.8.linear_attn.in_proj_z', 'model.layers.8.linear_attn.out_proj', 'model.layers.8.mlp.shared_expert.down_proj', 'model.layers.8.mlp.shared_expert.gate_proj', 'model.layers.8.mlp.shared_expert.up_proj', 'model.layers.8.mlp.shared_expert_gate', 'model.layers.8.mlp_hyper_connection.block_inject_weight', 'model.layers.8.mlp_hyper_connection.input_mix_weight_down', 'model.layers.8.mlp_hyper_connection.input_mix_weight_up', 'model.layers.9.attn_hyper_connection.block_inject_weight', 'model.layers.9.attn_hyper_connection.input_mix_weight_down', 'model.layers.9.attn_hyper_connection.input_mix_weight_up', 'model.layers.9.linear_attn.in_proj_a', 'model.layers.9.linear_attn.in_proj_b', 'model.layers.9.linear_attn.in_proj_qkv', 'model.layers.9.linear_attn.in_proj_z', 'model.layers.9.linear_attn.out_proj', 'model.layers.9.mlp.shared_expert.down_proj', 'model.layers.9.mlp.shared_expert.gate_proj', 'model.layers.9.mlp.shared_expert.up_proj', 'model.layers.9.mlp.shared_expert_gate', 'model.layers.9.mlp_hyper_connection.block_inject_weight', 'model.layers.9.mlp_hyper_connection.input_mix_weight_down', 'model.layers.9.mlp_hyper_connection.input_mix_weight_up']
````

### vq-dense-affine-hybrid-audit-v2.py

Original bytes: 3565. SHA-256: `5fc934d21d7177c3906a24aad6c7aceb0d1bc5aa972fb2a86b82c6282dc50543`.

Normalized bytes: 3558. SHA-256: `915adccd53fbd6b42184e846a1641aee62ee386b3d39a5005f40f3a50436eb4a`.

````text
from pathlib import Path
import json,hashlib,sys
sys.path.insert(0,'Tools')
from quantization_inventory import unique_json,validate_header
r=Path('.build/quantization-research');base=Path('<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit');vq=r/'candidate-3.2'
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
assert digest(base/'config.json')=='0da22a8ed4323fbe969bf982aeb054743b315206791f28ef74a309c707080ba5'
assert digest(base/'model.safetensors.index.json')=='072cc2c60b8af6cce82a387f62e39ca88754c3a6fccae0816dd21bb89d27470d'
assert digest(vq/'config.json')=='75d7d9b1bfa7762e46ef7c512f6779b43fbd1a1a7f9715684a79f6b01f07cfe5'
indexes=[unique_json((p/'model.safetensors.index.json').read_bytes())['weight_map'] for p in (base,vq)]
configs=[unique_json((p/'config.json').read_bytes()) for p in (base,vq)]
headers={};receipts=[]
def tensor(which,key):
 path=(base if which==0 else vq)/indexes[which][key]
 if path not in headers:
  with path.open('rb') as f:
   before=path.stat();prefix=f.read(8);n=int.from_bytes(prefix,'little');assert 0<n<4000000
   raw=f.read(n);assert len(raw)==n;header=unique_json(raw);validate_header(header,before.st_size-8-n)
   assert path.stat().st_mtime_ns==before.st_mtime_ns
  headers[path]=header;receipts.append({'arm':'base' if which==0 else 'vq','file':path.name,'file_bytes':before.st_size,'header_bytes':n,'header_sha256':hashlib.sha256(prefix+raw).hexdigest()})
 return headers[path][key]
def size(t):return t['data_offsets'][1]-t['data_offsets'][0]
modules=[];missing=[]
for scale in sorted(indexes[1]):
 if not scale.endswith('.scales') or any(x in scale for x in ('switch_mlp','ngram_embedding','vision','visual','mtp.')):continue
 name=scale[:-len('.scales')]
 keys=[name+'.'+x for x in ('weight','scales','biases')]
 base_keys=['language_model.'+k for k in keys]
 if not all(k in indexes[0] for k in base_keys):missing.append(name);continue
 q=configs[0]['quantization'];recipe=q.get('language_model.'+name,q.get(name,{k:q[k] for k in ('bits','group_size')}))
 if recipe['bits']!=4 or recipe['group_size']!=64:missing.append(name+' (other recipe)');continue
 old=[tensor(1,k) for k in keys];new=[tensor(0,k) for k in base_keys]
 assert old[0]['dtype']==new[0]['dtype']=='U32' and old[0]['shape'][:-1]==new[0]['shape'][:-1]
 assert old[0]['shape'][-1]==2*new[0]['shape'][-1]
 assert old[1]['shape']==new[1]['shape']==old[2]['shape']==new[2]['shape']
 modules.append({'module':name,'recipe':recipe,'vq_bytes':sum(map(size,old)),'affine_bytes':sum(map(size,new)),'tensors':keys,'baseline_tensors':base_keys})
before=sum(m['vq_bytes'] for m in modules);after=sum(m['affine_bytes'] for m in modules)
result={'schema':1,'scope':'Header-only same-checkpoint dense affine overlay feasibility; no candidate execution or payload qualification','modules':modules,'unmatched_vq_modules':missing,'headers':receipts,'replaced_vq_bytes':before,'replacement_affine_bytes':after,'recoverable_payload_bytes':before-after,'resident_payload_estimate_bytes':5318309400-before+after,'unchanged':'VQ routed experts, VQ PLE tables, raw norm tensors and all other non-matched tensors. Preserve corrected BF16 norm folding.','status':'hypothesis only; independent composite identity, full digest verification, traversal proof and fresh quality pilot required'}
(r/'vq-dense-affine-hybrid-audit-v2.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in ('modules','headers','unmatched_vq_modules')}));print('modules',len(modules),'unmatched_count',len(missing))
````

### vq-dense-affine-hybrid-audit-v2.json

Original bytes: 367194. SHA-256: `be46f26223fa493b9f4de1c0adea2bc8e31020962d6c1ffabe9d6d5dbd642cbf`.

Normalized bytes: 367194. SHA-256: `be46f26223fa493b9f4de1c0adea2bc8e31020962d6c1ffabe9d6d5dbd642cbf`.

````zlib-base64
eNrd3UtzHEeSJ/B7fwqYzt2y8AiP18xtzXZtD3uYvexlbY1WjywJIxJFgCCmxbH57psQJYoiCRAR
/ndPKx9rm26JQLEyy6sQ8J8//vNvV1c/vDv8vLzZ/fAvV/T3j/94frus//TD/1x2x+XuH+eb179e
vdu9Wf6xft3hl7fn65v7q+Ny82652p1O1zfL1flhuXu9+/XqtOzeXe+vX1/f//qvVzfnq8Pu5nh9
3N0vV8s/l8P7++vzzdX57urt7tfX593x6vb97vX16fqwe/yDH377u9+cj+9fL+/Wv/3/rv94dfWf
v/3/T3/w+Kxev3n18/rEfvv63/7objlc//aE//ji9d/tr+8fH4T//ue/+unu/P7tq3fXHx6/tPDv
f/Bfnx7m4fbV/tf73/7uUjOnwCF8+sOPF/rpC1KuuYX22Rfcr/fjfPfnE//tX/7+VH/8j+X6p5/v
f/j713/y7rB7vNxv/Mn+evdu/ZPf/+D/ffqL9uu/fv34XL79N+5ufnq/+2l5td6v5fWPzzyBb3/h
N57Pt7/wi6f3t8/u5Tdes4/fu7zZL8dX9+df1md+CS/f18/6GzfyG1/09U38xhdBXt8XPcPvf893
X/XvP/8XBcDPv75d7l4dzjc3y+HxPf/qzfU/l7sfr2/evr9//N+vPj75V8fzf9xoBkjiRuXp8KDG
Kb4sOEau6MngGXqQp4Jr6EGAwSe8A/LHfGHwSu4PNLjfv/UV2u/figN7fQhpWK8PsUFQf/PapY8I
Duiv78yLwnk9zy13734MP+7u729effmXXfJn9syVPRniUw/2VLBPPRgw7EF3BvfYL3wrIO6bypvi
Uj7rx68L9oZ45rN/4qE2fDO8/GcB5BahHln0Nni8pbu7V49/2/rgr97enf/91e0vD5pBH2vLsT0T
9Vw5l8Gwf+I6vh/kT33jd0P6qW/UCOCXX93c44wG5wuvXR6KHzQDkUolKu3JQGyNayryOPwwF4Uf
5mLwg1kEfoDE3wdI9H3Axd55/YR9fMxLDr0/rmEs8j5911Dgffou7bh75qImHkQSdU9d8ljQvXm9
Hgt+3t0tx1fLP9cf9Pc/Ph5r9WOvcnjmx2+PNPrD95kL+X4APvfN343D575ZIxzHrnT+sUaDc+A+
SGP0p9394iJGP13ITIz++c0TMfrnN9vE6HNXOv9Y8hh98j5IY3QNMw8R+vtlzMTnH986EZ1/fKtN
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
J2Ie34mYx3ciZpOdiFm8EzGLdyJm7E7E4ldtC1RtC1Rty9ZqWzTVtmiqbTFT2+JVbQtQbQtQbcu2
alv01LboqW0xUtvipf+yTPdflun+y2LZf1lQ/ZcF1X9ZVPovi4v+yzLZf1km+y+LXf9lwfRfFkz/
ZVHovywe+i/LXP9lmeu/LGb9lwXSf1kg/ZcF339Z3JRRFVEZVRGVURXrMqqCLKMqyDKqolZGVdyU
URVRGVURlVEV6zKqgiyjKsgyqqJWRlWclFEVQRlVEZRRFdsyqoIroyq4MqqiVEZV3JZRFWQZVUGW
UZWNy6iKYhlVUSyjKlZlVMVpGVXBlVEVXBlV2bSMqqiVURW1MqpiU0ZV/UpehUpehUpe3Vryqqbk
VU3Jq2aSV71KXgVKXgVKXt1W8qqe5FU9yatGkle9SF6dlrw6LXnVUvIqSvIqSvKqiuRVF5JXJyWv
TkpetZO8ipG8ipG8qiB51YPk1TnJq3OSV80kr0Ikr0Ikr+Ilr7qRvCqSvCqSvGoteRUpeRUpeVVN
8qobyasiyasiyavWkleRkleRklfVJK86kbwqkLwqkLxqK3kVJ3kVJ3lVSfKqW8mrSMmrSMmrG0te
VZS8qih51UryqlPJqzjJqzjJq5tKXlWTvKomedVG8ppfyWtQyWtQyWtbS17TlLymKXnNTPKaV8lr
QMlrQMlr20pe05O8pid5zUjymhfJa9OS16Ylr1lKXkNJXkNJXlORvOZC8tqk5LVJyWt2ktcwktcw
ktcUJK95kLw2J3ltTvKameQ1iOQ1iOQ1vOQ1N5LXRJLXRJLXrCWvISWvISWvqUlecyN5TSR5TSR5
zVryGlLyGlLymprkNSeS1wSS1wSS12wlr+Ekr+EkrylJXnMreQ0peQ0peW1jyWuKktcUJa9ZSV5z
KnkNJ3kNJ3ltU8lrapLX1CSv2Uhe9yt5HSp5HSp5fWvJ65qS1zUlr5tJXvcqeR0oeR0oeX1byet6
ktf1JK8bSV53kzjsosRhFyUOu3XisCMThx2ZOOxqicPuJnHYRYnDLkocduvEYUcmDjsycdjVEofd
SeKwCxKHXZA47LaJw45LHHZc4rArJQ6728RhRyYOOzJx2DdOHHbFxGFXTBx2q8Rhd5o47LjEYccl
DvumicOuljjsaonDbpU4vOidiH18J2If34nYTXYidvFOxC7eidixOxH7pe9E7OM7Efv4TsRushOx
i3cidvFOxI7didgvfidiH9+J2Md3InaTnYhdvBOxi3ciduxOxH7ZOxH7+E7EPr4TsZvsROzinYhd
vBOxQ3ciRrdoG5FmG5FkGzcW26gItlHRa6MV10anWhtxWBtxVhs3pdqoJrVRDWqjjdNGJw2Xcbbf
Ms62W0bDbssIaraMoF7LqNFqGT10Wsa5Rss412cZzdosI6TLMkKaLCO+xzI6aLGMUx2WcarBMlr1
V0ZEe2VEdFdGeHNl9FIiFSUVUlFSIBWN66MisDwqAqujolZxVPRSGxUlpVFRUhkVjQujIrAuKgLL
oqJWVVT0URQV52ui4nxJVDStiIqwgqgIq4eKOuVQ0Ws1VAQWQ0VgLVTcthQq6lVCRb1CqGhUBxV9
lkFFWBVUhBVBxS1roKJWCVTUqoCKJgVQMfhFuABVuABluLC1wwVNiAuaEhfMKC54tbgAxLgA1Liw
LccFPY8LeiAXjEQueCG5MG1yYRrlgqXKBRTLBZTLBRWYCy5kLkzSXJi0uWCHcwGjcwHDc0HB54IH
oAtzQhfmiC6YGV2AIF2AKF3AM11w43RBBHVBJHXBmuoC0uoCEuuCmtYFN1wXRF4XRGAXrMUuIMku
IM0uqKFdcKJ2QcB2QeB2wRbuAk7uAo7ugpLdBbd4F5B6F5B8Fzb2u6AIeEFR8IIV4QWnhhdwiBdw
ihc2Zbyg5nhBDfKCjeSRX8kjqOQRVPJoa8kjTckjTckjM8kjr5JHQMkjoOTRtpJHepJHepJHRpJH
XiSPpiWPpiWPLCWPUJJHKMkjFckjF5JHk5JHk5JHdpJHGMkjjOSRguSRB8mjOcmjOckjM8kjiOQR
RPIIL3nkRvJIJHkkkjyyljxCSh4hJY/UJI/cSB6JJI9EkkfWkkdIySOk5JGa5JETySOB5JFA8shW
8ggneYSTPFKSPHIreYSUPEJKHm0seaQoeaQoeWQleeRU8ggneYSTPNpU8khN8khN8shG8hwPxsRO
xsSOxtx8NqbqcEzV6Zh24zHdzsdEDshETsjceESm4oxMxSGZVlMy3YzJnJ+TOT8o03RSJmxUJmxW
ps6wTB/TMmfHZc7OyzQcmAmamAkamakxM9PF0MzJqZmTYzPt5mZiBmdiJmcqjM70MztTNjxTNj3T
fHwmdH4mdICm3gRNPyM0ZTM0ZUM0zadoQsdoQudo6g3S9DJJUzJKUzJL03iYJnCaJnCcptY8Tb8D
NaETNaEjNbeeqak5VFNzqqbZWE2vczWBgzWBkzW3Ha2pN1tTb7im0XTN5FfyElTyElTy0taSlzQl
L2lKXjKTvORV8hJQ8hJQ8tK2kpf0JC/pSV4ykrzkJnGYRInDJEocJuvEYUImDhMycZjUEofJTeIw
iRKHSZQ4TNaJw4RMHCZk4jCpJQ6Tk8RhEiQOkyBxmGwThwmXOEy4xGFSShwmt4nDhEwcJmTiMG2c
OEyKicOkmDhMVonD5DRxmHCJw4RLHKZNE4dJLXGY1BKHySpxuN7V08fClF/0zyupx8JPhntNNbbB
aP/y6b8gqr/6lu9H71ffohKlL7iW0UcYjrrvXel0dJ0vsTru6wsYiq/zeHydTeLrLI6vszi+ztj4
ulWPr5Q4ps8D6Muf1rV0rnE6wG7HA+x2PMBuTQLsVhxgt+IAu8UG2MNl/3h8GI+uh/HoejCJrgdx
dD2Io+tBHl3sV20ZqrYMVVveWm1ZU21ZU23ZTG3Zq9oyUG0ZqLa8rdqyntqyntqykdqyl/5Lnu6/
5On+S7bsv2RU/yWj+i9Zpf+SXfRf8mT/JU/2X7Jd/yVj+i8Z03/JCv2X7KH/kuf6L3mu/5LN+i8Z
0n/JkP5LxvdfspsyKhaVUbGojIqty6gYWUbFyDIqViujYjdlVCwqo2JRGRVbl1ExsoyKkWVUrFZG
xU7KqFhQRsWCMiq2LaNiXBkV48qoWKmMit2WUTGyjIqRZVS8cRkVK5ZRsWIZFVuVUbHTMirGlVEx
royKNy2jYrUyKlYro2KbMqrsV/IyVPIyVPLy1pKXNSUva0peNpO87FXyMlDyMlDy8raSl/UkL+tJ
XjaSvOxF8vK05OVpycuWkpdRkpdRkpdVJC+7kLw8KXl5UvKyneRljORljORlBcnLHiQvz0lenpO8
bCZ5GSJ5GSJ5GS952Y3kZZHkZZHkZWvJy0jJy0jJy2qSl91IXhZJXhZJXraWvIyUvIyUvKwmedmJ
5GWB5GWB5GVbycs4ycs4yctKkpfdSl5GSl5GSl7eWPKyouRlRcnLVpKXnUpexklexkle3lTysprk
ZTXJyzaSV/xKXoFKXoFKXtla8oqm5BVNyStmkle8Sl4BSl4BSl7ZVvKKnuQVPckrRpJXvEhemZa8
Mi15xVLyCkryCkryiorkFReSVyYlr0xKXrGTvIKRvIKRvKIgecWD5JU5yStzklfMJK9AJK9AJK/g
Ja+4kbwikrwikrxiLXkFKXkFKXlFTfKKG8krIskrIskr1pJXkJJXkJJX1CSvOJG8IpC8IpC8Yit5
BSd5BSd5RUnyilvJK0jJK0jJKxtLXlGUvKIoecVK8opTySs4ySs4ySubSl5Rk7yiJnnFRvKqX8mr
UMmrUMmrW0te1ZS8qil51UzyqlfJq0DJq0DJq9tKXtWTvKonedVI8qqbxGEVJQ6rKHFYrROHFZk4
rMjEYVVLHFY3icMqShxWUeKwWicOKzJxWJGJw6qWOKxOEodVkDisgsRhtU0cVlzisOISh1UpcVjd
Jg4rMnFYkYnDunHisComDqti4rBaJQ6r08RhxSUOKy5xWDdNHFa1xGFVSxxWq8ThRe9ErOM7Eev4
TsRqshOxinciVvFOxIrdiVgvfSdiHd+JWMd3IlaTnYhVvBOxinciVuxOxHrxOxHr+E7EOr4TsZrs
RKzinYhVvBOxYnci1sveiVjHdyLW8Z2I1WQnYhXvRKzinYgVuxOx+VXbBlXbBlXbtrXaNk21bZpq
28zUtnlV2wZU2wZU27at2jY9tW16atuM1LZ56b9s0/2Xbbr/sln2XzZU/2VD9V82lf7L5qL/sk32
X7bJ/stm13/ZMP2XDdN/2RT6L5uH/ss213/Z5vovm1n/ZYP0XzZI/2XD9182N2VUTVRG1URlVM26
jKohy6gasoyqqZVRNTdlVE1URtVEZVTNuoyqIcuoGrKMqqmVUTUnZVRNUEbVBGVUzbaMquHKqBqu
jKoplVE1t2VUDVlG1ZBlVG3jMqqmWEbVFMuomlUZVXNaRtVwZVQNV0bVNi2jamplVE2tjKrZlFF1
v5LXoZLXoZLXt5a8ril5XVPyupnkda+S14GS14GS17eVvK4neV1P8rqR5HUvktenJa9PS163lLyO
kryOkryuInndheT1Scnrk5LX7SSvYySvYySvK0he9yB5fU7y+pzkdTPJ6xDJ6xDJ63jJ624kr4sk
r4skr1tLXkdKXkdKXleTvO5G8rpI8rpI8rq15HWk5HWk5HU1yetOJK8LJK8LJK/bSl7HSV7HSV5X
krzuVvI6UvI6UvL6xpLXFSWvK0pet5K87lTyOk7yOk7y+qaS19Ukr6tJXjeRvOQW8hLS8RKS8dLG
ipcUES8pGl6yIrzkVPASDvASzu/SpnyX1PQuqeFdsrG75CVTmCSJwiTJEybjNGECZgkTMEmYtHKE
yUuKMEkyhEmSIEzG+cEETA8mYHYwaSUHk4/cYJpPDab5zGAyTQwmWF4wwdKCSScrmLwmBRMwJ5iA
KcG0bUYw6SUEk14+MBmlA5PPbGCCJQMTLBeYtkwFJq1MYNJKBCajPOAlz0VNw2NR0/BU1GQxFDVJ
Z6Im6UjUBJ2Imi58IGoanoeahsehJotpqEk6DDVJZ6Em6CjUdOmTUNPwINQ0PAc1WYxBTdIpqEk6
BDVBZ6Cmix6BmoYnoKbhAajJYv5pko4/TdLppwk6/DQFv9IaoNQaoNYatsbWoKmtQZNbg5m3Bq/g
GoDiGoDkGrY116CHrkFPXYMRuwYnLZNPX8gLYn2yZfKZ71SJY0zL5ND1Tj4QPiIvrGXyqauYDMYP
k6H4wS4QP2DC8AMmCD8AQ/AyWyafuIjBAHxpy+RT36YefpMtky+/zJlHkcWel0KoIKqECqJSqGBd
CxWQxVABWQ0V1Mqhgpt6qCAqiAqiiqhgXRIVkDVRAVkUFdSqooKTsqggqIsKgsKoYFsZFXClUQFX
GxWUiqOC2+qogCyPCsj6qLBxgVRQrJAKiiVSwapGKjgtkgq4KqmAK5MKm9ZJBbVCqaBWKRVsSqXI
r+QRVPIIKnm0teSRpuSRpuSRmeSRV8kjoOQRUPJoW8kjPckjPckjI8kjN4lDEiUOSZQ4JOvEISET
h4RMHJJa4pDcJA5JlDgkUeKQrBOHhEwcEjJxSGqJQ3KSOCRB4pAEiUOyTRwSLnFIuMQhKSUOyW3i
kJCJQ0ImDmnjxCEpJg5JMXFIVolDcpo4JFzikHCJQ9o0cUhqiUNSSxySVeLwopssabzLksbbLMmk
z5LEjZYk7rQkbKslXXqvJY03W9J4tyWZtFuSuN+SxA2XhO24pItvuaTxnksab7okk65LErddkrjv
krCNl3TZnZc03npJ472XZNJ8SeLuSxK3XxK2/zL6VdsIVdsIVdu4tdpGTbWNmmobzdQ2elXbCFTb
CFTbuK3aRj21jXpqG43UNnrpv4zT/Zdxuv8yWvZfRlT/ZUT1X0aV/svoov8yTvZfxsn+y2jXfxkx
/ZcR038ZFfovo4f+yzjXfxnn+i+jWf9lhPRfRkj/ZcT3X0Y3ZVRRVEYVRWVU0bqMKiLLqCKyjCqq
lVFFN2VUUVRGFUVlVNG6jCoiy6gisowqqpVRRSdlVFFQRhUFZVTRtowq4sqoIq6MKiqVUUW3ZVQR
WUYVkWVUceMyqqhYRhUVy6iiVRlVdFpGFXFlVBFXRhU3LaOKamVUUa2MKtqUUTneWYldWondWrn5
2krVvZWqiyvtNle6XV2J3F2JXF658fZKxfWVivsrrRZYJi+Sl6YlL01LXrKUvISSvISSvKQiecmF
5KVJyUuTkpfsJC9hJC9hJC8pSF7yIHlpTvLSnOQlM8lLEMlLEMlLeMnzs1JatlNatlTafKs0dK00
dK+03mJpP5ulZaulZbulzZdLQ7dLQ9dL6+2X9rJgWrJhWrJi2njHNHDJNHDLtNaaab97pqGLpqGb
prdeNa25a1pz2bTZtmmv66aB+6aBC6e33Titt3Jab+e00dJp9it5DJU8hkoeby15rCl5rCl5bCZ5
7FXyGCh5DJQ83lbyWE/yWE/y2Ejy2Ivk8bTk8bTksaXkMUryGCV5rCJ57ELyeFLyeFLy2E7yGCN5
jJE8VpA89iB5PCd5PCd5bCZ5DJE8hkge4yWP3UgeiySPRZLH1pLHSMljpOSxmuSxG8ljkeSxSPLY
WvIYKXmMlDxWkzx2InkskDwWSB7bSh7jJI9xksdKksduJY+RksdIyeONJY8VJY8VJY+tJI+dSh7j
JI9xksebSh6rSR6rSR7bSF72K3kZKnkZKnl5a8nLmpKXNSUvm0le9ip5GSh5GSh5eVvJy3qSl/Uk
LxtJXnaTOMyixGEWJQ6zdeIwIxOHGZk4zGqJw+wmcZhFicMsShxm68RhRiYOMzJxmNUSh9lJ4jAL
EodZkDjMtonDjEscZlziMCslDrPbxGFGJg4zMnGYN04cZsXEYVZMHGarxGF2mjjMuMRhxiUO86aJ
w6yWOMxqicNslTi86J2IeXwnYh7fiZhNdiJm8U7ELN6JmLE7EfOl70TM4zsR8/hOxGyyEzGLdyJm
8U7EjN2JmC9+J2Ie34mYx3ciZpOdiFm8EzGLdyJm7E7EfNk7EfP4TsQ8vhMxm+xEzOKdiFm8EzFj
dyIWv2pboGpboGpbtlbboqm2RVNti5naFq9qW4BqW4BqW7ZV26KntkVPbYuR2hYv/Zdluv+yTPdf
Fsv+y4Lqvyyo/sui0n9ZXPRflsn+yzLZf1ns+i8Lpv+yYPovi0L/ZfHQf1nm+i/LXP9lMeu/LJD+
ywLpvyz4/svipoyqiMqoiqiMqliXURVkGVVBllEVtTKq4qaMqojKqIqojKpYl1EVZBlVQZZRFbUy
quKkjKoIyqiKoIyq2JZRFVwZVcGVURWlMqritoyqIMuoCrKMqmxcRlUUy6iKYhlVsSqjKk7LqAqu
jKrgyqjKpmVURa2MqqiVURWbMqrqV/IqVPIqVPLq1pJXNSWvakpeNZO86lXyKlDyKlDy6raSV/Uk
r+pJXjWSvOpF8uq05NVpyauWkldRkldRkldVJK+6kLw6KXl1UvKqneRVjORVjORVBcmrHiSvzkle
nZO8aiZ5FSJ5FSJ5FS951Y3kVZHkVZHkVWvJq0jJq0jJq2qSV91IXhVJXhVJXrWWvIqUvIqUvKom
edWJ5FWB5FWB5FVbyas4yas4yatKklfdSl5FSl5FSl7dWPKqouRVRcmrVpJXnUpexUlexUle3VTy
qprkVTXJqzaS1/xKXoNKXoNKXtta8pqm5DVNyWtmkte8Sl4DSl4DSl7bVvKanuQ1PclrRpLXvEhe
m5a8Ni15zVLyGkryGkrymorkNReS1yYlr01KXrOTvIaRvIaRvKYgec2D5LU5yWtzktfMJK9BJK9B
JK/hJa+5kbwmkrwmkrxmLXkNKXkNKXlNTfKaG8lrIslrIslr1pLXkJLXkJLX1CSvOZG8JpC8JpC8
Zit5DSd5DSd5TUnymlvJa0jJa0jJaxtLXlOUvKYoec1K8ppTyWs4yWs4yWubSl5Tk7ymJnnNRvK6
X8nrUMnrUMnrW0te15S8ril53UzyulfJ60DJ60DJ69tKXteTvK4ned1I8rqbxGEXJQ67KHHYrROH
HZk47MjEYVdLHHY3icMuShx2UeKwWycOOzJx2JGJw66WOOxOEoddkDjsgsRht00cdlzisOMSh10p
cdjdJg47MnHYkYnDvnHisCsmDrti4rBbJQ6708RhxyUOOy5x2DdNHHa1xGFXSxx2q8ThRe9E7OM7
Efv4TsRushOxi3cidvFOxI7didgvfSdiH9+J2Md3InaTnYhdvBOxi3ciduxOxH7xOxH7+E7EPr4T
sZvsROzinYhdvBOxY3ci9sveidjHdyL28Z2I3WQnYhfvROzinYgduhOR3aItI82WkWTLG4stK4It
K3otW3EtO9VaxmEt46yWN6VaVpNaVoNatnFadtJwybP9ljzbbsmG3ZYMarZkUK8la7RasodOS55r
tOS5Pks2a7NkSJclQ5osGd9jyQ5aLHmqw5KnGizZqr+SEe2VjOiuZHhzJXspkWJJhRRLCqTYuD6K
geVRDKyOYq3iKPZSG8WS0iiWVEaxcWEUA+uiGFgWxVpVUeyjKIrna6J4viSKTSuiGFYQxbB6KNYp
h2Kv1VAMLIZiYC0Ub1sKxXqVUKxXCMVGdVDsswyKYVVQDCuC4i1roFirBIq1KqDYpACKg1+EC1CF
C1CGC1s7XNCEuKApccGM4oJXiwtAjAtAjQvbclzQ87igB3LBSOSCF5IL0yYXplEuWKpcQLFcQLlc
UIG54ELmwiTNhUmbC3Y4FzA6FzA8FxR8LngAujAndGGO6IKZ0QUI0gWI0gU80wU3ThdEUBdEUhes
qS4grS4gsS6oaV1ww3VB5HVBBHbBWuwCkuwC0uyCGtoFJ2oXBGwXBG4XbOEu4OQu4OguKNldcIt3
Aal3Acl3YWO/C4qAFxQFL1gRXnBqeAGHeAGneGFTxgtqjhfUIC/YSB75lTyCSh5BJY+2ljzSlDzS
lDwykzzyKnkElDwCSh5tK3mkJ3mkJ3lkJHnkRfJoWvJoWvLIUvIIJXmEkjxSkTxyIXk0KXk0KXlk
J3mEkTzCSB4pSB55kDyakzyakzwykzyCSB5BJI/wkkduJI9EkkciySNrySOk5BFS8khN8siN5JFI
8kgkeWQteYSUPEJKHqlJHjmRPBJIHgkkj2wlj3CSRzjJIyXJI7eSR0jJI6Tk0caSR4qSR4qSR1aS
R04lj3CSRzjJo00lj9Qkj9Qkj2wkL/qVvAiVvAiVvLi15EVNyYuakhfNJC96lbwIlLwIlLy4reRF
PcmLepIXjSQvepG8OC15cVryoqXkRZTkRZTkRRXJiy4kL05KXpyUvGgneREjeREjeVFB8qIHyYtz
khfnJC+aSV6ESF6ESF7ES150I3lRJHlRJHnRWvIiUvIiUvKimuRFN5IXRZIXRZIXrSUvIiUvIiUv
qkledCJ5USB5USB50VbyIk7yIk7yopLkRbeSF5GSF5GSFzeWvKgoeVFR8qKV5EWnkhdxkhdxkhc3
lbyoJnlRTfKijeQlv5KXoJKXoJKXtpa8pCl5SVPykpnkJa+Sl4CSl4CSl7aVvKQneUlP8pKR5CU3
icMkShwmUeIwWScOEzJxmJCJw6SWOExuEodJlDhMosRhsk4cJmTiMCETh0ktcZicJA6TIHGYBInD
ZJs4TLjEYcIlDpNS4jC5TRwmZOIwIROHaePEYVJMHCbFxGGyShwmp4nDhEscJlziMG2aOExqicOk
ljhMVonD9a6ePham/KJ/Xkk9Fn4y3GuqsQ1G+5dP/wVR/dW3fD96v/oWlSh9wbWMPsJw1H3vSqej
63yJ1XFfX8BQfJ3H4+tsEl9ncXydxfF1xsbXrXp8pcQxfR5AX/60rqVzjdMBdjseYLfjAXZrEmC3
4gC7FQfYLTbAHi77x+PDeHQ9jEfXg0l0PYij60EcXQ/y6GK/astQtWWo2vLWasuaasuaastmaste
1ZaBastAteVt1Zb11Jb11JaN1Ja99F/ydP8lT/dfsmX/JaP6LxnVf8kq/Zfsov+SJ/svebL/ku36
LxnTf8mY/ktW6L9kD/2XPNd/yXP9l2zWf8mQ/kuG9F8yvv+S3ZRRsaiMikVlVGxdRsXIMipGllGx
WhkVuymjYlEZFYvKqNi6jIqRZVSMLKNitTIqdlJGxYIyKhaUUbFtGRXjyqgYV0bFSmVU7LaMipFl
VIwso+KNy6hYsYyKFcuo2KqMip2WUTGujIpxZVS8aRkVq5VRsVoZFduUUWW/kpehkpehkpe3lrys
KXlZU/KymeRlr5KXgZKXgZKXt5W8rCd5WU/yspHkZS+Sl6clL09LXraUvIySvIySvKwiedmF5OVJ
ycuTkpftJC9jJC9jJC8rSF72IHl5TvLynORlM8nLEMnLEMnLeMnLbiQviyQviyQvW0teRkpeRkpe
VpO87EbyskjyskjysrXkZaTkZaTkZTXJy04kLwskLwskL9tKXsZJXsZJXlaSvOxW8jJS8jJS8vLG
kpcVJS8rSl62krzsVPIyTvIyTvLyppKX1SQvq0letpG84lfyClTyClTyytaSVzQlr2hKXjGTvOJV
8gpQ8gpQ8sq2klf0JK/oSV4xkrziRfLKtOSVackrlpJXUJJXUJJXVCSvuJC8Mil5ZVLyip3kFYzk
FYzkFQXJKx4kr8xJXpmTvGImeQUieQUieQUvecWN5BWR5BWR5BVryStIyStIyStqklfcSF4RSV4R
SV6xlryClLyClLyiJnnFieQVgeQVgeQVW8krOMkrOMkrSpJX3EpeQUpeQUpe2VjyiqLkFUXJK1aS
V5xKXsFJXsFJXtlU8oqa5BU1ySs2klf9Sl6FSl6FSl7dWvKqpuRVTcmrZpJXvUpeBUpeBUpe3Vby
qp7kVT3Jq0aSV90kDqsocVhFicNqnTisyMRhRSYOq1risLpJHFZR4rCKEofVOnFYkYnDikwcVrXE
YXWSOKyCxGEVJA6rbeKw4hKHFZc4rEqJw+o2cViRicOKTBzWjROHVTFxWBUTh9UqcVidJg4rLnFY
cYnDumnisKolDqta4rBaJQ4veidiHd+JWMd3IlaTnYhVvBOxinciVuxOxHrpOxHr+E7EOr4TsZrs
RKzinYhVvBOxYnci1ovfiVjHdyLW8Z2I1WQnYhXvRKzinYgVuxOxXvZOxDq+E7GO70SsJjsRq3gn
YhXvRKzQnYh+B6lC56hCx6huPUVVc4iq5gxVsxGqXieoAgeoAuenbjs+VW96qt7wVKPZqV5Gp05P
Tp0enGo5NxU1NhU1NVVlaKqLmamTI1MnJ6baDUzFzEvFjEtVmJbqYVjq3KzUuVGpZpNSIYNSIXNS
8WNS3UxJFQ1JFc1ItR6RipyQihyQqjYf1c14VNF0VNFwVOvZqMjRqMjJqGqDUZ3MRRWMRRVMRbUd
ioqbiYobiao0EdXtQFTkPFTkONSNp6EqDkNVnIVqNQrV6SRU3CBU3BzUTcegqk1BVRuCajMD1e8I
VOgEVOgA1K3nn2qOP9Wcfmo2/NTr7FPg6FPg5NNtB5/qzT3VG3tqNPXUy9DT6Zmn0yNPLSeeogae
ouadqow7dTHtdHLY6eSsU7tRp5hJp5hBpwpzTj2MOZ2bcjo35NRsxilkxClkwil+wKmb+aai8aai
6abWw02Rs02Ro03VJpu6GWwqmmsqGmtqPdUUOdQUOdNUbaSpk4mmgoGmgnmmtuNMcdNMccNMlWaZ
uh1lipxkihxkuvEcU8UxpopTTK2GmDqdYYobYYqbYLrpAFO1+aVq40ttppf6HV4KnV0KHV269eRS
zcGlmnNLzcaWep1aChxaCpxZuu3IUr2JpXoDS43mlboZVyqaVioaVmo9qxQ5qhQ5qVRtUKmbOaWi
MaWiKaXWQ0qRM0qRI0rVJpQ6GVAqmE8qGE9qO50UN5wUN5tUaTSp28mkyMGkyLmkG48lVZxKqjiU
1GomqdORpLiJpLiBpJvOI1UbR6o2jbQa5QEveRbp+CjS8UmkJoNIxXNIxWNIsVNIL30I6fgM0vER
pCYTSMUDSMXzR7HjRy9++uj48NHx2aMmo0fFk0fFg0exc0cve+zo+NTR8aGjJjNHxSNHxRNHsQNH
m1tobUhobUhobRtDa1OE1qYIrc0KWptTaG04aG04aG2bQmtTg9amBq3NBlqbk2bHNtvs2GabHZth
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
PfNBemilcc1h/U8Ph6Xx/rB+SOZ+KssuHPP6Y6KFJbT1fX4KB97F9cNm/SDilNa/+HCMTfQSlhe9
hOvF1bj+SKYnL7EQP/dBur6P10CIVFteg5To1PIp7Q+7Fsr64yAvfGzr61pqqnw4rP8r73Ytcwnp
RDVSEbyE+eXvwp6eCdFanwlROtTj6bCvu2M7dlo/WBoznU41MYW8/tFudwht/ZGfaF+Ph93j2y8s
vaTTGsqH9RAguL6XvICl5Vpi6JmeeQuWZ16/uL4Vjrv1MzFFymnZLafyeKhZL+WUWs79cNjHUy8c
12uM4ZT3tZRjLyWsQb1vIYlCtL7wU2Y9jq5/7ZM/KNZP+fbMeXQNzPVESkfer1e1/kipj5dxoPWF
TMthvyyH9V0cwokS98MS18++/amdjvx4+esH7ukgusT2sndhIopx/bB88l0Y1/PqM6/i+pMuLktM
+11fQ3FX1mN0i6nsco6HGPsarXFZT9nrebvu13BZIzYf188ayvv15d1LPkhf8hqWUvv6g+yZKM3r
efyZd+H6HEtaUtmvnzX70g79uFDfryG6K7zbp0PieMx14ZwOy/qXBU68a6dl/balltwOgut7yQu4
frql9SASiZ77lHnm9TvtKfec0rJfH6k8/pbUD0c6HtYPnUNeX7a0hu+yhmVcz73rLxF5jcpltytt
PQPlkmsVhWh/WYjmsP5S0cKTJ9K8fpI88y5MdZ/Xt1lZ33HrT5zjcTmGsJxSPC20nm6WUPb5tCt1
WQ8vtP5+uL79Doe4rB9Gy379GVwX0W+F4YXvwlrbGj5PXyLH9szvhWv8HfL6czytPxjW3wHzemXc
1wPCesxpCz8GJa+/SIR+WH9IlvUL6z7tKMf1pL4P65f88Vn66Xf9u+Xt693hY5v/p6ewfkMtLXwc
HvHHl7xZbu5ffTFj4ref66n8+ZWH88Nyt9uvl/x29+vr8+7455fyehJ/HEjxx5e+uz4+PuIfX7e8
u79+8zhA6dM3tPUjpVb+/Rve3xx+3t38tBwf78L/+d9Xd+f398vx6mP+493fr9Z/9W//679f3T/+
5es/3u3+4+rmfPfm6vcX5Gp3c7zavX59db7/eblb/+jmH78POPjjK368+rf1SS13D8vV4Xy3Xsrj
w/+3/0Hl4+Oczq+P1zc//fjbK/vDu/vd/fvHZ/nDz7++fXzId9fvrs43r3/916vH5Nrb5ebx4tYH
evP2/O76frn67WKv73/9+9Xp/fosjtc/rRd8td6s69P1YfeYk/n71f3dbv0X73avr97enc+n357y
aX1OP1/dvt+9Xr/56u316/P91d1y+/76br0Tf/uvv/1/jHB7yQ==
````

### vq-dense-affine-hybrid-audit-v2.log

Original bytes: 606. SHA-256: `115e8cbe2396065e816235b6d6637cf9234a3ee037d26072f6f2136dddd9b896`.

Normalized bytes: 606. SHA-256: `115e8cbe2396065e816235b6d6637cf9234a3ee037d26072f6f2136dddd9b896`.

````text
{"schema": 1, "scope": "Header-only same-checkpoint dense affine overlay feasibility; no candidate execution or payload qualification", "replaced_vq_bytes": 5152768000, "replacement_affine_bytes": 2727936000, "recoverable_payload_bytes": 2424832000, "resident_payload_estimate_bytes": 2893477400, "unchanged": "VQ routed experts, VQ PLE tables, raw norm tensors and all other non-matched tensors. Preserve corrected BF16 norm folding.", "status": "hypothesis only; independent composite identity, full digest verification, traversal proof and fresh quality pilot required"}
modules 498 unmatched_count 228
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
