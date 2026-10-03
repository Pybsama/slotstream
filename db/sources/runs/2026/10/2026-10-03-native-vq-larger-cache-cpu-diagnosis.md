---
type: run
created: 2026-10-03T13:19:04.878279+00:00
updated: 2026-10-03T13:19:04.878279+00:00
summary: CPU diagnosis after the larger fixed VQ cache did not improve speed
binary: 4dad7f7432d8d40aede62cb654fb0d77f8756c2017b3d6afc12745fee5804286
captured_at: 2026-10-03
command: Exact sequential commands are preserved in the driver and supervision identities below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: CPU diagnosis after the larger fixed VQ cache did not improve speed
tool: bounded VQ research diagnostics
---

A separately declared single model run samples the main process for ten seconds at one-millisecond intervals, beginning 64 seconds after the exact owned child was observed. The observer rechecks parent and executable identity before attaching and exits with the supervised model. All timings from this run are discarded because the sampler perturbs execution; the native receipt's uninstrumented eligibility flag does not override that exclusion.

The 5789 main-thread samples include 1732 in the demanded-read batch branch, 1155 in resident-bank output evaluation and 1245 at the router evaluation branch. The victim-search branch has five samples. These are CPU call-stack observations, not a GPU utilization trace, isolated causal shares or a performance ratio. They do not support making eviction bookkeeping the next major optimization. The run completes within the ten-GB process bound and with unchanged generated sequence.

Code review shows the experimental VQTensorFile retains normal file caching/read-ahead whereas the existing affine checkpoint configures F_NOCACHE and F_RDAHEAD. A controlled read-policy experiment is a smaller next hypothesis than an immediate full-record repack. Descriptor lifetime, complete-payload authentication, real-headroom checks, exact reads, cancellation and arithmetic must remain unchanged. No file-policy or performance change has been implemented or measured by this source.

Local home prefixes are replaced with <HOME>. Original byte lengths and hashes identify the unmodified local files. For large transcripts, the normalized UTF-8 bytes are stored losslessly as zlib-compressed base64 inside this Markdown source. Decode with `zlib.decompress(base64.b64decode(block))` and verify the listed normalized byte length and SHA-256. Every encoded block was round-trip checked before writing. This changes storage only, not the captured evidence. Small transcripts remain plain text. Raw tensor fixtures and source-bound executables remain in the bounded research directory; manifests bind their hashes. No model is installed or activated.

### vq-dense-reinvestment-cpu-sample-v1.py

Original bytes: 3155. SHA-256: `e4bb096f7a0089cf907e36475564893d9029a12a270dbad1e0a05fdd63b36bb3`.

Normalized bytes: 3148. SHA-256: `fb8ae975ea2e7dea351daded3b9fe44df9863b57474398394b19f344961b3e19`.

````text
from pathlib import Path
import sys,json,threading,subprocess,time,os
sys.path.insert(0,'Tools')
from quantization_logit_run import supervise,digest
r=Path('.build/quantization-research').resolve();f=r/'frozen-dense-reinvestment-v1';out=r/'vq-dense-reinvestment-cpu-sample-v1';out.mkdir()
assert json.loads((r/'vq-dense-reinvestment-cost-v1/run.json').read_text())['complete']
profile=Path('bench/quantization/dense-reinvestment-cost-v1.json').resolve();validation=r/'vq-dense-reinvestment-cost-v1/validation-reinvest/receipt.json'
cmd=[str(f/'slotstream'),'quantization-performance-pilot','--source-directory',str(r/'candidate-3.2'),'--source-inventory',str(r/'inventory-3.2/inventory.json'),'--profile',str(profile),'--output',str(out/'native'),'--measure','--validation-receipt',str(validation),'--dense-overlay-baseline','<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit','--dense-overlay-manifest',str(r/'vq-dense-overlay-pilot-v1/composite.json')]
protocol={'scope':'CPU stack diagnosis only; all timing discarded because sampling perturbs execution','extra_model_runs':1,'pack':'3.2-dense-affine4 with 1536/288 banks','maximum_process_bytes':10000000000,'minimum_reclaimable_bytes':13000000000,'run_seconds':1800,'sampling_seconds':10,'sample_interval_ms':1,'sampling_delay_seconds':64,'binary_sha256':digest(f/'slotstream'),'metallib_sha256':digest(f/'mlx.metallib'),'profile_sha256':digest(profile),'command':cmd}
(out/'protocol.json').write_text(json.dumps(protocol,indent=2)+'\n')
stop=threading.Event(); observations=[]
def observe():
 started=time.monotonic(); found=None
 while not stop.wait(.1):
  if time.monotonic()-started>110: observations.append({'failure':'no owned child found within deadline'});return
  ps=subprocess.check_output(['ps','-axo','pid=,ppid=,comm='],text=True)
  for line in ps.splitlines():
   fields=line.strip().split(None,2)
   if len(fields)==3 and int(fields[1])==os.getpid() and fields[2]==str(f/'slotstream'):
    if found is None: found=(int(fields[0]),time.monotonic())
  if found and time.monotonic()-found[1]>=64:
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

### vq-dense-reinvestment-cpu-sample-v1.log

Original bytes: 2217. SHA-256: `3a5d6b172eceb648cad4d7de188861da3ead72c56eefad465f9660e8b7c1c9fa`.

Normalized bytes: 2217. SHA-256: `3a5d6b172eceb648cad4d7de188861da3ead72c56eefad465f9660e8b7c1c9fa`.

````text
{"complete": true, "discarded_timing": true, "reason": "CPU sample observer", "sample_exists": true, "supervision": {"exit_code": 0, "failure": null, "sampled_peak_bytes": 7758551112, "samples": 1514, "after": {"page_bytes": 16384, "reclaimable_bytes": 24362123264, "swapins": 24, "swapouts": 2908, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   469351.\nPages active:                                 853379.\nPages inactive:                               826486.\nPages speculative:                             83395.\nPages throttled:                                   0.\nPages wired down:                             178913.\nPages purgeable:                                 119.\n\"Translation faults\":                     1877097553.\nPages copy-on-write:                        92187938.\nPages zero filled:                        3111381771.\nPages reactivated:                         171598962.\nPages purged:                               12183795.\nFile-backed pages:                           1017476.\nAnonymous pages:                              745784.\nPages stored in compressor:                  1239943.\nPages occupied by compressor:                 672264.\nDecompressions:                             93794185.\nCompressions:                              106474451.\nPageins:                                  2072966711.\nPageouts:                                     465124.\nSwapins:                                          24.\nSwapouts:                                       2908.\nPages tagged:                                 129784.\nPages tagged resident:                         85427.\nPages tagged compressed:                       44357.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5185.\nPages tag-storage free:                         1724.\nPages tag-storage non-tag pageable:            91387.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6740736.\nTagged compressions:                          673960.\nTagged decompressions:                        562308.\n"}, "seconds": 87.898475916998}}
````

### vq-dense-reinvestment-cpu-sample-v1/protocol.json

Original bytes: 1692. SHA-256: `0abb8f46aab638eed652c3e828bde5abe4485e5659d619afd2ad3036ac8a1391`.

Normalized bytes: 1636. SHA-256: `27db20e363a0a1a905cb20e31262c68a9af9de649ca8cdc0880fb2c085cf09f0`.

````text
{
  "scope": "CPU stack diagnosis only; all timing discarded because sampling perturbs execution",
  "extra_model_runs": 1,
  "pack": "3.2-dense-affine4 with 1536/288 banks",
  "maximum_process_bytes": 10000000000,
  "minimum_reclaimable_bytes": 13000000000,
  "run_seconds": 1800,
  "sampling_seconds": 10,
  "sample_interval_ms": 1,
  "sampling_delay_seconds": 64,
  "binary_sha256": "4dad7f7432d8d40aede62cb654fb0d77f8756c2017b3d6afc12745fee5804286",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed",
  "profile_sha256": "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-dense-reinvestment-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/bench/quantization/dense-reinvestment-cost-v1.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-reinvestment-cpu-sample-v1/native",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-reinvestment-cost-v1/validation-reinvest/receipt.json",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json"
  ]
}
````

### vq-dense-reinvestment-cpu-sample-v1/observer.json

Original bytes: 623. SHA-256: `612f456de0ef62c57ef83638a438dbb1e07e4e9be013ba5765608c6cf160d840`.

Normalized bytes: 609. SHA-256: `064e71f05aa9667d6c23164b01f8cbb1686e2699ef1c67bc13f0cb976ddf022b`.

````text
[
  {
    "command": [
      "/usr/bin/sample",
      "3639",
      "10",
      "1",
      "-file",
      "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-reinvestment-cpu-sample-v1/sample.txt"
    ],
    "code": 0,
    "stdout": "",
    "stderr": "Sampling process 3639 for 10 seconds with 1 millisecond of run time between samples\nSampling completed, processing symbols...\nSample analysis of process 3639 written to file <HOME>/Projects/slotstream/.build/quantization-research/vq-dense-reinvestment-cpu-sample-v1/sample.txt\n",
    "elapsed_since_child_observed": 74.79001529101515
  }
]
````

### vq-dense-reinvestment-cpu-sample-v1/sample.txt

Original bytes: 974975. SHA-256: `3bcee01e4ee50cc27cae4cb77b409d0dfa6cf012b378b1ff9d653f9b5f68a4f4`.

Normalized bytes: 974975. SHA-256: `3bcee01e4ee50cc27cae4cb77b409d0dfa6cf012b378b1ff9d653f9b5f68a4f4`.

````zlib-base64
eNrsvXlz5DaSPvy/PwUdu9FbfVgDgOBVoVD8+rA9HdNt97Ta3n13ooMBkqDEUVWxTLLULYdjP/uL
gwfIIusgWVLJLu9OS6qDeJBIJDITebxckNldGqVaHGopmS9n0eJKS2dxlmYJJXNtsowCTTd156lG
b2lyp0FtHs1mUUr9eBF88yGJfZqmU634T/nqv/jXPn/zgWTX1fvsv7/9ktIk/dsvl99//Nuzv1Vf
+OZdTALtZRAkxRPBVwgwwBgA8M3bgC6yKIxoMm2O9M2v7HlRvKhGAd+8jgOqfbpb0uLFlx/fm/ib
DzOShXEyLz86J/7Plwxjwp6uVbNZ3mXX8UI/g4hNwzDtz998IskVzZRHzqJbqmUkvfnmmzcko3/7
FM3LwRBA5ncQfAd0DdhTqE+BeaY7UPsOGGwq78hq4V9r1RcaH0dTgM6AY+Yf//lSq09QYNaQeWae
IW2CjB9t/ek3H+kyTjLlk9Y3L4u1/RTHM/7dv63S5G9etPibWGn6zTcfrtn7PplpYRxnyyRaZBUN
rTP4Y8sHGEdQcvOUD3CGfmTLMqMa/RpltSWW/60WWUL8Gxp88x3775tvXpPZTLtKyPJ6+g1/37Bs
R/t0zZYwcA3dsRkZptp7Ei3yF9lH3kTpkmT+9T9XdEXd8/lqlkUM+YX4/nP5hDQjbOLahH0vuJsF
T9nrpuMgTfsX4x/bp4yBKP6cfyMfdc5HEV+p2Ih/kRFdfA0YOvYQ8j9r4qNn6ZcozKYIAFw+J3/S
Momz2I9n2pcoWzDmYZRKNMZPKfFm9HU8n5NFcJasFpOnGhuNbRrOfmThU+2fK8I4+neSsfX6QJPi
9Q8RQ9SGzQYFNgypRQDD9rdzP54voxlNvruiC5owPgwupkDBmKPcNFaOrmVECGpjQsrHVB+Vzy/N
6QOxXhtaKxcoi3y2luRqEafs1/Tstw14Jmm8Snw6jRa3bFPGyd2U0Thkk/zl47tpvMqWq2x6S2ZR
IL7NX2SiIaU/M/E0I3evSEqZEKO1F9+TRRTSNJu2TtNSpokC4vl82RW0z3/9p4KxmKtuN+aaz5bx
wfX3SRIn5y8vJm7HiDl3AhyYbKNzsoqv/J0Rky1mMYQB1obIB6l9epcRIQbKkDb124fULaNlyI2D
5i/IsTtGR7UJY7NrdAO3jl6ICiZs38VMGonBfyWzFZWjxkvO+lzscTaZiuXPccwiTzzbfR0v/FXC
xLx/d8bEROQJXLrEhRzk6FS3weeO8YvNziRNxKQhWS5nd2Kn+7M4XSVU+w/It/cACinLA4kQPLts
7tEwbmCdGjTHsntBy8ENhIKxAsW0cRcTmxuR7EiovWkDIe5Jm10wIY7p2EWpKkhDdoYOoEeTYx7F
/B1sVwSgyMO7nCQG2oEYjBwYG9qv/3zPNNsZ01Q9esYe9IUkAZeAHtOpb+mUK1x8uumS+tklIxbt
OA6gXkhkA3gBFEBrz5bYTHsnaN9qOrYNjY/KuDf6nQb1h3mz2L9hMK+jgNGS/UjFYki0TMNL0g6c
hmWYFc7QBKAdJzTNHYFOJdRf//mRWTBJ8Jr41/SMnSkzBo8tLzMvEsYYNO2gGzIquvmhjiUe9Vk5
ILA7IE3TkW3XqJfzOXsyB3Mpxj8TwoEzKoOag/S4cvz9V3b+ZelUCI0O3I5V4Q5sW5zA9acXsnMP
2H9o0GJ8VMz/FVnctJIyyLX4DyRKGOY4vkmn6XW8mgXsVM6ixYrKiXxkSj//FvvRPg0TK+zge2GI
FfKL4QtF1NlrGs/lRLZJ355MUx4SjPSAWTmDhKIKWuOwwTggDRMrKM0aZeuMDfdG+S3DiboYXIzA
V/4VZ4EzvvgTmnP0MqI+fXXHQftcYs5mUs1LJKO06wjqRKDp28pEqmHkZAynx1ymfDZWMYOfL92C
vd3fuJV65heaZpbL+kmU5fppOqVfqb/K1tTTws6tVFNYmKLEMpBDof25F9Q/JFhXKsElUsHhbg5z
KxRkK1BC3e8LhfMrMrU6inL0YG3gggR2AJBFfLv/uGwSJnK0JgG4iueSLEvccAMMqEOkAHEwHgKE
bQbMJtaEwlSU+Ia6TJF1v5Ao2wBHLxico7HtoWimTTyMfanL5QaTFptgVDRhp68OhqLQmjj8WcSY
cwckUGGTAHsjINE2rZG+iSi6gsWGBI+BZQtl0M6kGbaDKjg5oOx6tbgRx+T/o6lPltx1/P84KErd
qxVJmF5Omaif/L/VIv6yYL+9XWRPte8utMlW6VcwlxR+4yypgnz9oFfmMs4MajKT2ni8GeRzaDWM
DnCeIqQqBr696Tw19RFn2blW9ZmPov1ApKpoBh5RRds0QT5FE9bI+WFGFuqiNRXl9jWybUXncShu
rJF4aK7gOyPPgGkYuoPZcJ+YlRwnPzCKSfzMKg3DlGZTP14tdpuHCRRe80xHWinKgwv1Ho8+CX7M
O3pNR31DMnLmfqTLhKZM3oqtItxUvyxSEtL3q4z7+MV22uh5dRTmooEF7o25/pDqBp/XUl6oFDLr
Ls3o3L2hyYLOKpllvyg1C/b/pgFelL9j//MhSH4Ieju6qdA77OlL7TclE4yzEWrWmGda+D43ApvE
2rJEiyibSPztjr/KM8vsDdu+Vx7XNMPWXJcDvczihFxRiXdGF1fZdQH4B4ZeOvqkUZ6LTJtSHYWe
/fkgwL4V0L7+PnfnXFvz3Rm/R3avV1e0uRvlB6rdWBqyth9SDxsHQ8jIZ2ocYkqv5lyxvGJH5dKV
eH2hGG2BCpEJSqwBtukBsU45Wncdrj+jJNkNLsYKWJ0cFKwg7pwEt1FKt8rfSvpSZ0yltwkLDVtu
A6gENEJ8OKQca8tihxGzk7mtLJAxybIj8EIrF8B9HRwSeAd0ZigsGLDkxk05PJpsA42wsrdMiO3D
gi5hJ9SfkWgusa5SGrjci0+DbXhVUWASxz80XA54ztR997bCnCV3rrRwtu25SnIxxTlEoX14uCVg
4qXxjBklbhbNtwoHCBTx4ENwILqivQ/SwiUvD9JDif51ZBLUGVOssmIT1ZEVOokAhkz/UMAkNO93
msTNRVzm8WbK7qhWMXCAdQDRaYyjglo1W8zKb95aVFDzAGRtzOGWJlF498vCvyaLKxpMNgfVcLyI
dKnMOjyMBqqF3Aez+xHvEGa1j7/6aCQDRDWiPNOwu1ZfH30GWnMOR776UgAcw+rrYLgrSVddYexE
9O/VlcRm0OoFIMslXQTMAF1k7LX057D9LDKRYtTZ+BAqtFZifLvgwSGXs8inu+JD5UUSw2cAy/58
EG5kCOtHZULZQZR7fhmqKXeqTHe3jgPDPwxQCbU4JN05nc/jW7r9ELXVQ1Qf33bXR9hHqtscEnCf
HhFdkxt0+pGGr7nIT88bL7yKsvTT+aTxquTogIcxP4UXF9NpEL+hfkK59XI5i7+UX8gvtt9Qrh2y
j056PP6Ftlqk0RW/VYn4rUrtPuV1nFD1Fqu4TAGOHVB8mG1dXJIndEZJSt2ACsNmE7DCQ8NwIULt
Q23nxm52C2hsuy6u2B98Fdp2MQSKBqzbBjjULm7zJ4QJ3dEqt1WL0cDOwYTN820WOce81ddVXvFy
tF54QLTtpvhOIMuDhoHUgxAcEmSx/msod3QYQKhQVHdM+7Bgu/wFjCHWnTFr7oIqJoUpR9DyD431
aJ0F+f2l5sapu1qEJErEcrPfxQ92Gn7ZfpAbFTUDC3sHgymAuiuB7Au52ccTG/B8kJFhoeH6BXRq
erq96crXGBk+n0Crms5/T27pa7IkfpTdVVd0DTUdK+eSaY1P32LB1xxZfo6sHRc01fMS6gfBxW89
j/RCqHgaPPLrgeppcMzLAdXPjn39aLgS2ypXooG4eOR//+BDqMZk2tZwXa0OR8QeboFQOewBNGw0
And1YDjz41lwBjdRo1yaAGAHjKMNSDT5UbWREtXpySkxlhgV45dnZZTtc1aSofcncABvIiUklfGm
P1DpLaXLblaBXmnc1B8YL+PAvqHKGGE1VNkbuDtqQNK7he+Gq4XPJVO+Lpu4UwkQdkI6eDVqWB4o
OFhr4pCLw7QeHqK4CYUas60PjabS1oE8VEywVoF5NPHAmor60cUCa3X8f8I4YK05xz9TDHDzPyUZ
8RHE/zb/m2o2elSxv+sT+INP4RHH/bbNSONz2i3mtx7x+3lkKOhRxcO2kRIdbTBs+8KjB46EbUdV
urIf2uvRBW9wUOTYMbDdQDsCCx8sAHYTUum+vv/o13VM8FGFRa3j15ozOKKwmDa0HO/9B8U0/zMf
U0SM1gL/iMJhtG6ADx8Lo3XAO65AGK0b58NGwRi9HU5WLTeeDjRuVRxJHGeypoK75C7A2pViS+61
mqUPDTp4qRiWZSbLE36JkxuJhASBfC1dWyD5esspG0DfC6wRzH6GSEIRQjSh2SpZ7KPgO8MCAXp7
JRFQvZJ2MIBVGYZXwjWdh+k0py9KDaWqU7gMLqCOA4c4hcXg3J0gqBCnTH+lM3aMpC796i+3ASmv
CjgOfUjYiETy5v979+a7y0+/vPrP/4y9f/vr9Gj3RYHSFaWbvW844aGrnyBcc5n19ZdyOp1C4VoJ
I5j5gQLeWlg4r08jEfzs/Zv62V6c3G8/wXuqScTMBEWFtLyxfYtQ++5fP12+YwJHy0n4ufUmuXT9
U0Jo7xNpr4sxyzKVezGMwDGvk26Zau0oC2yqHWX3mEib4BYE+292kP5vvKCtFa3KGry2H5AejA7H
cZCX5oTwkFv6uFycS+r2c6wuhYoqk1wKWbCPDByJIrBWNM0wu4qmOdbeCLV2ps9LlL+n8zi5O7ud
v/Sz6JaHWnVcaVT4YGCJ+qT1J0h8GPbAxxFex2nmCmiiviUnx5b4yepWGDpGYPQQQcXYIipynl4h
N+KRmwuyNdfTUmI3qUF6j10fPUvIcg8l3PP1PQeG0DDusciirSu5X75vYb+jyKKz7zZnE8EavSWz
Hepie4Ft8YE/JWSRcg0rff49+2YxNtrX0f+tHH0+++pyBFtqZEOkh4jvlqwc/sxfLqcW3HtYxiyA
KW1s4OmUUZBOp4ICaRZMp7dMzYmTc+U9kiTk7qJjMxfiF3vQD0SV8gY83bJ74JtyhJbWRDGd8nib
dsFSlrlllAp9QSnxHYEC4n4o/ljD8T0v27sJh1nicHRfls2m/DsCR28YmgTy3b/e/ny5SkLi08tr
ktBAwNE4ml/YjppdMpWdzGggKpFPeVg224nvL6e57lV+WeVsx7GRCfcPAfhW8asLcFF8E2U8LT8p
Qj8qOfT2538wW6QSOw7jfJ/sH4GTM8denFGeOIIzgN/gDLMXBK0VRJS65JZEM34by8AwyzPN2m+W
FUgetuuQdKsnpAaonFcZqDTni02YKlHDGJcGuMa4ltkbEgcltEp2NF3SRXX9y188e7muQzGV0jR6
pAbxIW1zFLEGamINjyXWNM2CTXxuNF9uAflCY2fnrKP8fHn5w7B6odOCFZlmL6x/aNhQ0V4tVzlJ
mwifdBQZVjjKg6EtOIodmEISGj0x8cBGFdWPJLtmyoOkJYO4mZSS/Z+80HacglnYp2wOOABCXY0W
Af0aLa7kZoVm74kwBQCoQOY0I7PpNG9h8v3Cj7laNL2imevL11wqX5x0hCSUWJFtBtxUDOgtvwDh
SA0bDEDKT2R2/Lz88X9+hNb//EDm0ewuB/pqFYY00bjVxdS+OnpuRBZ+EtGoKD+J2HPe89nyh8l2
HDl2ppDSwDJ6nUYVVk1zeoJlmmkYXXXBLK0rAdPpJ6NUmH9oVgtQCY2ZEF8zjTvxJDAF/9TfCLMs
lQBtij17//o86zD5fQwbRnCnAu9cvPb3l+90ANiBI+mYvtBqL7+ekTSlzVd/9v7d/oa6KGybNd7N
x8hhXNKEM3j+oIvp1KNX0SJ/8wN7ccJF5wuNsmfwWzdJvg/stfRpByeWqUCMeHoY6KMQ79tHQr5o
wdS37O0iiBImQT/9+PMy+4cwHCctFHzBRWH1wQ8kIfP02RPFd8ysvSTjr8i5v3mfD/8jXViNuV++
y99rAH4jJNhrLrbJIuMY34pfffopvqGLt/NlEt/SYOxBfqDFCM+edHBKWfmf7zJgmCMxCo9PEeAY
Wj7VZCWi26tJ6e1cw0Cz13X5ZyC+yT/4Ns5i5THu5YfvX79774KWj08GDLt9vPzo7SCmbljmC2ZG
FJoxF7BsJ4p6n/x3K9z/9rSLvvBRbMWlvMb5fiFusTbtwnK7zeLFlfinfn3T9olnHesAAVCYmsLR
iD59LGRP6JJZ1j/ESU75iaJ8N6llVvoAxYhQPB61SjZ9T+dLhuAcmqsXGmD/Y1uLyt/4/2pzuxRd
FJO/U7L8fkbnbDokCD7FH6nsOvQuSjOpHwud93yE57/mwX1vF2H8QoOr2cUTJobff3qnDvhMmi+d
DFfueAdggDwwJgk5ERtwXgZB8acEJNCofgLHsQ3PcfBJ3NyDuKnJGx6V8VeTN15UKPUFW36K8wdO
6lTdIIf0IrBfyKHQBgeQQ8psJT3JjKY+m2+JW7RWTbZ/YtLJDMosdBv7Y4uCWkRbSrPtAW2lA15E
tEF40kHuQSggp4gjFELBMUcRCugvYr8C1XzVxzlPFX4VZONTjBeHIF41yZeyVEKcMKos6Jc1mSh5
bINQrDQLmyLbCf1xKMEPlrc///jhFzFYzS2Tx/S+4mt4KTMhiusP9nmZlJ2LOA/ZNgDmaJi0ApWq
67Df6RqC4s6OIwg8G4yH4IhE7KNkWKxYE8j20AiUgAfwLkJL9S6adBQOgvdXr/h+qIQV6YM9awzp
81i0hh3gNb4qKPnyYlL/pnx5p7HlAzr2VaVNBH7oe3iMldAE07jMuKxfLFzNYo/MuKJLZczo2zef
G3YmKMxMAnww3OCBh7npQLZ60zFcFpXXwD7nkymP9uFhZG/DnygNqlyxlnvhsqaMH9iQwkEE08e8
b4NV828H2RaymxducABSXmSTh3sUioZwSJeSSDqsq7iO8nAH5eFu+WEwyCUtUyULDJ/e7YaguHri
6oXvkMEIeLrz258Zsy7YZnpNZjNGjes4aISVlDkVDjR0EPhg+LB88lHMOEGMzNSZlmGNgt5i2DDE
Ywxb1le810jCdiR1LAePK1yHAfdlQAup/GcO5j8O4fUPH9kWjPLEJh7528hqLCeNoA6H3BjWYxv8
eHknYhqa0QrdYQy1l16z7/Nb99qLsrl2/TamWchRCSTAtqjdwaHIaBJ9SLxD6/QYj4scyPueZhUy
6AAPQ782zWGy2z7EPC95JsOvMrJFuFQgWM1aQ1rUTyoOmWGfV95Qft1rHV5o4vYhXvKdQ2ZtoU5b
PtC+kpZ6EhtAB+pSQjhsLaea8Yi0hqnot/LQmoMMDMUPrD0UWaL4/jWIYmhOhHvWIqqh+eAPrUmo
aOp47l2bKNJ1H1SjqBJ3t2kVlV+MaxXD/GJ8XP2xxBpKb6L+WMINC+enfvwhh1VMtn7sYYeaUq74
dHUzjH7PH6M3vCxfK7zhhNjjUUMU9Y3ixm2JEhny/SJL7hrHQFl3RVycDIwLffSrg01bvavQR+NV
eAozHkbAx0LCU6jxA4Uaa41GAKdQlPuKT9PWWjCcYtTGouQ9xqnptTg1B+KxZ3IEgRSapp9cmPfo
wkRlGQrhwkSo5o2GPdNN9zP+y7pZeTm5yftP79jso9+pCOqWv7b7NIGtuAMC0fpJcQdgBA/iDlAN
1gL8J4l9ms/hA03kK6IibZflqiuWF7Z6FMpt29Gnc/W+z9U//krnKYamep469jgUXOfbjtNxH6rK
RJTiAZMOrqkqza1ZS7jiFuCHJhhrrqKmERfXrntNUib5eOWGc/WVW15Kw83YmXBeh+026PGKWyiL
K16Zz3XpXByT7moRsX3l3tA7lyRXaeMRYhxRFexLlFJXHDA8b87N6odNtlrO6sPn71/UPnBxMWn5
zBjDPKl/hP3dtVBGqRoFnuEbeLyF4kv1ny7gJysv6hUz9awoZzGd/teMzL2AgP9qujDypeTr5waM
j5Noyb7qZk/5q7Jh0M5fKVUw//lz4kVt/WugbWBijzlpETeVz9hd0C+iXsS/2PDTxW8UQQCB+Xn4
DPTaDAJ/3BnwOZwHNGDME/Hud4Gb3s29mClm2yrYA6BU2oc+OJ3LBz6XserDh7rxlzqX82ahOc05
oT0Z17/kJk8r8Tcc0I5CSR2Ns6dOvHt/OiU6GcD3GsNTVV3iMTzQrhnAwB4cSKiWMhLX3GxFZbzB
ZN02lm7aYrIeSSPfZWDZVjj3r0nSXUho2xvtVV6rgmCO4dg6n/u/oyyHl5dx0vHgkE6odc1U0oQd
uwlJ7iZ7TPq1LLb6s1jttM4jRWfG867nTZ5ebCKLUksPeTbx614FGxgjxLiW+n8qCuq5cybQvroM
K5ubbBsuXp/UdKczWCslX1aSpyYI7HEib3NcAs50KluYbwBRdVCkCOj2WNG/tdrAResBSSIJqZsq
pUKJeRTp5z/z9sVKNAzbvk7r9rWdESKRN2/fnBzb5ix8ee/kVn+2nURqQTXFCLyNo0B+5ln+SH66
y7OjdmhftD9KfOWHXEI82ygH1HhkjzoN76Jt64Mpe4xyQDsCOVCh2Lj5u/qNQKA0HCEOGaADY5X3
Q8KN/terNIvnUr3cuwDgxk91BIybluKjt4AvwowFiCJwUQS/mceSoHTYgoD6Y6oHqD+OeoAy4+ro
M3ZlWtaDZexqjyNj9/EY7MeWsQt1ZWMFAHpgjLU4rUbP1TCBuhqIDFoN+IiSaeARpODCB0/BlbVF
7j0FVw587ym4pan14Cm4bVjuNWkGtTh6gnvRtNWEPiZ1iExBlQDy+uHwwDKofzSMrqrdgd5wW2Ho
DKvDvQP2Obnz6FsRYPuK0TnqNBAUe8b2vIZhrTvGAWpTqGraXLT8ySFykXbpx91GAVRCprEJnVH0
yFOo9ClU+k+ixf8Zrowfm64+7pUxUmO69NFIyYlJrr6SjxIs24xiDwmMO1G0LXGofXLbvvakwVqS
HMW/dR4Uz/phRq5SaZ+sZNPW8/rA+aTE57YWGVeik/RwWIQ0fMwRtfARRdOWouAvVRAfqQW4DGtI
AS708K5zBB3VdY58u9V17jgnpX6wUg/VWwrbR02oAA/W6nfutWvaWOm1q/v4JHEfk8Q9Kbzbmj7w
jqRj+NdUcn+IlpQ3Yz/fkYStryrHEU83KILVxYZotGdYqxvc3RxESfrWCRrJxbc2/lqPhsq3qRZj
CciQED/4UM4toHi2YLDm2UKG8/jmBJU+eRAibK/NytRHlvxHHLdmAzVuzbObcWvmwJNk54yVDvwv
tJ8u2UkoAlo+ZHkoTh4QdMETWEImMbq+fLGFyh29IJXDNQyFTqJOYAptBB4h25u2uptts8VP/Rin
5Ziq+92xwdq0LDBoO++kPFaFf8PQC4A9kqw/bMdQ21I7hkIRxlzvGIrsv6SRo41r5NS0dY+uGTlw
sAa8LmUF8QrN5NnGRL/6R3O6l38XeXWT1pc7Pt0lgSo6BAaw1wSrYZsj6KdFCpq2oF/q6WbdSWVG
FQNsmxa1x9EWpZSQyW3y921ypMohC0IwpFIRPILivPXavHa90ikeS7KkRYR1vMqYSeIGzKAaPtG6
cqV+q3APT6d5QF6Dx9pzRozqlhibhIfc5sS4nur6OKv8QO4y5RBBpof9Vm8ZGttbJoy9l9VayI3U
ut07O6Y7IDAs0dC+eE7e1B6Md3ZIHnlN/OtcJssXxHXMKqVMuWCE8vnbO2BXzjwQOILU8gpHPoHz
EnrMvGRBxR1oBqA9aHlIP/YjiMxWMzCQGdJ297IxTGkN52xqtxCxf7jbiWST6hXVHHJvI/qlsLSa
H5HflEpC9Z4vPWwdqXGoPOOBzwQdZ1H5mO+ixYwxKMTYGLi7KigBL0rLVm1JEr6VJFzFznvR8tn8
U9dMk5vRpLAT96LOpkc96Vh1ABS6eB7nbJ6wwSlimniwAthFk4QKnY+393LDiM6CvejCtD7+s0yd
qf2x4yPaBZmOKnIQRziwS3LgMbKPdkM3ncaLkm+W1E8nwsHaNen2A7Daz2wugUj5kY/k8tgGYBRV
cn0+X5Ioozzgb21JJQuT5ZIyYy4p+Hfda7zO9s3vbBiVi4XzlmeqX1IpuzF5UpUaPkC+SkLwqKW9
AYCahwNxu7RHJ4/jX9fjaCuB4SEVZ0PD4Qj1sVwE81XC/h+5MdMZo+yOj3LeiHIx8Wp2odauaZZw
qaVTNrRW8fJmYxDQwPf4FueDsw3uWI96h9u1HQ5xu9Jq9nfy7OaN4mZwtOAGsEDbbQGLE66U1+16
uHorb8NGMp4+4IDuclcpLLXRV1VjPfVLKlOWU1Vee7KLT8oRTvHxfFLH4ZFSCnXyWIivv8eLwh3l
ZtHibptPSomLCEHo9HZKObW8+OVK7s7Jbs5qaCktkHTPBnyl+Pfl7kLjJOt27C2e3xNlk/rxJ5hr
0uHusWyFrxyfNCI0DGOIYx1tTRBlaLsaH6hpoKGNB2ar7QQlp+PnbbWHAuoTe3AQ9LasVDZtmrCz
/fsqlGN7Y0mKCfX8MVJmH0OwCrMBhjWHUALb9RBa46anPkjnAUkSUfayY9aGrfbwpsEok/6j7N0q
W7TyxJN3xKMzbcb/7ezX6ugB9v4SZHeUepvIAXhQ2N4QyWorvXtpyH0aA0t6qfmcG3BUXT+UdulM
D7VG6aiqtA3+J49cy8euJ6t/ITdlJlTJi6hQrRzHNhFG/vA7NVSGHrryvtGd0+SKiiufUospPlIp
ME6pSgHkYGOUyz2kuSUWesvda7M4XrrL+IZuQKJXxSuBblAPjJN3qYK5+Y2BmM02gEBK9RfdJOZo
yZ9Iu5GkiII98j4DMqTKwmHUNxtgVX3z1tQ3Z1DdlHYhU+2vcmdxcf/LIhG912jwkWsuPK0s7SoL
Uel2ISK+f1DdrkjtFrCn6xi7AoBVBZQOLvDxRyPxfU+M6d3Cv07iRbxK31BvdfWeccx6ljqsIjkt
EIT2UMjPOzqyD4JbCl6sCF7D8QEYDrdM7CZeGs+YXsgMxzndtsnLwBe+zX0I/ONfaqQUJLAAHVr/
5Y8qaHgd8iVTccgV5Zr0ayZ4mB4uX2hyn6PUSGACewRIdVDSV3x5PadzBQv/s0mcQr5w4jg+HIgE
Hka+INWgpJY/2KDMNeAixulHnt3wS8oWahQ1+KLtyZOW5OKuSHdUNp9zgB6Yuj9GqvlfoHr5dM09
9zhqlk8HO/RKfVg69OxhiU6HUmaqnopCmRmoKjNaxd6/fTeJ40wYmBzN/zLClcTib5+9bHHA+oHp
hOYIZUH7rVYZFMOXa1ipaHgQZVlXb/QcDzTiW40B0fLKZUGBpfj9fOhUplMm5PI7AhncWjt/nj0V
FxE+2/J0suFeS41DDrHD70qKsUQ0gzHOXckDTZ9/rykNRxl5YwaGUmIahbaPmzTVB9/I7EDVTTcU
NeLtyChKnoLu62BkRlGmtVrECVsG3rqCZvKiOi8Uu8zWrzWl543fa9e+NxnwqI1rW2VfGcjUhWVd
G2UKgTWcFBsCAXaihesGsZtQcT2eJSt6sUN0ZnXlYyDDDtfD2y1LH2FiPTvumbWOe/1Dy/Uht3iW
cleue7pIhagu8cBBDzZaFOiLFleTreiQKP5ZT9QwzUGK0s6BKbVL7pZgFFFa6OJi94vy/boqrd+k
r/VuartsHzxIZ+emtYCLapWoQcHoaSTHkULSV18sW9sLfREaB9YXt28rpjYoOpIDvUY8CbaG1cd7
+MXq2TIKKZo99dBo6T79V0pXU9UcFODxVmqYLlvHfkjdtWWkjUltaqAHDUQ7lBF11VaVrh4stVVt
Uz++o2rGpkJt/xCq2S7BX0NUL8a0XggOonr1UruUQqtM7cIPo3ZBlUt1zwjqwVPmALHTdo1BAhE+
MqNMFv5dhttPOyMVbBOG/qAzio1f1OkXFTlEDPurqulDOaZZG9Qe6PfqGUyHsOrNse5n5kVAp5z5
kGqkYhuIIUTSZXO6Hn8nbYsdpI4dDBu4f2vG2jkL+9+LoiGbUD1bdQ+ZtT2IhxRSGWbodlkQOz4j
19m3f7BMJN/v8/s+f5vNwGxzw8cj2wzHoYSuSaStwkjZFo4xqGjFiQe38aCJsMKDlr2upJi9y92h
YdqBEu3CtAOBbAztAJ38kVpBhHv0Q+KaHzJoUYbNYQkc6CgSGmr9/jZU2li7Q1Zx+EMK6w67hcUI
KJog6B8IBYdsfvVWwoNWbevr4zpk+e16yovmB64spu8u43g22Vrdh/FKww/hYDxIgRU3wfP06pKp
y533v0pD78A07P4XwIPWx6hpjTqqecwN40FYpmZM6rTGM2NVBOzwziwoDVI3v1/ccNmmOvIdo3kj
DdFD0K2ewYRh/fIDDlW+GC2CSJRtviVJJCT9dBFnUch0qdls1z6MxkDbsKUHKwfmeklMAp+kWRcM
oDRhtbH9IJsNKrn8bIlMURFtHD/JzmWIdUMxVn1k2QNt9f1dVnbtphA/jNxzdHUlcFBfiSEZww+t
u/TWF0xbvdeBD6MvQAOrV7iWXncl9pX+suj0T5cvV2xl6IySVMTFavnvuffwh3i1CERjBVlJp2BU
ShxP75/ulGtxr39ojP4hzvtXvWav1sfWS4ZA2DM8PGToUiMhHcO3KCdlKC5XTuwB1/mVc7s5eXJF
eZEq8cIviyyaTQTIWOShPXv2tBsbVCLnPL9vJ92ax1vk8fPQzM2J/LWOJU2rqCqz4EEfitv9LCGL
lIu/NFd4rTH2VG7D8ZIp/vVkS4Y9RKEjuvOKb8kCZNAe7ompzMvCu3K+sVaCMDaZ8sDbpDYaSHeo
VlAPTKGPVkPxGy8b3xMN9cqhwohIREkJhYhopLISOZL/k2UVOmp62RVRAKB1JAgbY9yabl7QHOVL
/uMNTf39lxMEAaX4sMu5kYhVIUFGRCjKgw4nIhpXikCz8hd50MMilqEhRaDRj/PguFANpMg7D5h+
C1IwyuJ+z5P+8h+TtQqhHTEhajSkY0pbiH1f3oboA9SIdSNSAHvLaKn8OumqmdRh8ypKj2/l96cF
XGgOUjzkFaqM8RL4ytSXvP7SeoYXLq7zCNChPlj74FlVl6skJDwNaCuM8rO1GgmOYyODQjxcEdne
v7UUFbJ/qz140Hvt3loP5Xy43q1aJ5J769w6ssiDhlGTzm06HuwdZrpHBGcjYYit7OZ7rrYEoyWJ
kkaBPeHuyh83aXnryU5ffdLV96AkHdLbqpAZ5lGcaxBWFihbZBmk1lxkCx0DVKRXiiGDatktZzDq
WfBuZKi6XlNsPKOFqmw6Q7cOG4+6Hpnx9qsuCZnAc2XH2Eag3rn6+UUc8C+lMlLs2cWz/P626+0X
2sa3283DSnIYhoEDGSHAHzDVkX4MK4TtymjkBqxptxmw5ojaepTyk8AXfQ06Pe0V3ZgRRhGuG2Gm
OY4mV5Qf/SiyB39k59P1dMrB8Sq9frziR2frDqx0YEScYZoS1NxsduvykpokCJKqwsbdLGip4B/4
vt43xmxsU0BRtxnrIKPFatExGNEW4EdP3ae4wRhASqMA3Q+IXdOue7dv2bFuokAqa7hMmhNpq5q7
9b7SsZxGUVMDgEF8N0pst61m1Tk4bLYhcY7Daq2d7j5qddP1tg/XXd9hxFY/+p3uyKq1q0/PqF19
WuZBGXX/xFysFrd0PBOPlZi7Fn6RR4RK37CoRRSntBVSDsjAtkf71oUbmeUUfiPUbBGNNjgKDU31
55CQtGwMp5+PTGs9/dfKyF7yG6lfJXBRRBaC1eyiVjf6TVY1T2mPb/qQRIyLo1t6saXabodPq1I2
fAwafta+s3/YjK/uKCJ+XTyL0ox3tuFNNoOtd8dqcDmyKB6CqIGJV712mTyqwMXzCqF/vVrcbIWn
ZqbpoG8c9jai7Y3LsJWbVRTsj2uP6/3KRSHu9/dulo0sXfv1nx8p2yrBK7K4OfN5cIc7nZE7dkgk
jFNoWnZV+0CiJJ0yiXKTsu0Yr2YBL+MYLVZ06vH3P1LCjxYepTFtP0Gc0oA1gO8RUQq6Nnz6JQoz
Zm/vaxkiZszwvgCROH0DjQc8nrkf6TKhKVO8xEXr2RdRMSQlIX11x+Z1/vKCzbQdaHl5wHAGVAjH
v53nfQCT767ogm9vGlz0aCfAodbCKObxLd0eR2HbLyzzxdnZmRJNoXv2i/J34vN39+e1Ecmml12p
BNkQGI1sYnO6HF5e1erM9TiYM2Y+lbZa/U69vM2nOgz2jXsx8D1uC8tR6ebLfIK2bWHvGw+BQPmc
n8WJxB3vZ3xBmEIVsAkJINMsXv6jMZ2OgCYFpwnEnVrx/AJjj5ZRDOWSJBljQo0sl7M73qxD82dx
ukqo9h9IYzh+/ef3X9kEsrO4mAYDT8VLb9/sPgGFzh7xfTDitmYcah0GNIQ12CiXmvmzC7L30Vam
TOfS3r/7nx9Imp3lP/+RNxlgDP8y/aEwDF6+0F7xbZ8Jl3NGp1dJFOSd2kWdsalsl3d5TZZsa8g/
3vDed+mU3/v8yp3ZTDlLPMZ4Uzm3jtmalV+Kx4uJaMs6tnzKBu415bxyvMtjFlxhHOWXEa5kvla3
T6krg1D3hD3Ov57bPUZPHM8Zkh1ymGVwhYp0a+8VVRXuai0y4MPbRt7wviz+Lf/d1iGmSMze3Gxj
WC+Oditk69eEZXLRVolCPKT452L7WyrhxUVLZx8Z+XEejLvI5LPWyChhXRQfjgU5yew8nMUkuyi+
UHuQ+GMeL+KUHfdtLTlrL30SO/5dzMRDy7vyyrvlpeInFwgXT2vdYI56+Z7s9OZBlrB8emMRn+Sb
qBr9wRbyybaOTFAn1G6WMLBwb3GptXXo+csKxkezix5ICNaBHaks3FDgDSn7yNNF70uV1/MbuiG7
qSwjJSkdS1JLCEVHw5a3mlVQtgUC2lDkgKa52gdBL0/xSQScRMBfTQQ4SBUBIT6MCFAvsWgms14l
ySdNmm7regZ1jIFsRs7mxGzdxPVL4ybt2X7ztPNPO/8vtvNtNXrdw/d0+CvHvuvy3o+L1VzEkV7R
xF0m8TzOaDOyii8kb3PcmRBaOoXtAALP61e0pwJdpjBwbAxj3q5YLrOcg7cK3SiTuyPfqXnpAz4n
MZ+ENKuyn8sWxpufk48TxakIAXsi2zm/WG9W2kaGKsQVUq9f0XaVDEouR04KgUnUxw/oQmTqLkkg
Qjg4yrz39LPGHOrVLFryeQFWEnqxDT6fJPhJgp8k+DYJjnRDFeHEalfeoHFS3k5b/7T1/0xbX69v
fWq0a2+9Mko7tDeV1Ix3ROVGcep3NVbvOu2xctrDUPdPp/1py5+2/NYtb9hAOUZ9S9QMHnnLn7bT
aTv9VRyfZpVhwraTbAK1vp0wHHiC9ojDq9czwhCfTsjTlj5t6a1b2jKVaHvdD1G7PWzY49nDeebB
nNxQV/yeTvbjmL1YZVuCwjb2q/F2Rz8NJTnSN8J6vkKvmt8tftUuZGrCuUf8G5eB++IuSXZ93iOr
44C0u9ieZcKDZ+4RUUcGnXLEAdkUXD6HR8lAHYzlH65aJ5G1vOgm4rqQePi1fLG2n59drJWWe7YD
6mNYcV11tQHqla62fHHYuuv24FV/POlXShoxz7/CYHj+VZMUvTaBUveq1354Mg7NXmgbgLVsA/Xd
njtiV+RPtm2D7c3WoA4tkehwiB2grRcr3U27x0oSXuAY6KTdn7T7k3a/i3avRiv6IWjX7s0hBvu+
sny9KGULkbqZfdsbrSHhO7ynso/8nLqb+L8X9Y22kTXanlpwiHyiACA/XDJShWwjveqHTMv7exH0
yQ5vPUaiqhH57PXyR0dZLEXrDywwtg74sOnn02aHu4drZTEt6nPsk+hl6EhJ9PK9eqKX3lcj1fZK
6XbUjG7YN1AIHltin9IOOXAgEK3t2/L6QO/FvhQS5WyVhfbr/Hc1PZiTnI/Ay2+vlz8kwKM6CHvz
mtZIpRb97F7HsxkVhP4Ui6Tgq1W8SoWaXkujbodWtgwhgJjUIHZ/bE10Mp/7/UrU4vsQi1qRZ3w9
5QcmvOzBVBTC2gxRAWj4+p+FVRmL2gqvQuqPzqv/Gy3RJf1txXtvn73NgwzPFvRrNtnCE8UNPQE+
Cn1gD2HYZRJnsc9Owy9RtqBpKjKvCzQf8jcLVAwTO6m4vcTL7WlvFwH9yvZY8XHG0JuAmwoz+54O
8DBmbkVebbezdOWlfhItszPOHk3srtiCsr/oFtyohB0AgHz8J2FxXHkfAweE4qRrzbKGem8eL+vM
cGh8oa61jNxQLQ41OcanfJovk6v2cgPKJrQAHjVb/xjXpCpcx9dEeEfa1wSPuSai8Spbk0s2cZL8
nIi9sanallgO+GfZCSZW5wWM7p3gjKyGcokUXfHqj24xTV6/l0eob86oC3WIfVU1xT2dpcd38ip+
BF79AXWuhtH/7FUVobJiB+RnBO8px9dKGn7y0nBTvZuqBmJgerrP1+Q1+/7zX7KoAOoMOJ6bUFyO
LyAZ2VY5FQdAuU4SHGIN0x2H3wyKz7Zd0alvbGkRggy2W+v3ZD1Dqo6Q8+0a55ud0t/oN+NWhhJF
xtMu/laKZwYY6Xobf/cMYNfa8VzRbFuQOsJh2GBu2Ev8wQOV60GlVBDleuzx9RZJ+elHGr7mJlp6
3njhVZSln84njVffLsTJz7Xlp5CnRAXxG+ondE4X2SXbseUXPtCEa8pvKOdg9tFJj8crAce15LA2
k6ZYXAIcO6C4pwkunCzi8W7eZsoNaKNvdYtZUlpTDhLFKgZws9sw8ctSZQUQxlSLK/aH0L02gHJM
BVTY11Qq7z8FTUh+N5gl8d3G1ShyjvngDvIGDa5VzMo1H350RaJxipCL/y1NN1ryb/0zr5iovaI/
iyKwr+KvnGEl/ILzfl4SZkCLR/GsNvniJ6ZB0ex9/qTiyW8XzJr12WC5F/jZbl4Nx4CW1YsCBxMu
VQFFz6HQHrEUGD9tBN+ekZSfYLw83KYDS/GR8PLkuT9PPkFCwY496KhiRx8P02j10FRKAdCpiA+N
l7JsLTb0YUdSqZiI4ScbY2TUGImHvJnbqBAS0zREy8uCRHqvHkPTDfElG1txqekwAIR4hFZcB9pf
NlBL7QHRBK65vzDsWb/ZzY+niAkgxicRYw52YrATOBOr+EMSz9+TxdWMBj+ROf0VtXdLLq1A7Pj6
eBUMoTFqqUikVlA1AQFtpSL336cM5Z+iVKT++EpFmn/BSpHmkVSK1BiSU6XIU6XIU6XIU6XIU6XI
HX2WJ8F4Cr48VYocXixKfutwlSIVLzMIbCRs+RFqRRbfqnUWEnPgnrgZLX5uLl9pYNvXIfh8kkQn
SXSSRA9ctq5DEh132bpKDj3GsnVlnJAoW+ebg8mglK1bEtkCSvoAmhMTyLdOrFbjpvuPtvl3Lz2o
Uvx5+0UwfM7aWrkeOZ+Cb7+mjAKLesWezYV6TLUsH7T80wl1OqFOJ9TWE4qHkChHlCkCjA51RBUC
Zzr9v+LXSfeOLrMe+I7WsT3SgVNou/9XV3fXAajjQxPYJ4lykignibK90Kfi8+eFPjtSH4E9UKLs
nECkl5lcPIEIWSMIklomdUqzXcok2UoiNQ9XPUmTkzQ5SZOtvjxbV8skeR2FBAeF8z4/TO1QHSn6
A/UH7vhDFDd1VISh2RMhOr6LcL12Ea6PHXH6B5vzKea0g1nRg0Wd/nGccaeKkNkr8tQEauCpPtDn
vluuNVBadXvBnyaBFasCAYT2+ALhFIS+Kdf/JBDWYfUIRTdVgQD+LAmH0AJqdjm2QWfGIThMxiEX
je5k40c6kJtVdBuyKVCj23R0L+UxRrVue1m2ploAGPY9p055sH3zYBGylRhLpIN6Jqw1pIDHwcxS
9qhVei3SI5tBEaMO1FV2yFbiUhG2gJpEiY1hyaE7712nVtoGh3+aeiEGVnM39eAgWcu5TpERNv5O
yUvIAn+eQ/PQieHamInhqErT4InhYruNkxiu6lEevYoWL32e1rarbol8CEbIJpxOE6ZsR3PuIuN/
f3p3yVVO+jUTXag2l7BRlEoKqAWOKb2uvPqX+RMigOWUu3s/ubtjGS0Q1qwWaB9V/mZZBV8wmNWS
YAZ6ppftaVxZNeuK7H1QWKPmi1m6mi+GTL8tX2x/NcX6U6SLWY8tW0zT9L9YthiXYvoRZItJaaqf
ssVO2WKnbLFTttgpW2wXcXmKMDlFmJxyNIYHwBa76Y97ytEwbSVFg/RrTX+SACcJ8FeLgcdqIyrP
DDtEgHHaTqftdNpOW9u911NKgtAer/dzzfN+pO3e6+X+HqrplnaEd1Zlkp5wOSFzXK+gvE/o20hA
r8LtfBQ6xoClb69sRhbxImK0/5BQ5V7tRz7nyC/qM25CiKvK+57t23iYdicBXtFsODCrqpDpWH5f
yv21ul4MY1YbqczqIXsIs95j0wtsqk0vegYrVTw8rOnFv15+3ogVV71cHBOAzwOPq369n6wyr5n3
fkK6/WfZXIcN+pPb6zBBfxCpQX9khKC/YicqhVnKjmUBndGMTm7jKHi2tTIL1v80wvewIUTqGbg9
hAjXQoj23oLjVhLFSklW34SotZLo/t4qrOUWW1Cstlj87lL4lSrnYUek2HxKyCLl4jV9nj9rQIlY
nle0hihaMKXk9SZYwFZxBaKrWicu1KMychW4uUfjAAepfQPASH0DZHfBephWI2jkzPUZhoz+RL/I
7k4TT/x4m/6yiJjeMZ2zbTlfzV+TJfGj7I5t6PjLD3HyUphQm3udVToICTyjTxxV1Ri41imuMQcJ
/IwL5XQ1py8XwetiTiPOpmy+LaZD+hQQURuz+oVWXZvalVSqNVHGu6jurhERssZkPVdfOsJ+zkVc
2dnLxZ0sAH+xW6JAYDEhAYZMhU9mE9wOvK9ISjcyjyJTzVDHwyBykM//9dOlpI2W0llY6Xax92//
7OVaQKjtB6ZNHPvz/YiAA/UO6WyN09U5pNYWJ6T28M4hVeDzw7RZVRNq+inZtpL1BkKnFzPCHqcV
wtXdExOhOhjTIaJGSa8WN4v4y0Juj49C33F3DJrWIfTt+yKIo8QJs9Mb+htPb2z2gFVsljyCrDsY
qeplBahvisr3+XfkTgGo1+hKva9NwUgBX6QZ/0tMWbrJiy+cjxCp8/Si4RStO5bll2sfEP9cCBc+
HCVYqEeAyuZYQ+wwlpFZWMMCIRpO5sFLVV0NdM0vJ2h6TRIauMssOecW38V9LGYR+XV4kOMst1UF
LjoBkIGLI613456usbLMUhRN3YbdWR3wU3zNtyUqOr7jiCIa+aRyYWYYA4imbJRrkl67oovyufqK
0I1crkeeN/h0bTa19nkrode7N/SOZ8ClzS9XfFtnbkGQtmdPWj73ZP/ndERk6Y5SqwRinStXKkmY
gmfbg+g8PqWDmLE1/+Z5lqzoRava1myVq0zSEN1r6pO0TGfgJB9SmdTWkPRTKlFZNZN7bntlnsH9
fDIGUpQnW3jMRnXJcFp8x6ysj9RfJWl0S9/F/g1bEf8mN7Z+iFeLQPi3ZI5lPn9KbMt3ensmFa/o
Uroa3fkqo19dPnLbwAXdQ9NCxv4N2/Co7rqypAZ31xlhaLe56/ZXJfWxkh4MU+2g5uG2nAfUx02m
V93PXFdJWOJ+4NKR3GUYVWaAFRKCRzWLRDqA4pTpDxMqO85GDlVbvj1/yx6QE1C3+toKuiah8cbU
vyxSElLpDfsQ81jBpATYrihVxqUNKBibihKf2jq+H0ykdA22ken4B8DJkW7IfBI5rSUf7LL0ukJb
ZhweBjMvpjQEo+ILt0FgdbMnHgSSl8MS7Qm39mRW8nsC4sNm47uhMLQakJRm3c2hDViV7ggcmaBW
QYGWMxhKe19AsW5qOukzReXif3bUoqh8EXqg0O16agIwAtTndbDiMpRhluKQm2sb+1A7wA/EBW75
BbmgOj4qKtpApSIan4paKxV5CM3sZUEZ9rKg0g6KNkQKhQPDstcoDPVxYDeAS+H9mvjX9Pz9p3fF
C8xeSOgqpW6YxHPX52/vMAt1Do4oUyAvbeQDGO11NND0HCIi1ROc0bhbRBqD7bbWaBUesBn52t9J
Kq7JzwJuuZ1d0Ywdm82AlV/eLjIdbaRxYHimyAQa6zCCoyUEO0qit0OE2bimZ6JeNkm54glNeeBB
ICtRbAwvsJVmvV7gg8/Dksz5rswvnzbdy+lKjjn2cM9gHqXshByeze2LEDCchYJJw+7f9GfDnm7B
bFSQbY93ze0Jub8hbSoVrsI+txH6qAadqRhMvomQPUZmvjbeRqu3xHbstpbYcH98RTyV1K2CrkbU
lXMIBJ4lPGCVWqXvfWOjHbkAajQK30MAKeV7mADaP9ygiBkrwkfPL85IKg6I4vTY2C05MAkQl7+V
60S9iUZ2LzgqoLM5WW42/LDS6MwGljXeuVWLuzzGWOxGjkAZjN2AUNSlKf7+yGnLPdL83iXPbah6
+sjPfiIJexA/CfISRG+oDILleSryI28XH5KYB3HkVwfPnu42V8exPASGzJXPVsScc92xP+AnGwGb
SoUnx0L2QMTKcSuh7gBTlH3KFzP/+KTZWaq9VE9VP8gyPdIDOjxqz6BW19iOxzNYrvSRewYrnjxG
z2Dt2uSIPYMNy+xReAab11JH6Rlcvz17EM+gthHIvXoGtS4wx+cZ1LaDfRjPoF6F0L8ii5viFnRG
7mgyTeJVRtPGiebF8U06Ta/j1SwQEaqLFZ16/P2PlAT8W+xH++awsVp7zbc8NcJeDF8cfvsqyWwa
MuH2LL1b+NcJU0J/7+i3W7vLNUQlsuKreajo/ho6G57vAWXszfKLne6GEA3yTbFyttGDp9ihvc5C
r+P5nCyC7xd+zNdjupUksPLfOsg2RARtIDKSZX0ws8/O/JaD++5f7vtP73JA8nzSvpAo+4XxzYzf
m/MUnCC/5BbuXPUQZTa2aTp6DwtOE94RBsAtLraZhhi4fOi1LGH5AaVqqK2U3QZw/xTAYngJwF0K
+rv+bdvoed52FTBbhVmEbI/0GdochSUQVllCKDI1lrB7EcXYARs70edR1gj2E2bZ5OlFu9JV+Rwd
5PikCdboB3aqYcbAL3/8nx+h9T8/kHk0u6tzskSacy/7nGBg/mEZ+pyDYotJQ6ePJavlwcYcxtuf
f/zwixhgAwbxoVrlcg/ZFsSW3X9wTQyvbON/ruiK5uPWsEy/kBs6bW7mskIx380II38IFA6mOI7c
NF4lPnXnlJmObs2vUHxE2dRVQybkYMMeBoLDcEsc9JYuMncWx0t3Gd/QDSj04ghgMHSDemAojDqQ
m98YgNlsAwCktN7UTWLi4QA4hBtJArZFdxdvAbF6jw4H7EujCHIV+9LGvVlBGwTDMmowwp7bAh5E
oNoAqwLVWxOoTs8jsYtilUwpyfffwq6VKaQ0+EjZS9z5mXbQszBzGDlDRHy//6G9ZVW5NcGxCcjT
dXzTDoBmBZBSk4L+ACXErgNhK77i7I9X6Rvqra7eMy6ZNg+Q8hqPHyCAYjwELgcsnizL3PxIs5/o
1+zHWeyR2aeE+PTtm8bwxd0YG912vH5yEo6hB6EqJ53rQUZTNe5pxm/hsbwOeRerF3XtOa8DC/Si
zjY2qkOoFIuCHkKxAMT+PMCP1WYd1McttQhTtQl04g8YtxpZ3ivzzfKOeHTWOTauhmYWAf480L3E
0ybdeXp1SRfB5WpJE7RLRqVB9r0gsO7RtEdYjcb1AMJdpj3eO2hYdRyXbnIu5iZ8F6dT/i+HPk15
2/GUz5DNjoFNo4CpJXx0NovFzctgHqUpzzXaVhiBFyl3cMs9prl/bDd6kEtMmeZ/JFeY3zZuVHe4
wDRrF5j22FGgf4gMgPtL6LfVhH6jZ/ZE3r/sQZL4EVKT+EML9J/CQwT3TGuRhI8oxGfaiCXsF+hT
et5loA/uuXr77GBD6QNm8/8bPY77sdXXmm6OVxyrulZ1z82ra8FBmVrFVWgD0Ka9Wok6R7eAjz8P
DEE9D2iwWs4inzOLm97NvXh2sY3fq/ww6sE+ZfN6RR6pd78ej3jtldtfu9XbeAUEAlvHfj0OzLmf
qUKzpp8Q3K/zEZ9rPuiWy1QmtGxRJjBepnnRYMvoGVmqmIX54JPmpWGZv7q1JO4R1Ittr7BYUI6Y
vu9ghXLYcHoHx9Zqrvrz5Q5NTLFym2KG+ycrwvvS/2thjMRALQ2zhm0vwWobFHAIFQHih1iNHSha
+Tm99tnB61g1pUMxDw9bsgDhmMVo77eoVbNvnzo3Qx97bkI+ScUuLa+Ruw+6qoSlb4P9S1je296C
yDKVzWXrLZurR8m4Iz67sKmeXY7eOLv0npz/MLn7w6yPoUWg7o9LTcWJ5ZHWCH8T9YgbLbk0iOad
Lg+FK31q4nXhjy3Qyw1+rz1cGzb2g3Vvvc+4Jt1QpJvvYa/L+bm3/oDrj2FKH6PmpKscwosqaoPh
IBjZL8rfdbsd094aBdwDkglUOIY/EgRxn7TIztyEfPk7Sa9F8dtJSum2SpQlR3nYt2DPWyVVGFVJ
htdc5+C1WiQOdzMSHaKqkCTA+9qK+B6Z27QMNWhPlsUdR+XBpx7FTQbDRcpKQmeUpLRoSbyryBbt
6nqwNR6vK7JTa4rc97oM79tl2EFql2Gv9y3diSk7ry8fijmV8Y+LSdd4RpLHv/1S49tiLX9eEmZ2
itPq2earhUbOWZGl1i/NDELlHsIC1ACfB4av69p8NcuiD+RuFpPg+8Vq/sNP50+uySKY0XLbNCa/
40zKmb8TOvyl6D8kDyn4pEEl9W/ek+jZ04t7HW1zGWY138yw8VCa88pUJ8m0hUSibtKDyqgq7okh
cd8w5ttBRtWrrJXOW5tSXbcNMA4ejojb7ym94ivvXvG2ErJZh3+9WtxsrRagV5eIgaF7/liweHEh
dx1Z8RfTYxc5zJhb9/52r5iOFKTEGhHptAMrxzgnyY27SmmwDR/ElUcksHQPjImvpGZC/RmJ5nvA
QpU7MdBD4o8LqxuYqDe4HZ9ZXesFJnFGhyeKXBH/2r2tMGbJnevza9fZttDmMqXSDqATotAeH14J
kHhpPGNmnst9K9uACccAVHyAPgT+i/J3OCL3wXH3cdnuUOxjxx9xxbuwHss+VhAe0z7eDOzB97GS
WHmM+3gN4L77uL6HPw/PID5p8Zu1eKDo8Njek+L6PXrpoIVV129g+2PF36JHfkf4UPG32jHF38rt
3rz6z9v5bvFVw6pMDTEtI+xd0e04gge1+w8eNIEaPKgDPLjUG1ejth2zulLdjfq9W4K2hv6kNNsh
9EdNpHYgPuKLX1y7+LX9loo8hjPk4vde65cdVfWy49n72kPs/cGBw9o23McSOFxXLe89cHhdwa67
/TpiU6oAKujve7Sh+4wxwEYtxkAfLyVmjGCN0jjJozX6hHkKty1TSLYHqUBT7RvrHPGyIRsoMRAe
JKPp5fd3OMKaXm4F9tixe1sDY41aYKxpjxAYe3/k05W2wky3MOyxdYuHiCvW/lRxxdrDxxVX5Rd5
XDE6hNZzv0l3WnPkx5Bw1+Ll3D/cVXG/hhDtW+XkXpUK01a8Rp6BugqyYTBIvL6JhH5KEiYWfpWZ
MkwhnMe3MhhiwlTUf9C7DoxlAQZqmibwRy3BX9vw7kfypUJaXNuG0SK32rZl2lCMQL/o6j2BXBcx
jx15aEhBZJCBZveQtavqyvG108es2Nkg2U/MVL2lKtaA8tpyE5JtTeSgpkPpWAL3PrevAWrKJcFd
ccfWMKfvJc2qtY8WKVNcOrdD5UqgxAz6lFlGbSvLIciR+XnrTtmyRsVx2856lUMnsLx+MR2wCwnX
AX+nE7844NsFl6L3BRaviNEPggwxdtm4hSTIo0joRGimU/bSdHvws145IhxE0b4FiOA98jU21Th2
z/ZHt3VdWRdpdxsT4uMll2HV0g8CfADXwCnkrDp4HibAbA/Pv600SKU+3jcvEN5rSWD13tJnknpE
3mVYBZ9oQR4/HoctDWs2FsNnoCyCxlVcCjTcebsbHFOhkW1a4xq+tT6wNdZulc0FEmwHxr434vcq
FQGqKUdGRwLU/mz1pyQX1KFyiBCPgvEclbukP0JQy38kYJz8x1prpWi+tbGSNDCVghq6frxLhmvp
fj7273fJDpOxume+quqmQl54xGqabqinioftzixRu6dSuyPJ7FqKbx+7ZP3GSI7KbBTebkEYiO2f
eCY7LFU/8o99/9WfrdLolllTP8zIVbq5b5KixFmOftRrbiB1zR1/xDUf7LuqChZx11Wf8FpYpr4y
bcRjuta2YKLSBvWY0ULwMdugjmpUOXA03wpc8634DBqzRtOudaoiIkJAaDiWNnqv5HRsVfiRrnT0
XuT8Swk/5cBjwg8dsW1nOhCpmeNel/Cz0d5r/jDp/+Mk/wMl9V+Hx2yc66p/2bdQ16Z19hM8rTbn
2r1ktyGF9vPGQUtvWzc2EU6vvPmP6FSWd/TL6SiIJO/p06noYNZxyOuKHh7YQVH+Q3l6rygJjpve
klnn8a10Mgpsi++uTwlZpNyhlj7/nn2zpwEgScYNJz58R8Ck0ssoFNWes3JsYTlZcM8x2ai41rtG
zF1W15NV95pV+i62XqVDPxDO4wY23bL3Bve8CS/vLsa7+rSXP6kMS4hCH9U7r0HcB8Iajb7njTc2
gajuYxzdl54s0axDlgLsh0Gi4LXjL1dJSHx6eU0SGggsVXuny+hqQWY0kDeV/BxkG+L9ZdVqIP+y
ysqOYyMT7pssrX6WI4vimyjjGUmJ688int3F1n9ZDPuPKFMi/xxoYJ/sexsicvGsUZgV1JgVj8Os
muY0wbnRfLkF4QuNHRazro7CuALqhU4LUGSaPYB+q9XoeLVc5cRswnvSHmBX+Y0c3YOhLRiciT5Z
6rIXoKmmq5B+JNk1bxYhqMjwbSZiW+nQTfjNKqrJwQEQdkaUxxhLSQHNnrP4oz6Pjh4YVzRz884r
LpUvdnTOM5VWGGYAGq0wbNAbJk9N39ZKZ8lO0zp03rjhTa7r8Fiirs4rZV4Rb70SWEYP6aI2PeoL
lSlfYXTVBRKq/WECxwDDQPJr9HWYEpiI6S37xNRbePkbQRp6SUmKvb17J62D5JEGbBDBlAq4c/Ha
31++YwooO+MkDdMXWu3l1zOSprT5KtMg299QFyTioWVtY+QwLmnC+Tp/0MV0KozL/M0P7MUJF5Qv
NMqewUs8FJ1341lhu63xICiXl+rh3qnCbZQTUfaSdoJofILx4hCkq6b4smg2ymiyoF9ymjZj+JRT
ZJ3NQUkHZDv7tr1qp8O3RX+h9T42uSfsFV+/S5nq3ex0pFcdbWwAzJEQlT2PPlLZp+5dlGbsd7o2
vtKqj9kONhhr/J5JW7iWtAX9vyijlrUHBKMSYxQ6aFsZVeAuWOZlJpKNGgxTamK8BVPogcFCGB7g
pICWelKYdDBXC252vd9pEm9nYtNWeBhYvQ98dH9qoG2paiAj25oaiOzeJNylFVrZRVL2w00n7z+9
m04vo9/pC638dUtfdqYXBs3uwRg6vXE/3wn5nNx59K1wvL5iJI669NcyR0kA9WgTKIADgMpQPcYQ
rnAEuhnxZvRcEK7Yzs8u+LuUmWHM6nVXInjRvaF3Lkmu0sZHc5qXf+fsdDFpfbnj0x1avEKFwHQ4
o6mYp9Bw8JFyWn0FA7vRlxIjOEDKbBODBWzZtCGd5ug/0ES+IirIdMlDXdH/sGXTgUIbPgqteSmD
+75f/MZ7Uf5D1DOZtOjMbWke9aC+tk8861Ixy1ASTmuIAB5+QD4KGyUqzuZCDnyK1/QeQcsNag+G
yrmNQsce49yuU0/UfhIFWnKUCfFvaLIPPdlsSRAUD5h0cEoVDLqm3OGKQ4AfmiNoJ+3yX33llvtB
3exuSc/rgN0GJV6xhWT0udh4XNQfIcZZRtSnX6KUihy1LFn5mZuVJ4T4SLZazurDFwdL7QMXF5OW
z4wxzJP6R9jfnfp31R/ZM3wDj7FEfJH+02V8VLRRmDxlqoKANp3+14zMvYCA/2paCfki8pVzAyrz
2ePEzZ7yV6PFbXxDd/5KZ5OGskNbAG0DE3uc6aotI3g/KeEE/hcbeLr4jSIIIDA/D8eu17AH/ljY
HywHr/oL3psFUNXuZwaAbxprBoA5rv4vdltpJnMtmv/e2lOk88rCAYFhcaCkeI40VXQwSA9TwMoD
7TXxr3NlWr5wwVt3rZgICpN47vr87R2QG0gB7oh2BDJzVz7h7Hqqo6PnE6u6emV8IkvV1PjE6TsH
TvpwziThLUTsH1E3JJtUr3gkjXw3FdXV3NuIfjnnBdTYydH8iPymPKeq93ypN3Xcg1XmL/CxGfC1
kY/5LlrM2MpAjM3e83qYzjl1BA/WvbP4Cw65ZtMVy0v3kAj2ra7ZnN67pkNlSsWFsrvM1veL9PJt
Vo52fEZ+1m3/YGl97/f5fZ/fvjOqJFoDGYa4IW7Y67Y5YMc/9L544CN+0K6ABlJvny2RP19uC7Pf
thAk2SXNq0ryCj0/6CUVrHGjBAykBgnwu5S1IAH21vAggTzqRfyYrLXY3Jan7+i+YzYCYfSeS2W1
aFYC1ltGR+XXyfrHZA/PdsYyFbbyrQDXwPaMB5Dr/d2/XKZHqQE7hXv/56XIPys8WEI/lKEfRWwO
ATrUe+4z+V9n1FAHiFqQUHlTxqOEDAoHIZkyLG9/fh0vFozNX7OdxeZ7HQeNIKFSLXGgoYPAHjgk
J0AUc7uZj+rO24YsRYoYMgwHD8kHFdWG5+kVYvZqRpMF2VoG2apsOofuXUSiDUUdRxWR1Y1BqXfs
+cMYDw5hPARqjGcOQiLvAO+V8eSg98p4xaAPy3htOO6J8cY+WZWIWw/6XN1ZDxTseYqZaypQGC1E
rPSOZ6ut2gaeUVOCrL66qbHDTRIPW4sySdRwtRDpT+c8t0KbPG23My0FK3J80rhBMoz+Tha8NS6M
Ye24HrILWDz6K3TsAd7O5wJIR5RBHUUZUoCUGBQLYsv+POgmFOdaRj70P/ntTz5yPYbgC7mha/oG
MitpayKM/GFgOJzyxlH62Zn8S66oy2vKl5Kg+IjSIqw0cgBysGEPhSH6l5VIhDrnzuJ46S7jG7oB
h165V4Fu0CGhY2qXuwrKzW8Mwmy2AQJCoIJgEhOPAYGDuJFkiII9JHJArAHjwwG7FCh71AT+KD7l
0SSbrRg4TLJ5a5LNGeAkaKdZtbFLAnJV6peFrK5Dg4+UvcTLPqcdFMVV0GuIiO8PcyRsXNlC0ROg
p+sIO6OHHSV6mFr+YCeguNAsrvx+5EEDv6Tkio5yn3zR9uRJPUZO8ETX5TkqoiGhA/SAl2wbNNu/
wIXb47xqG+OSrSzdIzxwILTH8sDtqX6qzhLP02uuaUvv7YNbF9JtmRK7QdSVJA/kw7CRO+GgPjDR
uCYGNKoEDw/yCrst3jsT9Fzj/WMj5BZhZuOOgRDKllqSKKm/IWVO/rhJy1tPdvrqkydbapR6SKci
z7nhou/pC/6z003hOIQBAC13G3bvDTyYdEHsJpR/+DxLVvRihxvmKuWTzQda6/Oxel8KPOxdzbCT
wjJrdzV6LxBw5IxG21YuK3zY6lEB1vAjLb/oC9gZ4l9POuSHmipMxJ2+kiqMrIcnlwHVBFAfCS/P
mgOqz+nQgJrf7aQie3jH47XU0cV9SUDs2n2J1Q+VtpOhJnFKc37SnMaG+uXdIfSOJWKyVdsN9J3B
bnOghT4TLa46Quexmvzp6GYDIbZgb4SKqC4s3eL3832xT6fM2pDlVTQZVl4zAp89ZXL9/+SzJ1tO
cgdRArhMKEDxIBTDGDDNPoshJsQws3/bATvqupgOHnNdtGaljtqt9JpBpR403n6miX3QAh3QrBXo
4KVf2gt06PsJWruqd+e6Smtv7moom1y5XY1hyuIdVkiEH3qMmk5NUvYHCKtoucBGDlULMj5/yx5Q
0mz/eDM7bw/1RXiLUhLSIhtA3BJtbhBmKd1MAAXjUU4ic9VuH70AIlMpjIhMxx8VIcco9gKZaYLn
RR1Zfxanq4Rq/wF5169y1XdZaF2hp+n5Y6Pl175D0FVaGlvuwOpmQ9wT3nN5AZYXCeWem+pioFkE
o6oUSnxYL+iCcH8AmrztyiGkNOuEYFgqCCcgjaoyjjEAxLf1S7dccRWrxNj+2cWE/7ul0QMIQlOh
zPXU7K28FInMeMzoZQzVIGC5ORvRy72uLFXAUwZZaDRzdsAw5KsFb4w9qdloZ7DNFQkoAv2so/r4
4oJnKTPUXIHCDaMkzUJeF0egEW141jJp5TdaL36gTzwHjwFtEzh+I7gdVXUb5Pthv4uYdVAClrtM
7xY8VIDDCpJ4n1AB6pHBS/coIvWbVQYOFa+vWEVM1uGx4vWrqgQ7ylzTrslcYfyMJXMf0q2jfqOm
5xeuHX4v0eijuVHr92HvvQiHKAlQLUUNfFEKr11J0HuTCYobRKlXy2oIS6l6ycgxNbBpU8lHzwuN
hyESQjUi+eMT6b6bzGltY99HmzlHbTPHFJx9YOPD1qIEWDV1/aLg9Hotyv0kJ1ZKu5c9fbtbTuqV
HyWwiI72XlhdYw9/yw7cSZr4+e0xdwxt7JxdaaGBZXs2rjN4niKVT9/cV1t/LoupuRnTUFzyNUo3
l+SE0DdEP654meblJWx97yG1egU3PvZaakJn/lj5RpUifCubeMmLkHm8iDn/0dpXJZfUXpL1Dd4x
vWHW8q4MKGh5qfjJN2B7zIpRnfCEsFVT6aWbeyeyyU/WKHYlUvH60kwlCz8Hf5V+c/EeBKtZI9Hn
yKirCHwIPEN0UufUvZ7C/YvJPG9zYW6j7m55j+qn+N1b2+I8QvJDXMWaEoeGgV3jboROK3DoFVDy
kfgKiMr5ygqYPVegvJfvImxVB17ea3xJyNKNuOOwfaGeXXRKog4PozKv0BYBBxIL39wIwt4TUy5j
0uWMGeTS4GqbYhFY4BH/pmNeTy4m+0xLr1y7xNedPBxAxTHFlnHaNofeNiZSBFcIzPqx3PvoWCtI
yJvIbi/mhpWYt8Ax9k/7gn10Saj4nS07HKnnmn7gey6lEWRgWxiPc8+F7lX55zVhj0v5f14E292f
8v98XWadlP+t9Pp2Pyl/Uv73ou3pDN3jDLXqZ6hfV/510HMFSv2sqr1FskaU+flaKZpWMrRTfmfC
v1ivePOspu7lr7WM/aR73fdY+CddYX2VDmli0XVDpRW/NLBPorhpKFmqLLZpTRZbe0ZBtmrc6W8r
Sn/fQLXjJU51Y0xM6nkqbUzD7kWaduLICM2dBCrfMsdJLlzFQDNyGSLWqiQXBj3JpbXG1Iofk60C
oz4Pfqu1sTLPhySaMw38ll5sOcS2FRqByMe4HsuLjN4E2Ff05zQSGvAbmvo7SNZ1Qj0Zh1IvtA3A
nq17CdR3d8DdODb2Qv5km6ry5Mm2KC+oQxuOddBs5viSLMqvR7YBlFwnqAMTNDaAhQcRZStZ+FXo
ZFuFRQYMGXZjZ8I9G/HtZRRDrAR8EmSB/b0YyyTOYj+eaV+ibMHbXPLb5wKEMHHPGGWqv8qe8gUs
BopX7edl9RY+Lb/aBlcxpgMo+v4Nd36ggzo/ENaR4vwoO4yuOT/wvs6PZrtWedl+sb0tNg18tH++
MNTcnwjffcVYE58siR9ld5vbShbTJ8CHuo73DjJ4LjosyMvziMkxplNEbJFfk0W8iJia8CGhCiV+
5DwQ+Tw2qVZHoa1dsxL9YPv717aQsTo5MsbKjaGLZqvF3x8p06a4fSKyAKR/Pf9Rdlz9RBL2IK7E
5NW835TZt+f5R94uPiQx79qa2xvPnu42R8exPAQ+9/KRCk+lCJ6a9Af6ZCNQ08QKUmT3RKqEW0iI
O8ATCbT54uUfL5LBNyJGFWLLdGxwXxsKY3VD9SkAAgsp57Khi6bceQQeW2K2qeiUvTTd3rsWKT3P
Ee1xfORwHrZ9LTpw7IvSrjawfQuME/uCjjHNAz2CNA90tGke6BGkeaBHluaBjjvNo7jCebA0D22f
kGMb1UKOw2aaxxAQzx845LiKv+6XTa6XlblE3REff76PFTlU4k23UftgiTeb0lV7JyMYajC/obfk
IkA8EG9R5rMofSddldqcfJVi/R1dXGXXn9f66VW172wHDGLrCod4vATwI83ek69FXSbe3KqBoDjq
eAdIx9nPYmzV6aS283Mixz8LaEhWs43eCUVP8bDh8dWpRww4QzGNGOVg1KIc9JGyecehJK4R0lwn
pL2/9bJ/zIzaw1Pfr73RYRcPgdriyfYVoyyeKNu+XQv3AluUrvhUlq54/j0vFiVHhXsXYqqTq64B
cSWDny7SfSoPmQ2Oo+rmMjA9JIL6XrOvP/8liwp8Th8TVMHHze7oahWv0txc8NngGf2JfpESciLD
7N6mv4hqQdM5O4Pmq/nrwl6+SuIvP8TJy+WSLoKu7VnOAgOCx9Xb67NxG9PJtXnRl2o1py8Xweti
emNMTFdn5gV4ZA2aFykWOlBanhDdOhBUuh/4NuhXFFSOynWwfGShie0yPAJK8wHTCPAxSRinJmFo
px/YGHA85NtnTm6o5CjGbLy7c3JLC556G/4UZ/LNyWbfTunaISbR+8Q35k7bnLlnd2VVy8BdxIuf
VrOZ6yVRcEW3p2RVfkxqgf0Kch54XavIDuHf7/bu7LP9xPnaLkaEp5CXTSvT/oLX8WqRrcmOjYsL
TcVx57O/Pu+F7j7FwhCBANUKX6ax+8AMsVHjm1//+T4O6OxDEnv0zBOJ8+70OgoCumA/UnaQ3k2z
hPh0mjJuSum0I7jQqG6DvBCbMg9OeXR+4O8RwMGUA6fyahDJLBvO89qVHzSCWkjqqzvG/KXWsTuI
PySMymjlek/7fqksQ88K65ed+h6bRIiYfMyGhSp0rm39vCAKA6NhLRv2XsNrPKpiraL+pEdwRqUJ
etAP/JYGNbq1L7bna+hy8nwhXVfRWK335qMGdfD+CNYplNdR68ag9IHWfYIaDXH6QMhBdHTa4Eh+
YYJ2dilKptHgV16BcZpFc8pk+PvL1tYbRUw177xhwn3uDv+op7dzYFF8w+tfpLyAwCzihcerZhBl
Gwy7bIKBfbJP3/qcUR00Cp+CGp/iMfiUgTPByEUUsVoV0AudFqDINPcGys4F4AzpzFUqqKIoMAzt
Wr86owegqYZqK/vPFb8gZyfWe5LNV7MDdXtUilQ6BNiiMuBvxchSWtg67jUdfpKoKH6b3/aIad0c
rRjntRG2BYDv8Lk1euUho23/dDbbaomKrANRe1zK9pYbe/M5lSB3HJOI86S+PEbv1Xne2lysWS6w
7OKQVU3oU1n6kHsaX2jlr1sLT9q+8Dmo5QP3yCRsgv+2tW5TE/6c3Hn0rUiWfMWWNaLJZFvrVmR7
zeYGumMMwDltbd2itHrX5nTO1M4cIC/+cenHS9rVMQBWXQ0oNqGz96FVB8ezxh5D/3mZ8vp2EUQJ
k32ffvx5mf1DFEuaUPYY3ueyuFyNZynfqMoHP5CEzNNnT5RKHOl1nGT8FTn3N+/z4X+kC6sx98t3
+XsNwHLTv45lMBPH+Fb86tNP8Q1dvJ0vk/iWBmMP8gMtRnjW1d28LKfKWQQY+1iF7SzyR9FY4siZ
hJn5XDP4fvEbb8OxiT/WS7Ior0XttXW7ulpAABRy032qFHWR+/ljIXhCmZlMf4iTnOYTRZlr0qkM
DuN0QoTiMehU9jx5T+dLNvY5NFcvNMD+x6uqy9/4/2qzuiRMLaXJ3ylZfj+jczYREgSf4uIS7V2U
5sn1uVN9+PNfX68WN28XYfxCg3lIOTs61QGfSUW4k8msqnUKBtx/f9rTB9zTtqnsaQghHnFPXy6j
2YzzAjsH8FiNefxr6t+IJ8vTjm3JnKKTDhrc91/N4lfr4gEoHE7C8Ticna5v89QJZgdUh7DeTnxG
Tfa6Lv8MxDf5B9/GWaw8xr388P3rd+9d0PLxyYBht49XtxmaZDSK+BXeUcrgNt1AMj4OMUG/Up+9
LuWDTD9L3+ZNQdvFBW9UXNgwigWzRk9gK6e7h8EQesIRjRYlc5BbLc2uPxjAYwFahRFxM1BvVpEH
+EiAIrU+v+2vtSEAQ+zAMiJtl+brjlndgFIfBwM2sXF4Mx8Cpe2pHYDmAkO9N3peu3qz9Vxg/6RA
n8p5pB9oorzcZVEbjmIu2RYZQOw8Lvkvd+hADF44CCsHjxngF8XvzhBVX3s0R9DDaKo1q4rfRw4j
9bRB7A/Rks6iRaOBZDcBW19VuM2LRCiDMHuEiGnYQCJssfZap9VdnctIJwicWOxgDo6ahwMigMfl
sWOlNudVSdSCIT/F+QMbRtUGrweGyumCQsc+8emh+BQjW9HVIbUG0ppT+5wdr6vlLOI5dYGb3s29
eHbRsU0UPcLBAzzz9unibNjFGXaQcnHmCIW0cXE2QJev3Wvyrq2ZKFaZ8S67oYjnihfnHbBVcnCh
UfzLK65M1r7j3kb0S/HFPd/dOl5H2lmlyhM9FIFNsikFL+6FsT3AAkIqyFiOKVHygqBMjriL1bxZ
coTDvVC9yusNTnSl2TLwDHuQ40grYDIsHJMAWGwHidlbhaLcKs8tkfiLfp58Djy37yohzebM9Tag
+Vp3PjAfMIpTl5GLbxAJo5EIU89u3kAWGAKMh5GlJIzrqqQRU/8SBXTh8sbFwtDiNJjwN59J3O0/
nlQ/xXN5ts6MrmWZN7vZlLHBvJ0NpvbQWZXzkuNPp6KRCPFpfgVQvBwFT7YQvGocAyg0PH84sjVs
kaA/kznd7X50pKBAQ4xZ+CeWc8oBQfKeyoqY2yMfqc0jlW8TLg04OOKzve2mvHDEwqdNuSDgT7ok
Y75JygoT2zPhlNgkEEJfVIhqR8JrCFkDPVrFVEkgtn+8ythYG6a4QeLV5tn9R5tgbA8+wSohqMgJ
rONkBLCMgZsUNjhSTq4QjV9TNsxiUpvAWhpsvVkXVsQbtPzT9t3SkofvXzqmmnLav6f923//Gqi2
f8FwJQCubxoFYXzLTO1Z/GVSbZUWVKoqiA1rFNUEdm1mZv6v0mtRuX+irG6bLqdqTNQcBdZGYC5X
UL+43t0+HZv2+rN7spbShxH6YyiuxXRFE+ei5sLkaVH2aDr9rxnj5oCA/2pON9/2ogVbUBZVcrOn
/NVocRvf0J2/0t28rWI628BktAmrTe1EqQ0eZN6QWcPR6zX0gT8e+odoh/dXUg4QwKoPA42rHCgr
1+3OKNjz/HzShbJMN8S2D8HJTOu4kTfVpcQH0POO3R0F/yTuqDKXR7qjnMEC9ciU1xZ/kFMxAnIs
+ySuuwrrqXvcvvc9LvcIM6yWSTyPszULTxBqk3qtY6zseM/BR7njh2z0Xfa3rexv6pv4z7+/sbK9
zZOrJuuozKXcKGEgcgyV7b1nqnj9ihZq4ZyZObcQsX9E5elsUr3SObPmR+Q3XZJcpefVe768W+9o
gFOFvAEfm6L3n3zMd9FixvvgYGwOvOjvUZmprAchajPh/molPF1BD7qCtm01ddMk65m12MHjyAuG
ggcnLNj/umVE5xs18SdItOWVrj9ahE3pAn1AWO27F6rxAYGwEFdZJCSS6QwSSB0LcyjKjk4aqGpj
RiDqG5WkMQZKtHbbue6iI6JI1mRPrzmurGkvDMFJ7D1Q5I2hFOJ0TAePGXmjretJ5aNdqVJMNkx0
83SGvr+tJ4hj+NThdzn/jjK30H9EhQWAnN4EUbTkcLUQIdvF7+fHS6rp9D9d0P2pyVMmBgLKXovv
2hM1KhFl6brUvfLZc83L6pf4AmsFEbxoQZI7N14OKbrRkL1dW22rWQxCH3HekaBk3RPQV73cME9m
O4quyw8xX1g1OGXzJYZfny909N67xBhrwps7OQ2avaGUYgGhYTanj3Hv6TNe2j8HqG+Vj0Bfq/Lh
DED+bT3a8kjrfGh5siQ6zkofWpnLiU61Pk61PrYxySnJ4H6SYVSK/3FKiTnx7CNIjFEpvmd6TFnA
RGTHwJEg9HWU2moRewwHbuJHkS6vNXNXRtcEG4ngdhM6ggOga1vVq3oq+J5Z4DpQtC3LpoP4c+/N
YSqHioN1NMLoJ3HYJQ6Nms4U0gGbHx+/aWk5qmGNRLFk1bKEYACr7VKFkXuffPmaS+WLk21NfJBt
Bo2CJoYNBu2JtjKMHJNkM80vdooKnttobwqpctdtqiHLrGofBJaBh27fvmDZRg+jq06L0lRKNARO
/1oB1Xf0LTKZ315LYAp+fjWyAaahK/vTs7E9HOa3j8T09ehVtChKL7AXJ/JyvUUkdtqDlZqlhwOi
blXaTSvqCbJdfonYhthUV6SdhGyCKc1Wy9c19uWFS+qvfKR+aymIpsFcUqRsGdZlJutIqRbhEDQS
WUqPSguUc4xXM96WNom/7G4bqUnkyAltPBbQsm2YGK62HfPesQJ5Qe+Xmejy3eglVian/P/sfQmT
2za27l9R6k25FNvxA0BwU/n2K8eOM66xE8ftZO69Uy4VSILdHGsLKdnuqan57Q8LF5AiJRKklrY1
t26s1kIcHAAHZ/0Ob2cWEsMfjrp/l+jLyOBbXbbZ4a9oDh1SoctABV2OGVj+YbjWlaoMv1lS5Qyy
6eC3IceQpXg/jTAwBmHefdGLLx7QE3lAi41yMaGOgnlcZfroa0Q+NhXtAyMe2xyMW1v4xwaqxSfe
XtpOqMddntof61gB3yW26ThDsoszrELOs6BygwtqSl35XNcxPQLwsJTU0/JXktyK7jVVeLS3cfSJ
6RwPdoDq5pQbZk65G3pwiC0HD2DqKU5h7Fn2ACtdbdNbtpEbiKx27XWLnrk2CqxByJKETdmadiEp
X1BX2YkkdMEwJIlaSu+f/nSe3FzTRXC9YfcJyv3n/KMnz9Qk/wyWNLBM0sd/YNyDnAwMVc8Z9isp
ONCC32ROxuje5GRIv8/Z5mSMUrypi0VysUj2bJKLNbLTGjFLORnGEMdy9E12D2B3mto+wO/LyXsB
z17ETFsDtCOlIy31EeqhCaHz14QcoxRCtKvJqdDowfk2WyShvK6VV7eK2TSXZQjBUTWKKvFQdRc5
sBJlNLDbMxMkzce/ZVbcdE28GX36aRkFWS0P/0gUd/qUd39mYnL6kd7J2kPle49H6o/Gyh/5VJX3
HjQosJaSSRK4IqVaJYx3yrXu0coZSM2McUFFABim3VNW3YcbljFU3qMC9oaTJ/+8Gucv6+umdl6v
TV54pwgYexbCYKC0lMyr8TPPyPk9ITd0qD5IjD3Zw8fbgZucMyUCfuTa6uKGB/jLTGriSp6/6AIj
cFEP3wq8B/kjSgE3E/5GVfgDZygRwhNFUh70r1FSfvpiLVZ2+519xZCGcleYTmjW1m9hs6fUSS+M
RHSzns7Zof8i8AcE7OvH9P1mwFeoIr5aoE82033YjaU6GYS3dqM78IVWl720RXHDdVXcVj4IKp4N
t4cP5h6sEyr5zgCs+M6cfjWPpSrr2YysEjrleA3RzWa5SaZBNE+e9i/dTZWsqwGqgBuYpGxmCAyB
U9+72HrUnkctd0mL8mvFiwcBj9goE4G9JtLJLDNy+E1hlvWJJzSklzP9okV2OVazy6FudBRWFnF1
J4pRu+xf5a3n7PfvqxdhCy+4q7iSsUP5HuWkyCpUXcOvfmq59DryFJU+68DD0C9NUX/7OoeY4zXf
83/IIyv0eAg2s1q1R/2m4mTr933lA+VlpzXYC3Gw9wv1whSpoQQTodIyQruPmmre37KJ7zp20Dtl
2cR3o/vSjv7rqD3krbiMb6fuELlIrTvsl7QkuZeH73iSY/SJHs6xwTlQGWQ8rbzBk272+PcBKLos
G34QDsKDf3/9INTl6T66VxDUVdpzlfrLv5aLDHR6uo4Wd/v06wJfzg/DfpVT5d3DeNiRX1s7Ozvb
LjYtxx6EMnivznbhrOVH2zNAXxagy1XcXEOIHltqGTsIqP8478KKevH+khp0jNSgyd6ExpOmBk3u
DSbEJTXoZKlBmTv420tUQY5ay2pBuzcn78dhkyGITGzWHjD+ZvqFP6Ik8qJZtL5TwZqb9qZdus8c
/3xSf9R+X8jxQfXSAqh3XHo7bUNco5n6tTtzo/zV9AbO/0538tW49u2GbzfACisJHdhzthM6LHeY
RKSLu/LA7kqoJlUhE4iYSeGuhPaBUV54Yo5E1G/IzGmXk6MgnCLHdas6mmUeXIbcl9yw0dllh6nC
xLXwwNlhWb1t5ifZtvGbPR+m2ujKpgMlUGv6PABWfR7kCBmxQ25pWDqhDq6eUNO4XJ29r054uTqP
eXXmDXdETJoSULo6gdEfT7sPMv12ipba1BfybrVaBLoNzQX6IVRX8eHbhMuVeKXnoJCLlGQW+YxX
qQ9JcwHcbyApAF9ExRFFhZFDXgkt2/TKSQGWcbZu2gMnBaB7lBQw+ZbAcS0FwAsbwMHfBu++AhiT
79SY4dcEX2JZWIUvoXhAvOYMYARatQAjpTldE2ZD0PivlKx+mtF5JwATvef3hzLJAS5cgAHy/KGA
l5cJs6RCEsVTUSSwWfB/WmSmFoZ1YDF1tC/ssYod0YgakcU8BGqE0w/JC97j2OiQHnFHteq9YAsk
Gg6DzHFRUO+xG9i4uIEvbuCLG3gYN7DhFqUlIQT+xQ28f0+foRu4vN1N4Hx7231vwCPvjeGHtD/o
3VeGEjBqq/XmZblC6+2TEXiJLhxVI7OQIiJwWHEZgsEQM9T+wNtd6Du0S97VILjXg/ejipiuB4Zo
njza3T55SI4MwwR1j1hu6A/HhAPFoHJ/sghChdAZAhC0kc7plMPeTz12uy+CaUylqGrCI+n/5zaS
Qw0Hip5PgBrAwsOAjX4DhS8ltNB7VfZSRjrtrAo5iiLkms7lCr8fV7irJntg6cfLb3DT6pUecCos
Ajby1PsXjZf7nbwIK+gDQLd9jlleyvkqmlG2FPQTmXXIONiNMNLQCVpJ74DQIRJyQBIg3ZumrnsT
30v3cTtX3qnLanhEwDjPkpr7VFp+Kac5QTnNowvK7t5geSkMDIE++nvG7GpuwttoRWfRolJW28zC
2neVOiOej5E5BZPxduB2u8FYY5qA0j3MIGiAmeeNpXY2osgbEuRpTLyVVODql+1fNvr+je5YKsoG
hHiwjX7NdJgZzydgghEPVT3u31L/o3iyFP8vlxk/xw0cOPZfVYftdhcQrGRJeMZldx8y5wmX5Lhh
95Bmg9b4laKuPvKH6nv9qJvd5rqWYrdhfVEL72t+KLwnuaHfaOVzCaHf1s1ZLJn3IeEOy3dvrn9h
8ugYNr6rwIO6wKI8iLBgY5NZ9C/CuSFRQnWPvDFkW2qoVps4NnKqfalhD7NebVUlDJ68HZQ0iLZa
U0Gl1anth0EPk2ekjP/+dbvRjaIzluO7pNfofPxXvzKpsmB75zkTw4wLt8sgG/Jv0Vq2fcg6X0HT
AIEP+g3JB42WHAmVjzqd1w1pZjwWQ4Yh7jukyKojTMzPkxs0ZRc2u+vJrHoTSVjp4iayC0e4S00y
ABVlOtYxWe2jwSl88Z5vaJOA7kefeHQ/esTrE3q0/vBNRJ5Rb/iMyEs/ZU1o5Evnsos/de8muRjj
R/Gplj/91vyq5U9P5Vu9bPrjwxjfP54PA2WsMBBRoLll8bYP4PkmWS/nciccwxGAoKu4/Wzki/oX
QURmi4huKe4BPQHnGPBH9yTgj8454H9RUC8K6iVSdAb3dFPE/6u+ow0VHxqFBv5qsga+rXiL0jYi
oGbYJzp9L9ohp/HSNrFSqNREen5wCZWefaj0ctHVaRWOCgMTur1TtVVW/379/HpN1vT1krCJd+H4
Fd/0UtXje5upe9E8DY+OqywXfp54ecPUwT9IHDGNKq8PUol5EUefaPwsvtnM6WL9XlTp1g79oMzN
B7utUUfx49gGGc4cPWJIGqol0i6whZ20HZN24VlaogeTcY/25nSfh4x7NLo0LDmKjHt0uUyOZjV9
Y15NXLaY9PfofUWJgveie87ofDvn3J8Dc/H6nTAs/S36MaCLHMWPEeiC/6GT1YW6CugChK7pb9WF
Ws43dWEMnIBfMiE86g+FKfjo/nQJgOqtGeBwCx4KXDxcFw/XJeXiW0q1cEtGCRri2nxD1vNN9/yK
LTiQ+sAAUBCabAeJ+2YuRpQQVia2hkjjvqHzT+NmZI9teSd1v5p5NE5wb+OKxv8U3e726RotIFVa
Y6O0/mKDFFfACW2XuKCycMhCw3R340s3JV+81d3TkMwSenWqdfxqF7jDF8PZkqzTfxoUX6XiwbFJ
4FT3heH2ujc7qybiUtdVgH1vSwGGPch/dG+8Jo/O23Py6OI9uXhP2m2Sb9SD4hRpt9yDYuEP5y12
K2YhqJqF0OhpBHQxDSXx3exDU9W92c03lOPvYiMeKS3/ku7Xt4ykQ7qfBdRsP11loGQoXEc382UU
HMhSzRFZmXzyQUC4XrtZkDiFWjbsIZxt4oHT5aqEuKndLrGEvNupoaCtNBT0qI9wabLaqOQV9ZcX
UcsZy+qJ8Q7zrQG9t276L9ZVHM/0nW3g3fKs85Aum7VpYdEZ5J/ROqUuEXO3rOMguwyGyJlpyjn2
5pSp7Qldt+i/VGAQw8Bl6vuHr2mLO4r1xLa445e2eI9mi/Br6GTzVTX9GN2fmI4F1ZiO5W93uLEg
7n9VMiWiOIWnOH0IF7cpCD3K5ymJkj1rtRPC4RadKYZ1wmilwdQTqlMrFOuuQNTpaC9n5CbZAn3f
vfkLJzhEHMiLcUM8TeoW2gWFJWbww1qseyp9AqakjwfxgCpv/ShG+XUl8bTF7go3C2G+lvYXv/E4
PDv7hYQCqTSfaeqo7ebXNMQhNEGxd271U17rJZ7Qmp8VhMprurZJTlWcKRs8MG2uLuYTTlVGMJR4
lux7TvzbVKjJN5hEi+kmoUzhWM6nPv+4BeWG4sDlei6/GOWpkY9gTMa4Lzz4iYDJNRUhBdyIK0JD
RNUyXP0jdwp3Fec2dpxyM3o8lJgRk9OSME2THFyIFNoGtlxuAKeMuJ0YzqAZLmcpQR4dVIKgsgQR
IHRVCWL0NWdaQ2RaQIXIDIbJ070fuxwXxx1bBBCn2OUY9LgnSyJ0vvxE98tQjFRj0gRDOHxOgwIB
LRX81QY+qEWB0G7dAe8D/NyjWof62cHPNUUxzwh+7lGr8IQO/BxWocE9u09F9X1ykLcgr/JTwcVn
V+PyL+XbrcaWD2gKVRjKVgkA9EB/bMzLSmithAXUlUAEfDgHGX0wzF4pVk6F2TsqjX9szN4iJHU0
zN7icB4Ns1cNvp0Os3fUQMfRMHvRSYuxbSVs5AIL+rW12JY5oKxJT4+QMWnsbF+ATFh1ryMvJvHd
w/3xNJUP4vV6syp3fk8fycP80nopWSRX9Y8SP3mZWjgPr9q6KjxaDW44jtFDdRUkzdm9wRjLLKuP
48ZGnEV/OkARgINWeX4Lq4gs5XLzwmo9kaPZwPy0J9511Y4AttHQEcA+oHYR05uICdR4dxhx18qU
TEOXVkxDwwZ9z1cp1qZsuZ2BttLWVH80Vv7I105578GDhpi+GlAj5laRFDQdZ+Basepcg+U0pvzz
p+t4Q69aeNCU9AsUeP420bbl9rQ3s964owX9PG5uy1zqdps749ltbdnU6W9QbnW5na6jxd3eqEAm
VDiWEwTkoLX3Zx+r/6oi9fel9tJST6gJ6sSK1dN0OeUJHe04odzrPmOXDz8VHKo72HdcES56U4fI
dp0hzJ06upbzgjj/drP4uJcyJTgQIt/RtD9KJ/BZfPOWxOuI6wGHqppTTqBHrIArVckyXqfnDw0h
DcdksVzczZebZLQgc5qs2HH7numqqw2zaeMbOuUDHrgU68HjrUzWSqwaKEEyj4AQlDgB0UGF6jln
vN+7fPdLtvsOPCwVtA5DOkQaxNOABswYjHyypsE0uZt7y9lVE6poMbqLoTeElDwqGIeSug0h42UV
i4Ppk0OIzOyZU385m5FVQrkXcB3dbJgQnQbRPNG8BMpzz+PDXCpuxYF3J93leVMGpu4WG6CN+i/s
z2R9y4XjYZLwlYsP+5aw5qJFQL+wgyy9bEOCqpxp8tcBEzcUrRYERGTFDJP6BY+GKKDACdjEqFal
YxP2p/8XekPW0Sd6lEoTD1crTcyvKQ0fqtEvjwYeKM3WxcfU4M4CV+/+IOudObbepT78Uh/evuzz
26oOt9X0JTNA/gAq/W8bto5MXgYHvd9Vq5kAU+DO/JmNnKqxziC5d8Nm1ZdVK1dRCblaBfqz/x2z
5/yD6SR5Sh5nuweFsyIWI0qeA22vbzmvdh1H7IBM5aOnN3RBYzad7J7ulGLboWRU8I4foLczsqg1
NZnFfrXDt1W+nlu7v1oUSpkq410EQZnxrgnvT+CgpDQ5ZjXkaJpnfwoKzZwQ36muhe2c+wQcrE7A
r07AcS/mcw/zWeEuk/H4QObz9YydmN9XAbs5DrRNsAJea0JLbJOSm8U27WEcZrIIKjdANSso6oHS
hqjpbPV95QPlZadirfSyWa74JURm2yu49wv1WgdU029M0/NLBV8HrnL/+q3rg8EQ36ui9cMHw88l
HL4ncLIj0OwoVWgesocIobAV4TQs2P/3K+MXIrOb1w4paVWeg4SfNWE8yS6IYeBw0or6Lc2zBTBm
CvkieJKW/q/WJb68jaN5xN24V3uCSg0nvwimIB9jUCrZRwNl86QMeMb/eUETX3l5ZvwwCkAHppxZ
0Cnzwx5AtT9RuR9WEyWtkNY3fTb1wdbDOZvWJ4jYf3hsmazHxTuq+Tr9FNHP0oZ9PKp+Rf5Syv3i
M1+6PJtqoHOxDXxsEX55ycf8EC1mTFmFGPfZxwUZAbtlo1mq7y2W7OnRgoqZVEIH1VmR1YoueCc6
MeurcenLHX65O1IEfFMmhsrZs5mbtnFv96sDgFKeCnF9eaoFD5wyOZTTQC22dRxY9RngPg2MzidN
udzLwTXxML0c4EnT5JXyc9cFJq5Pk8fuMKZknmnRCVpjv65jKgj1wJOQTLkJZQzUP+tEcCCwjAdC
S3NDxlBW1lB2vu4slXR64GFYMoJRXxPt4s84nj8DOmojaWZpOiV/BrR7W5lfBXZft8mc/02tzul8
7mxVdgaukCoVr4eNh7q1r30yo8GL5fptvOShqmdrZvhrZZhr3OOW7ShwsDAUOTqJoGgaLNfTlaRp
SjKi0vI3/Yu9IXTHyBRqfdkOaPYFqYWcuauOV3LCEPbwBe2gbzq9iZefpx7bcgsexZTXQAULcMA/
tyFta0pYCxxXQA3g96zob4/dhlTkJWQ6A/i8uI/pyNfq1jfr4WQL9wcGoV/1h2kKv4oQX7ENRWI6
bc+FQ05ZnbFPqjOGOhaLW4KHXm2kdBu3DG5CRUwZnhnwO5X/vg9ws8P94BlmkYA0FxLoR141LokQ
YU71/nNdx4KhfvYaHk3F44UhUz1kHv8kqcPV8qnrUNoDKskYTZlMn0n76ZbOVjROpvSLv9pHg6OQ
4Bp9unV/x4mQk196/+T4GSTh8m4fBTmcrOBCD0ANToK2kx9CBazSg77fl4qtGre9FLgqBQSCwSlo
VZ+b55HL+lzcY0dA3U1Z2pP6FBhdDqODlV0YuD12IdLlvGk9thXMVMZ9w3+cvUbI77MSWodCjXtB
09ev1H7xP69f/HD9/vcf//KXrSXJZTDMZTBBTAHVDrMx6eNzEJtrJuvzGfI3nzxToosZfo4fWKZj
aO0xp8+NZyuuXsMzRPi5uPBAf2SNBquRZpBW7LIfN/R1dB4jqEbxqeM8zl+7FeMQa+aTDEMsNNQw
Pu+lW6HOhto9KFNzNSvayl4/7Ur3ZPKXKUitUhmxL0EBPvz+Knv0P4gXTRZ/UgQBBNaHsdZIO91p
ipqFaGCIyEk6Px416pFVkvJrs1jGjDIuZOi6Yt+XPhvv+XpbCHpEKZE9TpQnMRXWtgaGMujrq8iT
Nva4LHZN3ACK6ykEdekatvMVzruUpkJDkb35rWA2tNIdcjw4oTeYQ8Cc68tkR3WQujiooCJiV78v
cBcPxuMyfjQynce9saThIByyVPnlAqPKIMs8IXGqZsKIs6s3qqY1Xi9c1HeY9sPkCU92KcuSX64n
k2uR9/J2nQGY8XKjq6v28kiMs4qoTz9HsrhbFt5M12Xv6hbIWia9Sp9f1Quz3oM8KH/j6sH+KlNE
TTqcNDy1JOwnBe0SthTS0+rtfn4s5YI2PFNcVH39WEadZrUjGyzNPOPVh1dttK62j9qpkRUGg4ks
w6vVyExtQ75BcLSafz8QN5NdGwEYEMRtxKZzalXD0DxgzA40ofX4yZMnxTkDoYtzLwXEgH/64evd
58XNzfe57w9pefTd5003Yctn7EwxVb+Ya/Tdvt/1+fvuPnY0zZoua30sgdMfTaTpvwbgcV6jl/qw
weP8NcUDBA47i4v8MpRygmi79I4t/subrCalj31B5zKzeukWamdXw3NAOUamh/+DW5gMHAk/SiVq
jmAkvVkNzWvUpAPk+qRiQpimoy0h9zUEYZQ2QFQ4BRBXQEPX6RVuU7H5d9CQg+PnOFwcmh/ifj1h
+fBTZgelA//G8czScctNRj6TjzliR+5nzyM8PNiJMOrZW8TI8eimst4oxRjkbZVyAZF9RentlMtM
gFxs9sajZSpNTgf9RBfr6Wy5XE1Xy490BxVGLjIDYJh0iP4eKiEf/2QEzGY7CEBFbyVgWMTC/Qng
JHyULIiCDhj+AbF7tAnWP5emimcROhh86NUzYy8ZqVxroMZV2hf5xOndQmMnkCNlInN594qpbQ3U
WAp2oIf69re4H5g6/ynTN27uzaPwxiD+AL7XNo5FJVEg9PzAP5wfsfu9W6p3cj2z2o4G6Vc6HT2V
RizICZJp0q1w2nSafEeeMqGmb1DCccpegnM6KY4aSHN9b0tD1U/6q7+CCiUtv484qNrvi5gX2DFr
5B1lb3G3dtLUE664JkNEdDOURvuvyazPkyB5sk1fEwaceo9Ti4J+LuBmDXsvfcndwr+Nl4vlJnlB
vc3NG7ZLttpVIaVdlQ2oru5THJIGcq/Xy5jcUI4A95ztPnbhyTeq3bNcpXsWUwV7kiNObbRkNmYj
Rdd0vVld3/JOyuPdtD98vGdycmIpoN33uxgdYuD3ndl+Zv9Ib6KFrNtMP06q7AZKq7TQ0wsHGn3M
eTVxxfCQVbLmNXOO0cWBeFIHIjqx+1A39dA0rMfl4Bk0C6e+ZiCtv+PuW9iOuKiKY9tR4jUN0eQI
9ZFNlhrEhHYpiGkMl5vIzsg04aiywVSizU5X7JYc74UVYmekoq+5muBc/Mi0zBd9XCRGy5TRx/lr
rHVZo36BZqQuESkv0QDpI+n+ldWSCVsTsYd3bxYTYcf2c/SQ24mBjH51ZE3FbhzjLaHxpzbQbpYS
y8VEJIjKx/KER6YH9LBPTx0sOiPLrP1+gWqqAHY8UNow5tFlnVNKxBbJavlJMnVbHLbOUzMt/Nh1
lcCdb2C/yFPT6/zdT7QgxYtkeBIPqG8OS5faQ6UGgvrI7tEhbsr0hzVHhuH3S0LX1aGzjxXvXlFw
CQMX4r4hy13J47sWhmdywz054/+Rj6y/LxU8S8M3xSFTE73No58z11B3FS6fM0u3huCUqWq6eHLA
UfHkkK8//gnT5GCfvYChuhdQUNJetLZmL3JMVyXHcPAAV0A/2ydm6vCntKlH+ghxn06jtdzvpcTZ
xTKg7Y0iLlMeXj282tdGhpkjhG5bx6519PWBoFwdbINBbqTTyo7swN6t2laI2sW9GITAPv6xdSx1
GbCLe4vwftsCl86tDcpXijuYUvsfCbCyD0YWGgAId5ICnoiPf1hMrCq0toEH4coP//jl+tmGnRY6
oyQR7uxR+jr1rL9cbhaBwAaTi5MpUpS4nuH1uOWEgU7KY79drhptdSNv/M6sc4dpdHoH5eK72ue7
smzVd2V7274rC2J93p93IrBVSgSmoC4RuLtINNWjL+CBIraRduMD7Wiyip3CDvCgD0Uxzzomi4Sb
PUnq0LP72gIp1zhWqH873oMwBVHo+mXMXQidfkpWsZjZwXva3N1GnM/lYvovGi/TX9bTnLOOQJIi
J+XjcCPKwYek+jq6mTNVrTW1oKA2sC1nGGq7LrOhNKpEIfH88jqjAWrF21zKhQeDX8rhEJfypIiv
tPFiIAQeQyUVI6Q+DHHu2DFD0Ft9a7Ucjroc1WOnsRx4WAFlKgVTTEAh0VimKqCwjo+2ROhPPB2S
yXym4pcVqeuUkjoJr2qXfkCkdsmeI9to6NA0alVhK6mUWazj6iTqeg/vDZi4tltNBQN69J91kelI
DR1cykz7lpkaahk3tWwwBLDxgFtI7Y/CwWGryB+65O1P3N2IDj5idzQlQ2V+ZJ6dipFe3+1Rnq8l
8mfFeDz5Mus7Kd4Yl7tHNmTLIpDTEzhA0689Uit0u7vWrZJr3QAfzlyClvaXvZUiqNUgRpZ47Uy/
E7ueXospyHtLSKymjZZ5pHjWXWCEzgdNqiRdTTl3e4jK86oynokyF6K77Udt+HSsbP7RToKOn88/
KlH0FWX0Ixcp3MHY6cud0dHDjuX/nTAEqc2GcixaK/5sDGsiQLOw5jzo4TofBtRCTOugKVawe3lL
0Z1aYeX7UmUjUVz+QCpk6ePGNR89aPXTB3tzhDxkhMAfLNPx1LGT7uCapR5eBOAPl+2ype4rxwxh
AIbKRJwMwbg+EB5sNtAeDsLj9Ag52ihhpXJ883II6oDmsCozcd0hcE99I5qwCPFxp1mtVx8bg1Q0
hNGC9/yhLZ1mpUC9Z5YC9bZ1MIPvTArARsJXfc4FYKOdRWpnUAAmCfz3EQrAcvVIFIAFupazJFfy
VAFlGILUAho526yu65gucXE/UgtifxWFpZzA18SjM0FudXBcjI29ADh9xx5VMJqvN+wyRY3RfDWY
bxLDObtdD0vb3sY9XX0KVvYyYXdkyK6xqagC3iyKcustIjLT2cWmpXm1jw5Ua3sQNJgWdayHR4PZ
X6t6QDSYkTL8tuApDVxgvwAV+wUFfj/fAhy9fFsa9rkYdU3TQpqXMZnTt4Q3FpEBBTE4wiEFwDf9
vo4NnkTn306JlyxnmzXTOqM53Qd4ovQSYiIF6lSjooG1OaREQD1g+TXuDdA7dp9GQH+qusR36HIl
LEvftfxSAFRLv6zX5gRR3GuqvKzBPn8hZEZDKpKS8+bbafuYjFRo9RAw/GjJsKCgLb8mfhXt75JJ
83VJgAENbbkySeXK9SYOmbXUgoT8u6UOweykI5PCHnTIeuvny8WCbe7nzKZkc71dBtmgf4vWEp4s
dR+40DRA4PQakA8ZLXlok485ndcNaGaIH2JATZyLUSmoJcQJU0vQlJmITHCQ2T5xkuNuB9ClJulN
Q5kKJgZWHRCcPF9/u2VplsKZwDdYc3pl0TrD9TwP9Lk4p2LQeLlcP+MD8039v8sFbVYGlRpMN8R+
v3tTDO7zMAXPuBdm7qvwF0qDIsWqhobckxg4MAhOf39Aw3IeQwuqTnLDSzt2cIe5V5NTAzW6dgxM
N0JF42RGpo3qLj4Xn5xMQ3W2eLZT42xBwDo9mYWWzcn06sjUaOwGhyXTUDLSGJmeJR1s7HOddJKB
iYOgpIohq+7gIHRyMnFpR2JQe77dk5NZ8lJ6sjVPlUz75NxESiY3PzhGHZmueXIycel8O6Iqd+t8
69XgHLMt6NDyBNrqJUL8OrFntL9ErNGb1//9TGTIkkT8+/TZ1Xg6aQC9z8cObF7rwMbOfv7ox7s1
TZ4kn6NwPYEdQDN4iq0kgGthfPTNIiEh/X3B/46ElhI8JytmVa/vJvl7zMTm2tNkTzEwo9MRvcb+
71N/OV9FMxr/cEMXPJpFg6tJFzJ5pzue0RHdbJabZGiSlUBMYCOE8UA0c7N4RWJOwYisVrO7Edso
I3+2TDYxHf0fZnYsOm0BlUqpwgxDJT8p2lQVooKtt0127EvUmSxul+akJLdkRZ/c0DWzlvZgPQRM
ZohwWvFjQYPrapAgmsmsqJ/ura19OPUFItkv9LP0S4098c+r5HcRc5zM2Sacb+b5nuSdn18uY4lq
2bQhczmDbSwaewy10pnFq85oWpmSnMcTke27mdNni+B5NsUBJocKFCI2O9MdfnYV17ZY+2la0Ler
msXETmB2Sdwb4Pjk3bSkvLRA8/kxOtM1Us8PBxgdh/FyPlkviwWfNPgJFaIQaSQKIw2aKlRllLxf
vojmdJFEy8U+WCZOFGjmlKtFVPVUXFO2wRc+fRLTTzROGgu3CqlMDOoPKZXr6RJIsRlx75eVs7tr
q7kKAwMvOASpglixCpN3NHy+3CzWydPKGz9G6+T903Hl3VeLGY+BLWiSfA958kawfEGZaGVbYn09
W37Of/CWxlzfekH55c6+OtZ4vJKXHS3Whf9F/Og5UwfVVPL0giPAdQLaBTJ8mznCD1WSR9OAVrLK
tknI1BNGASJUR0CdIkVzJJoBH05rQwWYEtfaPGew7cz4ky5StEjWvJ6TPec5WSwXkU9mb2OqHMef
+TCRz13ypS4ENcuYmagEBJ7jd3FaF/dMShfTgioDZ/s9+/sdFxA8AWmrJoeXDsnvvicxe9D7u1WW
Lf2CJn4crQTmh/zKq8XbeOmzQ5MWKD/8vt0MXdf2kNZRgSNG03Pi39KxPpkPdpJpKQfKtZGjeaRh
mY8tiJtMioUrEtQV9LIGEZRX1DCCbcvzwfmcQvUMSmjA/mcQDm6UwpLu4KKhdM6zlBTnLydQ6QD6
AHSdoHL4Xi/9j2ztGWX+Jo6ZsvCGrDKqsqPGpclPi3V893jXr1JA5x0/rta/QXwlz/Sv8StRJfe0
wl3x47/RYtwK2x/04nFdT+OHD67GZ0DEzuV3Co2KeIBorL6y/tciV/ZZELDDlhTr+Y6yKbIP/kqS
21Y74j25uaFBxhoRIhTgVzVrXjByw5ikuQP+TqK1TP+a/H0Zf6Txg/PcJKelc7dqDrCykVBX5XTL
YqnyYjLJcu//67+a+JXrGy1ucWXb2516YZW/VSn08uerFoVeWCn0skK30+AHuI/N0n1sDONxVZaS
33xseG7uvedioKxLsq23XvrLGdudnE2EGdItdmhle2c7Ycf3tzf07v2cty/g9yKlXqeLX85/D0xk
3V1cbEvPdtrrltgwSn6JP37j+cRM6Vl69IloFDOeTm6jIKAL9k/COHs3WcfEp5NkReKE1u8M20W5
Ow54IRX1BqVHp04ep73rieOeC1SzBsdIEdYJvECiSr/PwzqPfuI1BemgqEuKAB92Pvsy5UPXx1ZB
AZhihKgmnGR3q/s2sFMNee2OdjWA8irRPz/wa3IlDLtbHu2jKmkpnsxndrmM95RUQSbYURlVB+Ku
w2/xJs1RbCZAxR/0CaokJHYfX1LQkGXHyfidWQ8zWfVOgz9ExTtPMl1u1m+ua9PulO5XyIJdk+Dy
ZoaMqmj5MVpPN0x/mfqziHfzK7LB8hw4J8+Awz7pWnDh4EE2JihtTNx/Y45G1tAwaFhFGfJCty5K
3Bly5ruRifsgNSKgAjXCsARf2Rmjir9yR82oZykfGZG72ZgX0bXEBFWApglwBM7Qn9nIUjA4BtaY
y7/LxWh/zj9tsbWR1P0fCBYsRf4sme1gQtvvbTFLVBnW/6cxs7n0kUzMLhPikSTyp4z5TJF76jNZ
tbvTjaVkRbuWS/ytteneETDrNtoKhoVyH8xqs55KrLbG1RBs2Q3GUugDLnIcCMo1JEbnhknZPL6r
bZqkKIntwZ/UH9UCNynvNZafKqUygWsN0ZyomOnoRIDpKgX61cum0t5cNCjqS0Z3BGaFgiAE+hTc
j0as7PjKrANx+XLy5J9X4/xlvvcrtdtqJK/yYQP4i1EAZgWehQjQ4y263Bn97gzsIvXOEE3mK3cG
MIe4M5i1Pl0LubrmAddQOCmWi6cNRKvM4Hpe9l9eyz/e+s30U0Q/Zz/s+One8RoyaAq8RWLw0oTR
SJZqJE9uJxg7mjwbZYgLksSlHFHSyG8mfrsuNvN/MIE9WfxJEQQQWB+ecmKvxopCLMX6E6gIM1jU
rgDPdPwP2iTmsBCMEk6RIC87CJJibxMWzQsE9RmuB58BL7e5icmsOo2S5EjXufGB6YDRMpkyZvGj
IcmoiJ+yU7DClNxQYEyBIXB7MWVUoGWsSDBlgngq+yNVpynI3zs7/k8ucJv/qGNC4yZAuKgfQq5t
9pjvwfapsiR8n15uhtPcDG7h/mE3A/FrrAlNQ6+dNRGk7cen61tGU3ATLzerRPZGumYkPB7lL/fi
4Tq+AKZW0UIh7LHx9xM/J3celdGoH9mSRjTe206CkenRKpkA9hfSJUtHMO0dTZab2Ke7jZ3yV1N+
53/njQhq3274dgsjyBRtPYYygjKxfEozaNTXEIIlQwiDD+exdUsmuo+2ti7WJvO4QI7quKPTQDhm
DewuV1avK8tWEKyZMUO3ryygbcEf1/1lIAUv3XFBBc7d6FzOq8qAizOi4oywkeKLgJZ/Ob4nOb4K
8Cs/vng4X0Tl5uO+iPzBKcLCeMc0d0+m7+cNeHU5K0yfCsfwP6P1NHMxSJQY5Gpyo14TkPOV7GE3
W0ziu/G+qSlPeS5TR1KUkvLkc+SopueNv9+9N1T4Ps8JKvEAB+hzYrTVoGfOU8qEOc07SQksrnIj
njq7OlMAALUg0FTRRmWCBB2TiUjjaBy58OoAipiR3W9kPvZKGlwpGwoMMkUDkt9QiICFruwTrCdB
S9FML1qw7TddrvpEMCuekiZpVX8DK9FaEPoiXVkSpQkBIV81T5LrDtwOO8VkVV0ehMT0y5OFrqG5
q4yhprvzW73mrlR1s7kDWFloR1eyPCpP3l/OZmQl+7ekdQDTIJonT/trCWmo8WoAhaOBRUrQHwJD
BAk260i4ui1Tmz8VUJQmDrXcIfshotUGNzy1zVGmYTo9plHBXrvmJuofkt5czX/M7rDN7Oph007e
9aOSm8Yj/D6aLT9PV2R92/YRubum2/fr600elxkZ+I/z16L3mpwdb0LXveWYyld41O2hJA3xmZjq
9rBAj2m0nUjD0gglXF2Ux1p7KP/xbssTgiKLBGJInOKwS02rFyMUZUs0o5LWXfmdRcDUuuQpI5qR
zih/PNrLGD2OXJXJqMYqMgIONn6LB2uuddYfdgdPS5/znIjk6aHYXBksI6aeiENypSFZsEhzxciU
eJycoAnujFZU3eyndT1XSxb25KXXu1cdpZEGtLAuJej8FUEm7VRNEPsVTRBaUHsZYPeAV4dYVzmK
FDjV1nhIn/Dv9jbHy8h+L6mepNS/pfH7InDXBKadB3t5Dyjb6bPTvyt8mz9dv36VNkmMlouUwT/T
hVHv5mT3AHvfkH8G4pf8i6+W66XymOn125+ev34zBTVfH/cYdv945U27xUJb7XpmmdD/cNBtyr1D
aVsD2bGxKUCkGlbIsa1KgMh0jCF8eecpS2wlpglCZFQNauAMs0Z8MVIO9HdjKj99wS/juncUltTb
WIonwXRC0RFky3GJzaGMgvP3XKrBbc8hftVxafY0LJpdl60cl0VNIqAWcHprGqdwXT46A+flPZFL
jqGqOMiuyiVoHPTuGDJECtV2xY6DcTVEavQSMt946kwhYM7BftFNncGWo6bO6IuY+3C0zdLRdqvW
C8SXo3052l/N0VZA0UIQul/zpW0C1ZiAhjNQhKpTmh0bXHEF+abRK9J8klY+/JVT9sSv7kR8uUuo
rWQ3rO7eVw2l/evpKqnJ2BHQspyS1DbS4mppWomw0NnUZPXBVGBO9Z5i2RpSf5Xh9EwmaWJWRZZc
7RPy2HJDgT8i2HA7MXStY7vmohLOkmcFjXJjt+goiwpIahcElpDA+VxT1H19B7Et3WqVZnSpITuj
i5v1LeMsI5GDb6YpXckkSq43niDiRZTwayCYrKIFm8bPb39/zSlj32r0tRVZbpZJzF7mVon68au0
e873feYRp7fiq8Uzds+2n5bSJtMyQ8vvdyHpTmy1FC2E3pObQ8zRULrXWSYz1Pveunaph11lE76N
ozm7XOS7k1tKVq8WATPnU9xp5fWvYciETc4NPif+H+6o5vAInBtbvfAysGXRhhP6fn+r3ypNJtOu
qksW0/lyTVOAuexL+WKVaa8SjbMECI+roy4YgOjvRqZ8fkaKxPeucgsXnQMdz7GdIQaeiKH3NfjK
Kxxlgy8fDDP0iA1+8FZfTUPzwY/f9KuZmjI9R2j/VUcKbLEP8/YMch+iQQYW+ufzl+82C67+yXFf
CQxPPx2fw2S9XG4WgZCOsvFfzgEEkQPAMIRkpIgusE1jF/vAgBYvKRvAX3loyZV3ZBCSy3b9YULJ
sk9iieCtxoh5Q0I39DAFQwxcDJ0qdIwDObeKt7jCutWoEeTkMIUTOYPYi31VTKU7FlcxcY2KaaFB
c7zZkkUBXfh313SdTCaRqPOS3oqCfw/39dwkARDwRbF8Wtp2E4NeFmGNRpLyggZ8b1e3Nsg3tiVS
VjUGt87AGoRlc5Bi1RxEep6u2nnl/owjz0+pIwYehn5pfnCIxOKhZrgn665b6mT37ysfKC87rcDe
CqC9X9jbu9Flr1FpEaGtH81G9zcxBt2jxBj0LSbGQMN6jB2IlOwYpgQ9zl67EH8404SuEnhBYGyB
F7gD509o14BjtUzVB1s14GiY7IYzD9Uo5REoMGFdqMYeQt283HMHvucgUqNumJolZQz0kBYN2UN8
+5KEmwlTdmUIb8S4FChqY0MUFFuOCA7JESbIgcZl292Hbeeo5a0msMrqFbTuTeT+QLgFowtyQb2O
k/uHJYwiHCYMfjnwBz/wqtQ2ed5l6cDbg/p8qgc+pjdRwi6bLD6889jXZySo+qlLq+i8NhiiGv8M
8HkNaKn4vGGNZmfrBOxLeOc/k/UtjZ99iZJDYXYrs8DUDvlyRTyKx2RbCqXv9Efs7lsuALGa9GUj
p1ouoAuFZpQ8iy95y86qh33La44K56Lth0EPTKli9Pev241tKB573yW98KyM4wX6su+jY4X3HuXv
o5MF9R4pMSR0ilBekUa3j+u5H1ZwnQ6Cq9n3zJfuEauK6mJqFxvXueY4Nbn6lWqQKtniSGYuOyWA
tKVy2Uq5VWCbWD8PTpdM3jMpumkiMI/VCgJds2ei3m4nZybMSpSz3bGLwBzZnfs2PQc7fQj87p6Y
BR5Tuhbph2/Zm2OJL03ZM16QNZGMe8veS5pUfcUjbISGB/pxTTGnBMP45JaLQ7CtmF4eImX8WNDP
KT/HFStIQQfecukWOWwUOYQ4fXkg4v7RUkl/eM1U42dBkP0pGhRWb2in0A6cINA3ugoqpADfJoO3
ThR9iKokqHlBAXWdszvjZumMm35fRKydkpJdONeb1WoZr2nwjJ9QkW73Uxwv47Sor4HMogkBDQNP
i4vG8ZvwqGEtAkxR6lFpwmNrFgcYQ6Y3KM2iXBCYdk16gwGGcFjIbSD6QUqvf+py4bbuJqHTMF7O
p75oaN0i71fRSkBAhCEi0x3lIzi+f58yuRf/8/rFD9fvf//xL3/JCzACOqNrKqzU+uSLzDYyseNj
PEwd06BcM9QwfyBhY6pcw30d6FOmWFM65QlRn2gVr0X9xoLdW6IMVrgEHl49LABRaj9+PNr5cf2S
qPnhVLZbkg+YYG2X7QEXqLytHX/ABRqdcFuXJNY7Gmx8eiixm6v+XO56UOCgxWLEtKpfszCtZFPx
4A3T26fywVPZh3U2zYLJnXyxHWrgBef4Vfl2Rha1RU289UrdL2uNwAdauLEN8ljJkCIuQhW2uyY8
IKrzuTpLHzUA/J+ulRlQXaWmPyCKf9so1s4lahfAKlWeum618tQyD4q9fx866J2bj/6QPfROj+Gl
5oqftH0EvNxRu+4orMAFE5cJw2HuqBrg8pTnp0Yt3wYH2v/BvieWgOcbdAEFXsgDuA5eyDSsg8Gi
p1zfNxGhrL+WQEQPW3I63cHitcAfLEtK8UjuSpMB63KntPpHiZ+8TCt2H+5EKVILEZAX2lWYIscZ
OKKrvvOJO7gE/GNzN8BfrtkxFFhGb9fpzDJnarSis2hBr9dkTQWoZxgtgqYnXY01wPjVSmADEA9s
XTEOAj39W6WuM/58tb/rjFMEkAIrtLQumH2uP6aQ1LG5yevnKEnLTFP39UhSW8R/WTF5/SKaJ206
lne053DhRoPsABgyCYO7weWmt/tflGL0NKEmheiSNnerK7JrVkw62ssZuUm2kot2a4tFCitEIQ34
+RdPS/Hf3b4LefAkB1fNcTDRdo6DJugcvDhED+naG52la89SsZQosRzFteeisz8LiimOKQ79Yc4C
PH6gA6hhDoTrwhzofswEIiXjjwA3rJmMY5uD3Tj/kQ6EhnYOxbUHgI1Lsh7B3hy9XobrOflyIE7a
Sjab50oTIJEjigloQvV/q5o/VjNRvZBWPF6Oa573dnAdR9kO0KxuB02U4XsK2H0/wLq/UaBuq1SK
iPXA9OFZdclCWO2S5QnpUeqSNcCNlhQY12yiWphmLesVfhSj/Lo6DOAZVmwsTAO1vYBmRkGJTSFJ
1kxGbZL1cv43cVl1lri7IQwbQN7V0iUb2QLNThCRJbwKKWxp7oOl90+fp9Re00WQu0T4m0+eKS7u
3MMdWCa34+8rL12k8tJ3anmpZYyP7uONNroXN9rom73RoKGmGpueDroQLsU3VpvUz9dO+TOUXWd4
SMT++M/lntM5J6jJV51671br7eMstfOrnVHPls9I5cb+L+bV692+3/X59RdZkdFgItMK6urdHU15
34/7wXIaU/7bp2wr06sWvq3CtcWmIvvKlqdiW6521sJpw8a6AWPHKSErazezP/ZSOqWlrKnVs209
W/YiEfZJBFi0q2a8N/3hcjBOC1Kue4SMvKUIz7ngLrbLxjvMVYTUQ295/kBXkRKWWDAtc7qKoznd
sfvUtjZ5zwne1sbxNTYf6qMTQdUiMzxT4IvnSpFl6StFm8UyZtoj7x1I1x22Yul34x6PaumJMJFl
+HwnlEaZsHNoaW2Fi054uhtAlkme6g7IKpr1bgEmkB7bmYUkbwJDtEoWr5GOn+IcvBRYzfS1jQDX
eimgBvYX7CP31BwdD9olqacVVIejR//45frZhvGGzihJKK/OlOF6Xg33v2w3ZH6FMk5wnpHqUOK6
HvY/HJcTUGm8yFhByqzoHc9JRYJ0xCbj7+Vm2r0kJsKOXSSV3E4MLWTT/Fpu2rI8vyGh8ac2aQ2W
ojpgElQalwOg7bA6rbTS7POLgNrpF6Gjb1qkunKgV9q0GAy0aaOEQzP4Ao+gcdsW7g2eC4XK8XFo
Wf3drwHHGRdozBxv/OeYrG4nE05YtLiZ+kyYrGlcn+ueUeYhvfy6noLFURfJDHBP1ZKz5c371xns
gih6Xq3oIvix6NyYA3hnBQ2u61hQyy+RZlqKh4sOOdVD4fFPEqV/XJav5fjUdSjVHFOM6rMDJ9vy
3NIZkxDJlH7xV/socBQCXEOnzltJMZUTX3r/5CAhEnZw3/i5Wi04oIXVMlJI0BJNOSKObELefRVK
cNhCQ+LQbLtVpBIOQUU+FEVCXFDJjvExWSQ8PzdtcQu6J8SVqPzpE+8qI/8Zb4VkG0Iwigbku4Is
+ilDZ9cIMFYYl8aMBEmvGP+Ul81lCPvy0wzfTqVIDiNvae0wK20MIJPEBWU5cEGKAbDVEiBDnHJd
AgxoaO9tLDCerjdxyK6WFgTk3y1dfEyuIZNCbSomjI79aE/QLqE9OT2G4xM/AtZTMRwf8BRITyoF
ZRqOgvM0ysGCtDdZrt3JTWb1EOPomJvsaIBio9KAp9tkdTQcYZPhgW9I5S7yoI9EVl7lijQ0lHpc
c0VyLaaswe64I5FSJmD4AXFKV49GKfaoFQiipHFKq7e5mEIlpXNHHr5SSO7abhUgEehQP2kF6EYz
IDdmnzSgNzpq5bSLgwp12LW0qPt3lx6lhomUFqXI1tKWs+BtqSAroev9BVm5D5RXZLkQ4w9HmHJh
ofApm5pThsNsAjUfA7koqGYB2VCLOiUak+XjZa+fdqV7MvnLFKR15eOsjrCAknr4/VX26EoRylhr
pN0+c4VbNBD1Z9n8uA/KMjS5lfOrHGYpV+jvjcqoX2+bA4ooJXiYyMtI8WgNjzaQx0r2gA7sXD+1
KQ4N7a3kEaDlEDnWdWKpAtv2cPU6gZr+lZ1IbRIO9FpMQF7govq3EUZOyZgOjNDR97+oGMCdSMox
95QWiDYkHu7jitmH+zmP1ulqNzDGVUBIfeI4/dwye1IsKds0yztu6DdQYzkK2B/SQRAelei5D4Ce
/ynTN26C7XSRwhuMnb6WwbH1oa3Rp96/aLzcrw6pyhDo3i7eGNYkwY6jmiRQlL1VTRJg93Oop1EG
7t73b8d7YHkgCl1RBKAEF6DTJ1GoCOFn9+HTEnoK+3xFxXW5XEz5Iqa/GO8uviTQlR3fiudz9cTB
B2dWkVQgmOUMwqz2x0dxO/vQ6BttaTFfA6ll+MSrlOEju69C0aI6VOnXyMtDaZkGpFE6PGqg4hn/
5wVNfEZQ/rqeKKwcG2Zk4PJOMAxHPy7Tdje4rrodeFX1aQWaqTRf4z6WWoGm4fU3tiKEYcQ0o+hf
tKWPpRQj9MxSIFfLDmjjYZE607hcsyWNvIZyLFu1vlyfVPVfU29PGW10uyb4FMdR8IhdfbepsUPd
LVFQNJpHjqLd4j6qgpFGYtJhf9vQDU1HLSNIfyYft9s05x3YeJgXYZ0Y90ghJa9okrDa0zmNb6io
HszPe/YV5ajnyRgAudjsqTYZoxwYTZps09lyuZqulh/pDhqM/PYJgGFSD/TV3VQyPv7Jhp/NdgyP
cr8SG94iFu6vOhqjj3L6UdDBmx2Q7tnTcFhJC41CVHjQk7ml1YBv585mQxPpFMWDjEiZgVklUqMY
PlUuA/rnhtblW02nJAimHuEZFWRF/GjdhDpRZKV5CDtEOojZUydsr0EtxeY0iVajHoUBikEWAu4x
Ou2mYbLeUjaN69bsbIS6anzHslGh0CvG08kelJPACxyhhrzPZ/boJ66RJJ+jcM3U6vanQjgjV9SP
hEIUjPzZMtnEdPR/4IgRwLbhlLF/KldCYrg+fXbVRKFR5EEEVipWnrPfP/p9HWXEuR1IS7dHafgp
p6m47poT3XAAlAxI6a3vNHaL3MzCTSvkBSPm85TdO7dPG+r1rzrhLCtpr5DXglQSOpHTcTrHlzBb
Tp7utXtITTdH7a9OCK3Sxv7jtzdMsZ69jZcefSKSwtguvo2CgC7YPwljyZ1IWKQTpjnECa3f4WZu
tpnAo1B4O0pPTk9gh4aHnNC3r396Te4o26Zs+s+SDOhGUChJW/xCP08EONlkX7l6aAKf8stIPDLJ
SGI2QRepoFKVC9AOBBXO+NCEENbQYxjdRAGjiK3Mmi3oiKxWs7sRo6gir4ZZ5NxnwRgJEOZS7P8+
5b2rohmNf5DYwGsaXHUIh8j/uZhR+PyW+h9Xy2ixfrKa0Z/mHg1EeK3E2M80urldJ/X0YZy7kUxA
bEssdunBksXYMToS+G9ePlw+NWwTvFt+Tp7cCIw3xs7kdrmZBdxJHC02DRwsuuZyFrqeJDB7lKSu
A4BwRpyobt6/B8ocfs8jVy3phsXpJtTtUv1fkDg6JpHd9AuVyIOTmSd3MDIDZo3rkikIHZB7hsI+
7AhA/JqzY3Qora7Syyi22DPf00WyjF8yofGE43Yw+pZhyKPHIh++FbEWKERR4FlCmy09OJWlHdAq
t4n9jpOrHnpeG/dk+o6ueOnJYi3KgJ58jta3vy8SEtI3GxEM/vFuTZMdyiDEbsFp3lgQDCZHy9QL
dq84i7tY4VaXNoLbw8JhFthUTglbYNNpWmCjF4sq1H6icRTe/b7wb8nipilaomg6gYcIbqDMgD0X
D47ChO2x9mvnEuQ4Z7B2dulw2gA0rZ3Vg9bR2a7d6Ihrh61BtBKrpJVQUKeVdD9oUv4036RoUK2E
uBr8Gx2eSEXjY1qJuFaHEvbpnWoOyVKMFS1A9lip1QIsTWq/4/Seuw6g3KDmATQABwNFASB0+D3x
XbYzjnP9Z0JvuH3olLYhcobehsLxci2Aen/erJMnRBQjFgvGmcWHeL6MaU3eLwGu4bqG/0F7+CoB
bKGYFKIvl7Gsi3zFW9/4dLxeirgePxRLLtJ/f//SkX/upBRlsX0CfOyZ0OlDadUXyq+2yB9NU/qv
mXlObugTny3emo55lYr4JvvoZbycT3jg9nf25vM0ajCJkmfXz1+92j2DzGVJQGCFQZcU67oJCHan
cJ60RPZ4i7zdW8DO6fLNILD9vnQJ5vJxJHm/iprNnRQYOQUuwh52+lOQ0zCZSFK4w1a0PeAAqVt9
m3f9WXGZ7lxY1/HMYBDytStOgVpvanZeTASHcVwZoOS4MnCT4wp1ZhZTksoqor5QtnNfKqMS+WGT
cmDpKPYQNtMZk8+MxJhpo5M5+RLNN3NxxbYi2sUF0W5o6PlbuNv8HnguhNkI75/PIg21wqN5Kw60
16BrKXsNGJrWeEWohIzFY2aUtCIBK44TlwkiUH9GEbI1TdzzNLuPZXDbgwlTw1SsAGI4oNHU0pEE
9pYunpnzXD0bs+0tlcggmrNlENXETDrEEdvoXB/ylsuPE34Wn7M/EvHq2iczmjQZ4uAxtPDjJ0+e
FI4EhH2BgSVfhw7/tMaxYHQXGGjARWBUs/846krAjGz2GoGhVmUYTcGEphI+sF3Hb9IUdILgb17/
t0jPfTLNdGUOU8N3zNNnj0c/8uthfw6GHRIynEW7bX3oE6mUcQUOkn6u7GmPXrEH5IuLNKgU5SyC
sOJ6lfmPb5eiuDwnr15GWgVtgIJhOZgaQII8SZMekUhJZHGQ1F6GpZLTuS/6lu+ANotuKHy1PP8Q
FJdcHxoUFvUqbOmlblW/LXEPErOcof3JQrkLEIOA+LDSNQr3I6JMBu/40ZizhIpkTBC4XrVVYedA
ZAMpVeAwvmK5ScsukZh3rK68UW9pFJ2BAUWhr6Lggd60brUO5e3zWpSqW0rzUBeD1jqP4R4gTYgt
mponZJl+Q55Qhxwue/QzP8DvaBIFG159UE0VaqAEKYk4wIT+ViKOY3ape7Iyt1h+9h8xSRBGX6RZ
1UQGVK4kx+2G58GOauubkdMQ8M67k305uwHGpsicqZNByMadCORIHtKlFNwtyDzyn5Nkp3fLVZxb
tk38Dx2H4wgn6/iODzNOXVq/rsifG/oHL/Xljdrkm+9JfEPXvBiBy5+n6buvFmwX+jRJrvJS8iEf
0vL7DzR+wDN/1f/udmIC4BROOBAg0J3NCqPfL59zMmISMQkpGfXTFyYTmEUR8U6+l2WoXwariCY4
BnS0FoEvA8dMEsnO75eMovXSX86SGq5rsqHyfWVluXO468//Hq0X7NP3Elu74TcP2+xhW/EjY7Nb
YfwjpWoFZwTWsPHVIiv6PhQ7s5F4RWQcrdg9+o6G2z8+FBdxsQVtzwmBLhN3s/Geci/96LmcD1n4
TKxRf8PVinRbPNy9RTNlR3C3YwnKo0phVXaPbnOXQ8JVCdtFll1QxXSOoBdVAjO/ga435M6jvNkU
733Lw26bFY19CaswHnjZd/xy7xlwVYYQ1/D7MYQDbbFnB3gyefb2VcIOBP9rGkaLYLpKCc+4xffU
uAm5pvRHCcWYP1Aq93kRQBAa1MZ9KefLuSOOlo2LlGFDFDr9h90TwMsGLjBq2cCGhYcY+N8th87n
TLGPDWeYoUdp58PJZLZcftysnMLSLPXqbBtyzag1oKWQ6+DjLVFR5cWXyAb9Bob3XrpAxaIJiGX0
3rNwxGgsZvtyGaes4E6tGV3nKll3LvCirqUAFyWz7HvZ766ZdUuvWkxYSU8IXOgMcEbhaJruAj7h
aWn6bVVE5Bj+N78XkaPYfYEHrJ5iQckbYXqHv4ljZhi8o2yGTLP6K0lu35DV0zFZLBd38+UmGS3I
nCYrjlRb0qqe82qpnxbMmsxn/5r86+7NhmkyVwKVImj7lL/Ru6tx++8W7VEOPotXi4B+SXOOtuR5
l6fv1jkNZc8Hvm103PNwKIcSNlWHkmwdWedQAh034N48n22W5CYOcYDX9SYcjCHILvzqjCPSPVzr
5u8E5QK13I6lOI7jdm1dJl34881sHfEIzc6WK5D9T6D4LFdpmbnZGX23DJWYDqvRFFxWLZM4YnJa
NuWaLxdLzkBa0w699JbsMfyaLfms5lOJgV/zVvYvd5XUo9MYBZoDsewAA4VVBuOdRkm+2jc+XpLA
J8laBlySTt2izotRak8SYhEsMGczTkG3M6Kbft23gv7rWDxxo/XIll6sogDqCnFIRd5dJVSBu/Tg
QqN3b65/4WGirfHTwGjwksm05LYhha2A6AoNM3C3Spg7EcOEUSG7YolcF0jhJYdsTDkpJJjXKQ9X
Zg2h0TXHJGFX69OrJyR5tVgb6AnTuBoa8hQCLbAIEPGRoheYiuOAnI6EqKQ8mTNVY2cE3iyCxcDh
/zdAPLtIo0KjzEMx+iydZCL8/motD0mmjT5ZSBxMRp3iyBgJFYddiNnX2Srudn8XN7PvGQB/0KD4
eDCZ5brBI4OGa03XtktAdt2iPD2FhF10sOJCwse9hUSDnrNDyUFKXoVjep0Zvl/NgQpaIfufB0p6
jtVVFHzXHcMRlDAcfdwDw/HRkTW7R1+9bgdRkdVFLG59lJU7Q0MC1O0QuUHUSXJR8IfU8iKOFA7B
ZnZVngM3VXZ2hH0bR/NoHX2iV3vahzb0ziowenwMKuCipqbsOzYQWLng+MX/vH7xw/X733/8y18y
qB7GxFTuNo4P1fF92ElTgf2ksGmUVDWwleRiuB2t4VOoavB8VDV4NqoaPKaq5jiKpgb1NTXpQGVL
9yxJlj53lQZceqYB2d2uy8KV65rdIj89D5FVVmUs0EuVGZVcNi+Zaf4knie/SBApmfs9oatk94kq
jnXADN/A0UIXnPK20lM2+HTBRt9zckFohCJhmv8oxc3t6ZuQXa2z8ce7b/Y8LNHstAhnS7I+UyeP
4rpAgeyknTNSx8mzQw/gF/7VWNz61eu+YTNZRZptaCKgpK2ane6HUliAM16sTLzhPUjXlSY7T3eg
hJeXqaUqU6MbKo98uI0wqH7aYsQHD2rG3INlD4IgFA49lRG8J7ZzYI9RkWbLk1uhCWo8Rl38Zbiu
/vuP357F0fp2TtkfT5gmNl9GQeNdqBS4unYGfKb+XscoxLkITf/9W9qWvsSk/JZeC1DKNZ3cxFEw
WYvD/nO83KzSFufXXKFJ0j9e8NOciHRwkbDEtN/YWyZ0t2BWfGPcxjdTJ79CW8p/E3e8QnEhsgUy
elrbNpVFErVofVgR3p5w0xXCW0MDx21ac0mhrlIoXc4eSSJ/mojK+6c8taHqbJbnreG7fb68b+Qd
n6vZnMocn0ulIW3DmSGVpv3GdjvYO/nft75VL5n2/kzIqsq31pvVjMqHZP+52v+RyvgViRqXoHIL
i8dssVGSdXVVveHFPX6V/eDU1/kVp0wqyePvz3r5HrT68CBL+OBB/SI+SA/Rg9M7aB7su6yhQahT
7cxn474umm9cIN6b03Mi4ddg5ZyXDFRzTytKhmLZQMMjAt9M3eypq1PH35e3JNhmMdszErCpOUmy
5A98AtXil7wiDlAYQi1/4HeFkVNH3XR6Ey8/T727KVkE05gKLPQuMDod/1TY0DhvVMSfADWArz3v
TjEoVA65QS3X0UWgXgTqtyJQlcApE6iy6nlboHZqEKcK1FMFUL4b1fc64DJkFjGjllndM14/uE+g
YLXxAeqc2X4RKBeB8k0JFNtSIrGGH6J6Dc10NAXKtlt1Tj7SPemGDTul0xbZF7Tet+1Ke3qfZxwi
3wzLMWzs9tMb+3XPaesWPyDPrsZaTvOjr2IRhoVM7a12CzJADzW4c5RDK7RxQI5tB01qIiW64ZFj
r7RhqclQVAQZ9CMv1dW+P6k3sEDj4rk3ZqWHLrwoTBeF6aIwNSpMptKb2/ApqVeYLHgvU9i0UJIh
KOEkdyukhH1jx5YCO+zaBOGB8qjy2sV3NBRomMnTyhs/Ruvk/dNx5d1XC2Go8oyl7+EV09eC5Qvq
x3ROF+trpqvlP3hLY55w9YLyIDL76ljj8Yqrj5263ZXGlgLqE1AMuufZpXW2MZ1RktBpQMuZjXVJ
/LjIyxLxE42UuuPm72vl7ueZ9DJ3/7gHoCh84gfAccAAyRMluM+EUbYjoVJJ3/RDv4MHF+uVOxlq
j0RgeDX1TibolL2Sz5QRMCZfomTykdLVi2i+L89OAY/0XNgxz06mbMwpWUz5mHuy6UEYlLPpDbdr
nSQu5dKzcZuT6pQr/Dwz5/MtQBwX0zJjcPdGxUZ71qiaEdeVKqriWeYX5ljSjF1OIDwVBbuM7qWR
jy41t93Y9d3XW3eLUKnutrS5tOpuHw3nBpPf3dqWDckeCsqlCakvDGPVFYQ1p9JJiXEtoFbldU/e
/tpPJ8aOejptZ5jT2T5k7SjrA7sB9nwL6zNkVVvGr+OX4teWJHx9ikERTeaKAcV9FYMKw5LN/Kvi
l2uq/HJIiV+oQ7u5fzfBjCd/bij9F9Xg2jnyq0ifJBa1S/aLZWItbtXzaxoxXaA90+7BzUZNqOqd
Fgaa7LpHgQmA1cAEBvpFwTVAZCeoOBqCU6eoW2pJ+YN90bgmPdtSsqqhI1pI9AnEtevckLNFeXlu
B0DNxQCmWamKt9xeTNFsEaHCkhhWB9emoeXeM4orNsRh6NehGeFOQCU17tXfXkcLSmSXm3c0pDEv
2eZdpxhV82jB27rxvxrbMqCiayCEpi38T3+XjZmyhthdK+czklo6QXNsX0YB8Hwbb1HQsViO20B/
bjhCJePTG7JmVonATklkYy8vIgn7Zx2TRbLidW43vDLumn2ZfbRO2O0Z7K59M93CWUpIiDSwJY/X
CVXpOngfOp+q4Js1WZT7LFrFoPVcszMC4ml3LjzA+QbK4TYGAWZAWrLQxGqkAzh1dbrWwdEgy01o
bIRPBJFpFdZEgA3qNzbCAnqwRkXrK5GLwEEUdgS7QOBYldSZbr4NvcUwVLQUxw5xV2jOS1C7AnVx
3KB2JqSVc5COKE9CIBhXv/LFwgfIUfFhs41vavlr5Pw9ehMtnvn+HqAV9U5FXpftpykCS1AFwHF6
ikA0Ygu9aRqtiJMFfmigjrsJVbqqplcGG2a1WWfAAbxVMFmxzZY0Xj9F+CnwLCTk3HuudwlY8Udp
6lm25p39qWj0PEO1ySpZ+VI0o4sWMHkedkXv8UZqINYBfdmiJ1qwK/b5LqJA4bhkVAXY30UVgo6u
j36arqgSGWiK0APqGx6nI/1J92xK1dvdOhxhOViJRxi+lo+7+wq4CowWWwC4ewGwpetJzhegEcjC
Utoq+tbWCkCA+mDU7IazCOiaRLNJhhMlw7jZD54OgPXw/dWWVaF6x+WPt+2MK5GKCgeBm9CAOPh+
d99Ql20XCRalW0o/OsBCFQmuza64queHd+C5OsZSZsghhydymMW21dUG0pWrudp6egOzMlXbCft9
G3j2TtNT24i7thv6lzzVS57qkfNU+2BMw3ME+UpNqW8A5KuCy3h0kK8Ol+0F5OsC8nUB+bqAfH2L
IF+jS0XkpSLy26qINGy1sNoLQ6c/Jk0DrH5vvK+KSyLTR7HDyO5gaEAtm1QJYHHYXeD0hN2F9yC1
YXTyALHcRAdNbTBLqQ0AaKYZT3MimcnIqdxTnAKhERil0ifX6p2yW6VBIyu9N1S7IvHybytCuO69
vVfpmSXJF415CCHMMlZWEdsuHiCRWLBiul5mu0r0t5jyzTzurAJMP0X0s/zS9w1XQD4dSok4sqss
FS7N/DcRPrB8dYoUIy5faV26hNtJvhYBVu4W2FEDq7ZccPzQBNvRWdc98PQhMtT5G0bfwtjjt3M5
k2YuXVu5WKDUygUO49odlRPQ5mlvaJ7pPpm8jL7QgN9RP25CdskL91TaJ4XmDuDyT9p85xfCT+yP
yy81kYjHI2czK/7DjfZ1vKHq2yGZJZSpY2zBflps5u/JzTWTHjP6ltwxZTbIfMS/rghjraBnW1sT
unK3rti7u1orrt2ANyk5+DF0SvXp1uUYHukYHqaj0gn6KWFLbX3ZMUAw2k3x8+VsRqVvI9l4sm38
E67lVGn+x7MPOyMmRc8ny7WgFomcyPSKLJOyKzyktHoybKCT79CYKDtdR4u7fdGbvGkaRxiFvHnK
oQWKkvPHBUpdDlRHgXLcZpmXjuCXjuCnsLFcpQ6ZgLDSEBz1tZSznJJXi/cx8Zl0n3Afgk+ZzUT8
j/UNWYtj5EEi623XedaUoMwGmoJ0up594r3zpiQI4lyIMbEVbNfy+IHvG12i3FC3M7kquTCqk1zo
4vG6eLwuHq+v3uNlKlgD7H9OyeXlGKi/y2u9nMrxxufIgFwSeoi4hM9+w+yi9DqyDi2JrZIOiWtB
09r750bHLyVKfSHnW0qkirVWpURFZQOvJXL8Si1R15F39fyUocRx2gK1Xd9PJa+aaQuho/b97ABG
sLsoW6yWIOthSt7DfZjFjBoKsEKNBXSoqacnYfoTdzWV7gC5uZbxZCKdbamAzdOHeYLtaOcvvr/a
U24CUWj5lR1g602rEjLdC5vTUPqIHR+brc+nAUpH84/f3jAVYvY2Xnr0iceY8ZGdx9soCOiC/ZMw
cu6krjxJViROGk4pdHNxYQKPWiJltvToVHR1uDyc0c8vfhGCr6bbM/FvaVNhkKLJYtMh27EF1Al2
EBd08PbGgm+//W1H3V/hYg4xls0GyuNDtxt4uTGABHcN3LVKGZ17Oai8ZI8vxbOx/32ecrwgr58k
L8BbGTmBryvIVXK2ULrWZKYI4X2WuAv8QGTG5r9I8a+cQ+4bq1RJ7OLe++Y04OGFanZc2IHvhlMG
bUWkMUFChxMkuTqYiH4XtXkAhQoADApU8ExsGlqAFerZFAOPd7YZUUFtzg0QS8HDssyg7Om0NOEx
9Nhzvph0purmdEzkl/3BWlw6lSzZGZ05MIyJljZUtDfl2pCjUaukHaq/5m++4z7oBfFmPGZ/JW9h
KRLZr2+fL1d3NTH3h3l8vfbNQYLuSpAOIMPXqafKirj4DHdGS4v4vg1Ap3VHHbVwZJW08AD31sLV
fSeqmOJ58gsjhdHwWXiAJ3S1D4VeKTcCdqBxkeZVRWzwKWfEnowCEBqhLODNa4lMqHc3llPks/HH
vR2qqYp8lp5QFb0eBZbwxeWchNDWuvW14HFVae35H469c5UoAtu5oa70PBIg2L2CA+uX44ARUHIc
AO3Y0KSbUIUq4h82LadGqNpf+dbMQlxyZ0L/kPxWYO45v2tcWd34zSf7niQfhajkSWLjyr6ePl8u
/E3M47J3ap233GPIRa7B08baz9nSc+KZbmFQhNgM6bYTDZldbDzzG6k9Zqw7YeUx/5Z5qTu+1B1f
6o4vdceXuuPd6ulFHF6qjr+JqmOkAIVDw5M1Z9tVx9DsfIgqvbp4SiVnWcrpcbuomxLaN3h0khEn
fz8Bl1N9OdWXU91wqm2onmov8PtjCRSn+jS9lb/TC2cgoAY0CAIfLoLjIjgugqMBhMRyVcERemBI
wdEbd0QKlidQcX9lDhInABSGOiGy70aaLV0wchQcQBP4F9FyES0X0XJEfKMDixZHFS34ojlcjvfl
eDcdb9tSu675Iap3JJiOVvx1O1F2Tj7SPcW1Dfuk0wbZ159u36bbj/ENC7gZiHyZkl6ksGJXg18D
tf1u28rvgBy7Gmu1Xjz6GhaQGdAAvkhFUVueA61F1Oq3qdVk84D82q7qrOm2qdti89jrbKgqDKAC
e7tPy81HeyupvvIGs4+2aq4uDWa/2gaz29+6pw1mDdW7CixQOQAaEcdObOHJLOOGe0hZMYDc6sk0
exLWAN0h06d/jsnqVoJ38KIRn7evqMe5UuA7EOlc/DZqIKwNcgdEKnSH27Fzw7mlKZVyliHCoClN
qWPX86YGCRzXKrrh/J1KspkCfrOn+zAIERH5U3nakoHdzigc3TR8ZpVtkluh2VZujzbqZBO8iTIj
SEsaHjbtfnBB9aQ87Dxtfa3+SpszRlG8AULsQ6ei++oBBKV5aptFUYoRTPPKQt6Thr+iVeVA/Cz/
WitjcP8yXI07P/ZBm+cO9Z36oi9DOYKYEn4Eq9y8WYquMQkvGu3Q9RLp5Y1C5KoZs4FXkzfaKWsf
3QsYI3QGMEbo64ExwkqAChoBAWUYI1O3RWVF3fqPNLzq9WLVCAR2ueYYQXQBcbqAOO0uXVJ8pYQQ
DzglECfk9AdxOmf3AS65D6xy9+8O+oLmPYSMUv0CDGruoU5LAPlm49rIgkNKyUpX8iXaXRpT2NYB
8U23c9UYx0XgUkOyXnrC5dANjWaL4nwEhSn/nP1cBRV2Otfm8Dv2py9s3gENXkchXUdzKuyfx6Pn
O8p9C2cpowXZQ3VwTNF6Scw1nJEsqeBQvXk3acixeTvyTQFsxQYQ6RBD0cqp7UVbeU0FZkp1TXWj
Bwq88V68aKOwQtll6Am8/OF4lNHDrqWbzXKTpPAUPht9TX+hnyUy1NgT/7xKfl9EfzLzOdX0npMV
8aP1HVdpPr9cxs9EMHjSsuaaBJ5pOh96+HOnFbolsU+4IZ1s5vTZIniezWPAGcACq51NIdTJSylN
Iu0DGrELlWsHjN7nZLFcREzovo2pooP/zJc68rOa953V5jk0d+A5vtPTBZT3Kr2h6woRWeF+9vc7
joOesItPwI3JjIA8MaBUus/vb75+9Mua+904rDYP+mrV8SuNUV3bB+BDbw9hSgfTTj4ypScvDVy/
Ycc1/SzlxHN+Ff60WMd3j3f96prNjtzQHT8ucj2T22W8/h7iK9mk4Nf41SKh8fpphdfix3+jxbiV
RXjQi+MP6tbwwdX4DIjYuRmcAtSBqX4EfBjAKZuSd73mGBbPgoAdy6RY3XdMjeUf/JUkt632x3ty
c8NMxZRRz3LHR80OKNi6YSzT3A9/J9H6tw1lYm/y92X8kcYPznPLnJbO3UK/tK0MEwzjVE8p3LuX
0j9/monG13+PedpV3LjRtndNGC2Cpu3SuD6FkXckKkUDilRQbgET6I3R/uIgNrMMh1hVZV2rHC2S
tP7rv/ZwvZQL1HDJY5V6DklwaKsKKoXbxLeAr9NgQVW/lU7kTUYMU7d84ctMvd7CijU6hzha9z23
sqFF33OjS+sOTYvZKHlumU5cYzF3igQjpatX3rKkuS8OLuKtgU2M7l142KNfMVb+8mKcxH66xXmC
4u69VIDKBbYLSAXQTraiyXzCTjfXG7fg6ZcVWQQ/zWbRKomSX3OixqI5kUrl9/uZ4gI8UJseFXbD
i6PghkrcDRnkne7EkHJAgb9BAr9jN5s6xKo94xXDWaENjrItTKRuC4Txjm1h2VZ3OVBvM4qgfzke
9pxH2LcMxd1agqWskM/++qDbSe0oaEFb99Xh8YIMpOIF+eDwwtUuuSNtE9dgIkM94Xq0Rmfo0uhM
peLRcRudWUBtdGaAzs28pMzv1+hsqkirfY3ZCucPAChwdMjtpDKZZZWpu9g77nK6lrqc1uEVPBOo
uOgmUyp7QjrVdhj647dnIt+Asj+eMKE8ZyZu49nMRYQJXNsNhwoS5DfJOxqK+zOHBc3e+DFaJ++f
jivvvlrMInaJ8JX/HnK3V7B8Qf1Y2HjX7DrKf/CWxnzdX1B+UbOvjjUeX27juedCL3QgJ6BYA2Ft
mulbM0oSOg1opa66ZoMqWKECcUUjTlNVc1Kr+sk0I0BCTweCjzsx3xT9goQA6wH8pTpNmmS5jpd3
O7muAs25yNN0X182Y2PA5xSbUhm9zaWSNevm4I5e0BVssK98zI1TIR9FJUL59zqZQueX4goK5Thw
IaRNSHzdW1v+b7RCua6Y3czZBb5rk4PCq+Wj0AfOh0sb3L5tcAuW8ja4OhlkfXBakWmpOK1dQASg
Zi4kUPrgYBfW2HzA6iRPptOpf/sxWX+cBiT+rEJ9p/AF8nhuN7Fkkov4CBx+yli1czE1nZr0T+fS
xfLSxfKSAPm1J0AqfbAJIaaNS/mPAPTPfxzzDJW7ObMuRgsyp8mK+PT7yYTdpzHx11tbbRpE82Qb
jmH6KaKfs1r+k+2EDH5gD/ol4yS7vNTuzBbUbuq+n5WfmOAN2CZSeBktmJ43OBcLCIZ2bKv3sipN
cIjn+Gp7F6jZNXW0DRzkz1f7cYNyVEOOG2SF7uHVDUNx74bYxLSm757RTd9gltmm6Q4rUBsDPzRQ
57hMnhWJpBopnD5jsbsyayKZCM82u8Aa7/Lipgg8C4nGdu/zJuGPUqSSrCkV7B6wTZ8QZEsgVqS5
h3eRSOphVyRJNlIDsU77+S16osWCxs93EIVMlUemYe+kCmHt27VdSN22SiF13DOkPurqJc6TLYSX
GB1BJzaUKi12Li1YF1h3++rE8u7+NZa38pOAhmQz2xlvd5S9KjtJyGdkp8U5fF+DdDOkbQ2w391j
Lx++ZkNPuTtxJrwOP9P1q/lqlrm8/krJKo1h1qZx1tOWai+MNieE3Pdy6H1iKdhZIba4SN3aJ243
+f3uzTXv5SG6YG/TcsO9Og3VE8WONSwDb1muHUuwGjuG7ei8oSTlO47p4e57g8skpvato4a+CwrO
B/sfLlkZpg36VftmA481Fcdzq2ZCtto6D3i43DrP6GuTfRtQKBcQlG8CBOUCf7LTmjoD4JODQJ4U
LOOQJ+jwJp/lOiWVoabVeReVYXQP3K2jk7tbR8dwt7old2uXlPDR0VP4RqdI4dNv+Vc59mkEiXet
aAc2jwsDMgiB2fqUI7N0uP747Q3bBbO38dKjTzw2wke2g26jIKAL9k/CJPWdkDlso6xInDQZly4q
cmg8SkWdc+nRmbehvcB2R79dP3vG7MZF7vEonbF4uaKpVIqCL6JiYDIjCS+aie9+Xczumuxg1T8F
gLNl39idOqO69eH1d8s1ie/e88KQJ2Rxw45jc9lvEV4PMDBkeF39fWoJd7vr3MLKITLtZUd5L1TM
cBvKLrl5ovGPd2taCPKuCogr+6kLbwz9RGa7K59B4NlhpUrf7G4DuTWXOx+84UZXvUFhYJZRNqCp
o3NZKgViaA2Nv0D/8CBHEWN0rXOXmWSOrUPcozJ5KYM+kyaVp9gdjD8+qvAH65FQ4dFPn9hB30VE
YSe7hk9E03TKf5NGcjRp4FT88I9Xv15v4pBJuWuhwwpaRpyU35nwmV2zG4FdqIHMJeHIA8vN+s31
JE0zyH8sfEmpl9N1HWRBB3/QpotTFi0/RuvpJqHx1J9FjKgpW/9VNuzforVSmeBCE/uEauUzGIPs
VlDarXio3VpRizl500g41nbbhzyi1VBWUYACQg9YNeeKfaRFaaUTVbqpxT/jLZ/JPjOf7XPXquxz
Q5Osql+IY+2lhL0Szenzl+Ptr0m3zIM94CKMXFvcHAW50NImlxP8wz+mb96/Vs8kN8v+zgyAFPU9
O4K8bnCmakWuS4ABDfyhx/iSglrR0EBGSRLk0puLApPCnrRwal79+ny5WLANzyMtbM63y6AiC/Kr
jEkDAwRO70H5sNGSo0jwcTlG4/ageZmSGDQMBxhU6sT+7XSe3KBpxE3dRaY7FDpxiva+nSYZQJea
ZBA6ypQU4reZCqVHu+frbsGBRR7GQJV5oVsjnZFlDSHzblab9A6pElgvQNzCy+8aHg4cIUGIBPHX
yrLJ5N2xm4dtCzC9HEE7J4LnCCLkn8UWMpUOieyCR3bdBa95P41qtlAYLYRR1fLedBT10PNMoO4i
2xrGTZheh8+X8zkvp134zL6N+YfzeZQmo2TtYJ8KUIXx91cNmTTFJY9cGX8OZMhUdNs23V5OxB/+
8ezn//4Z2v/9ksyj2V1Kr0CT4CkO/A9ZPMXvsN8XsvyVBrlXLUnvM/YUcbPyR6m3KzsdISK+5r7c
R6ckLb9jJQjGNo2TBiJR5rRiVFJq+04/KjmdbAjuhk2Wm9inIuv894Tj14j3//rstQEAU6Dkdkge
j0pvP5+RJKHVd3/1/pl+cFX35HHpy1L9yuLF1fnmejd0gRGYfVelJtMooesWmUaWkmnkQqODHWId
xtOjADSERmgE244e1OWYYU6lyIen8ZNVTFdMHSwTtwxDxqrJvhMfGgS7WxnJ2O7WjQofEdfgUQ9k
A1vxIduujXdBG3QFbfvuUta0zZLTlDR91zUDylCUHOp3LBV5VDLSXvzP6xc/XL///ce//KWQW96/
aLzcR0TRdQ0YTncSNM+EUpJuu9IB3Qz2YWmciUIy8MTFHVJBxbBh62A7CikZrKN7HKZghRTbRXA3
1oV5SK4oznDHp6FfwxRL61gqGzUFPaE30eKZz/G4agnJAgPYCZB1rO3JFAqsLAUOd21QG1h6rQqn
yYwpNbUGoVp3YbulPHMmNay+Xd3EwK0SolokQPT4ylkmWCnNJ4gVhq7KfEezqct9ybBSugoiHwN/
mF5Tp2pivqtSkV/QsyhZ894qQlPZm6+Mi9bmIbJdpyfOaw1Fy3lBln+7WXzcRxOEipsEeWEnXQn1
0uZdV8lMJaZZo807HUFtUlqEdfNks+LlLo3RWmAqwzt0G0LD6By+qIVJSxqvSENFpiI41Ig6dRxR
CdIGthX6u/QDw9ZxG6KRZPu1uB8qF6b8aA9al8ISYDo7CHRNWzddkxP3uyDmWXyz4fZKokErUgP+
KPT8HcQ6NtL2C+dLzAyRgD3yOuK5EOvl4kXESE84ue8ob4EejFsDoZlBiHeqzP1CZNMUyaq+AVGR
gwuxQ9XSLgPYZi9nsXJJpST0UlLOUb1wQFEaZ/mhWSrGtIyewbpvTcuoDxKeOuoxoNZhIKxqHXSg
wKJCGccCnpJF0EMNyQFLOZFGR5DtA4h2qFba2QYOd8l2t4MLFB/GTYsNS03Iw8jfTsjD3epFGSFv
ZW8OkQ7boEbZCjCGYbnb48JOF9+jkovhjF2y2CmhikJ/UE+LiJek6YYt4BkVr49FoPAO18MzQqhl
9/+///f/todl0pAEIyKx60cy8RBjwPbDI/aXH/qkyLwLMCC6WNjlPPZDd+ho7PXOphBQXx8gK5WN
CZvFXptMkdi+w5vY9LBbuZhOxxbCug0ByFaksWV1hcpqKToUPYaLju1oDrSNrliBldLEH0bMKpW1
ifXrq0h5x2Hbt7v04Mrugt4QrsrsTu3ihYlEVXaRpev3yzSkbODxvSpALBAwXCMoeyZBR0ShllvN
ReotRcAAW+3oLcRGZ9FE7DzbiN23RmLn20qsazMxXOh/vJmY7QzeTOyssexaeGX32mdGAWZHPdLN
9GktAdnlo+IAEL9GUe8KBHBkETg6AxE4OkMROLpXInB0piJwdGYicHRfROCoRWCqTcKuowTHAM+t
7lBxfZjUN0cBwDRCYg5zXIt+KSKvqGVvC2RDCE7PEqTG7ELH2EKTsTtBYcH70FfocEk18ri0TzRS
ps9OSSkLUCfRqM6/cpDGrY3QCtjGDhj4Ejyht0gpNcW2iZzBL8zjd/K5N1AA/x7oGsqTR+U9RE9/
D2FTRQbhsBfbvn3zIF4TNffbIjVNRjpCx1yww+47dlgOuchjz7bvgzJ0GOwNHZbwwPEWs+piywrq
8rkF6JX4vGMYZQeneXJxYmE1VGhuIwLanRJr4Ohvf6gJV+xSfUnX/m3zmYZKI6/QsAnaogBBjT4Y
R0y8gueVdgV7Jl0htXMmAXRov8SlvKRWmztugUlFOTqHdk6jOjWzfVMnS+3pBE6vqNlA7RICqL2l
MDmoWxJGhtqmUkv4q2D85+Tj5FOGJ+UR3peHA5ZNBPzUJKGpXyh9RYP8AZPl4jp9bxJuEhq85SFS
xgHlCy/5++zhs2gt4ODYT/jrJvtYFeem422Jc9fS1xNFdyMxteDFcv02XgYbf53TOmamWhzRZPKR
3iUc4n7DXktGzEnC+BAtPiYTJh18ms5pl6FvKbpmSD2ld1F+L7la6mfIHjGVk5gGy/V0JacxJdk8
aslREJ1C7Ai1nz9I1vQbdj/FlD9pMtlF05CtNMLZkqxb9r5obhig1ZLjzJRDbBVCghiWJQIx+bK6
lntyKWaU9MNwu+TX6QCgOjrH1mm5CndOrdOQ4t1zARWZInzTRosualdFt7ih65+59hb5vNydKYIk
U4Oyv9/xlmoJO5sCa0GCqqf/PM4Ut/ckZg/ik+JaA/2y5vCuXOddxpkq92rBRDMvwbuqB2YvX91I
UWRc2+8ScNjSKtkZ/cgkSQ78vn5DVhlV6dzF3v9psY7vHu/6VaoD7fhx4exKbpcx0zUx10sZb36N
Xy0SGq+fVrgrfvw3WoxbYfuDXjx+ULdqD67GZ0DEzuV3CgWaeJ2SfWucktdrju/4TOYhFuv5jh1Q
/sFfSXLbake8Jzc3NMhY80zqwGzeNWteMHLDmKS5A/5OorWE5Zj8fRl/pPGD89wkp6VztxjByj5C
pD18KzwAfKsJsnAdh28Njf/P3ps3t40k+6L/v08Bx53oUNtq3arCztDRjJd2j99xtz0te2bOm3Ag
sBQkjEmCTZC2NeE4n/3VgqUKxE6ApGydG3dapqjKrC0rl19morryrbraAy3O+j38jpMo2LrzjjWS
zSI7ItQB1HebT1i9WsNoD81PuzU/FYo7BTatlT2SH+V7afP65IhtXp8o96vN65ND4EIKF4tr2Hrf
1KHTO7YGEi+ohqyaYwv1/gdXlJF7AZuEVJ7A8FR/f2RTgVSX+noRvqrLHAptvTyW+SS09YLmfT8D
ApyDnAHdrz0D2nBfDytylxa1dDgcrxJgJ3h4VI9lQOSuAH1AGmPaicZxsgp62c+XO54fkcOzbj1J
eYJmzXf3+XIb5Ybfc0cP/19hjmknvLS0bNZocjb7kwNa0k2V5tqOlbNszY1t/TMW0yx9a7NdzfFl
0U1TaB/b8Ctx4VduVLsFJe8YG2ZnGTlbVzuON+bOuzoVN9vVbJbl6579eNLb90OnX06yhT/8UL2J
P6SX6IfjIw5qOjqJrYJY0IsIyaxl5m1vDEqtK/y7FYj35vYcSfjVRCdOSwZyJiu9ARYsiiWoPkcf
iIc9rQk2tKtAp0KFEAioOi9QeyB31UE+EKEZS6iFONQqfCCoV6mjtAFnRVOvrI8vUUST2xqXjJh9
o/O+DnKtI7Rnqmsrkk5ouUaRdH2rU+ZlQnfr7dU4eQWsAqL9TnqSE1y86+2SJtjMZpzqNd7Q3nLU
23pW/Y3H3JdY/Cf92s9f/Pk2iT5Fm7uXc/cmafYoFA4F2zJtu+cMhoAdxUqSVk97+4kAoeiQWyAg
bZEJ+yXnw/0ug4CTJpeBJ8zIlbesweivI0DovyUA/bcLnz8OeP6A0HkhWcjydB9M/sKqBVwm1IHq
VTyxvdxoqtBsbT4/Y7mkHzFevYgWLbVWhSodlmfDnnulcoQ4dpcOpdkCEQdhIEPEVbvvcVTldghu
A9JG0ExPs5V0AQe3bA3LC6PpA+oZdl4aUeGnJsA9wP4IjXhdi0JHpeUagOh6Ii8YEcrf1HrBwnIh
68UrhObrhQb093hSNv3P3GW8vFuQB05ZugucrGjfKdaMZLXdYKJHBVsfO7yOYO0CtlrA9ca78ynC
n7lNWqMRCifG1KULNuB6ZVW8h5S3Uw2xvN2Q1Kx7t/rSfTUNqVSNtif+8psTbtJRtQLPl4WbsXdq
kFCN8jKIt94cX53x/+66bWr05iJRHwPDKlqk3s50DezfHyplkQakUg4fZyw+bnFtEoZMQxMYMgAY
owtU2m2JNbvJMU3kY6YGV179EnSj6CsGAp311XWzYXg8EO7TPp62Bvzl7XvGHj9gysL9wu2M13h5
s7nNuwKSr/FqC5whD1mmZQNrv1IFbFhO+Be8+dX9krURus7LpBWUtZyyZdtuD8pokIKtCgWqtTD0
q1xYWi8X1qk3hOdFvI/ZED6r4z1pQ3hdaggPBpX9piZLzqSzYFzWNBUvslvVQJVUKHtQZ0BJvpR5
GDNpYADYP/+2EBSo+qw1tHNab6sppN26rik1lNAsaA7qjwybA+EUOuAm9H1wqHBghSP/RTTC2fIP
jCCAwPhwWb11j+v2lLyGff/ivP5pEgDzrq+6QCuAKrczOKyQ+MPZPvjZNgpxSM820uSzbY2mlv0v
L2RefZYKB48KgCk3Z++TjTzsqYfIknxpxr6+NKEvRFoGP63Q1tKzSPCjBX3L6yAlw21edilaLDTw
MlzAFIfqosXI6u2QzwGkrcW7UFGEFljAsMdzplMB66RpOBG5flSWkJGeU5s3IsfiLdmYQh8rZek0
Akdz3GjgWX7/7tRPvu0EoWKSD0lC32eSkHgCHhKFHhKFWHKAmCkU+kMPk3CcyutRwKj+67/q1izD
XYlonRohX/Brqt6AAiXdn0ChGgt5Ai1gjRpPPmBGRSExXN+Dw0pRZGFiciqfJkns0yc7oOfzHyn7
XQtS0GhFj1TuYVqjUI2RaI0mGLNA5UO9lgxdcvg6LR1RdaYhgur6tGkYeOBUUzpw/sOB+2YOXG4v
NlQAKlfRKqzFAFkVHX7VQRksfUCGIkoHeaE29Q3QNdFO522nyz55Y0iJnzJIkFvrdUarJRZFNIPe
B+ywUKh7VT90aN1QXSjjH0KoT38UpSxvYFl7H0Uib7b1Rc7zE+eHKup94vKMSMSVPPZiEDKr7SZL
50tmzFE1J1e+vo9LzoVnIPb8vKNxGCrdkydpjkMmfKDa+5w+z9CrWX4J3Yp6iHlxCz3NZrWwa7mB
GhxwFHf4iZZL2t62nilbcKt5WsD6ktUyhbTBUXkn3dD65EYx2O4bDA6Q/g2PGwM0FFHZnuIYELsr
ms8yNDIHj2R/cDlC/t+PVzuSSkRm8D/elV1XLOMGjpKCOCDt7cfmdF+bHBcMxkivGnOjijyeutnt
9hml/oGrQ2xllk06PZPjbLZZZBjYAeDJz6PsdinkUtpXosqu5q6P90svm/BbdMerVS27KNdm+65m
UymfzirFv0C0f7eMLtaeqhdd+bDfu2BEBWWaak/fBWeBFwnelBnIfi2oghlgyQogTZ6fXMmBQp9N
ouXwig3lwBjqp3DfAxAMPAEQDDx1EAx8AME8AAUODRSAQEIK+CWkgKZPLRCFEjZUIFZm3WjTeyAM
yQPh9e7EQ69uEH2KAtyWb2NhT9xpqEJ9SF2WXDNhRL+RdgyCO8o1DAv6UjsGZOwHUe9wHYRaQeQ2
WKXbgNDUt8FEoj9Oh/5et0EZeBtUMavUcvuWM33wf9eVrz2IB7x4Cvr7wAUtxgqQq+36wMGg2qad
jQKkG6JR0D330ZqgBKaZdz7RgYeRbdVUwOxRRV2V2JRlBN0UwiYrfr9N8PN44ZEDS8RWVleyxpUp
1Lc2fUvtmfou8vMOL5N4fc0yBi7mTGMnDJV04TasXWi4umn1Li5Qx8aG/aNOYhoiWcsFAyoMiAni
zu/u5xcRk9HuOm8iEUbLoKHAXfG6Ey4sfcxG0FChMB6ao054YEw2V40sJJVrEsvpOEdBaLNFjoLr
9z0KzjVT4X/ZEmPPZQn2xcrXSGgrxxDaqm2rA1qRi0RXa0ykAs7z+18t3zJvzybeuHP2lsziDdmV
9+9eWvyfLWV9813xNU+H1ocB56DCzHdSnrNjyisznFExwr5JfvVyHS+I9hPg9+TDvHhBlDy9fv7q
1axj6CkwwkDTPgzqYu6kzw6WWD3bYal5e82cF18PegJ5nwwtmSBWFNHc8Ch3SYXiXTJUq3fo/bB3
STnpu6Tcx7ukjHuXClAZvUpIG1oHhGalsrJbDN7tMmRDvGZouNJadqt4Hlgq3qelZ+z923fi1cZJ
8DzMSdJPL54W9DJ3rx+YltfnZULj620IaILeZmq9Lho6hsI0kroEJHVJGwmeSTUHfu4ubonOROhu
4hZZouclZlwrcINBFbZT/cznm37m3W1w0kxWQ4KARYF5jC2YQmMdoq9CYQuIwqr3gvyNfyMt6Uba
fr8n/+Bv7Wm/tPfynR1LYwVAfGZV8OGhxNd03bGhchngYLuaR3TfAie5W3jx/KrV12QLAWgPWeCo
wkdo4kqFjw/unRtHOY4bR+n/KFIFgZfYbwuKEYY8qI2aQZJGKCl0jYjrV8sNXi/TxuX4y4q2uVje
NEuX4qL7mmFB68jn1pLObS9P9UOooBQ5OXyg4DCIHcGKdbz/4HXcDs7JbEOGzQHdnzNtikiAJoYC
Qp/FyatCAebQUMCJtKFSv5v+Juio3U1opcOH3iYPvU0eeps89DZ56G3S6GF7EIcPnU2+i84mSOiq
AVXPC/zKzibI7H2JhtbIzfV9ViMXD3CQP6pJQUzof5nRMY+STavhAZGQjKj1dZk/yJEHOfI9yRED
aKIcMWrkiDWoQWvNAlPrhVp2jh+v7hzWlRN/SV1b9At5ia32Gr1C/RZfp4VpFYVTmiHdAgOYVo4m
/vbLwbaEJlMgtLUhoPQeBq4h2rcuq+Yv2LdopO6htCBOdOOQQR1yZdq+ctb6jab0QISEKek6kqaE
bGuA9/bF/7x+8dP1u/fP/vSnBV74q8qVzP0ymuUHxuC4wgCfkCb7hHRtb58QnfTc/c/dbuUjVn9M
hn4wVMi/Xi03HxR3GVS3Zq5ZKsKu2x2RoU7R8b5ALrKO914d3lfXe+BGfo+3RAySv/83LnLw21MB
bMHhqHoBSxTcGWpAWZLKqtm/x59fLdO3jCfHXax5umBdvEYVijUgO9zNU4BA7euOE7LyGqt6Fqk6
LsT9EUzc8VefXSc1x0FIqvuPLGvPNglDE+pOs4xznq1jBxYQqzirmvGwUlIziSKzycbIktZKV9V9
Uza3y3Dubja4rfdSq+5+op2GCseSawRI6hujQ33/VMn32frN0mBF2qZlz9VsVE4KLd3FELBM/NU6
WkSb6BPO5I1qDcZESOnwi/gTbg+5aYaYD6+jXnCsoQ9dnnPEHjowzkMnpT+tyYNHtBfCz1nTyyJU
47F8qGp9Y7f0WckzyJtRDhAGgSZVvVeB1jtwKxy/nO7ZvZKLWgEecM0QSR2JoGmDAfHlIYtSNCY6
0VRxQfwRO9S0pGWytGMqzSYCgtKsM6dlldJsGD0i44et9k5bGB691js/vcet9E7/7+vp1XnnbH3T
Vd6zKT7UeL/PNd4FQKvrAas3+uu4Ra6z23/AEtdGgZN2fU8Fg4RCJb/P4/k8Ux63Ht/sC/o8lzl2
hFbQLdwKEgwAFFjDrneaTS8z1UQ1FyquYRumNoSqIFaynK1osZrPZgyIldYCxzn4Uv7Oby61SJ7F
XyrKxp0r1nZe/A+DYpKbt47vssv6ZuWSQ83olEVvdl2HSdsidQIFvXGPfe6arYl3zTbHemkpF+li
8StWujtNkzfzvJmAnAmoDUFiSlDTxpxBYakJLXBMJ61h2KKTloeHKpGYfZy0x+jUzf2QyXbRpU03
9IEpeiI1oNr94Y6dGiufeo/uQu91LcuVeschZBn7FFN6aDjduFZPvuNm00+OFEUuAu87MeS28DGU
8ptcOCCr5hu+GzoS5YgRynfDHFLe+tAe16Gvli69WsgfkLFzgKTEe5OMuB/II48MMWwb6l7iYwrt
ygRF4VWiXXmwzptnWj28edMU4qdeu9Muw68wHk+jCH92SPuX4LeEaoCe5luNLKEezXuV3OMgFuAn
LytLg3FW7t08zkzj0qGxhFr8GnN+iLX4TdCbh8M/7orkFOj9uCNNeNttY4C4GtCMQT4JTKGqPwk9
DJTiJIgiLX3bWDED6v/3qetuuUnehLMWOEJgqIY7npm+m9qcllXk1Qt+w5+5++jMY/95lbxfRn9s
cVZrOy8ZcLOOP+flGVqqLxR+McOFnjb0XElp0YKn64JC6IhKh58ug+fZLEbkHxYOCteA+tCLccCi
XXtci6l6lEhBzYN2KJHKQTz0JznN/iTKBNv00J3kNLuTKKXd/hZ7k8DiAbd92w5BuTUJ0PWBCyZc
EFr7w2HQ5Uvxk080QOFQ/PJl6XzuzITlOrDEdx87W/ZUOh/xneOub5LyHxfnVT7UbDGqxj6r+N4P
/cepyc8UO0eoUGOdI8QlmUHdsgav8firHMTkONO/vNyst/jqrD15RBP6GUA91HYmaBr2HhM8lp2w
y4WYiJB6G8iylq2HMh9Q5MPv3mIVTVJeWxdDOVgdQ2NHDxVlipODDl5PBg0oOi+4gKwA2dpejVcV
AePPBIlQ2aYMoMrV5cBSGRpT6PXQX0igHoV0jHPTFAvdQ9U/z37WujvBpriVFtBEQB/G/sOtfLiV
B7uVhYuJ3krV3/9W9myIpEkNkbA/uCGS0sgDW0iKQiPs5D+f1eSlCUobsExZUqnqMIUtrz9UGEmZ
Unu5y+4Ld+MyjSxeOrR8V/pXNQyLSiZmkrUgQg0fa6jhI60kywjloL/5U36k4zUxaMnJkiKVxa+4
76vGiZPbHiDgLZryP+TWhw33MD4EfjgTDLt4+eu719kHZHXX2L/ziQW3iR2f/vpM+PXj6hB3cUtt
gAGzMLkTj49AFnsPm+lroc8Titjx3DmFzDluuCEEIgYM/RdRL2fLPzCCAALjw6X4/SV5jhxaT5BZ
34+vHl+dNf76XGn89Y/NScu6rquaz/R9+vczFaint2GwwG3SDWMZyUM3bIrXH1pSzxsD1xW6U9HQ
opMvfmOZolm9yTn9R3uTG6FvphnoeLdRfR/A13gFU8XmO4ZreNakxbyPVre0XLWUVt+jdaRLVUu9
eHP728vnLfXPhbrShouHl/wedJAMocOaGRhm1UEy++Ehjn2Q7kcBXGX8gwSkg6Qd1ZehS2lQPh6h
QGht8776vHzLEhr39UITfZVdSu/c5CMDXdEsqJpeiUWRC883+xUh7jsvoZAHnVi/eCgPny22801U
FzkTgLaQWAAiFEzviSaQk9hTot9IGrvgPnYNU85gVcnK7ZPB6q1jN/BppRe2Dkmv+MWpwW6Le+ga
rhZIDV9tYO6X1pqaZNyI7ZDQX65wtRscE77xNstAv2qJ57RZfsjXQMl41gfFn4/nbh8K6VNVQ4D0
AauzGIaTvExAepmCMbzsD3Xbpffl0P48eBr+PHgEf17fjs5A9OaxBAiBfOcXa5KLaVsi1pb7nB4u
5sPF/D4upmBj0qvpawMd7XCSGBiSrmbgP1zN7/Fqjt8O/WS7rYhpSKB7v7Jpbp8q4ULww8P48DB+
Rw8jkh7GwDqhh9E0BFsSI7MuPQzafS/mQRIK70064cCOhnnbSZYVBP3jinHbEM4Kre1SfVYQuKdt
Fx+CP/cw+AMnCZoDKWhu1wbNYY+j/uc//3mXmMJSIt0gWNNCR+kmaYDce6LCfQlCXCTwalhD5F/D
z/O+B0nixMVHFUaaKVl0MKyt7Q0njWMBKY7lgiGp9x6+iZZPWdn1xqo9gsKGfKQNzLxfEy01WhDV
hVO8xuQzDv05q/7GY143rfhP+rWfv/jzbRJ9ijZ3L+fuTdIRJGBbpq0e9XprliV60FHt9Z747Owf
AyVyo63iOeC9LfPwpzU8+EmofSNxTyiWkjFM2xaXSAXWXqV7TzicB4VGMsjXyhh5fUjRMcoE2+v1
1ida/w6AsAEq26l8eXl5fhhnfc6bMLyPr86aftuB7x9+GM75D22pdzXJYEioR61Ciyl64s5c3M4G
YYthM9y5QDuf1mFXxe5rwAClwz44MbdxMZjVUqdUCuwgu3z39DFzR3+n/13+snZXt6xstk89Mz51
UFUXQC6WykNujwpCcJK2LaKhGaoswF35PBv79eHhVemvcVZXdI1DvKYlJAnXH1sqy+hAJQ+rn9e2
L0bhzPVKSoTkINy8ddebKC2s/3FzO2P1n7qWfXID3wRD6tsTwquMcJe6hUAFoS/3utjvrSzIt1Qw
ZP9zisqEVXgcXBuCUFa3TOMBHHRvwUFZP0uH3HHm12+N8QhlfEJkYu3DYKkucEMtdMcl/z9nK14U
vPm32+XHVk+iIfSeUwHSPuyRS8FYY2QdxsEqXrXTBwJ9u3u4YZIXBkkBKTWsNQDNHi/Mxv2In9KT
yky+dvFdaGtEfAN1gPlHKTouJVkruouKFRD6lieVzOzj1d+RSyXaAwzDkxXoxGgu4J4uee/EVVNN
w+z94h1Hqg0MOiAolhlFx40dG6qYvxTyVimVOHzUP3R8HFdYXhaF+8K8o/rCDMsQ19fVa9e3jyh0
rllY4JftJknrvRW1tmrqnwvhb9X2jvs+GDYQnctubVi016KME1pChakWGm7PQGTPeMCPzcYA4cDS
/ZGiSVD5q5vc0kJ2hD5j8Kz5Fln5gXFNHVpHlVImgKJC4WJr/zKrUPnba3YwOvZdg7Ao9QqB55tU
qfkHjm5uN8mwLrF/bGmvILJKvwqdPAkzOCHn003If/KGXOWjuyAzb9R+dNF4dUMwyHjNGWzo/ilW
SIJqoEq5QPaAt1xQKMr0ByhBzW7zvFV5c/Wt8reFxmdVn7X1pj+1wt5FUwbXdQ1XaptgQWtP+zqh
VvLOzlUZ0qdb+1zoaOLSF521WKd6ncMN+ovbztJ4EvEIRZhR6Jn+GOJxJKgGkKAaNhiEP3oAISpH
gSH2AuBCVRURuIZ23DwuQ3JCBHqdE8KCQ1oI4C8rd0nMvxfEfCHbT+T7WbtLAgnpxp6O/f4uCU7W
CaJF0lIOHQI7MKTGlxoyex63Y9jVg5MIhe4dIaT5Ecc8fDJ8JvDAGIfvIQ38IQ38IQ38IdLzraaB
S51dgGsdV4JLjrugtk9zZwmuVEfJ+R16s+a34yLAoUukX0MzZQFkFHiazvo28EGyLA+rM0diW0OK
aOjaKsAEakflBZEzJS0b0bc/u2vqsIy9BK8/4XQzoiVdnM01FUF13QPFSpsBsmo0us7IE8pb/phG
5Eg2uOWglF2j235Fdo2qdl54SrpIrcGf3Hl1uboitcYzQzmzRdVBj31OCZaEISV81lZcHKJUey5o
Q73PGSPUoSSKGdkB8LpCf/agH/h0DzZ544g0fNSPsVmZtXRhPrt1OCOh3iUKfVRaF60v+Z21+fkT
MVKbGCi0Llv1XUQXAdO/SR02velzDn7616s319t1SK7iNXvhGB8KZeP9chPNr8n74c5xwPHrNGgT
bze/Xs8+cBbzPxaDorZtIQN271wu8sS5iuKP0cbZJrTc3zwiDDlkv1cZyf8mNjsFiKTUoK75PWDz
/P+0cQ4mkA6mtv/BVOjlL3Hm0P7CZy2wy9p2AZpWPBwe9EK7gktkGD25/KpAW+TzZrVNl7HMWw2o
svAP2arH8wzon/frOllww0q2i/pxRGMvTrxyCGcdleMdzs8V6sZNmyxX6MdNTS1UYYKACAz6XHOm
+IoDY8AcHzXN0omWfTpajDpbKLTwAKHLC6wWs4W2Omi2iqKPNd1m5O8+czdtce6IPZni3CEYOHfa
E3C3ju/zeLFwl8HPS58oQGty8/DG8flnDuYf1pQbLkr3Istg8M+AK5+UTd0azuZXwuhP/3r6yz9/
geY/X7qLaH6XcslrvCppr1uZ9X9Em9sXEVHGN/4ttQ6zN4WMw2oV08Gk/rTEPsGBqfd8V2RGaW3k
Yaw+j5dhdFPHZB4lZEzaOtiPSdpCeJdNzthyg79sFOq55mwJ3NOMgSYmi5XEmmfgvZl81Kd0Qg6V
Y7UTTO0UVygPirEVsrqnTdcxSS0tQoRdW4G5S/bZX5++Js8E0f34KUvOFenj53M3SXD50zfev6t/
IR7ZiKZiV9FI2bgmFhi5+elAV0S00mS59JdvyYdnPCqHyRi0pjlfvLfkswyEs3NLDS2/AVgNA3WE
pbsvi8fBTa+WQbQmD8y7X96sNv+N10s8P6tYP4rQE7741l27i+TxD0I4KbmN1xv6CZ/7i19T8r/g
pVma+/Xr9HclhrlX4Tl9tNzlhvL4iv3o43fxR7x8tVit4084GJvIS5xRePxDzTnRdOGGAd0Y5Zjc
l4Oy4nHHn5d/bPEWN52R3TIKcryx6huPa5bcKN4mrFEnyjhLXl70t9EK0wDpZceFrPw026Qrpu3R
sgUs+JzQkvHZP15HTEl79eaXt++lz2rmn2fqk/kj1UWjzZ/5PKO4xMbTIGf75+VmfZeZreRrUsKS
hywrCLr3lmrnhvJTxc5fswT0MiuZU4Oxgu097yKcRrNClqhZoT3Xi+1Z7P3bd9ZxvGFlTSgP/1+8
LALd9NcXTyv8435g2KGh7cvBcF+5hoDoK99Hg0Nj2hZCAJoYFyayysYFHMwn19jZmWXngr0xuXKX
Bpk+lE82Ki6Z6YfBHidbkTh497ob/UyPpDfLt9096VMOXr0h92RJ1AbaY5esxG0clBxiKCNqQ10F
gQ/2JUrJRjFtgUzpOosqonlBd0Y0DLX9ibL+Na5/6yySG0TM/A15JzNHeXE1PrLXU4Q65+aFjXV3
FD5kTgofZD0XhY1jeb46mAnt9N0eUIOi30PzSx4uaMBJ/R5B6jpwNiwwnfCmMhSWdq7kP1a75kRH
SMAqlwmySuucvlMl3rtI1YV75+FXzGZ4RjYiqnXYIIFPj9W9FfhUbX0PPp9U+kFE83mBF/H6LmWQ
irprP6530kDB+tMMaO/1Rj55sPy+Qcsv9xEzy0/T/H2PyKN7ckgSvMlsIzpOvDwrjy2aT3VWjHjB
gKmC/Vcvv2S/u3dv3TtaMovKzKdzchjJOZlfVq3YFRVr6xt81v8v5ddk53jo+fEIPAOY1oMEeZAg
E/qOnjz4jVr8RlDPXBXMcaRibf/1zle84DzvSXmpadv5FbM6iRn1lBfvO6tA2ZcZFZz2yNXsvR4W
OKICJ4CHiAbng7KmCdCe/pbdLvJM883cP49ZK9K0W6mzXUbk+BCL5Y6WJ0lKX02V5vzfqbC+Oqv8
uObbNRn5BXIFBTqwdnrN65axt0/nkLjH8f06lljgAqJ9gmNwUttJqHpKjSerZJRoaB9HT1tEL2Ob
Q5GTWcr9W7zmn7DEpDoLRQWCAmVaeE+XzMPD0fBw5AWW2cOBwN7OmHsSRI0yZ3cmGN/F6YBn8loK
aK0dJQcKSg4Khzvl4T2AzghPAwiRWoYNAWscMUj92OkKcIfd2a6M5BrpD+3JvLsJArufCEtSDcoT
Jq5bIcsT+ne0SblLUx90tJcsrZsiX450Hdomy16D15G3Jmv3uGuiMz8q7OfNdjXnnanzE8KGpPLn
HVsqSaxcVQ/F/iTL1H981Yi7E7UNL3RLD5Q1GImW1/uV2sEviBz4wtpvz2bbJc06KLV852rHBRQK
wWRPfQCwAQHYXzbyRB7KyWzGEh9qaUOjoI0AHCFCAJUVf4bTpaD0d7BA/BsCG7DQvHxXM/xvWcYV
iHoq47QyPBDY3+7cLSlEgFhe6ijQyHZdMcGbkmONp5jUaIdGARGg5QYHH8j7o6yclldSWrlvxx9p
iPfldxxs/QzTvwcsvSYXocgasl0PMHzvmlFM5YxqDtobKRZHa1/wQZ3MGOuerNtPt6o0XSu/kmtu
/eKXSIgDuqbBUnqEBVPtYepXN2TFyVngPHh5+vZ35vp6sL6ntr4LnPV3Y3vrQoQS4aFQM+mI/nz9
+lVaK57YLkWgRL2swz2Sz1X+z4D9Jf3iq3gTC8M4129/fv76VwdUfP1sD7Lt9JrfTCIzBbCe0aNx
S3kF4T1EgNSZ3aeF/5h1Up+Pgv64X96+h8jtwSO3sxro+YMCIFsuAuBdg+rQgCj8RjV/tagnQBR/
ZFslxV9DYzxa1MmaLtj+Pud9f1/2ULf/om3EonlEEZevT/HWPcCi32Uftw6NPZ7a1BUbpo7h7OfL
73UXZrM/OaD+j85+pCURMfksviuaC+Nq5aPYO8OnKUOKki3zxW2PsuDfh0SBmqCruabBerlIvgTz
QaSMIVKEZSYiRasKm+mqMar2/hA0Gxw0m/WOT4mxMQSg9aC4yK2phDQr1zT1kuaiAW2MWFKN2Zpg
1rCHKLrOTjG9bLHY7S13/q4rbkWsWt4iUrRqDX2PkFC3SUTL+jnIwqh5JqZon1uwVFBD1ey9Yki7
2D5BIDQC+yTBIf7RmfCPfKLCZz90AfDZhjYigO8YZQureRgO3hMau4QgHFYzAp5U8SKkicWLPKyV
ixcNuaSlC5oUmBwy0VSwBOSFG6Hcv/zRM0blzepdUc0z02Uv5YeC45DJX/CM5dJBrC4CZlpF7WUN
YyxgmG5nxrCFqpZlzMh/WnDJz2HlbSmhjcQwfGCwIob5bHl00DQGMlp+3zkIpisCZViVkDrsCafd
jj4BmoA+sd0B7hG0T+0zVYjgqR5i8rSofTbk1UAVr0VD1dq02CFVJ68aX5KOYzSWyBW/mIPK+32/
7/htjWJ1pOv+WK/YMV8vngO382q1os2FRmS2PpDysFmrhjjrIXn5cJ+rB4El3j3dBOLdM4xBL/fx
dv+IZST22wYob0OgjbANxN7NysmxuiesQdqz4kVgz2epTqkBw2HBKrb2bHDHj1c7C87qTyfCjcvT
O7BtBUNJ3uMNR0L1QdUzoLXnhnd1/zbwSb2lMLV/eOhYqlfzmHpL/5cP2Z7epfo6604mOkl1fcC0
erVesbOW3qzzihb21mSscWvN6sKSeNBHZlVFXK2/M8naOXt5N7sdu6YaiCqKG0+XpL455PTpHXwN
tHJOtDmTDQ5+3GptCcHStv2yH07XrQGskm1pLcxE+KwJ7VuWgOgIbWuA6OLf1qQqPg0c5EV0ECrK
U5lQG4LAVFIliRJ3yB1Pyf6NhmNTqnJ5yM/uxxzlkD8YKHOA0BcDaUNwQUqec6/lMDqH45Qchl9l
pm9+37OvCFc9VxgAsjXd2ocFykTuDHVYFXFnHhMrfBV/xA08qIX2BlQde2A/JmQ2Pv5ByM/nDeRR
/ogR8oZraPuSpwx85NOPgh6VfQLXHEwb9r8G4i1Qhy86U9lp4bNFcnNNVKPacmcWKMqd6ZY+iCCa
RD5aQBPlo7cjH+1Ba1NXErgQE/keUSjU+yXvmoGD3zH5iKJfkg9t8PggRK4/WHC0FC3OqpExhme7
3NWWVraF0srY9K19zhYH4Kfgy18oFPh94t7gUUA5V1Ujn1XgkuprQGY7YQM10D1/+EypyR0nznYZ
utGa5TvVOZ52SiALFZANy/e/3dXOJDVf7X1myvThbCXJU7lI8KZ9oXM9lBWbhnAQA3ASGaaLATDb
s0vgUx2BgVZDB3No0CRSVMlwO0kV4mShxnoDjGAm9etRqRuC08s3+/udR+7KIZwCD3rAqOhpAwdE
c7WKljLsPx3tJKHJFDFpbaPUZUYdsFNaxS1iLNHELOHHeixLdTsc0fY2UwdSxig0Bh2pzEoQO+Fk
T+sb1vE52bENshfetl2gQnWQXkj/T61rxVPDgNR5J6+RS1vv6BgO5oJc1g6FRvM+ArzQqLUHOTrx
A5QYLchRgscoLipyIPNwkLKiSo76H3zIEJAOmTGYC8rHAQ8ZJ3iwQ5YRPN4hq+LhAIdMHduXKPat
8hFz2u34EvsrS2rFE5mwLmcd38jcaGJPT+Ba0tNjgomsZc4j99acladQlR7Qmvlkm3a5TjcAgxT1
LpoyzmqIR8ubGn+6GBhHNgrKqa0mHMTdo72UY5nvLsowH/pfrhfNln9gBAEExoezQZSaA9rCamHa
cEXWqw114GrlxsR2Ga8JZzhwiNFVgp9Jvztr+XpXrBHCmPm8pZGIIjzIRV/AAseH0uVAhhZEXTOa
U7CLcMhC0RIg4ah3UTZTVbecI2nDwQ7QzlabWjReIEYbMvdyT/V3IuQKD3ciGGAqJ8I4ot0QN8zc
8Y0CONCv0Oh55F0heJdQ/ph+Yp1CP7QlWAdEYoXWfopstRe9haXcry70YTGh6++lztZz46wxa3fM
k/+k312v3IrWEZro7rf6g9PguGoY1IvIvQc9rSqkS67GADhBDWQt/YTtmUPzRy6l88+Q2c2otdL3
2agrN1rLv+CiOR3urOJXP3T60zrMtBAIR2qIqoqemsfdWdVWxZ0N/AoFG3VsNq3Dsbp9q2Yux2i3
by+sacDeOfudsMYAIDUNvgsQf+AFlkmpvcvX4MnPFCSQdnxH3d1xOtuq2v7ewuGA9HBUXKleqq5m
n2KX7VmJr0O22J7trMoB+2vPsk05lebaWdo8YWnqztroNNtqo/vQUxueUkNtiZm/bV1yXv+Dg1/d
zWI7n6iEmWUJ2W3AYs6JPzLKXAhYqravDv7H4tMIGSayihAzt6k7byuy2OF7dUl1Vf8zIK+wLZ+x
RpkRWlzbhg20nZ3RwVCwYym/ecO0ug12AhxSrzQNRdawLC4Fb1fL/5eqZbs5us6nCH/O/rDnb1vp
1VxJ4TyTZ54+KVmm8u1M06zBxo/AYMzpcQ6pVkzTqJbbBfM63xAxv1rHi3iDS+6oS7ZIBee7iTqq
VmTJAM+z97KPGMOUK8IdYzW7EJx7bxs60Yaj6PlM2FSCmM2GzWTtzstTYLnPZ83jpHSiOGFFetOs
uPPUimZnvn4BCvMfYqIf7xeASI2bdBHSksGOEwXkEY7CO2flBswdQ/l7zNl8XOJevqO7HAMhtUrr
nzy9H8Lb1ESMrQVkSH/fehFToS9GR9h28JFMi69td0FMhK4VSR8RWysychRkrczCUXC19UwcAFW7
S35aTC0EY/kaNJArzdTX4LMMjn18DYS1X1//8ykzWsk7tLh8elXndxB8AIEV6AwGlv8tJ6uq3SM4
hDL1ODABXet3KFz6IPBMZiIUBraq93HicXol0549FzWvgyHY9oFesu17Sl3jFN0d1Mw2juXv4Da+
cSSHR+ZhME7G41H4PIzJXR4V2MDTcHqMDlqcxu1RQo4c1/GxgxA5ei0OFYi1OHwEyrU4jAFTVBom
2bN7xKiThabYMMLVyw2Beheiyqww9B02Q8rm/uTEmyGpwqbrVqhXNkMadJOVHP/TXNdtzmu1nfWY
LS35Gs1xCpiUj0duijZUYmxsmyIgYjzLK4G0rIE3vgTu6RJ5rXWE/XZNTjR74N9u0kpzab27K+q6
CaNlUPfHV2cDPJBIRIaF3JUmh1Ot3nkT9+V6TNMrrJj991v2EImZKV4ISxgnyxp60e5BayYoFYUK
Nb+kV0ADDpy8ct9akJahPKfbAqXsU36ogT5d7+pdRP/ofas1IPatdge4/U6pKEvnLMRJi7KIU/J1
ZqHulWyYu1S7AFbNohxL6AVds06t0fyZhSZN/ZlY3xc7ZSkrd72J3LnirlbzO4WwpvjzONmusfJ/
EDnZpX8lhLfIV15E7s0yTsiPyUUaJnbpBrzlooA2pHgbEc7PuJuezIx6ieL13Wy1jkOiVb///fWM
V4Sk2M0oYH9NPwzwMsFvPuH13L175iasNZ304a/uMgpxsqlZoBxahjAyLXre/++lzzX59U83eElD
hzi46gG9tu73goBiRQLssgaNArNP/v43gcUMCNcrscA6lkecEz+oUzwneSS/+A790/GN1y/Ogfzj
lSwc1Ecu8nA6fnKZr+l85cZYj5yuC2+cz9NmKt64zpB04/DwYOOg6GD9NMHB+jGxwfpRocH6ySGD
9cmjZPA0Y2TwARi8j8n5i7u5ZQmFU+CBkSW0TtcCyOzTaBngL9Hyhl98NAyudc/cU/fBMfXgkpq+
L+99W+dRevJqUGgdiUJ7T3yevG7kjU18Mq+cP6KEfsTrPitJ5ukGQTbAWc3pqHcCIsELCPzQ2Bv8
1z+vkrHqlNbgGW1YSqMsnVIt2RA8XTLCPv4cJdhh0p52EHY2ckCDB3rEv83y6aUviGmZxXfGIPOD
/JUiibO8ObaAzvX0sGtRFG0sYwcCVfToQb3O2un6jqsKJRmx2slB5p4iI/k4SX5lPX8vVtj9SM4C
A6Y/u9vgpMZ1YRV5mjDATNORB0oNI9A1NDkj3G3c5KMTLcO4DTqKilZh0PI1qzNueKYctgTULIM4
HaIWDxxte3PVi+0uy1+u3t3u6gxUbjC5qLSYZPfp26oFDn7rkCbmICNmblbcOrOrya8prh8nhBNO
o5pqkWMVuIHVp/4Sg/k5UcISpnBztTwIfJdlPcSrFDpg2X2q5kqQwozkWXN63Cd3HbnLDX+HFjF1
LpO1rwhYSx9xvfV17Lvzit9yfELFR9l/KWKgxows8t5dS9dscTUQ0Pul5avyehDRdb8WQys8XK6l
Yr20GKAn6BbJy7GK79+KSMdDCw15RQyt54qUmkWlni72n8twHrubqzP2n11oUE0zPlDEK3xfiFfc
znQN9GZOqWSP3mrO3eOUvcctSDXCTBBoAjMGGMLMyJ3PhGgwCHRWIqvU+Axqg7h8Usq44oeKPPJf
uMHzGi9vNrc7tV2EkjOWDawPA2nzCopkUE72F7z51f2S6e/UM1GiW5Alwt70Pxx/YwRXHt0Zs2Jn
1GHnp8Qo347nRPnCHBrGPyBWzRpvifUQruOF49Nfd+BaFXIcQeAy347HxuNDsLTegVwLphuhh501
UbM+7aTtit9YEn2E5YUyzNzjq8cptLLu1+dK469rOjUJNwhbOi9SRgeYqXrfHBH4DTwOhfiljwML
CO3xOJQd0H9sK/y6HYsQnNhKqbagWIAASTqn3VPLmlXAKtexG/huknbyTXohKk/tUOVixTVcEFBh
mDY79OPtckPEChge1biPSqktKaUMljJYKd1ZjiW+ud9KqQ5DWe6YcL8wzikppfXsHUEpbQoZnVQ7
3pIOcaBmvBJAUu7FG0brZBPSkDLjwSFL8Lm1M6+Qiw59d0DNkW4s0UIE7bwUPihyooG/d06+s0ru
ltQHSJkJ1nEfHyD23I6bg8ZygiHDFl3Ppl8HJu0qe1Dmj0wdiExjfh0tos3FDd5s8LoZehHYENs9
giNIeXNd1EFgkb4LugEUgYi/YH9bTJxuAZ3Li53iCFktQtfUkQdVvx/iYZcBl3LwdBn8wyWirA8j
UJM4CXqiPKp4cSgvf8XzFY13EYG6nGXcrHHibzswpWUBTcqUa/Rr88OV3118McVfRH60KSFpdz+G
9OMR9jjzdNNJ+Hb/SbDuAnsyPfhcIHELPDSEe6GV7RrPMa0z1NLNFhV1mbFtwwAMIZq3owswD9+9
ItoXhRnX9qXLC1L5gWGqnjWMai1dYhEvl9v5nKwCj5+csa+R/yGC8vGPtWwV3fJsA/TjalwRoRui
iOhbxIBoDkyez37H4XNqdSSXpQ+eRZvk3eVZ6dNXS4o5D5Y4SX6ENFocxC+wv8YLvNxck0c//4MU
Sf4CUz2OfPVswPCVEfVsSZ4T7UzUbdKnwwW2FWAN9C+H5bBhs1tBDkypu/ou0fy9ADZysWUNyej5
85//3LzVRLN0A8XleUZKuuE6rWXzhP7L0/ziHBjkXx8GlrTaOZtKuhIfGsoJFcWEoOZ2BWuMVj3Y
NsSCPhDUFPTp7KeByi0x/BymuLCMCLrBLYFpobW7rVNIf48A6WGbxhykQcxoewuhLmEh/LrNtTpv
7ov/ef3ip+t375/96U8OE/bulphg/JBTBNjbTEkvGXAZG5rl69bB1wFBQ4xO1x1yU+28DgdHwB+2
PvYY2OOiWQeFHltVzYgM+9AHIS9myA5CHTjI7C7tyANHGPmI8epFtEga4QqwwBUHLsI95RxNy5rP
m9tYQAB1XXT9QTB41+nEah1+vIzrSTrRi5LIrqVaSHKEQtMe7hVuXBDxetBCsfdgpYTyo65lqrrk
IIX2Xr0WEqL94P/gAet1iitVuEddA5NlExbK0LX9HMnpSvEkis7LdaJBCOFEGViHQFyo0Zza7D9S
5znqR/57vjjnRNBu51dVhWPYOqVxotVGesjerqlfLfqEr1pqiLS8dRD5GvClZCs0NIM+XvHCzMoS
f670knP/tOtFhcYp6NKWYe6Tl8CaTn35T7zEada+s4mWd60dqFQho5+YE/6BdT1kWEBywoK9nLDj
dWmBEi7ZtrR9K6cq9EwrNLTCyvW6PoWaksNCXYK/0KR8hlndViuMuUQLdSNgsbF90vrHWyUbiqvk
22CvVaKcTYYjzeXT5DjSypjsd4sjVb6VkP0YONLa5fhucaSd1Idjhezb2TtgyF65HyF75Sgh+37x
8QOE7PuyNGHIXpk6ZK8bwFC4mHHI1UK2lXnmdN2mu++uyQT/4LNpnaQwR9eHeVTjER8sX7/O46mG
MKInrBprZMfGdD7H649/sMmu8Wa7Xvap62+HOY9Q7ztZ8Wz5GV5aRwjm66naFoKZ9qtDIkhGW09o
WuOu5ywdc6z1pJiK/gyiouEFYRD7QNxwJPSOoFyy9hX0B7x2SuPvxn4MyypaaRgm1MSR5bGF5his
SUfDqLDowwNUwygirEVzt2JcHtBgbT8WyU3jqFrBa+DpfnlUqZ9IFidxfLIEm0ZuC5MVqBDZYHdc
2lzNiZM0suxwazQLOje1CUFCbI1CsStGplz7NDE55bQ9qF6Erw3V3F3coqQpC5CwsSl2nnH7KvwN
4wAHZ12i4xYMgtFW2TTEVXYr2N7p+Uzh9F2aPmtC02ehH40GxxFe0FblxwDlwguN+BjQwcZ+DNiY
YwkvE42znkDVxPW0rMwK1WzdHG09yWDG2I8BH3O8xwCO/RjACR8DONFjAIc8BsKlp4+BbVWJqWLc
ubvEzmqb3DYxahVDQmL8FefeHOncQ1uWI6A498aY516b4Nxr360SNM25/yo3/eIDB2s3WnbTJ1TD
tMAojIrNxAyUT95Qxzr1uqz6o/zUq2OeelUf/9TTMR+k/fGl/RFVf2Uy1V/pr/oX1aqp6l+lm9cG
z9riZtDK9f4Qe25RwcO0R5ED7I2TXr/MBaBZmj2eHKCDjaxF8zFHc6kAc6QF1UpmiZ4vqK6OuKBk
sNEXlI451oLaYKT1RPJ65jE+zbRHPKCmPb5ZwsYc76FSx36o1Hvno/o6iVnylVWhKGG0mad8u2pa
AWFUiMPyM/V1kke1Qj3NH9Y19j81rYJRjKxagZavAkTaOHfVVC1Z9mWhHE03rfHuqk5Mv7HvKhvz
Qak8AaVSvquqVulC+BRv/VtaLYRpaM7naJOSSH/RuBgF17aHCg3AGOnFMsySQyEDMLDfjHMLUjIj
3oKc9ZFugW3oJVmg0JYYfDdYb3MH2jPa3/yC5izii3Ucby5o3eyfWMqG61PY3U9/xAkh78dLf7te
k6P5Y6ZeGPpoS0nHGnBdVem6yukLbEjpwub3FHV0diEDolKulU0keDEqXbD0rWrzUJhAEAC6G5Qi
uo/YyJcBDrY0z5JivJzkbuHF86um96QYU3MDY2fMMr9pOXSfmjjbTdMqGIIE0Mpd3B9VLAXLenWi
5afm/vBIkFjIRKFWNXJ57JimNLYzLVqWhqGC6qEnXROlZWXUJvZVgYAFXa2eQPMcUOdJ+FYTDU5l
c7tdfmTYxb/gxHdX0fJG+QulhLFzs3XXLhEVxOA/+8t2GX+myJNXNJvxJ9oZtC3NM9swmt1n46YV
LdjZzbIWGByHrexWcbYsrY0tzlhlt6S//+137Mfr4HcidZ4xKlT+nOEvK7zeJLzyL6tcOvOpf2M+
Z92QaEySlm6vxtGioqBnAHyLp0yVyaT5Y2or63Wr2tQKKiPHSpFd+DzTZu7eEZbX5PyR2dQk+QiM
WwxW1wXbWleHwlZNaeJv5+5SXN5Zchtv5wGtKB4tt3WoZCHviKYdaqXVZIOmHZvsTmzNiN1Ny7e+
w8skXr+M6LtKmXJmcRgmeDNjdZA6MWcAYas9DtWSBk6z1UqF2uo5+8p4E+vq0jLxF87veLXGCREh
7PhdUF3u/TJxQ/zrlpXdZke0sd+VUGCDvGGsk80+e8tryVFmV1WaQJP6Y+jgQ0cayBxnn3RD2idT
23+fCGs720QRiGecq2rkYZ5gFZg9WsI17wGiRhklf72J1+4N5lzMWU3IjI2XhCfex01qcGxhrKLQ
sz70IMcJUh9tmtowd6nBcru9ae1YqOXGNXXUanpPuoSyoVDCCb6hCf8OazOR+rV99sa0eYqRUbiK
iXGPe3NAPQR89jIT/hy7625MFJUlCAuqO4AFthALN/gUJbgPSND2QF9icL8F14QmlYGmB70nm8Uw
tsvQjdYOg4rW40V3ADbQLOyPwFR90J8+x2ZuGVHaMgn1KCdu+3bnGasjSTrVECWdbtVJOrW7pJMH
+ITXUXj3funfusubAo5Vk8hNuUBunbxVYWcuyM1TQqq09Vh/F1k9ThwcME9VmqdZ9/6rXQU6HOcU
QPG193QA6viyeqyO+Nw5zu/u5xcRa3Xrru+ypyeMlkGDFqIV7S+10NK0vd+/kZbLEHVMzwjrlqvU
wartMJVV/ueCBUGU8mXGVENJMiAo5DvFlCdfF1NSb83aY6QZHflSBl2ysYUJF+rTCROk7m/2qKIt
Bu3QH8HsIXxVWhPEpsTLgDoQN+Sz5E1YrTYaSFAbLa27MqHklHmBpes5bVDWkSrKFoJS1YFpfeix
y0gt6cZrzHoL8V4k0XJGDalZd1050P0+5DkD/XHBRSgCBrbaVT8f4dRJ7wbMMm2rT11XWYiqDx39
ef0JP3dXrh9t7oono3TocnWZrL9h+n6f97zCLvJTetXUoCFQU3dqMDbrJ/DwZtGTo6roT46qoD85
qHo+7DhplnicUI/3e687oyLpzvQQ1GlhPn6A3jDgWGPdu8zaoDXoNE/rJZzzIoCcJD0wLF2SZrkG
cp5kqfVhVSfExvp8esGm5fU443l2Z1rFgXDWEZRmCVZ+CLq4qLNqAPsqDqL3mUx4XyfTd1es8VFz
mubIZRoftaaFijLHyQiSu768If+gK1YpeYD4kFk66EO1+k0JaSOPTk+KJXrZdM32+xHPQaAy/WTl
Lgmp9UfGSaurTyimEuhe2JuHnIs19udutOhBOtdYCWk1CEF/0tkO7NBmbysO2lkQZq/ahjWEhbxm
46eCkc36zsHLjQAeqatMaQu1IkNo+sM4yHlwvSSebzfYof3J24hDILg9fVhOzoYDAQIWEAACHtrJ
Pme39dX126fvnv/V+f3Nm3fO397//P5n5/mb3979/NuLn184/3j66p3jNEV/IRJo+HpFyj0Rx3cJ
DemlWAkqkcgYveppuumZtCAoAUdHBaDQ4ccCoNCxRgagsCFHB6DIo44HQOEjjwtA2eV3JLBF1dDj
AFCqxx4FgHKQNWlbmT0AKN3nMByAUkXlaACUanaODkCpZAzY9wGAUl0wjTJ/ygCUurp8pg2PCUCp
Y2ummMQgPSYApZ6zr4y3EwKgNLGqMGb3B6DU00D2UQEoTZMnrB0KgNK8B8gaGYDSTI5J30k8rW10
2VQnBaC0c6Dks58IgNKFBcbEGACUZmKw97nK/Hz8XPVb3V16nNRFIkRnZXqW4GRByPD7keMEvf/g
ddzuKDfEkBAwta6ktKNGgpuWQDtYJLh5I7QRIsH1FMaKxENDWn9/BMkNFaKJMR+qwtoTxXdKHCqc
2d9x2AzgwKYdQG2U9wPm5KlW2UzfEugbpj8K/SLq4X/67GS8NHh0Qe7QNWEIwYGPwkCEVz1fhwRl
NHExDiijtg/EUUEZDadiUlBG465PBspo2eWpQRnN5DkDQ0AZ53kbkgyYcZ7/7Hd8kdHxInwNVs5D
O7bsfKCDNGIrTiOaKMLXegemjPC1Ef96gAhfOw+TRfi6kJ44wteNhSkjfF05mCTCN+3p123x5Kn2
4UT/cHxek/CfEJ/XImpHxue1itrDeo0OkULTSdROhs/rKGRHw+dNvNY6EF1jeqj1o14DXKFJEY5L
/z9/17tKmVyzp8z4KujLTCuOJqEkdwV9mRGkCY+9ATWrPyPVT+02wUHH507UNwy3r77RjGfhcbXW
584AwnOHQmsYCwd97kaIfulAjH65aU+oyheno8NBKacSPaXNN55twxCvLxzaZGW7wE+XwXNWtuY3
/PnMY797lbxfRn8QPhfkoVhsF9nLNCPH+vPLeP2Uma41MbyiySd5pQKwb/DpO4RFNi3FofpXP9oV
KF3UdbVoIR9iH5k9Ke0Ud0/wpsPLaYi+AthFfMODIQSgISaW+VojQqBLuzeoyL1UqFRvr7MkYLNc
DaZCzbTMUnHIUTFpdPixMGl0rJExaWzI0TFp8qhjYtLoyONj0mR+R8VfyUOPi0mTxx4ZkzbhmrSt
zGiYtKY5jIdJo1ROCJNG2TlJTBpl7J5i0upW9bQxaYxvQz01TBpXeMyxsE4jYtI4ZzPG24lj0jJW
FcbsNJg0ToNc9FPDpGWTJ6wdE5NW7MHoRZGayX2drChSG1021YNj0mQOipJQB8SklVlgTEyFSSuI
HQKTVlA7CCZNJDcxJi0VYEctctMov/oVubl1k9u/u/NaBnPfGa1340FtHNGmOIQE0Wefk4HcNX5F
jd6lS5UZZ0Z1CJ9GjmfNvh4zT4j2NcNytX6nhLBwzVjgGeIXyS3hI3j/7qUllbKppo0Kt48eYn3I
AX3+kpP/BW+e85/ebtbZOnDalKZ8MdTC7ETQxxD0J8y6Ei6Sm2u8DGo7neT2nE8edQuBA9+KEZGa
xa04JjxMPPnTwMM4hdOD52Uzhyey/vA+rP/AWl7dwyiDa3lJsC2ru74/2L8KJf8q6LgTCJwaUDKV
j+DQQMkcuAEOCZQsNp3QPTxQUox+UAbGrl5V93/qqaFj+EKoh0bHFGihQ6BjRBjQge3XDAR0aHTM
DijooOiYMi4ATYyOKd6wsatX1YcC97/IhuTeNJqej27OqSM/4pyBF//z+sVP1+/eP/vTn+pec3kH
Mr9MaJhI91IjzdRL8VE4bnxUHzE+qo8fH9UniY/qk8VH9Unio/p08VF9wvioPmV8VJ86PqpPHx/V
DxIf1U8rPqqfanxUv8/xUf2exke1U42PQv1046NQuy/x0a+M2Snjo7MSwPRkFwMZpxvINU4lkKsf
OpCrHy2Qq59AIFc/hUCu/hDIvReBXHiygdwxupXkGGnWrUQfJ3oLFR6wvKCxY0JzEzdHalGGXXeB
awVu0PvU/ZXQwesLwrcXLfGZdycoctUktSI4bKsocA8dwRk9gqmcRARtygIX9P/s0wzb2MeK2tjH
CdrYR47Z2PcqZDNmLYssYPPdp2Vlx0E9SFJWcfjUA9aykDPx9snmN6Q6EqrX877NarJs03+xbFvO
TOzOceK32hGFnkn5sf3e/LTm/dK821ZjQhOyj03VA/25qE/6bbdkBCtCDV1/CPEj5BxXMXHwrONq
Jg6WdzzexRxQZKbLxZy6yEzNZTxEkZmqG3jgIjPV9/CQRWYaL+E9Ov0mEk9/VysMnSKMRpm2oVX9
/81GbmjVROmEGlo1s0kZbQ5J14kDyxI8nAh2pgqPAaJSBqJehoGoJI3jUL5jpUHSTFv2pnLaxyp7
04mdQ5S9qWXlsCroLhMHV0BrmRjjATaJkJYQUGBcBBQZfjQEFBlrbAQUHXJ8BJQ06qgIKDLyBAgo
id9xEVDS0CMjoKSxx0ZATbcmbSszHgKqYQ4jIqAIlVNCQBF2ThMBRRi7vwioylW9BwgoaJ0mAsqw
0MkioAwL3h8EFGX2HiKgVE3YNuwH/kgR8VLUIEVG3NQiI0BuoGm2pnZGK6joZOFWKjoRuJUKDwy3
UuGx4FYqODbc6gnl4bhwqyd8IaaHW309mptCxJadgKNChrod1VUhs3K0eJnMxJHiZWUmDhwxeEAk
nlRpmYciGsct4nB8ROhRSvvAUmmfl26yoVV1SqV9vHhz+9vL5y0oTkuo8ONi/76XQfk+QJwsx+gE
UZyEryPBODPKh8ZxQv3IQE6oHQ7J+agqR12iWQqSoiIzHXoGOBg2YXy86EPvs/wEoAPjRdHR8KJ5
6wAnb4HaYtyYoLBuQs1UrXsEUVVODKLawfA9AERVOSZE9cgm9wkgBB5NixE4RJWa08PJPSClHpBS
D0ipB6RUjpQiRyRDSqm2xQyiMZFStN77WEgpMtbYSCk65PhIKWnUUZFSZOQJkFISv+MipaShR0ZK
SWOPjZSabk3aVmY8pFTDHEZEShEqp4SUIuycJlIK6fcVKfWIMX/fkFLUfjCBcWpIKV7b0zBOr5cO
5+wr4+3EkVIZqwpjdhqkFKehqieHCcomT1g7Jiao2AMVHQATVJBjj8KBO3XnUBh4eEyQzMGjHBF1
QExQmQW2EFNhgmRix+rY/TX/1kn07P4qfGsco1wV7gIxyn1tCCtHSCCuYuLQKcTVPBy0dfcsRcxN
DwkqqB0EEiSSmxgSlBW2PzVAQ7YEx4UEFRvRERIEzmVIAzjvBW8YdTdGBGgVnQiOvxvKhAAtBqYw
Tg1ewud9eHhJdvoPCy8RJPsx4CWSqNcPAy9JN5ivcrqyNeErDQqPlx8EHWd0YrCSTM5997CSQrAe
AlYitXQ5GKxEbOUiwkq626wCrES3uyunY8BKBhRYEokrRyqwJPNw0AJLZdJHs4+6hC2ntY6OhN14
dIrYjUfHwW48Oih249ExsBuPjordeHRK2I1Hk2A3VEtyE3WpJKUeLNCl6oLNTUNdTYEu7lk3ARRr
w1iWPS7igQw/GuKBjDU24oEOOT7iAYBJEA+P2MjjIh4e7fA7UnT/UcVSjIN4eFS5zKMgHgqZMeGa
KC0rswfiQZZ5TXMYjngoy1VK5WiIh11ULGXn6IiHKrAuZeweIB4eVcM1Klf1dBAPj2reXsMEx0Q8
1LE1UwzVOirioZ6zr4y3E0I8NLGqMGb3RzzU00DHRTw0TR4dDvHQvAdIHRnx0EyOE5zCpGqjyyhP
inho56CY/USIhy4sMCbGQDw0SMijxiEb5ePBIl8tom+EyFc9BfWokcd6vpQyZ0dZf27YT7f+6KiR
x4bn0Jgy8ti03hnl8SOPzbuMpo48NpPnHRaHRB7Pi/hMGn08z3/2ey0B3HcFgDB/3+o4/yPGKRvO
//cVp2y8kKPHKVsu4kRxymaqlO6EuehtxNm0R81FB+BcF53Yum1r53lAEWrd+DtqTKl+0SaNKTXt
1ZCYkmaJMSXkH2zldSA6NFwf1K98R7VYKdeLerpeu3fPtmGI1xfkbC6T7QI/XQbPCQsb/Bv+fOax
371K3i+jPwifC7Jgi+0i26EZOeafX8brp+yBr3HLaHnDUbJbAdjXn5DO4kG8CxGzAwl4gSI7uTfb
eJuwI9RB2Nd0fEEiI+U4HRwWoIFFzjJAupW5LXTNkhssjJs2TIcfK4hGxxo5iMaGHD2IJo86Ztow
HXn8tGGZ31FTZOWhx00blsceOW14wjVpW5nR0oab5jBe2jClckJpw5Sdk0wbpozd2wYL1at6+g0W
qAv1JBss6NA42QYLlLd70mBBYcxO2WCBlek8zVYChLXTaCWwk+EwbSsBTvDwrQRSykdsJaBIsz9K
KwGBiWlbCaATrU78vdT3fqivftz1P9X66srJ11fPHEDHra8OwWnW97aPU957lhE+ZHVvekvtoxX3
5s+lfcja3lDJqxynnmslDis3vDLFPw92em7odm36DE+x1jd8SMosxPVha33Do9X6PnCGZGWq1IEz
JHczpw6WIVmVNnXgDMnqZKlDZkhWh4Yeqls/VLc+6erWmmmIGZKBNaC6dZw422XoRmt2v/n/kIP1
uV27gWYRkwtM1R9WztrZMpKf3UiIZrTbYLZvZ7FPobk8K5kMx419jthcXh+/ubw+SXN5fbLm8vok
zeX16Rqp6xM2l9enbC6vT91cXp++ubx+kOby+mk1l9dPtbm8fp+by+v3tLm8jtCJxj6BebqxT2Dc
n+bylNn711xeDIRic4TW8szTeqIhWnAqIVpw6BAtOFqIFpxAiBacQogW3I8Q7UOI8HtvwVz9Tohx
QUv3R+q7/Fc3uaXIfkKdsXfW7HfPsdhE2yVq2X3vrTw7id7KfCfuwdUwRPXXM8Ja0aT36m1dtkae
C8YNsReWGVMXN0I57nIKiaCX94yVQCVzJS2INfKFue5anUmGJjintK5OUqieaJdr9WhdrtUjdblW
j93lWj1cJPwhKvIQFXno+TlO3UgoxooMCNI90YAtZ45lVrFqqyPFPR6xsfrHPVShgYTvhUUolfW7
oUOyeMcfTNlY4812vezjQbGL6DjsHeIB4lSztVRVlK3l5WI730SrOb7aCUaZiAejfsUbd37xPF4s
yKliv8q+R6gTSULU7iwGRQceKwZFxxoQg7KlGJQc62NDSjGoeRyv5GBUU8wICTmNhqmW7qs8ejkW
5QQ4xOs1JnOZ3zbGkMSAF1Z3hIJMhrwKuD3Mo9pCLMb3UIVwrRiW721rKE0VAz0etiuFqDx8Em/X
fge+LU1YjHrff+Xgcx7tIYKQesQ7Lg7yYL1ypapiMqzPn3P2gDmreNVAQS+AHgBasD7M86hMY+xg
GJNIyFB++pfz67vX4p1WnGTrLaLN009uNKd+1fSXPDM9+cCJM1nAppTphrZtGciEjRRnKc1Xb355
+54NIVHmhGV6qdGUkmV/KFqGHrJM1cZWM1U6V1RP1+lBWM2cdIyyV4/VySh/VZCp878XiV5XkCyR
ykPehJTlNTS9Lkg9YcSi+GO0oa2t19nB2azdVTb6f0cbQd7aUNd8F4P2sbVhs0DCVpFZuKDLLBgt
oicvsb95Tg492bPbOCjNIFcQyBxUENQHBMWRFTp2FNNbSwcnBkHFyHom4NnIYdhxZDY2Q2Atkhvk
MLDG0m1t620K6C+su52JlcgVe9xJnfB8tQMlOGjPM+OJbTnAnQ4uVJ6//AVv3t2t8KsXfDzqEisZ
BzlUOEAoRIbVba2oGfL8pfPq2nnz7P99Xjt4If9VPbSwP9XyqEC62H7rldDGkV2iQDFV12+dIKf8
9Jd//gLNf750F9H8TiKkhNF8Ln3ydH1DqRcMZkyQQRjzdCTKS7bWZLGJcoa0dlZo9biKZejNSSGZ
bOERIXqc1YWHJ7S60DOGAPPj1V35wnn0N4lgWOaqok8UIoy1bjRojIO99oyIc4vnK7KtDv7ir9oo
WgJBW7WtrgR5tSiBHB/ZwZajolgDcWn1NOEdRFagdaejFEsYe/+mQthNKBy9bWYw157oWoa+1Yck
JUqo+Q6xu0Q1ln528VRQ0XIagaHaWsdpwT5noiglRaYR2B1J5Gb1l//ERCdflLD0Nehywath650W
DI58yQRZRy4ZAl14UPotKNTFg9HQ1auir09/z2BxpalrUAeN+6ftr2Fr2U1jGrbRduypnvvbdYqJ
YAWBlNTj+oZdtuTV8ncacmF+1/Sjl+t4wb46W7Nffah7ItXCvkC+BcMWXr4ybhznt2s2+q/tnMgv
1y4DAlQeGdBvMzd470mJhWhJ9OKNTM7dvFoG+EsDWUM7pwXdc9II6mltSPKzClpOHJx0T5Am7AkC
rUsClRf/8/rFT9fv3j/705+KJI0KhSjXhzTgGRY44iSFLAV68FDjwYP7XzooXTrdbtzg3cjWdtkp
tqULPirXrldABrobila91N2QN7SFxETs4PXTS14/8i1Ks9nxR8cey/FHxxrZ8ceGnMzxJ48+meNP
JjOa469i2DEdf0O41gRUOuHaqHlqJ+Z8lwQzutu5L9JNgAq8pgTuA8yAk0HlWSySmw4zsYRzH2K7
MUD1qERG9l1qnZ2XodVMJZ2Ow1TN3+JNFNL8jExCXeONLM+4NSNONddRDUFFDczmFuOpvDdSy3+H
bkZUfGdSySl+d8fXlwFuGA+G3oGHGdN7K146X3zZXkRBygGeMcH8LlpgqrKnTLF/ErEUr2c7b2D2
5rI3MIRWF56IeqGiBhMiKPj5B9EDrnOW8DLY5aUwI5BgbkLUHJUseKE6jC6v0SA+8jUxRHe3iiyt
Kx/kVkBNIWxkB+R1lGyeMlh/iYKoeLSkQMsEKOxXz+ymNOm6zXRCqmA62dAHfch9ZanT3E9Bb3Oc
4F6uily6M1dF6Pej/USx7ZIfIWWiddKSveiHVl/Cj2hp/WQTzGaOE26XDGCY/Xy5mH+ZkQu2xrPZ
gm7qbJaevJ+XfkzTR5jBHG3O2ADZn19+iqNAOfvx6sfZ7E8OOFf4v8mByf+en9zHP17NZv/LaZ3V
VDXIAIw2CjUGYMyoXNzOoK73nu2Mwr5GmRdhnfzvWU22glUwbmOLMh7gTxSo5K9WMx3BAYx/payn
W5XculT9Wm3WDl4wy6Ris37+RF6rV+TXV/RPiI79H7yO0z+t5ltgW/VDtt4FJbriljaIcYWyzmXX
NRuPsaakVQ12JFMurF2ibYABZzpvFcTdzdfbdUiWqJ50/hWZvAVDZGvDyTMGmG6yiokdsYgDIszC
pC20oQEhjV3V/X0YYCykFNYr39nlpne0xQ3BEI7Q9NfOkG6dOsqto16XDvLxZrWdzfAnd34mfOhS
f8APshhslXlCNSdyCRHLXtlb6CniPJqFB2N6NqNYt85yQ8/lNFQhLa0yitzIK0HsnBsmKp5yMBhR
bWbU9SMtfPEr/tRUcp054MhCgwB7FJ6Y/yE7MdCGg9l+IjPO2WDpjJfsJeQfkBVeY//On2NnExP1
g/z6TPj14+oTYoCCcQxYp19eUZ+PQBZ88CFhtcnoMWHen9mMu38EhL//5MkFrDR0MALqIFld+IYG
uZ5MyfVkDRCXtJfe/lcc7qPpyLde90e59cW87s+Vh2iy+65K9920du+7ZQ3i+SvlWrw1fe4MBB8G
EmWL5ch3JozWySaMNg3FRHbcjAU/5AJZeA9+2jmitUba/ahCogSxa/x9GOIsOavkbkl9RJSlKh4a
8/mCgRzAe/l2mRO+W+dELJxfXFzI79d5/jNivx3xPUNTTUZoQEMZ18d8hJ9kj7BDlHOMHc+d0/Qm
xw03ZHge9vuX60Wz5R8YQSJBjA+X4veXRJsmf5Rgpjs/vnp8ddb463Ol8dfVOdbZ7HVdV1nJUf7n
M2Ra3/C0NWnezMTI5m0NvXCTKYriEQ1CW6s4onCPvYpXNH80XitL/Pksr8M4j5c30tNHdqwyTmgZ
Jh6sL9agSJxNtLxrTccwCjBJCEKsfTi1jRO1QbJzgVWxc+q+Gn4nh1/5tZL/fbb7By+YwZ0bvdKx
UOSZk6XJjtDZj9KvfvihcllEiat7oKQim/0VTgT38H3iZeBg+o9oeXM2rq8Tu0AbwwCwlUHTaPKx
SJ5Nw9BkH4tmDvNs2lKc5SXhB++46CrQegHQB7vnCpLvXjcSFLHrvov2cMdZY0LB28nRR3o0fHgX
cnSG04HGu3Eg8zAikrydPOywvVn2D99dMMjWmuBWQ0u61ixLf4RrbR36WpPTdNhrTf9rHu5acwyw
eahrnUGOzaNd6wL0bB7jWj8RQMQt5wkKcX1yoHQwlGKu2HapOl3UWcI+hANDZRzvyIGMShpu/1CL
KwcFrNzT/UEk4fgSTHCIEAFmj6SX9NgJIdmcbMWwAzfBuuTHki+M6x98YVQdCSuDzMHx3BLGPcGb
LoWSDQHiDjVwKtuSV+zi53WEbYHa8aMYSDvXkeTgU309sM7zn22QOvj2tG30o89VN8Q52qPYa2oP
cQPOoSH4UrnYQf55/rPns6UedN67dTwAgh/FC1R/IK2DChKeQunR+Fa79BDTY4A6QHacwJUUnIDk
nGLrwOdUJQfVsMoHFaU5J/Rn1df2OKiHPzy93yAExApM0BhwjtCBJ4qGPLUWDe9IU9W08+Jnf9Jp
Q2Sd24akDtvFGdOCActQk11U4dWGolfbGxIuhNNF6iEAYqjeHCFU32Nf6N23i3TX9L7n+9IfKlu/
K3U5laiAyLpef88CHAbNNSVkrjaELE+b3iabeFFCJbcRFzOnNbsvFHogFtmQsoH7+ba0vmhvHYlo
76DnFNMM6gCTa7L1N6+WyYaGGmtt3qKYcGCYLTX0qi9MJT1nGS+XW7LJ5K6yQq9n7Gt83R//WMsO
LGYf2Abs72ugD5lAajZLogCzdEdeYvmF0G/srJ4PW0gxN/X+6K+04R4ZlQaOlgn+1V09oyFY+aPL
F1Fys40SHLzdrC8FvlmLvs1VKcx0rpy5ZGHvFvE2UZbuAicrCu1lPeRYliwZkrXTfLtd32A66fMS
D6+WYdxG9Cr7I7pw0bz447dutO7JMR3s25/jbEYL+Z21/Bn/zw/1h67I8whs1+rvaMkyax+O3fdy
7F7H8cft6tnW/4g3L+PWEa46HtExuXzccOAhEg98f4DrSQj7lAV/7iYJhUSw9+5V+BvGQaG4VlAt
VPrAghgOo9r5nVcN6Z3v+a4qg2eJNGGWQb9wTW/VyQCS6mT1VZ0OZ4oezlUDhxm8srHbW83utIiG
4GTzw/5EulvQsvXcaw370NENMVRi9pEkZpe8Ux1Jeac97RCaV80zm3M/GWtXxa4R7U2164UjdnmQ
5+AGfyWfz/G6Moup0oMnazz1cBtfN2mYoJwAfHG7Ws2QZfY6F+pBgU9lmJf8jRq0lyqA4BD2PH9f
vFeeAHXrJrcOewAvxU8+UcXF2dytOASUb8vjc+W369mM5w7St5xNgEWCr64YuI/WWjoTx2F/50Qb
PmeJBAWZ7kmTLzVFt1bjcsG5LWbNqiiLvpCfVY7TLeY/g3ZvCCj8HpYxjxvyhWNZeOWFU3tK4pO/
cSIICNNKqntcOHRiglSIgng+A9SOIEfhyU6SPBbaKI9Ft0oPYnkN3EdzUPrEkmBlLIloKsNjSUpX
NcwU1bAAdjbCtDFrdpg5fJDW7FD7pMZreXIlOT+B461jN/DdpD0Zy7DF9DCigvZZXK1IvfI/MZqt
sK1zIfs9JGbmefFz91IpYy66nuXH8UIpqE+hFDFW8fKtxE4uAcq1anLt1UVWDxzRuHMWa7eoqI+D
GVKB8W7t+vjnJX0pd+ZXrKYZ6pbf764K6/nqzVPfx/NXS14z+K2bNUfJSQFhJVF3p/2oK2mqUpmd
rvEupE1QeUiTKg91tVcVBSGlhpW0G07qQSpXthcKQYW6YXUl94jegWaCv+PcQs/J6Ugk1zUIm7Z0
o3tOtpyMy1ot0IcuQ0I+nc/TGo9PlwEjXN5jWxQQumb1ofyV0h7ge9Ak3wPsN1vupVokN9fkxPyp
dp6lBS5Oj4f1rmnC9Gd7wG5CJJQyCw2k9ZmgqThRfLPaNlBkU36+Xa/xcpPtenLWzGcWkSvKrQkX
KjQD0G/jTWFZ3sYxEZUZI7+Lnrzi/gon3FI1rPUjl0OoXS+J59sNsZeIrGh7j4VypUT3gaDXQUMH
2gfNOjcscSs4xCDdlj6CZ8hJBSJpA/bYFqUDQbZAPKvu+paKh3IJflHsmVov6jJ9gUj1AYSiRLct
uyct5h5PnO0ydKM1LwdQU+JjV9wVAJvAsLpftGEPlyo9XFpnajI9YTnfrwJ3g9+to8Vr/AnPy6dX
O5eeZtsE4Dz/2e+0ymjS8omi2YHCrkDPyjLK1M3Dn5mGEsmoKJFsBrrRT+8Xa3QX1PKazfWVsUFR
fdowkdFZM1XKdFkktJaO0PfDx+7UawmEldS6PdrD962o0kz3zexW+pOYiAbar1J/U0lUsbmD4YKj
sHRBX+5arswuyVH2yFVaNbFSrGF0EjLWYUpyWgcvxKkoenN3GDnnq9wBRssMAHLwQ2CCzg/GE0a3
1syrTjTLe9gyMw64VndqvPFMhW1bU4jRFA0b1+9F6VFOi4sNaqm+dj3y+tVREx4ZGACtHzHmyONt
UeJ4I73rFfF2E4lxfrM3rVkdsmAoos80REAfGMBQCj6ggE3/y5cXKV+0LcFzikaQ+DgXYArdmDLC
wLaGMEXZmjP8Dc+LfbVk7BAT83XsBqxcRn0HG2GXQl/XhtGnHLCqGc4NpuVQ66EmAshT930w4ABO
jIyQD+ABvQYDpqiLjYh9VetFC/YSU5JX3HV7LiYUuyk5X6juWXdALKGjUuekakWEYKU+l+stedFQ
p9ZNuqt3nhDc5xXLO+KwV8zovmFUXWJyMO7YcEs0WZHd5xTmeyXrH03rpwG1x0zETep0DnSrm8kN
DwFwVw4CeFP2ALoJ9CyIu2hKaGTF15TaE3QpxMBP+Ks3NOuGk8asGUqp5kKOq7OhrpsaAl1G/jpx
567esyhaJdBZqM1V+9VBPTh0IPXgcFta1KtK0YimdHcqGm/oQhMRDXqtDejF/h7lRJeWPkSa2lya
MvPMdI9vA01ExuntHet5feqJvbrp2YmTLCEo3YbdUiAV/VaKrYYqzjwC0IRZ3yaddb5XlXLTJmjz
pk3uilzqC6rTX9A2wD8xmq6/iT7hn/6I6e3246XP/cdF6yY4YusmOKR1kyq1bpKlDBtSat2Ud2xC
TUdb6qYEy/JFHrXcsqmpFVRxFgDS3d3AGR35koj17WpOhSoOnORu4cXzq8bWT/mYmhsYlU2aJmsL
Lg9NT9Bdu1RCQocmZKKwtkOTOHZMTb52psXORoZRf60nXJO2lVEbOzMJBCzY7K5qmgPqPAm/5VGg
VDa32+VHhrb6C058dxUtb5S/UEqYmHpbd+0SUYED5ewv22X8mWZavCIiQvnpShH0k+RzFObtlXY3
zDV1ZGOvVQ5TdlZE4EREGLJVZWwJDI7DVnarOFtW6+PGGfPncbJdY+X/UEweFYybyFf+/rffsR+v
g9+J1HnGqFD5c4a/EPV9k8xWEfbxs7sNTmY+VSDnc6ZNUU2PIhKrS+JmIVuggwD4DDO5S4ZNbWao
razXrao8HflfGTnmV7igi37mzObuHWF5Tc4fmU1N3RKBcUunKNn/e0lDI9GcPDk3eEnBlDi4moEO
XNOeWkia+Nu5uxSXd5bcxtt58Jz3P8Q1q5mjMQlT0MZaaTXZoHwxVbsTW8TU1XUyxju8TOL1y4i+
q5QpZxaHYYI3aQvRLswZQNhqj5evkQbmjEFN68jZjPGWrLAfcb+ZQvXUC+d3vFrjhIgQdvwuaMPN
98vEDXEanmBH9PLpFZlETfkLW9hbHLDs9332Ni0DQZhdVWkCDVXIiK0IPnSkMdI25T4Yvk2mtv82
VWxStIw2Z5ypalhxXuooMJHJxML+O6ATY4ZSTwO5nIk5Xt5sbjMuyuG9bC8wVlHoWR96UGP0qBqf
lhmeu+sb7Nxub1p1ek10g3ma3pMsJUzpJvhmQR/SGyLGVg5nwmfPSytmViiKEWgW7s1APneZB5Y6
2I2HInuecKC6AzigPCzc4FOU4F6V+73ONw6OdOPyJhPsxulW3Y1TuwtGeYBPeB2Fd++X/i0NZ9fU
/DAFoecht+7eq7CPzFNCqjt0X38Ku7QOvP6m9DDRUFzN+hsd+VJOYv2Vidff3F9fUUUlCtqhP4K+
YlZrAUQXxMuAGv4b8lnyJqyW+AYSJL6ldZcFSkb41XIeLfH1nJbl60g0j85SojowrQ89ttgsPWpp
13Gm5BBSrN/4rPsjF+h+H+qMfn9fpFTySe36rsIRTpxob0AX7K9YQIUfUFrO4DmVOcll6YNn0SZ5
d3lW+pSfk2CJk+RHSNPZgvgF9teYPpfX8/hz/gdv8Zou3gtM1RXy1bMBwwulAyJqOUo2IwXlVHQ6
cIFtBVjrcQOIEc8GzJ19QSmkXkEuU3UINeRiq9fRh6Wj72QEWVkC8g+6YlVHPq+kSY+8aumg35GH
FeoV9dV202wsUbnSNbvnfcsDqjJ9YvYvCan1x25eYyFDPNC9sDcPORdr7M/daNGDdFGaIgzUIAT9
SWc7sEObAURx0M6CMHvVNqwhLLBWHtSJ/qlgZLO+czB1Nrc9uEhIkLJDaPrDOMh5mNaRP5r0hbb0
3ltN/gm9E1Msv6fqvac/rz/h5+7K9aPNXWHrl957TZAEhul3XIsq6cNN2pReNTVoiHIHqj2o5Reu
tzUpFplmeiWjaRhyNEUbNZpiGKMFU8hQI8dS6Iijh1KkQceMpJCBxw+kSNyOGjOQRh43jCINPXIU
ZboFaVmW0WIoDTMYL4RCiJxQBIVwc5IBFMLXvY2fVK7p6YdPDP00oyeGerLBE8LavYmdEF6nDJ08
OHK/CUfu6KEr1vfw6KGrWmNjktDVfsbG4NCV0uBbOUjoSmn2rxwgdFW266cLXcFTdN3XmvLTuu4F
wodz3Vd7EA7luhfo93fdF75T5rvPLAYtcydcLrbzTbSa46sdj4JpzFqA2b8SJZKwkJBnzp1nzgRt
NF+CNsSVYEuuBDnFRyt5EuZxvJJdCk2mPxIwzYZZLtujNTgUnACHeE3bMXye3zZ6AkSnBd6tDCQS
ITcWtxvrqi2Y1L5X1QRxZ1C+n62+EFW01j1cnTzWn2NNcC8QjuvyViflukyAeW3bOTeLoVVADl/9
/VYHck+u8zkUDiL0Ai/twEJ/bqokAKdesDKR7ukCYrKAnwH6Ue7xVG0LQbgjnxDo5PG8IHJyTTO3
WXBp1/mJRpNXaGx5hSaUV2gEeaWKnkAD7ybZikTwJ6qesSkQ5ewTzol0Ohiq4WWFFJDsCn84GKd3
MFofMtj7WZCknu/uphQOlW8QiRksfl79r3TMjIdjNuoxg9Mfs0cDjlmLvvRoj4Mm5q15Qblo+Rjr
IUUgDJxFymHbSTZVfpJZsvBFkWUpKfslRZ85W0Y4uJllM9LB3V3MsQ6uMv3BVfaQjzUHd0INcF+O
bUMTOA7oaf1/3sXkBCrL7cLD6zQU439UztaYCM2ECFReeInoDJnZeq58vsVL5eq/9B9nOVcmSH/I
amQrS/z5TGrH8mNtpz9d7PRnYmGyhp7+wBxOX/4Tk1mmLrdNtLzr3sg7BHmFLWZpSOMO7gnOhspm
/l2g3JglZWeLNxKYjQ2KskF7F+CQupTYIqOgasxuXhxxUNWoGnQsUUy9cv3OYk2hEzaYkf4wdVRE
ItYp9AGk0Ie4APllHAtgwEZV0x8yoxjtplbXcCq0N7ex7mqNg27W7qr71C3PF98JhMS9HyuYII3c
H/4mcOsDV1zS7OhHMS14vqRp6wtWgKhU70BHRdUGFeRFXdijlQmP3aIqK8Ig9anjL5u8OgFXo5IZ
v00JEYL8ExZzmNUVXck8sNDCmmmJD0pOvr0/RH4YU9q8c8B19B/yAuY/1jSHFXo+WAFD8Yl96FFx
hWB2+ZshTO2Pkgd14VxBM/2BLA2bmbC2l+yzvz59rQIwm6XTTc4V6WNWTwqXP33j/bv6F+LaRbSj
XRWNlI1rvKZLkQ5EXrxoSbQi8lIFEVE6Nu9+ebPa/Dc7kmeYDEP9/7zUDi3nSwhH4hffumt3kTz+
QXjZktt4vaGf8Lm/+DUl/wtemqW5X79Of1dimFcZfR6zQi8bymNW8+UdUbCWrxarNXlEgrGJsC4q
jELeuW6nKp5uFEcb5PW/pT2f8mirhniyVb90sqG9yw5XEtjJ5UXrGtWOjADVEDRPE+dniGeaLCvd
E1qPh5hNxeqr1cebrC75XOX/DNhf0i++ijexMIxz/fbn569/dUDF18/2INtOT25AUt51kNeQwrpR
uSbHwNBIDOzXU04aqhOQBYhAFmlJ9Hsk+lZcqf95ySzaJqknmVJp21BRma/6xuOa4wTz7uVUikAE
tIrl27G4+jxGtg4qhjwBNBXjR5MtNi6gyMCfn9IZvbtbERW51KG16Z8l67ZCqumFULM8PRBPa6ZQ
jhxf3x17XNCANP4RgIXj0u+P1SjRPzw2a3wGemb5SgyMg71qGHIs5EeJBHVQ/sHeljXebNfLPq+O
jSvZHg1iLg87pre2GHUCGJdE4IRR3hKfHbFkQMSSVU74FKHhLQweKB9A4mJqzKhE7OAJGRL1SdCa
jALq5ElZ4EW8vnvmrtcRXrPOVn68wnWuk7yEPdUMDWhrFfRevXnOnT/PCbe/Vvl/8nqgzP8TWFWj
HANQLjEwWrpRzah7JWDJY/YLUISeH1QO0/sNUQ3Ba+2FwK8Ytd3bsHDvPPyKOXnSY1jtgNaFFruW
55W8ZqqtF8RhJ69Z18Q/acgJkmWl8X99/U/W/oOOeesSU4ObN3wZ6uR93oM0sLzArBr2mhaeJSfu
8urCTYgAU9HFDd7kmdYlQz/3TwaGCzC9NcVEnrzfRPP04iBrl9IRkpwl+mNlT9YMun9qas3A+ybS
ysOOlfErjRrFH6ONQyE1mfZaRDdy4V649jXflWxZWCsS2BvzlFeeiJlIoD9Xxodrj74NAt2kR9XN
xmFyAapgl4OesTkgxuaAOCWQv7Gv3lxv16FLm0/R1tc/U2yd8tmNNu/JWZ9fk3m4cxz8nfbMntEo
C5H6v14X7SLTPxYDbbZtke2VNgJUGj/7lu1oGHp4Tr40qLDjbGFmM7oy1WK+ED626ruI2toMqMg9
yFbj4C6VnE2Da/ngEIU+oqKF/Q0/Ki2j40/unPeM/kS0m3h9WaZc09Yc5UQ96Ac+nRG5N8uEuvYS
/niZFZQ7lcUHYlV8IGxofRxNaE7gZ7qg+CJTJZBI6DC6qdUCDa3wOAeSM28/spkGTX1sdcSRaQjE
TV3bJf6319GSmKnMYnqavEwbfNc6CWHhWoHA85lr5R84urndJOk7o6EdGtmDerFwV5dPz5VntU5I
vTBOgEX/XwfjxB7NddWzXpNIfLc+DRH9QccaMaJhYri2v7tLVcVfuEXfWv3FEMACIQqtisFHuLZA
urZa87WtIexEi1UL9XPFi+N5tbjScqcbYcIL7QomkGE0MVGjdBPlz0mbpzmYf1ijdYsRPSMAstZN
ZM4A4sSII2oZEQEOW4Gz8pKk0a5zHrgo+9BrYCmUPwuW+FM1e4e/vSxuHYheLV1UFq2Oom8RbWpE
m5X5ualoC22rcvC6zmXSyEXjMiQ0SoWa6P+37lEgzIuyeWb9at/F6YBncphLuEu1YVKsoSC8pytx
nJCgsHQg8CqWrt3pkzcm5E4f0eFsFbbvSzfZXKT/5ZMrveL5W0tuJ40e49nNOgpSANAvDPZDVGuy
dNfUek7Sf7ygGkUyo+osV8E/4bUXJ7jZrjYK4RLYUNOp5ibzlvqPdG1nLk6Kfow4fiMinD53l/Ey
ItN5S2z7wsP5C32DI5+uN9Gq3aZAYZYX4dJN8Kvkw+h4Yqs+FhCSS/n/s/dmS3LcWILoe3wFH8Zq
2N3jKeyLrE1mWBzVnKFULFFSz7Vr12geER5UjpKZ7FwksR/m2+cceCwOd3hkSEXVTNsdPjAzwxHA
OQ7g7Ms7ZCB75ePC+n1yVFBrKza8chA+d124Yu6ZujBjQm8R5B8Gdp0vCiVPN8CnR0PiIxyo//Ii
M/aHrPGB2lgw9zf310CPr3/uv9oP+03Sx8nYRdlGkE2hqDB5Dqv3H5/2Qs90qT/VnSPkpEPzNd2Z
rHF1N4PCdXapBf4+sKJB6tkd7u3Pd9fbFy//oY6uNqOQOLvpJsY9KU0NjHc7uInvMhD7kzDYfKpY
ipMUvuNri1ji14f5K2907IPYe6YOegV6F7/FvAJUAL69++UByNEHoC0fnj7gX18uKRpHSxMoGlTq
bFgrFQ1p53DgW3z37vAeD7+PzxHisd+M/XsY3v26e7jevAMAgMv88wZO6VdHyWp8IhfG/i2Dn1v5
zHNk4If/RziGQWX5y8ehwdg+HurLL//TO/LM/XpxXvyuYvksMXj2a5lATEY9Pn286YdJDv999fyj
8Yv/2F0vbsFheAck//bxn4/S0JxuffXVYfBdfp3dzT/vbu66x68OXygmyn98uLu9w1vQF7O9zWe7
+GiIv30N/OCm8nQIaqx8dPiJfPqrf/gKIRsSRV7+w//R2/enix7+IVt4nH2yiX/aX6LT6v/bNvJP
dY5jjgyH8pzmAaR4T96ufvySarFEBH/sHn58lyO//jnHoR6UgX/8Cp9mgXDTv3u6vQbhGCjhJ9Av
3z9Mhu5DWI9/7/f4q5fVjxdGL8iLIya2ldnWMoYZ5ESjZqj9AYV4h7Liwz+gj8Vl+ocBgy+//M83
3Yf1tiP/eRrLtn/XeMqwp+Xm/vojfPXd4z/gp4M35eKvLOZ0nWJaqJGiqwBeV6NzAuSLzVjz/dcc
FTi0ku23R778sNQ4/GS73LFu7IPTFznMUYcYTKQjGOAKnDOYHv3QqECtjaiiOyj2373OYd7HZfa3
aqrXHwOhQa83G9udmREBuWzOg8ULbQVwoKpzjjoEn/bi+rF8G790Px2nP7YMZofrgS2DmWCVN/8u
GzPfP909PWQn6AUejrqiZEdh4t1uHMCqZ4rSqAzCx2cyOkcOfi6LeI75tD/9G0x3c65PI2Pjagqd
Ogvl50ya1YsG3r+hAPls4j+gvvp4jeObGSgzqAGYFlVo0JUM15Oey2yREHWY9qfhOFz/pgjzTlUA
/I+haNKThRk1TUGWNM1ltP7ngFd1+hGnJyTH34wmF2dn/2zKpTmhiMrleqZc2t8BxsUGdCpGqxvN
zNSCTn/H6mhBHyxbCyb0y4znbAyatdOQGlXdn3f7TO9P5723FP4JRPbu495RITWpzvdvT2ggAz0b
yMAjTF71Y9mTQYTyLS8mtkrPJj6IPO9u+1+yE+b/Bfnjy9t/6xkllKj/728XYXghwmwrFOCI2NcZ
r5fvvnz35QPI0/3Dl+vr7gF+ZF8O9j/+MlNJzKuCR48PIKZvzxsn5ckxs+2AxVWo8NiC8e7dt90v
8Trflu7+yFjRhDcEGKGYOphGn8tZJGK3ppcElepTtAVaT46RTf8ER3N3/Wt+Hc+E64qtMXJdYV1z
heAMhdzTKbSQf3VWU7hwjrPkeDzwqFv8tvG/df76jp20LMmkzP7LZW2keK8fQNyF9Z5uUQt5WdyA
K1qNS+8Z4RVm+ge0ecllH85H3RzE3L2tqBpkcwzKwCgb2VNRmx1l3QsmPkq4B0pvbUc45ZU5P0tU
axEgt5aLmRjczNb/rYkYx9brORGjKL1RnXGY7OphFFpYzmhGwUKMqcqmVgXzLNydi4kbxfBxpdbm
3Lx/QI0Y9bfL68qMS7fp2onMRv0FmjlyVa23oL7BmfjuGCjwTy3a8/fHgonZxPP4rPzj5cxC9JwI
afnGqknIFj+33N8eIyGpGAdqMF0L1PjDgWDjOA2iKjFe8OgcDNlrA+w48+sLX/zIacLXQAjGjhut
zq32dwjMoIVwacRUuJT8AgDzMXwFOzP69eV82GDQ+NNC1vLocOqtKA4nrb6ld/gW67L8SZ9hfMcq
R03T2Yw5kG+DHvwvMUsJN/jV7pu+355KrZyN7DN0u60Qyo/3d493m7ubF79cP2IBn5zC8upxEHvf
7B9e3fa/Yiwk5hbd3SKYGGH14tXttv/1+vb9YTjIgGf9zuroeO4266KizBGafcBxlh2y+fI3hdXy
XQXDigvuh7+6e+DAsO/XmysQ4D+A4rcYeHd0bEpitV0P2R/j70+D+9SidJkVzHz6z9uaR+P+y4vx
l16O/jheo9Fnf7rEpmzVeSnuP1Ju+7p/f327f/gGPnw5ODoqoSwLMSlMjZKR+G47FkD/b5L/cxE9
So0yufCGVF5e1tZOSfcHWHKdpPMxr/qknBrSk0u0xcOqe0fv9hDwc8h7fM64sl0DgRel2LOf65jm
RWerxf/ndWzefve9/0//6VA4Di0Ak5IGU9V/ZPtTRbEueQyH+vOb7w9Oo9fXD49uuz38ObG6n2zu
Zmtl5Qwf9eZ370Y2cJTdj3uwpEef8nj0rut+yy6MFl00vU9iVUdJSFuWbUnHSWbZOrNlcq7TmZSk
o6cLp9/ssplyMr218+m/e30IKc+bkGsa+BNzOmpuo5wLRXfjtMZjvYu81HAFft+dYGr0hthQPuXS
7Xj37gmhfoeZDew3VFKzG1s5nZ+xkuVxyrsH4IW77vo+8/7hP6yZcUFDhFORdrrVfFMDeHCS43UG
bRzj777/Lpl88DEWfoNH88v13eOP36Tw5dlSG0c5ZiNUt64hMoTtwUmcxOUdSice/v4WEwAeHgsm
fuT8+7HfYam2R3SF75lPPFoWD+UfX92CqLYB8W1vzPnHs+CzUYVEqzek9q7O+V4ekLDNw+hmLS/F
OHqfigpVOmaqU5Qtj1fxErLER9nahgxFWQ4T/NMrmOBAL0aBAPIYGbhIpJ9NfN3uioJCclH5fcjZ
WhcqYceQw6xgbDtTKBianFtv7BfaR2+8zD/mLqAF6fBIUsh2s9md/Cs/finFJUtnk0J97hMPpwwt
cGWu1CgirzL75u7jp3eg0qI2iXLysiZZcVwUUV8fP32XHWCzzThr+zzleVmyFhRJLYI0uAvoOcg/
h0FinLSxYVkvnxkkzm7Obw3h5GRsCWBKFCGc9txSf2NSdlnLEDtslBXfCP0diw/3b7D/vZxezzPV
lZZr0YH6N/W7kbM7cPBxXX5wJxFl//uC555xn3VKb7P4dHCfcUqrmzTYgBZtISfzDpYD2pWuXS7J
mSnRJXdy1E9Tnk7TdhsqJh7jOUf4PRWlx/K7XlekvTN1Wn4HvxuJrmq9+S1y39/RxqPI2MbDSeWt
jO0xk0idq3cbQPex/6b/ZRCJX67zj1cP32cLySE++lAiAf2dv6S7+0EkX8q/OJJRoYUhv+G9jSH9
/foTPUXhg8Ru+2VBhc0hqEd4ArHYF1aDv47i4vKxHfvbTvE8Pe27iuya18xzYgHJd93jxOddcSNm
XFAqLUnThXEpf/o8gSn/5cUZwP7xq5fnnl4A95/+9Psh/9OfnoF9wW43UvYopybTsfHOgIDG5xLU
Xie4f7rFEgGA5gY1g7f946EK7sv6iL2t8fRjP6z9dXPz9HD9M1y4dNO9f7hMNbJG2+r135dzfxwn
E52diGlSm+hvysAUWo0zMDFKcfX27v7xxfrTi8e7jy/udkOPAngJ3QcMT7y56T4+YAGnfV+CF+PG
BL+1xtsBE2HMKebkgoqkB8e4Jaddv6CcxqGoPFWnr/2m4hWHYOMR4/zN1e4PnQz0yWNzUUG0Q1lw
bUev+2THuOjLlLPRopcXVT8WUzjZnH5Pj4hj+4pyludDGA/n5HRILiiCf3jRtr5XF3Q7OMzAy5f2
G+q7H/stjPbs48OnW6xY+PPF2zYqDLQfcP9xM/Sf+wh39d2Huy0Qkt3D5Ts58lpfGKJ5+OJJuP2M
at588t9Rof1YdP44yf/falfP38CFhaKP9fGXr/dl716O6OqziXbn9HJMRaN7a+CQS1LExP8jJjX9
z2HKl8sHagTP8d5ll+rlFHN0cy+mU6Mv/Zb43vm3LyhacyzGVJ76/+ulW7wdpLY5w5q5NOiQ4TR8
8BXGGGw+bW6A2N+92+Djl6PH/7i8i/Y/1H58hooQB9noiPe0+uqb1y3m8w5xcqCv5pZJX26Bh8IC
GAAIbOj+GgvRAqSwzE+5CG2APx7yb2+HWN/lV65/68aCsAiX+u7DfmOfK5A2W6akKdv7u8uYr6oK
cOw3fvf3xMHMJvnNcSazGf4D5BLOYP49buqDCHqc5GKn9Oybv6eqxHySz+TEm038W31Cswl+uwlx
NsX/KRFDdcA+px1qvsL/PqNFHZZnTRTHr638NWZDvHj1oXsPhPowzT7NQRBCXjQvRh/Kju+2a/3i
n06v/MVL8g8v/jkRFVnwpolEuobTZBsPEzTUa6q890EE+9WLL76H1/HwxT9+cfr6aElq1pRMl6RW
bAxd716MGtuOudiLl1zyKyrgS8MvCIwNybaBNFEz33BJZWOSbhtnbRsZJzy0FIB5m+/GF6+v1/fw
Dr5of33cs7UvxgtcrZ9utzf9F2HfCOKLr7vNX94WQ0Y4mM1WbqY4wIddvxbrF1Py/uKllfRKA8iE
+2hbzpqQCLw/7UljrIHfQmtiCy/XCAYgPz3cfwHf+2IyTwkAJsPMAOj5VpoMAHxje1iecoOrW6mT
5Z43xhDZcBt0Y4OkTRsj1VQmKUk7Wn0gKl8Uc5Ug9GIOQm+12ME+4ndg5StyhSP2EGjRSiYMaQLz
EbA2sTGUxcbK1DKvhSNWjSDAOVbl5Ka24jqX/zrRwTXyy4fjy1ewcktcoIzThmkH79tReAvJhUbQ
KA1hniYeqrhXppyAVDkI/Y5Iucsg/fpxcwCEU8KuqCJXEgDivBUiAO5RyRaOglONNzI11ImQ4CU5
IkkVoOOEJRg7OgdjB/dqtxu/mcd7oM3HY2EUzfDgbbI80RhNaFSItuHMw9VmjDVwk6KTkSrqxbkX
NJp5VcLAKoBtiNzpDBgKg5v7Tx8f745gWTa8JookhyjBYnSxEVpTPDKsgdMbmlYHpQkNVChahWs6
cQnVZv66toRSJvWLBYb64iUc1eP2Rauss0Q3sI0c7hJcI8sVUCDYUs9hZGvjudc1nnlVAsEqkEnL
+LCRpfwBb0uKASoGUHn8boiySXCogT4L1zgq4IYTrjS10UixcMOLWUuAZFcDCAusj1/Vru8eQanY
ISs7wkY40um2pQyIdcOFADqdCRCQnIYZDlC2icJGnntV85kn8G0r8G172hdbedxFqiU7nvqodWi9
Yo1LSSEZDo131jciESCWvmWtl+dgq+7gdk6Zt1Ttuj1AIzHjxUsG5/BK5NdEUuSWh4ZKD+8qaAl7
Z4FAWp00XEUZtCl5w2iiAgCqSQUA0+k9SRrLeAUE3DhgCKZhzMFGaWsa713bmAgkIQQSWqZnEBxn
KkEw6woIG8PKTRlrUrAzjGsNW0MH/h6UE0AMfWNZC3vjXWqca0nTGk4UgxtBrDu3N+PJS+A2tgLc
Vq55caILBevFS8ntVX5VAJrjmicC3NsavGdMOeCpXjRAQH0rWs6JZudAK6YuYduqGmy9VfzFop0Q
WIuWV0A4MhFoozfA4GzTBgr0icUWSJMkjaJCWk2ckVGdBa6YewJd5Wgz0qu+eHPXt7sjNQd0kLt4
mbzB60+BlPPWaWC/xgK5hLMaubIxmHMwnWZclUtX4NEKSymMJUkUik/5eQDTlYXvSMLUlcpymfVK
Mw1kQIMg0HACF9AqeG+JauW5ZlGpOBcl0333oUe/2sMX5QpXu8OTL34ASXgQNidjViXI/RyPzphd
icfr7ul28+PeRvQAFwZo+xVF8Sr/gtySSm1bAuADrQeZmFGgH1Q1IsZgLbAGYKfPInJYoI7GaHAJ
T314OWZVIli5hxvgU7LA+v3Hp4dfrrIY/h2aHrNUiUjjxgWBigdriAHBgFMQDFxivElCq5YLa7gP
c3zf3F//3D32I0xOs9exOD1flcDOmXUv1EasB0rrX7u3J0Yt6ZFRMy4IA04E4lWAA+eJAQISCQAP
SlTSGuThdHafULe8yYEhz+7Sz/0GJqgPK2BclVjM2Wov9YaXm/O6//Ua1OrmOPtxdyxSJNwioTwV
RjSeIq0UICk5IVnjpfBJOgVMj12yRfuVFk7Z8HBVAlvBQPUbbobNefuxu38YCcMi705WFjzqQiA3
CdAZgIJy3/goSCOpI63UgbiaZvmH7M4YyFWJSAU7DerRrtifAcahzv3T/Z7+0SuWqQb8AGyp0HiN
gFwobRosr9W4oHVDFHA5YYlRWS1cxrayRh2fysBVCT6t4LSWUg/sJXyb3j5dPx73TKIkTgPI4cK0
jdQgVHKSROM4CAypVa3VUfpkJjp1OU0JwXrOfvtObzs6nJkP/aYD/I+HhjJ6JTPlVcy1EWhOI7hH
aaWFt8iB/wqQ3zSzBoWyEoxirlW54Jwd7DpFO1vs7XmWRqMLLbdNcgx2lVrgBBT0bZoCCFakVVS6
s7t6np2FL+qsDMCck0TQtqjhE1Z2+/6pe99/fbftb7AV2Z5sCM7zFeRMS46v0zEN0jCoVY1TOoG2
LJBQihDa9iKqMVlniUmVo1Yl8BWMtpxt5kIGZuHcdJ9AqLb0Co1V+SfqGabVLcg+jY4ctX3B8JC2
jVA2KBB7k0vP8+X97MvSxX7AqgSUT6EHrruTu20Bffe0vb67cvg/srn13a844ZGYSwmniiAmxiUg
kyo2MlhQfD3QdB8MbRQJUhmjmGkvIufTpepYTUetSizUHDVOd1s725jvsKTdSwPqhboCDgzfOf6O
ajMhyUUUlp1HFsVBnA/RgPhnQHqiEW10z+4OLrG8Nfi0AJ4zMge+W8ueVvYFZ8ivAmhe3hD4H08V
BYCpAFXaCyDfAgQIg2IrNzFpIHxAFeWzcOd5lwHPj1clkJXX3m9B1iwgf+g3T/fXj3AZdAZZwai9
uSnbmyLhRqcA6hxq3oSIxgYrm+CUAfUAJDnjz3Od/fwLrGb/dFUCOYec0m69lYNydb15QqvRyW6r
QWdiQOBZJvGSw53ltAXO6ICkMtmCEIO/gQhqjHM82AmnmUy4KtfdVICBAyALi922u//l+rZqvDAt
0ZGxtgktWuONg6tIgM5LTzhQTFBL01njxXjqErTKDlPRbSsU7yj8h+5+fXe7Jxqc82z05TzTPiNc
kr5hPMEVgzPbWN1GUJYlCIPGO8vY59NJTnAsnOnj81WJXV9Bud/uqF5C+RXmQt52N3AniczMF8UR
kDhUdFYAoi16JRJsCpDFRhBKAtGyJVxeQh9rKy3f0unIEre+gptk24m/JbzF8jZ9Ta2kDGREx0Fo
1wzUFUds4+GQNd5JFbg2kvvfjFRe7HmM8rBVCXkFHUUVKzWT48xXOcgUePKe8oOMyTjN5hKecQMF
X4K2HJMFYZ+3qfEKUNVUJOco3CJynvjn6euI5EerEk5dAR7EhLUa3/rbu8fr3aejdUeYfOkzuKDg
WwoinQroQiFRgYjkQUEBggpsQGg4Zecu/XjmEjLWVSAzILjuLU/d7Ra48Mh0qQw5qkzBU9mC1Nu4
1ilkoalxBi65Z6A0JVCnVDuxHU7mK2GZWwYs23YbUXJ29/Fj3tlB+AV4JAgpV5TgkfXKC49+AyVQ
/m2VaIwWugG5EnaAEuuFOq/D5cnrsu/wbFVCt52DvFPSllzx+1djqX0vXRFqBx1CWjQAxKZFqs6F
BqU5pLYB9SE6qYHV16w382s2XqR+MMcjViXEqoIGqP2lWvn97TWaCDET69W2v4UjdQ2TA8MkuBPw
P+6A1EmxJBsqDXpuQCcz2jCQFDXzVpMU03m6X19kAaHq2BK1uT3AcrqlpKQb2/7hp8e7jw9HKxuo
VHmXDNMgCuAdDNIl0xoDfEyDvOiZb2zStnFOekoMcyz6S/YpDksdSB0OqGNXGThGjTNm5qgJaZSc
qyhP/ePYgma4SdYm20SeQIjgwKetVhokG9CyHHwGAtmlpB3nPqOdwNNVCeD8lnPJB/sfkIT1HQZy
PDzcnEzwLJNtg8IY2mgU103iBAhOhNcPwhhtojfOaFB+o/AlwZlMtypXZXNQTK9pqSWF9E3/OLZy
cQP0D+hJvr7wuryVQcI5wOsLIlhjuTUN6EUWTwyLVp8XdA7TL7zEw+NVCWVl7y2B417Y5G+Hr/aH
8IcjFWdwvrPPJZtTgci0ILcI7VFNtejVdLYJKSjLg7eCnnXV1RdZlZDxGriCqMEzhOlu7z8VfmrG
B2FXBKmB5SkJ1MSotjE8SoCUGa85S4yKcr9nM03gkBU4jOj3DvOv79bXN/2f+4fH7ubxKH4LtBLu
BYcIyoGLLjUtejO5AOnB4bvToNlIaaKgNpQQVeYsYTI1mOwm6+qnt9ydbgS8NrwLQnCruUXpBbaN
aQ7vxqYmeKd01EkCdz63bV31TlhboZd2Q7QtROLvQhjTE4fWAWtAiGq5QNspyAASDhNIxZpr6kHc
IpfQE5i2fgvgQQnm3JVv+U7rrmS8b3/69Bpb0CCswOIyvDnQgA+Ok2CSoEE1KqJZI3oQbiVjoI6a
AOJL4J7zS8A+LLOgle6frkpY5xdYqM1W7mbE+8/33ccfrzcPWZjNRnYlr1Q+jUBtTPJtaCIyJs5B
bPDZzAScLzEWgpbPW5gO8y8T8cOIVQnsXCIXRsu1WZcY3Nzdv/10u4Fzi+99IKDwy2BBNZoLIhJt
QrDZkAsMtQXabloHt4lZoNDPWTP28y+Bv3+8KsFUFdh7yktR819ejdxuVyxbkCjyoRApqEDJN5GB
/s2TAqnAxAA6udIpeBBynpFyQJbM2TQA5cVK7gma+tDT8wJXO3ffWrHeAiMucP367haD9m6O11qb
HD3mHZe6bSxRGPtneOMEgQMmaBRGAfP1F92Qw+wLjrb901UJopjDvdlYXnLnb16/OYDMsuUhAVtP
BCi0SBpAtsCQjfapYTFwpyyxkcdLQIaJ69DCg1UJ01yHkmStdxU5DAsDvMReFGheZUjGNWUu2kAb
ISJooiqB+A9KFMjPhBsJ/E0x/7yRGOY9I4PB01UJnKlAvOXb8tUecvD3TThfonWAU9Cn1ZW4Yjxb
UYMG7gNUvkktalykRfsAHBVC8X2z5BhLl7ztcq06LuWYEqPKYZFsvenYnon+2831Y8+PurXJFmCl
W8EwKpJ5+C8lDhI9/GapUYF4zpydeG+KaVblWnO+Kblgu5Keu00uhZzd+NlaRvHIyqS8UrDphHiG
biSQISWwcqZ8hDtGonjmDBymXbCn75+uSth4BWBpe10AjG0A7m6fHq8B8Wukg2ZgojnAA2BMIPew
hgqm4aolBaorVY1TRmuJKpHgl6kRuMj3h0WWTnIxqERGVq6gEOuJ6cB3D72/6+63oLOiVpHtXfvf
MrEDUViAFGMMSpuOycYn0I9kap0hzCpgvJegc1ymjsjx8aqEdlNBYa23JRX59un2FhSa/P0xc9qb
FOQQbHA16CZJgwQAIkADxwoOOGEOEIqiwcjOFnZLKXcRKawtWsetNrJEs0Z68KbyQr507YuXVqAz
zWbHgeAyKjhNjQKO1HAJvzkNklqu/ZAk7IyPn8+c7NqFi9SuSrArWyaBippBq9nePrw7WBSOao0x
p/BbYyyTjoRGWJXFiNi4xGGTqDU8ac8jnUT/zacsIeJ9BSKhuCki8B4+ffj4ePfhBBRV9mhrZMxS
liOBjYdbkBjcB01A8VKSuJYHkc5HR5aTl+CJuR1UbZVg5TWdqNvyEIJrs+Nft0oy3yifze2GoLKq
mjaZCKKKg3tkzh6Es8p2RdUG+GQFaCsmzLK77W4+PYKQvB0rRsm1TDDgjLqloKkljtGDGmk8k1pY
1CTNpYYWd1jhjN/uMKTEwFYxUGY9GAvidfceizhhPcCHB8wWCblkwyngAc8FhohL61wjTCYmGP6o
BBzWqGwbZAJ+P+GW5+edgFg5GT3hvORGDx/vHm+ypvVhX6nwasSa9lKgoAbVoyt7JTKXYgA0SRrZ
KQhXXIKWZ1WEUw16sicE9AznLw0XwyWf4VOzYasSJ1FB1OzWE2n80DAZDZGqhlVsU6AcJNxAJShO
oO0D7SCmaUUkIE2EZLz9fBTxAM95lEtMLalgai3tC/0wXj/85O7X14+HOCV2pRHfHM/COQsCow1g
0zCUvNWNizQ1SVFOW0V0sue1w8nsC4bWctAEi7lkodm6Jxiae8Li55xlhdIRihRqb7LMQX+ewmHj
ALi0aLI0DhRcodFqg4HwnvJnVPTfElaWoagPG56tSjTmmqFWW9GXUTt/feruH/997+TNEX46S675
NxSbTPCaYMwcaYEw+BgbE4xoQvTR2eg5oectoKcF6qCfnq9KSOdkTWsmN3vDWQKt8tv+/fXD4/2n
k+nM5AAQJGjCtlrAfw3lGDbrJdAFEeCYKbhacLysSe1nV+Ldd28XJKd9surDF1XQVyWSc/OFNt1m
Em6FUQhP13ij8FBanVNYpOHKONu0WaGXVDSm1boxjKfgIseUn0sZ0vevljnR969WJXBz9UjbnqpS
Pfrhuv/F319v81XK4QQm6/SKgbSqlWwkxVgdj0H4eMR8S52kIMcS7i6B+jR/HfLT81UJKKtBv57o
Sm+GMgpYoC4z4ofrzJRAN8IYNzbkwgWQXeGkOaBg8Poda4wEIq659l4YC8KsvUhdni+1oDPPB05Q
21RQ29mu3Ji/fOxv4/V9riTz6ciU4MXn7Ag6mF1aQ4xutJOwRTrAmaK0RYonHAElC5Tcs7epWKKO
TDGkRGNXIdMd40xPXDnPI8K9Bh0p0CZSUJU4kLDGs2TgN0GsUNpG/TcjUrh/Lhg/GbQqsRQV1Dmx
dL0Yt5Pe5nKjeDwF2sLVPkji+AduKAUNSyg0yoYcwg0SE1BKkKIUvIc2GE7l5xMwDhAtDNw/LRHn
tIK47Mh2RgWPKtPQ8QobSWGNAHSEYRAP/J/lRO0CyKEgQnGU0H0EWV2FHCHNFBdEsfbzIVxCsuA5
KMaUyMt1Dfme7OPcAfd3NzkL492HvsPKHx/GEj3SotZaFgngKyLeWGaRFmEyKgjFUmpuk2xLgf7c
pBPoKpJF12k7jyVzT493r7tPd09HBzUX2bvlouYOzpxEt2qIqjFex6bV3LfaAtGM/GLF6bjEuYjH
w5gSkW5urtBr0/PNEB/z64cbdsWOZkVMFhsCdlrjRALZglsp8PKYxnMM2GktyKyKBkpk+W7HM63K
1SrvckN26/m7/OF629/hazQwnFwNmbRUuSRoQ1HS4QkUNmAy6JlrGSjeQmr//KHO8y6/u/y4gHkz
T/bHD9nEJH5z9/769uHpI5ZNg7c3qG9KoHU5u4Ys0UaxRrKU0BAhGheYbXSgcCN9iEzrS45AXuXZ
+ziGZSExYzRigi2vYIu5JKWF4OOIKqA3LIe+511iWiBfIXDGMS42grLjJTNwFb311FvDLb0ovhoX
evP0cEi9WjBjTUaVyMgKVd3o7SSqBKs9fN3dgkqBJGBs8hBOmyCVbVIiEf0vHmQ1tBjALeCJhDaI
i3zB5QoLAUDFmBKPeTqFNaRTpNyUzc3d0/an68ergL8MIYMc09DZwBJPf6AYqhWQSlARjJDoNcCI
GdOaJjhO4Zdkkj2fInRYZOEu7Z+uSpDnlhFD9VpNrj9+N95tjmYQASdqSKjPkBMQk73UTdCo4aTQ
wl1CVwfQUmpsFPGyAP7jMmcwwMerEtq5jGnsWurtjIJ9/frIBSS89MFH3ErPLAH25INNWMIiYs0P
2SQGHMzTlkb9fKT+16+XCdjXr1claHP1ykpF9D5K5Jd+ff94TC1XTCCcV5Rmyu+DJ6BWGRCWIjqV
QmocGzKTfGiFCiqcF5v+tV8vnpBy2LLGPKZrJbyrEqf5Xbe6Z5TOJKihtjTaZzjRGjToXJVl/2s2
AhDpvfYNZcGiKwjOFsoWQXqgacG1zKVn9+j1fpHlnTqMWJUQz+kvnLq1XJfFAECp7q5ve9SGgGLc
H+P9mTwF2grPnNAgBIF+CWig8TtFD7tnXMu1jFGcDaqpr7EqAdtUoOVmEsl87OiKYgVGSyBP3/+G
8pGUKkUlGri7Gh0iugGxokWvlVYGC5tI+kwA837+pSDm/eMSdm4rsAtOprAfjVZ398DpjAaWjtr8
/jeMGCKBUYYml2SAILXWYTCzbQiTVPvoQAa/yA5RLLWEymhIic68DJK1a7qdpOPkPGBMt+fZNJl/
ZvsRb4EhgEAiUFHk3DeOe9a0MlkfDLo1zvuk8rxnUo9XJVh9BVahia6kDm26p5uj/4RRcaVzeLSL
xBMNrBnABojRBOHhTTfRe98SmXTLL8qvy9PXAc+PSsDFXIS2m97yeaTT1/32ujsyAM4JBgwh+4pA
RBwSlkAFen0IsK+ofINVPHjyPOj0fJBEnv0ME8DHqxLIuVHB7tZW8JOB8Q1m6h5JieDymF9mW8pU
aEmTfHbqU6CIIAA1IcSgpWm5SBedcFylolVW1l+VcM6B79haTmj7v7zaJ9plM+GQAMLk3hJiBDHC
sCa0HJ2uoEBYoWSjU+sFEHvrn4suy2k3FwQ27WFYimvaP16VqKgKfptuEkB3SgiJ6dt5FD4Dgjo4
/zF+OEXHmyg9RjrBxnmsjNQKZzhowgyO2kXh3eNlFvwN4yElUpt1BaktmeTfbx+v/nv4bmjA5e9y
ubXu48hVZPNtb0lIQGZN4yjHCFobG0tb2wintAwyepku8v7Pl6qjNR9X4radCxsdJz2dJ26+/eHP
J2NAjswwIHhrpzEeg6JNzjWm9aDUgjTrnFZBc3pxKtIPfz6TgPTDn1clfHPlu1NitytvUfatvPoL
6rB7LVYbAZQgV7SxIQHfQ9OFRBewBTXWY8Swa2XruXVJn2cT+8kXmNvwsAA6O6ynQK95t5u/6b3b
itpDyTZpT64rApQO7Z2gyWF0aQKh1rfCN9F4oAraeeKftwCecUkdH69KQCt3YL2b+tszhxxZt9/+
2GHV3quv37wtkpgz94CjTrhpWmJyCTy4EtYDJebAOTxPIEjJ5xl1Za1nvaYDLAssfnhY4r6TNdyt
3E4l2VHVhWOYOjnJsdFExQyBU2bw7kuJ1AzoGjOKAscnioj0jBw7XWECaIW7gFxrbRG0fkj3qiWP
SYF5ZgprgqCdIHIKhAqUae2tVipyycnZYmrF3KsSDloDjtFSVHLv39/374FAxOtcFB2LZY6rzFAf
I02gyIFyj9VaaGMUvELlQcUTHKTAcFFeVmWZBbPMfOAELV5DS4stn+TH3fQDVK9ud3dIk+gVWrnz
T5RbAwh+tm2BmBq9L0LImAI8iYOrELi6LCZlstAZW9Np0AQhU0MIZIwhLuWmu31/vR2dbzzYjGA6
QWgkk0CTAuGNsZhyyGXyybXI8UrD6niWyfKVM4zdXedxu6MgY56DYbyWiSa0agWOlQANZg4I1Wgq
jYH3S9p4cW7sYqDx/uGqhK8GNHp7ykob17fvn64x9GYfcjzYhAwf6ism0GOFCqmRUcEREBTUXAYq
JOhdRsLFk1xf5IYsl1kos1GMKZGpeHDWWxCw94VX/DffnCop2X3dSjN4ByjhHitrEMw3AQ3dM/iN
atuyljBLgvt7VVI6wrgqsZjv07rfaaEG1H6Ob9+MCsqoo9tNBCMpZxZYFEYrtSh0t8I0RKckgDPH
kOzfCbUTjKsSi/m1Xe9AHueze9N+uPsf10dZGzZQZNIvtHNtcLEJDJV/9PB4b+D2JGZh+3zy4eL0
w7zE8v3Jj1clpJsK+EoypUsbxpC4lZdb7yPgueB7QWn/Ww7wCcJQ0JISR1cPFhMxKCqRoOAUutQC
dbjMkjFbcMmeMRtYIljJ5l3vejMRtE+aEb6nf33tvoGN2me9KpkdhNFpbrxupGyx9IXxjXMCa3ox
Ghn3nlPzrPyHEy9vDz4tge/nFqYNldt+TpQxwC4HpA9xInB9BnFbYCQ/abDaGpI2NtRrlM6r1DLm
rAwXB7jgCmdiXPDxqgS0r0CvpZrIrnn//lv/yXfvj1ldQ3EXHtsQW9kkZwkWkvAgdFAsmCxMaxUH
0Ztelm9zWmEp5+Y0osShkhu1oUZMaoy5Byx/Pgp9WoxCx1yxZFLbEIc1TuFX0EOparAQCFABH6m4
aEdmKy5IHNNhJXaVbMsNSIaTKluHOja7otpWjkaWzKIEYB3opD7bc0CG5a3BgGmM7MUU6pASaErs
olI2z1kL5uNWJeymgpCwbLccBeG7zU/Ym+52+1338FPFjZeLPjmWZNtqUJYYpvJLdMZjnQcJ1Fkq
oNVtCJelQ9RXW8qOqI8ukRZdBWkQwEqksWr2/hTUfZUSaDbI9ApTn0GWM8yjGOcaCgqT95Qbp57b
xMnsS3s4GVZiI2tnUhq6L7b8b0/dfXf7eH3bj4Sho8DQtq10DiQgYKNYcUGEBvQqEI0IKIRaE09T
3WUxnXYCU4UOY8TAvshl+LHf/JSuj6rdEKYnCQi/1jRRombhJRr1JZrFHU/ahJayaVW+YpoSAlV7
K3qju/WxhvjjzanstNE5hAvhIK0DrDHUgWn0wYF+kE8uUFDmQozwxuKkpvF4shKMSgGJDTM921dI
WT98ADp3qDqPNFxxDhqiTE0iCrOK8S1I5pqkmWsZVyBpT4sUnOYo166EfmxYv93sFaRcTLBSljAQ
Fo1MqrECUyA9bxvjWguqdTCRJHStikpZwhoElSpCG7Yjgg4QvM+erse7n07l7vcV/2WMINCxHALQ
Cixo3TYt6M3MtMgQJu9/Mk8Jw7zKvd1wMoQpw2BQMPru3t2878dFGseFVwUBzBPHLhFY6ddpoGQe
JM/o0X1PtLXk71V4tQLsqsSrcuqlXE9sF2esX9/0T/fdzSSHZuDDNilBKHDfSDDK2YJm4WwThRei
jTS03P1RZrACqEV7WDFqVb6BTeW1rMlEpj3zWr7tPuU6WQ85hHL8XlirW4bJZED/0bjsExYwco1q
nZCROpOi+KPeSwnV4osph5VvZl25HVrwfiJyvt43Gxtj3lJqqBJAoInD8H08Gy32KFGeoc20Vc+k
sR9nXYD88HhVAicqEGspLz7iX3eP99e/FkFHkXIBqlYjCRbDsFE2VlnbEDjbXmkeI//DTLwDNIt7
Nzwu30BNxLZiyFy47JLH3CV6/Ap4S1MLFxp0HtxMkK6xpJltBKgMCZ6BavGHHeM9OMsXe3i+KvGt
vYRtRy9+CQfnxakMCfHYJ0A3usUC285j1CWWCG9BFLLBgDhk/qhXcMbPcXhaor9dV9DvldjMrbnp
Ld4jEOAfBtelFqeQ7UFtdArYPwEO77AQmw6gpIs2AMPXThNGnCL6YpNusdoZq24xrsSt1xXcdpx0
e5np39HXfJSahM2iOB7ShPZ15E4MGz8YKhstBdecBqcVn0hN41nK9Xeitn63Jbx0o4x0oqNkfRCi
ogBREcTFRsIbRLlaNkZitQ9M0g8sUts+Ewo0nX0CY2X/0YG9XS63+Ze359oAKKq0ZqCHWu41MjOQ
clRw2GFIcUUj6K3p88Wvn2BZyNV4W9W/0Zs9Q3u71rI0Hrqnxx9zMOaIvoHEwoLD4EsslCFiQKGW
YzSCQps7Adp3WQ3iPPVS6eH8cFVCV9Gwe2ImyibGon6DdRb3KWFHgwjIXFcqe150oo5JkIbbiFxW
YiEVh1451UYvHIHjdj5TbrbGclhsMWxVgl5R7Xaaq0qh10O+7WJyrQ/Wq4jtYyjQG5BeNYYUYRYQ
bZVM2kp5waE7pvUuO+YPQ1Yl1JWLvjNsawd/6b+fClfm9B62t0jxNoKwKxunse1VQj5BAmtY8hq0
NM08n+hH/16rWAkr8cryG9LpsqHUSUnGTPZ9npGXIvkWZJToiQeCF3TjMHcyMEZUTIood7b31oca
QJWyWPjhxu515h8xXOhx9FboqYUMqGWEMhEaEjXmpsEtsxGjFdDXBfzGGDdJ8J5MNwGF1UCRkg3v
Bvul30171QmLeb0guEQUYSxcDYfZZIopSUEgpYbUO+yMJpsAUZExdlvQoAdG8NOvo355ZSMirPps
VEtBhGRYIhEojQUNu9FGSA2vzbloq7Cc5ixBqZRh2uz6De8OLdGwvEkomqIh8Dz3jfOUEqlEA28P
vZ7oY4BNaVhojeDANi2XC/3QprOWQPUVarzbqc2eUT/d/nJ9uy2aRuXAEJkiKAsAjsQSER5zmrNr
PGjHDfaVYLwKzni+EpCdrgHSc2GHzordsfcZVzpXgiBBc6uDaiJWeIWXwECpxzpKxCpGuY+tnHiC
j5NMlp5vDLwV9HPtN+bjp931zakwoSCFeRveBLH4CkyLofVRqsbCDcaKDwYAxBx1vrA344lX5fJd
DaatNcfD8hG+ef/u/nHUdi3bvlQC4iWB7WMFQMxRwG4KPDVU8ARc1qZo3NJRKeecQNRXIKJwHNel
SHVz028G1lSrXh5A3yQeKIu0AnXtQBrvBWmSCcyDuKfaIM4LVZP5SyAriTjwIcjUZVRKv8Gu10cA
lclEObu8gvOBMNGYhEKfxvoWXmMxXpBCQ+uY8+eDUsZTT2DTNdjset8S8b7/cPdzPz5oRmawcpEw
0JW8dLl1BKrnIIY60HHwwkVlsf2CqXf3ms46Aal2ymi325Pon/pPH97fl5Y9WAgTxZvEMScLmZZx
JjTJGt6CRudSqB/28VwTINYVIBjvecFDt7cPD9tqER2QOZLAiqsoBmIBVoHBIEC3WTRKtgG41tkj
NZq5BKySV7vF0IIDL8Uu5ader7mQasRKqhT1TSzwYAMWYuQN45a1vCXYoLZ+9U5TTUCobRBbb/qB
PA9S1ZU/sVGZ3eupjbJt4ZLlviNIox2cvsYaUIKFV4b7iQG6nGgCw6YGw3a3v1O77ifsnnI0AOOL
MAxEWUti7p2EpWJAiED6LBJxLulW+TSRr8pZJgDUKA/rO14oym/vdo+vYYZRWxmdLUMUFAMDchVx
6MWiJDSeetwUbzQ1KpJ4kXt+NP+Cj+c0oIRf1c6RWrN99R1sYfXzKYd0LJEJJVTShjQ0YrvYFuRq
LFjTwMfUgjoXwrQ+VDHZBIzaPupe7Jufbj58PLJYZK/OGsuClI3SBG66YKhXYvBnbC1tsR7s1IZ/
mqFcWFf4K9Vqtzffd/ebH69/7kdvQOnj5SZEmOitaqjmGrOpJFa5wX5vIIclhx1zJ1aByXSrctUK
DabbjZFFqvzbHifZq59ib2YZclKBsrCI1QJRBMSSgWroq6w9iK4goybpPmNbiyMgS17F/eMSye22
gmQPwvPwvr/7sbv+7u6n/vb630+JCywX+2TYEAfb7LYOO8u0FigpGpWkoyFSrxiZ0I3KXCUs/Vz+
3jJid2W1t/z/Q/e0OVnzdGbHXqMSkDz2ZwW+h/WNHHaSbp2IoImCSmLt5aGKuMC5KEV8viohrdBf
xpjYuyAz3O9uQSt9/HhKAtfHYtGBe6E4d9hSEusoSNFYGTAWhVFvqXLU81mG/XTGEiJWkXDYZtLe
ruhAOGpxp0B68C0FQZkbzKjG4i8C5NWoCEjLMZnWm79ri7tqG0JEaFvDsp9EmC2ahuufFyHhMmiJ
BfCdxPjNFjTw3DKT6OAU1wqYBfl8luKFwROcK2SSbcVuLx9+7D6MCg3IQRYTKXLftJYAd6Aac3qp
BVLpNXHBAN+b1BgYzVGuXamktOWdPZhRNiN78NFOyo9symMFdIClIViAmntQUY22FlskMWngWFne
Tt3tkwlX5cpdDZye7avF//Wp297n9tBHUTkHfoEWxlNsAoh9WEgXmOVgKSTURI7diOLf6XBPAZxg
N9/oXuqdFXt3tnvjwn+r+rElAeocgRsGIhSgKCI2R+YNRQGYCCGU8X8vP/YIylWBiSEV9LaYM1OW
fTvEuBcltnNx8INmrRxTUWgLyiIDdDnBjhveNNZrp3xrWhCsPx+znUO0VC1uOq7Ef6sr+O+k2N/j
m3//0F3Jk0kFRS0tjQf9F+MjDObZgajusQw9a0lyARv6Tu7PeJJy9Up3PPhQm0MX8CHO5d1m92N/
8xEJViV8Rlmuo8ZKGy2GIFvNGkxmbJQVgepAA3W+Gj4znXYC2tyM3iu1NmVkp3uT3qI8Qodjn2sB
Hv9ADR3otozSgjLhsHefwfhoEA5APgHOzKSX+rJSGbDOgjAAT1YlkJsK5LrDCmW5CEx3f7KoSjKU
UEIKDdsZAEDaBHiTDTcYWWCA/1tQ1EBBU0bGiYlqNFUJgl7XQOj1XhnFKpjHfPacACSAJCtnG8xE
aziIdVgwN3cVAq2dUcrFRHU4TTFZuUKuVGc3+0CwXx9uHsed7Q8puyoIplCO1AnT0jnHGG8ZGw1U
SragoVI2OUTjmUoQKvygV2tK93aK8OP1bf/Qz4TaXDk4Ok449kSXeojGgvNCrWiEBDhoAA5B3DQm
rTZdCdF6btzuNVvLvX3u56+vHzbV8P6kjDbO+4ZgxU6O1m2rgHWKiFX9NAFe+vci4SMgVyUeleOu
12uxpyHdqRcvxsBnWyx1DiQRAZIkJs9iUrx3KjVRWIE+VKroRFnsKp14cZXa0hth2XDTXv3l2z4X
6DkaPbPboCUqeCAJRHG0jlsM4CGsYUq0oEAIkMAn16ycpwRhIysgbM20b9599/DjMEl///ZQwohi
xnpOoxyylZJVmCCUGkUyB1PYKk2Lhjl8PYwz1l5UHb+22oKvrDKyxG9rK/jt7KQALWhEb9/+ZZxJ
mZOHsJ5MrvxOLVAzoGyCooiFPXkcbEMTFE8GazKyy8pznZZZVMz2z0skKumHvQE2N0lB+WGUuEVp
NmsYK6ljqWkN9itg2TQFKoAHzsFoIKAfXVaQ+YfltK0fJklbAFmF9Vm6nhRaHcq9YWEX+IHtzLrc
956Q7OYnXGUKwlsbNAeJ3+eGpCnGxmJ9MQsEjrQ0eG4u0olrq50rQ1eOXJWoVK6tlZtJwvHHm6f3
aCB7vJo3jsfLwhUD4QILkqJDVKPHTfDYRB5ZAIkvRnXRmXoDy7y6XbSaHB+XKMhtBQUlxN7U+nX3
uPnxxOeEPbbPYgkuMYm6YanF/B+JniARmpaCJILxtoFO3KbFXCUUlZjnHvSzQ1ptFmgf7+4x1Ogg
bygzRF7DejKAKgCvDehMbEwExk+xTp7B6td2ogvOpioB2c7tDH1H13a3m0Un/eDSaTsVts3NUQ/5
F1RTQzJCgNKCVQfgxgnaeNLiBQRKLbHbcnIX23B+cGcMOD+4VQlu5VR2XG32luv+14/dSHQROtdr
B+UChLPGWCw1pWlq0NDaMOqsAN5spUqThmPjWcr1eUUT6ARZ74Yj9WN//WHb3TTdw+0RCE3J0fap
nHBGpiy9sX1gv8ReT5JHRbm2iU1EuPmMJUCCVgDq4CCXxQw2d7fjShnAw5H82yxNWexvzwJ2bIbN
DGiaa0EOZwKPrpeekIuIT7nGQp5bMabEpKvIX2tFNnNMTurlGA9KgFOhFoGR4c1Qr0s70sCZdEHA
1XGaXIrHeXVxPGJVglvZjQ1j08BdLEvT/gpK1XV/uynCHSVz2kWBYRrAernFAkQKdsTp4FVKJgEx
uqywfbHEkg2rGLQqoa5Qi43YkVJmQsXwGmC5fYR3cju4cY/45DjGVkSfsBElVRwwMgYuYtC+CSZR
Tn0b4d+F5ZH3K4XjSov1kWcjS9wqxTTgw50uKWFukfbD9cNTd4M6wzFbPAuoWkcjPRwvkJjCkBdj
MWdZE1BOQFIN1l502iaL1DGaDCqRUTVk7E6W9+Yv340qsBitjzWN0KGoU0qNCwZLOytMCbMWG5bY
Vlpg1Jddm7zAQtzgd5MaLH1urzUDutts9CzZC8VFuGtjiXyftE/YUStnXiavMYRGiJDrUze2TbGB
nfAM9okkEy+VXceLLUuw41ET1CpSx2bNu71y/fDx+nb79OHjkUdhz+DcuVDEAEoPbZjHBq6pxdJM
mDQOerYAAk3d1ORaTlVCsZ57KPutFv2kG97AXQ6VS1m+sZ564IxWNoSixRevrQmWgXodRSvb1gpx
kYazn3yhAtTwcFXCVxGVMEDGzkvMHmrL8gwyqCcgDmFbuBa9MlhJ0oZEGy0MsC8P2LTyb6wrmx+V
4NqK2rWjgxmlTNNc32Oc423/UHgsaDKgy2IPdu6xGLnEDAcNIrJLzijvCZzcS/Oa/XGF5YDL05gC
j1pEHXyoGRksH3fb3fYUKoVOJ64MtgPjcEIEOrFRwPcKNEf4j4OaGEMRSFfOMVl7rkbtiAAdrogE
WN99wGoh+zpMOmfkJWlNyxqXDN4WuCi+pTR7wKLnWrvL3p2HNepJq3cfViVQvAKp0aqfi8//9U37
5/FG60SIoNw1ImICO6YjmRQx+Nx6xlsFF59fLC/j5GckZnxcAm4qr5gJY/d99P7rm6MPal/iKocn
cSKS8Rw1N7RzYl3B5EB0dlLJ0DriKP39Ja6KzhhHAFYlhLYGdjcp5PivqHht797v2xDNtFDOh9KU
ilmlXENjxCxWPLCwDY1grcF2pEKzi5IpllYb41aOmeC0ruBkyXaSJvV083j9ePe0+XHGhrCFGhps
chc1NfhUgPRp721olMB+q1yRxgH9aJwkzFAZtb5MGzuzbCE1ToeVKNq5CLzTvZ50fcr1xY9lCufV
IQMzoGTSCBomakvamsaCntIwRolk6Axl54MyxgssNQY5jViV0FYujCFbRoYL47Ae5/6LQ0eoTyPX
nrrSOdVeywQvHnQ7IEsCLZi6AWEKSADhAcRFZiOfGMsX512VgPQV6Lgh+wI7b27fV65zACKAZRmA
YmNEK7rJLdbdbGVsGYtE2mdi+i+/zkcASrArZWZ3oJGv1aA5f/cqpRrcjjtPg2sivkCOtWUMx4pi
IRrrg8aiDJ8J7hMEJeCVblE7s7ZMTmrLvMHcoNvHoR6BQieXyvEukdA2lwsVFBgVCCiNwVxGAbIO
k15pQeVltWRGCyxVkRkNKZFYV5HodVln7M9vvv/X++72/Q1qOwaraOb+yPkX3AzqvMU4TEMDlj/N
RnmuG9CEFPEY+8IvKp82WmZB3zkNmKCxq6CxoZYOh+jbDhTa21HD+fFB0jYqAJZGAywYC3wYIP1N
24rQKqtAgnSf6SCVUJQIVDIo4EPNdsU+xLftr4/9/W13E68fPt5gUijPNB+uOeKSWiEoHCTiHVxm
Y4GbKRYbuNUg/FiQJy4rxz9bZsE7Ph02QalGLXds3R3ECxBX5vuBxRuCw77mjmCJCxAyQPYFJcNS
ENpBA3Gu/WzyxQGCEvBdRaCzjExylt13b79/VeSWU6MStQqODkVvtbRY5hoolDKMoz2DS/9H9Bhb
as2VH61KJGgNM2X3xUf+/KpGap0wRmK1XOuxIDN6t4BQYYcgRSUliaValaXftSNHACZg6wrYXE+r
yX4duo8YiDP2ZCklr6gYQuJaLp3CnHEQUlF/Be5hhhyoQGiKEcZe5g8aL7SgVY2HlMjwyrWwXadL
8fXj/fWYml+9wb/3iFnEiwwtCDCnkHHERIHYyrFaonfoEVBBgPIIV4fIz37ojsAs9e7ePy4R7yoy
bifopJrhd/2v+N6GArtoIWdDOct9c4sofLQR8KVBY6Eijs4PIHaY5ieJykLtJXt4XKaOwvHxqoS2
QqW3Yj3xfeXyDbf5lXY3E+uUzg2PXAgqkLaRWKN5qJ3DBNwoDAXCNk1GX1ZGrrLQggRQGbkqsdhU
ULPbbbk72Plz2z/m0hQPm3wchybhhtEcshOkICGCPAnMk6AFAORJbAvDSAuiOTBT5i4q94f1I+Nh
oeWjNhtWImUrInFPerOdZfO6zeP1zyBYv3gpJc2lv7LpLaoE+i5vJNeHuu7Kg0KVhHQRyL2gF/e3
OaywnMZ7GLEqwZ2JNh0x3a7Xc9fBGb3Ji8Ba0QI3EtjfTmlQAyOxDSHCCcFROXum/MdogTNeg7ne
BNCuyRwFS3uzr48Jqs7j5mj3LFpAR5as1c41rCUANuGwAZFSuC4xyQhaFWsnBqXxZKtywcqL7Df0
0Onl4Zfr3UDUDhmZVzwHKeafuekLiiegcorkeRNbC/Q2Mt44L9uGBRpl5CTRIp04T/rFfPZVCQSb
Q7bj3aYkK9cfxhXq6L6IN8mp2SD1CdmSAO8JE6MUkfCKKG8S6EMY4WxTukgCf/X1s566r6t+OgR4
XcFCi0kTpkNzmVMrsGqPGSxc7aVEhQ6OKqhIpHGKg2wuWuoJw0Dji0L/Dk1kzlLHyaASrbntGT7c
dHyvVr8dQpsn+j63Zt+HgwLYrW1pw7CDC3dJNDaE2Kg2EcG41clcVloajQBvZ4U6FiAoUZh3Gugo
5gPKSjuRx/0VHxsdkKBQkT13OV+6NYoaCvsiMYOEW6dQxUCNw2inQRwRteiNKTJnicl4xKqEm86R
YYyua71Rxi/tSBWPWxMDUy552rTJRWwCaRorhGoIfGZiBGVKq79ha6bYvJ1VT0HAWQUbvuZ2ZFJ6
+win8yF3gz8a29mVyjjwlLC3DSgdAsvrBuuwfii6uT0QBJlA3g0Va9J0yhIovqkApazlkwbtfb/5
8erh0+3jj33RlPbFSwsUkyHxHH4ZEiaxcA1IAlh0kWuNOWYSI9utwCrIwJ/iZxdU32YQ384hLEKe
ykHlq1Bd5VWsdT+LoJvBBuoXJgihvUdafuxE7X0AVgRKSBQMS0FgkRNPSNNqD0eOcB61//t1ooYH
Jb7z+ifw4Rak9PU+c/nh7ubnK3vMHsw5qM6DLgZc2YLiDEw6isaYkJoIQl+KGqTdVpVnsJymhGCe
nwIf9lr3+xzh7mHchpNROcQdMcdZ22gW4SYLzAehcMIc1W2ENxoBiomLdDxNCUBfewU7YUoC8wGt
3T9jmbZT0KHOVgAggJiyYTk24SRYmcfwAGKLF1QLEFj45Ub3PP/zRvfxsBKXXeVlcrnR++yaN919
d3PT34R50o+Q5BjI7J3hkiQCZxYDzJPQoHRhR0HjWsz6sTRMTNaLE69KSLYV8EBnldUCvdeoxAxt
0vbSD8h/qBjuM+dBWI9Yxq8B4oL9T7HfRLQEhHdsw+1gORsuKtP76rDQ+Sq9x2ElUlZXkNps7LzY
U7q7ubn75fuPzV/e/vdj1R2DRalYrlUIMKdAG0Mc5plHEDWp1I1UwLaiBkXqMmveeKVlH/BhRInL
prJBYrOb3IVjSy3U2pE9D5uj6JBnInMQFpdoJm4kwV4OLgGfAl0dJAjsYCQxe4xe1tVrSWUfDShw
ENu59kHlGijtcAfefh2OUtsQXglck2vRqICV0COo6daKFqP2A9dJm9ZMVI7jDKtyiYqgokAY27P2
zdPHhxMdk4zlbgfKSWdaRjHEWiF7YI310cMZoDyBjubaNAkEHM9TAKBoBXFFtxMHxTf9I1bCyuGc
QywnKr4Mo7O4aGJSCpP7gKQzUHPQdWWkUKxVF4lG+8nrO7Z/OAG6rwDN2HYz6XB+c3cPLHvzun/f
bT5hnArlR0usFylIFkAH8uijVkRgLn3bUJXQe6xbb9Jn57ETkJYOaTGoRH0eWYcfrrdlIMFf47Gf
cLZRSOt9YtiNMxqLvXWALgNVxLxf0DGAYjjz+QWrv8b6kL/GCUoVSVJxu6bTYMHddtS7hPKhPr5z
XmEr+sBRywAFwzKdGuyLAWxeK5su6tJ2mL0O8eFpCTeviH1K6MPdxS9tsJz1kVuq3EWIYc8y7AKI
KddRMqQccJVDDC0NruVqkn40maeEQVTkECUtNcX1/W/9/bq/v3s4xD0N5QyDBxkTc08w8YgzbKKL
Ea9UgmjkhQHJ7OyROExaf2WHpyW4svbKunXXlbGTb9+WQWVM60gNpsxh6WieMAHRAuE1ILclJdtI
43lYYcYFZ+HbUrZVXe0wrjdbNWFmWEZrIIljQInFenFwu4KTGHaPzTG8lU1SCTdeJBb0Zez4MP8S
iTg8L6FfV1ixBmVYVtpNYF+Ex1NImeFDlY0sK1vqhKKxbQK2swYigYVTLXYHVa0EgTmCKH1524m8
0rmuE3nAqgS6ovPq3TSgO2ChnNjf9GUd4yQltS1I+Ymgv1ZqrHFtYuM0lunQoFHLy/rJnKZf2IfT
gBL8XYWvG877XVVohQv6afNjd30bru83+b6O/ywwS975QFvQB7GUj8VazRZ4ruOc5GgA4y6id5MF
F67weMyqREVU8BMgA5CpzPfmx7vb/punD+tJxQWNIR0Wa9loDM7A8ileAzqKAD9qLZBzzS+VXMdr
LAt+41ElNqKGzWZ7SHD8Djb4I3z5E5rP4qfb7sP1qds3tzm7lTvlMaI7RInqbTKNDZEBNfWYrC5a
0CwmpVIWJx3Dxui8EF7HBJaU3E0ENEQZfe23Y0NWblynJapjWAkPFV+PHaTQzmgi0YF6onw4nzY/
nXxRUitGrUqI5xeCqR7EmdJ8vX2YWq2TVMDhlcODkYZ0IavQzk+5NyARR0kvIqmv4gILgAerEqrK
G98qNjHnAKhnTO0saYWVRCJWmuKOicYR4xrQcAJoM8zAmb8Q6Gdt7eMhqxLmuawIN3S9trMsw1wk
ixGLjaGvDPq2Tn/kQkAkGqwkDUJKxOooCdstK2xoobnDlj08XZpiuFwva3i4KqGds2PO4NCUdNTf
PPWPd3fIjUcB0s57FeA2OgmMDJS1XMRPo6ToUe30xNtnOqIf510KmToOKKBmcxcwfLjtJu64N/d3
6JTst+Hm7mm7z72bhngT4lu0UGBZTay9GjgDhECADG1qW35R9Fd1oSW3fGVoidy8TnnHsa1WGbj+
16frzU+v7+5+GuUCykM/KHMls8LPgwAxA6N3HPo9Evq4lYoNkqUgI0vkGRn0uMqCpnF4vCqBrWwP
KoDreTWhoejXvtE73Td69yDjpdjSJlEsw6YjSEcBr4PVWgQNmlWbni8WtJiQenhaAj3PDsMPpd0X
evp189BjJcxTVVKaw1kslg9mAT1L2NAIWyZTSbEZUNDEYQ1fOqm6UExUwCConcMg6C6H58Lg7cPm
4dOxuLFgOdUJCx2GpBtLYHfhaiAlDLYhLobAWtBg6MTqOp6lXJ7NbRVcUt5xVaZMfFhf3/anjCuG
JvWEqIZAkRAkbKOI4S/RNcxyOIAouvjnbEt52kV5HB+uSsjmUoXkmq9LG9+f+7tpxzRGOL1iCkvM
8Wy0pNGlGGOuPYr+AEz2DimAwAS7awAPYS6SZ0drLahDpwGrEuwqLjtQd8siPvc5yuJQCedqdPn3
zciVUseK1zJZZ1XUjVYaG8El7FARZKOj5Ql0d0/S+es/W2+hQE85qsTMbiqY2Z0tuz/u/Vgw0d37
2+uSG+dOcLmjbv45BFIIuHgG+L2MWFQA1GqGBROpijZ54qQ533ojdPfrJYY/c119WwNq7rwaDSvf
wDydDj5cU67lLDfldXRvTluZS9opwMUZ3wiFseGYlOywpxCTQRumZbSMXZydgtOfyU7BxyXo87Ir
nYQTZkot8evu46h3AJP0dLuy7O41xpOoxrQJa/zyiCVYSAPKInMcZMwYnukVk+dfIOb5WQG1ql0m
BWr6dhoUftM9Yom4N7lOQgIN4abo8MKwmAp1oSHSKmzrxRvjIkbFGmp8hA1JF3Yara20GCZeGVvi
1/UV/EAaLfnrn18Pm8IwVBH+zxUfWrj0mBJLA0fGCiJbMNhsO+WyjyAOnfd75jkXSNvr2T5UnHhS
szXdG/BuB4WmP6o9B9bKcv2eodqDE44QrkBvVZipoZxrQN8C0QD+s4zrIL0u+Vt92lUJRIUoadFv
S8kdS/88PFyvc0xHcTDgWhjvbBMUtirHyAWHlXeTwsKd8JQL/mxRoePMCzdyPKSE3ugK9MZ0+/JY
4bs/3/f97Xd99/ru/ftTeSbKae6kyQwjCSMVLM3FrSnoq4mio0Ox1ingEHZaoak64wQoWwPKGjV7
pftqSkO1pBxhigrR/k++D/GCd2iFiI2XaIeJWGtRYD3hoLQKrqVe/V0aTg/PSkxr1w8+zJJivZEM
3kKm8jXMKZqgcrfMSA3SERYSyIVfGdzItjWtlbRt0zMU8flCe+MRE/DnIXhAnskkjxe/n5lC+MGh
DXbv7cCfiIBUWO4S239hWXktPRwmL9Bo4HQkjA6tKy4yLh1WWcbjMKLAo9LYJn8oqK4fuBxAhSdt
9NE+oNBSjbmH2DrRYgE+hWm+DLUOqpA26tiqv+m0nZ6XOMgKHer0ejdv/fuYTaGjAyWG9iq5WPLh
d7w4FvRurH6LUQGYS4YtQb3Gpg0B1UjNWLy0+W+55nL333JciaGuYWh6yeeRs3VyK3muxx/xaMlG
RMx6l5ECOQAtx2s0Xgmp20Sej5y9gOrOx5XomMrl6ayQct5E7O23b44qOUpBRIEiwXWTAvY38Uk1
LlmMDhUcODFTMtDLSyt/e06Og6cl1FZWoN7KSbmQU6LDAITbfri+vX54vO/mhUOE4iEoIM1w7rAu
t8O4CCWaEDUFAbwlVFyETW2lBSG7MrLEcjvLlO8UVbu+xPKHbzAyTuZY1/wzB0YkAywbTpbDKkQU
xA1rWdsISZ1mBtQnKp9JaF222w7PVgVUmlRA1YT3ozDokWHyIBgNxk8qHMXySI1ykmH4s2gsUxrz
paNr2yBTjIvhz9NZJ3DNjSCKgRowibTbbjGeyKNdKNzdPnabx4dxASOzdyBbfaWxg01uC6CxlY7C
KH6szCcY1mEEuYkFq7wM2JJZXMYxpust8Y3puFWJlKhgioWZJ+UhhlmOaB7L15wqA3FDRMZT5twY
TSThqJpKLBLdStsYr0kjqNItJ4p5qn8LnqMFzyM6GlhiOq8s1inBN2J5Tzej3C2mOcvYZYOCT8wx
liNbc0xHwsLTGHOouTPYIiBcFkd9WuxMKcJy0KqEf878leqVqW9ffatMAuEyEkzNx/YhWEbbBgE7
ZxxTFNuBEfWMFLY/HWc3ZlXCqCuA7/SkJBhu5t1tN+nIFzy8cgUXn2l01WCbBot1SUIIQG59qw29
uFrTMPtyjabheQn7vKoiftjvtpOX/uHD0+2hE97u+uYxl2cq/De8ddxypRopsb+WNyBrReMaDWQX
DpSXVvBL/fintVJea9mjPx05wW7O2pVhRpTYDfp46TjOXeFTG7lv0z7y22uOIScOEOTacxKTuyxQ
Zjz/guYyGrEqgZ2rYMpyTnYzyX7s0LFDr0RJgW/ASQICjYZkzBfzPvIczCSVTFIw/qxO8oxDpxiy
KsGs0GM4BLJ8+28/ffj4ePchXnfvb+8wdP5QefVYNJWeqrdrrgUW7Wu0Z7mwiwJROImGROcobFBr
I7lMRllYdElQWRheIixqCIN0XlKwN3e/9PegdBddpI1CY78FFkMtRjdrjL5gTTAyWey/pMJFeB3m
XiAC+6cl1JrXoN71lTKVryLGz0xSL3OMBfD7RAB0ZRmGaEWP5c5T47xziifhTby8yUixyhmZuBhX
4mQqwhi6RreTAvoPGzTx3m+zM9diKgGKkIQTUIqzVZqbZBXWQY4JS720gJdXwP+VjkKFBI/cM+b2
0RJLtvbRkFUJMaugoUBt0jNNa+AraJCwOdxWqBgtd6nxDv3PxPrGRUkxSUrooE1wLFxc2PCM3214
WoKtKvdgLYZuRcXb/+nr7rZ73w8lPOjB17mPqspZHQIETKuQM2osR4JyMahmjWyZ1iRpLi/L6C3X
WtyH0ZhVCXyFxa9B7OVzA8v34cVLxYaSQWrfLNW6kILDkqgsBw5G3AwCEiRQQ62ItSleXHgMFjhj
Vvk+lIDXZOK11FqvS2v/7fv7u59P3C93INPAIJC4ao5uCsI8Nlf1TYQ/k4vOJ3fRnT5MvmTsH55O
wK6IJdjloIzRzBj/EP4lDu6kXJeACZFfeWiD9tG2jZfooWh1aDwRsZEx0RS4Q/3+4leOa5x56fi4
hN9U9Nat3Ez6soPI0r8B5K+3yO2wx8rQZgiZ3vEP5OOtUybIFqirx0gpTAnCWBLXJmGjYZ7Z86HI
44UWJJDRiFUJdUUs3xrOJ7U7+9v+/pAHfwjLYPvEQH00ZTmGdQYoJtNZjDLEsgrSsSYKwaKXUQlp
L/PKzpZb8s7OBpbomcoF2cIN4fWow7vNY/cetID7p4eCAYJ4q4STcDtaLCYZCTBwHTGQxhsmrNXk
MlPQX4b5v8P5F4p7jkaUqKxrh25rJnpIeOPgXXzCHMVjeVI4Z0CodK51wxwVLWi3Gi5/wx2JjTPc
Y/VmymwyQl+WvDlaZuHmnAaM0QDddG6w0JKYbt5a+xgPiA0ics+AvTtEJmLRH4LZm2jL5hoLVWJH
I9bKyLQAFfdZwfc4+/LNPw4pMJBMVjDgayvJyRSEpX1yDfNjJTPBTh0uiLcOOx2E1rBB8/AYGN3a
QICAEZc0XTQHlTOXkFUyULXu1pPGDO6HNK71wsRQ7yBXblC6ZYrwRqQWzjkwtcZgZyGBKbHK0DZe
xsn2SyxId8PDVQllBXRj5MRDmu7hcvq77n47sqtj5pQYKp4cf0e7TiQAv6OgTESM2LaY4ZHJkiFO
Gx5AMb9Iv5utueSfmo5blcjM7y8ozmxTkqIpckP5E54rKeRAK4aprqIBogNHRyk4Or4NQIhk22pQ
/GhsL6vT+Sw+y6jYeRNh+FCyCdM4muJ+DjBT3aLjbExtMrEBkRUd9iFhlV7duJRY21qjzGUHLi+x
4BDERyX8sga/IhMXRy4TDfRruhuDPV1LndqYUmMEuucjpk1quDkhttq2WBL/sl4M01XOlKwejSrx
URWKZHtFJ/mGucd5btozMVNpKojizjTRYCci7KxlPcfGnVYYZwEffT58r5x6qe/KeEyJQMXGpjvJ
J7wNC07coFKIHTY2hY8Dq44eG2DBqZFGc6yiCyIhNy3IUg7j/LQjQmHt92fUuspCyyUwJgNXJQ6i
gpiiap4JOllu6CiCkfAPVRwj0MYIqixIJLntK9wZz7VqiCBGBEq1/ptw3KvdX4zAONf5JA8oMVes
gnnf0Un1jJ9PIeOb3UGm1FoeOFKUEjObTaNadPTkYF8DYnKUwXneJiu8uZAjHRcKaZExjcYU6Ky7
CvXe6M00ctz9Zf0/+pH9OjNVLD5tXGxaTnOHXqymLtCqpQPwWtWaeJGD4Tj5wk4cHq9KGLcVwG0/
qVwe+/XT+7efPqzv8LyxbGlgOTNfB8u4BKU8cY+RlljMSTPSGEmt4pjGni4SfccrLGjooxElDnZu
6NXbXSfmARDD10/EQQ1qo5BwoqQcXCLAvhRnAqM4cscpkOUZoKak5UJZot2lfq3JcmfCOsbDViUW
89hx3RNJ5qh9d/0BZDbOBQrzKpuyTn/kuCvquASpwKAaz32Libyg38cAGwX6pA2X+RoOa52Ri+Hp
qgS4cjv6ne1KgeDbbm9Z1Nl8oqncN3xrpWataEDyxdgsSxuMIGtApHeKssQTvwjw/fQLBRO7mR0R
IJwnX5r1ejcxYX8cVrpqP6z77bbfus3d02AlPoaPFrpiAn3d5IA3rB9tUJMHBR8rq1MUaZhyF1Gs
M8vVUTzzhVWB4WZuPjUbqiblCdCn+L9oe5M2yW0rWnCfv8JLb1iNeVhitOtZQ7VTkt296Y8RwShl
KyuzXg6S9X593wtGRhAgGUm59byw00EUcS9JAHc85/A6IBPJy/Cfyl6wJORgwIExSFrIcWf2zoWO
eUV9BHcuboOrw48pwhRhnGL9i5sMuqmlnhsOYHrRxhJFyImHelPOjviSE82FkZdjLbLhWL1GqXEu
i0T09V6Y8Z7rwIEP9U4MYrElWVkTN73UdJQouCGM0rPglsImhoudUhWptB5pYNK4ZqzElhiSs/Eq
ecn15oh8meNKJL5cb3SZW9BWS2HmEdN/3eW7s/yEjEAJOkhCufZI84drhNrOE847l5T0BPFGjdz6
AeEE618OXr2ppZQLou91w1bj+/0vi77YiYaHRucZnOREaHQpo0AAcCQX4wYssmiT38aX0E6z4ou1
w2qV5pjBvTWEixoCAYvFp+0HWO9tylc1ZkMMtq1hG2RSxRfTYFIabjuWmDdahkTydQzh9WL1tk4d
pBNLIku9q0LAJQyWfu3vX8vR6T6XVMIp8Ih5EKsCQXDjDpwxrIfV6DoiXxW1TGU40cEt3gRsujDR
CsbpwshKNczfzlRDQiQ7y48UiN/nKTfciUESD/fz3wWDlxqNXDxEOeSxcgI9flj9TMBCUl6wkLYm
SsZJ15Mk4/VapWFuRNqe7Zv2vXF62KePd59fT5VhyX3C7ePfI9/IuILGilQvfcyewzmJ3RFcYXGg
4djVp6jgjkejNtlhbzOsHIqnqze16Ev6CN68on8OXx5f3qokMY/3+OvwdK5zZMg0dCKiMwyNFOrA
iMxY8hwK4int4ChkinsTwZveZMIszrgGAb00ttZzIWVte2mbmBPyQo13+/ensEgIZTBRHTTrsFUR
3pXBDBdXXTIOOT90jttwJc+zXFMJLtdazPlY8ce9qks4kVcbhecfcFMrXbpcKmedIR2xaBI7bQsE
aidAZA7ulxUh/xldR3+Hqdd4me6/NsosfXoD5fWnl/LHb0ZeJnYpWImKSiNZFzzmvLiwHRLJdkxj
BbcB+z5vOnPe7r2yYE5Xa6kHtiT1oT9xGu2fJ5xGI9+mIYEnBueiV8jGhAwBnmEBvY4peReF5U2b
4+QmzeTz8n27U8NR7E6QUE/3cJa9RdrL7CxZ66JV6P0EhB3hCKhsYHbuvDJCpBxaQKjLXW7qmY4L
02vRbBblof34cYysv9Xel+JPpsAigM2aBIbFOVj8YZEf0mRPM3ZURbENk7VMsBpfmw9dD8FPBtS6
LsC22t3OsDn18aRKZPxCsV0JzH/mLdVdpAhXiUEPh1W6VCUaFJcCfNStxHHvUcbNC0NA0oWdYk/o
/rDA3LzI2uwRBTEp38WI301GuD6JfCkSW0oxOCDzdtbma4zNleCDWbDg4EfL9DuAmfCtmdJEOgaa
gk8pdixj8zimxJy3FjvGQgESzzT8OZhWCwMbfeySPrvG16nw1RE8/nbon/YVZoGRxlIC5ymNBQDV
g1GaSepSImCXCsdciH8Y9P0y1Qbc98vgRsV5xsoeZZs5D/f98/Mp3M5G3vOxeE8QOJ0YUjAJNFy9
64zAoIcUMmXYzLW8nvR/u/GK63O6elNLNzcHenqwZqEWzO33j68PL03OQxkw2WwCa9tzbL0xnStF
SCmToIIWxG33Ok8zXPE7TyNuanHnMZuesb7J3ZwqyGCdLecLShQjaiZ84X1BA9Rm3hmG2BIhxQAu
tAvG/YGqttlcV2vbZqNvaoV2C1qaltmsYPg8DYe7faubdFlHBraaJhy5ksD88dyTTgrQzCV4U0Zv
xhI6z3AFSeg8ptbDzLP9PT+Itj0BngR8rDUxDLicymgEIVToFWQVkbNMYCMOQ5ikINRGCPDTzddA
pk+XK8HFQokS/Lg7rBSOjMktuE8XOv90d/hcSg4nheDYQ6QR1c5g/zvSajqrEIQry0C1YHkbStV5
nvA2y7Vk23Rco95+ST3wC0Z77kQn+unp8T9ncHaDdhUJniXknU+lbE8gobKAJYS7lhYuEybl/w+M
vPEf3I20NnMhGh0OSzocJGVzSPPXh7uX5xHY/MeHcTeeQrMTy1NmYKNJjs1RCrkSiDJdUpJoCmdQ
lux9aHa88xUkc7xca6CW3oKme80bJKt8OzLkvrkDJWkLZx9hYOKS5NAdAHcTtq/cEeaFpNExm/NG
sNG326/CWL0NqMVf6GruRS/bnNjL09B/gS/w/777WmP5MNhnte9MZuAgaAbyO4Ut2YkilgezblMC
fXr/lczYZEStwUJWrxfHoW8KiV+HlzeWkdv9z8Ph9f5Sv16SlJxZGk3upCJwmEuL9BYODhYSEkfW
4ag2eWaLE61EapaG1sottEf0GI/YTVrWxpTh3a/DGc3XypGSRuTIOFKfsIAuf2ASE0ukA59FGCKD
UhU4eF2k1N72ppaBLwjGiJpSijyeUfspMYUtD/NynIH3W9qWC3sCsnZQMG5T9FYztU4h8vi8JMdC
KRrYEdTKpeTBtF1ucs4aB4YPAjR7jL4rnTvLGVhEEbYU632kTG41Tx/e75GbDasVWigoR0iQBsbp
0+vzz00BCFeKaMvgrKVIrWjBh/Aq0g62FwM7o1faXe/WPd1zpTFhvNjIurD3SXDRG7ZnBN36BW4c
WIntoKPJSWmeLjy0iQcDex7lharVB9xMwDyNyDuXMidukwUX2MopymqZ5wzV8OOgGq6WM8bWDz+/
ftk99Hf3E2OAEfNBfRifeWa09EWzQMADAC/TxWg6FY10XhinNdsG9TWd5x3Yr+nQWreFEpyd4Kap
lP11bJtNzwWf/jHP+IElk6dSNXgTVuAyFRxj1uB+dl5G1lkh4fcgkalwU7jqNNdKuOp09aaW2y4o
o6xt0EK+Sxc32n6QdKTekKV80IEHYFK0XcTCKO6T7RyxWGlHrUCUXR+3wfhcJlmxDS4DaiUWSDR2
4miajsmvT4992Wo/nLiBEEVv/KXp5BFYc166rFKijriORGY7TsHEtiZ49OJSdJJnvbEbqZlnFT+v
GlXreFx4UZIcBzlLRT8N+zaH60zQnCANNUckZG1KS7uE/0uTlaASLNitTs4/x9uvezinAZX4cgEr
fiel4LX9cBf6+wE27CesfBg5L5T9IEpmB7mMjKXwCrjBpJv3WMsMBrXVCBXlo9mGi3meY1mD8+Va
/oVcKLhmvHn8b/92oWNcEX7qpbI+UPCawIhTEoNP4OYgxyJ2MXgvYo5J5W0Iw+1ka0DD7bhataNY
Uk1INusxQVMq9sOXxwfEenzcP95X5RwiSOp8HkmOuOcEbDvwRXmMUlCmiNDpj9Q61DNdL3moxzb6
Lbw6RS1rtrjbBP+8gGOMZ5A8tWGVP9DMA7OV26A6z8AA5y6D5+MF6YJLnjjwTKPaBnIxnWhlo5sO
uanlXtjq1M423+GlNKLKMcJNj3f3JUN/+ipNaVmGg8YJDvu28ggUQzLs4Fi+FinVmTEhLMsbG/vn
k612kM+HVqpaPrfKd9bu+yYi8v3tKfr1POa0CgItJR/UqbFf5aSothL81ICoMbjwGPGIFpo8VV6R
uI2F6zLRylu7DKgUOS5Yz7ujPuxqNJ/w8+vDL/C+TxKAA1vMNyLOllyhd080gQWUkVQsYuev0J0t
IAxSZh8iAat802fYTLfylupBU7X2ZD93CffkYJstvXRGnnVCQu+x1aaYDsxRo5gu4MaIfYNtzNTr
LjGsCqfYEhXfx765qsJ0RC3/Qnx0T/m+rczp76P76byNY1nReB5RcPtUTAJtUVg06PsZlQMSC3AK
ro6x2ygRxwlWt264dlNLOA/m7BkYAnRe4vn6+fPwXEABLswXdHRaJezKVoAtE2gqNNhgr0WwPiM4
rOClKevo5rqiyTxXKjsvgyp92IJlsBfgptSvYfgVbIpf0Bc70VBYLt7cgwy7FoONmTGk7CVgqvkE
/5WSoA6MUyvjdayLhPde9cnert7UAooFqYXgtdT//CGMHfLjmQKb0wdR0IDVqbrLJx8sLGZGGXxD
OmMMl4Cjo50Dhzhjz/ymaoHJPCsFA5MRtSZifjzulTo0AfR/DTt4Bm9sOIwqVvYl/N8PxY8Z6aJ1
ouCvMNNFBjYmp0j+gL6AcjxI4TCQcN1VG+d5N287FWd58HREpfAS0cUeoRvnFXnffjOmR74b4KC6
Tw+fJ9jApTQyYjFOyJ02CFpiRHlzpGOwdSWB9bjb/IPZJFcSItNhlV5Gzz2EvRW6ob0Yo7xf7g53
o4of48e3WGmJW0uG3cIMNuLCnpgQlNIhzm7O4PcGRZ3dQKQFd73CogVXK9H7hfAu/ihUY4LuH3ts
cS5Qd6zQuHrrBNO2y3Lso81gnhHWaSpNBntUEf0ezg3cc01UuFTL2S98OrAlU9pg2v3yaXj6cvdG
C8rsh5H76vQXGpOYHcjSdFQjNahiDrMcpDgzRiENG90IZTeZag3FbjKkVmeBF/ggjW14gctnV47R
WYVnga9TTGqduyQQX9pE2ZkMByJV3LnsYGuWfvMaqGa5sgiqcTe1+P2STkND+ffx+9vXQq13Ri98
fLpUaJT/xSM+SWYDdeMexhNYJrC3qS4kQuCEYVFuM/mXZluDyJ2PbPQ7Luhnx4Pn/m73o/v0NByH
J8TKOgeGNYevrqSlGcOAjAZ7C7M3lIBCKZjOgmvDHec+bcO2/PGhcEL29yOc4IYU1YJctV4LOH4H
uVOrNd/HAhWEJfdPpRNHFMNflNoU0ElIBWal1pSjq4ZMnfAGYfuyRsP2FrT8A4BFpzmuQhadxtQ6
7fSCTnvO+YwQanjaD9NWY00LyHTBL5GIBILRNVCIuxiwBVp2UiOWMNgOibitcFI4y5bTdSrROuTU
24ha5/3cMDrYw4EsgGKORYx1eiiR5AKcNogmCeZD7hz4AR1s5QYemyRqG8Ln5PZXvIJxwE0t6byC
7rDvW5wp94x4dP3Dy9KOmKxzcIiyLmrsETUB2ythpVEjPIUDNUgZNsKU1pOsopTWw25q2Rfexx6L
8upMx8+PL4/zxM0UEAEcT0WxYjxGZK4gNHZGY7kRfoghukC30YU2U63EQutBtUoLHMIDOdIGq+3u
y3PpuHwtvOV3w4wdSBsPXxVWukaMWwukdSDIwGRUEAINc7ktI/XtpbWzTLRGbN8Mu6nl3y0pddzN
sIK+3vdvbATP+V8FY3psFsfsvEtEKfAnFDGwfrjmSCUF359LkbqkU9hWQdlMs1oCPx1UqVOculYd
Ohwa5/pSqVlXgjovDZWlux3BGD3+FS2YddiSGBSPVpo/oxL0cr2WfqGOdmBkaBmnSs7tQ/4Wd8Fv
7uqtzGIYLWOg3SICozZwymbvOgEnEEPgnWw2bWWXu69s2+frN7W0czth2FvduHWfxuK36dEzkjZp
sFARJUgFTOlgspbx1EVjnOXMJSE2xdont19Z55cBU/GPZJiLf6SMcTaW3bzcHX7/4C7gsSUQQBl8
/EaKjnmkepQRm+2w444bxmiwhuRYlzJPb3NTT8UX5pewSht2iKdfXr9eqrEkdjmMBLfJOxq1BJtD
WsQHSZ2JAiFtldTcB8wdbQONGmdYA40ar9ayS7oguzJDvT+CCwm3nL51FXiSNCO4AUHIG4cpCgyc
anBHRADT0W4yNcY7r0RTyrVaXmUX5DVtdczj1+Hhef909/UUTCm0SmykTCNgCEXwVAlF/OkUAtjp
zndJuQyPPzvyDvfDxu6F70GE2zcRVlCJpkNqNRdgTeBHc6jzLG+Fcj/fFSC+QkJOilVrmYnUWtXp
kPAANrAoQ06dAjuDCc+wn+5PYYY5SfD3j9fpyf/efHZm8TVao6oarbuHX6b0N0ivjvQ3rDA+WWKp
9451EumUOVe4aQaET/Qxeua1Tu7PUPHjwy9rZSO/NEr1S0oddr2ec7p+6h+GEYSCFewySsYApeVO
GC8V1rpgYgw8SKvRT+bg6cMyA+eN/BlaTaW4xv06jmj0HBb0tIQeK3y80vEW+q8vr3heMIJoZiWy
8fZnQfJNVoOT1XmPBKreg/MlGRgi8H+DI0z8SYtxKsvKy5yMqLW1sx1yB77wvoHW+h/9r/24lsfz
cTXqaUximRk4HxnygTNwNT3Vuksy+5iSNPwdXLp6pmVt6jE3teiHJX0GtQC4ev/4+eSsVlEc7YkB
3wT2FjjruSvFhmBwhSwEYZ46ua15oJniCvzqZVCjynFBFSMPh1N8o4k8tBEO2G1gG1IRzl3kBRMG
S9XhZFBwCDAfwK5hjQ2weMdapkHOZaJKqHnEOMRP3fe3/658WqoomnwdsZyDVZI5Fphjyww4gxT2
OJvM1kwL3H49rAoXb2oJl8TWLZfS7fDy+vXsRM7qlEqc28iUfAydlQ63ZUs6Y8GtwO5T+DJs8HJT
hc/KVGvHzOLgWkWt5yrynWn7NH7K501r1EopWL5iRJUMQTqwycBAc6bwwKPFiF2QmkSfOai3Denv
Mss6mttsM0Jx7VwHMdhDWyvXf/6MDPamHC2mcPtpzYIgsVMpIwemoWDwEgL/NxmPWP12G7rEeO+1
gji8dlML188l3jGpmoaeb688dKkdJZi3DvCAYZ0GBfYxY11GVAmvOGyo21h2vr36zM+Xb2pZ1VyB
fW8tbbqaHw7Dk3/8D1YjgVmPdsr4x8hra4mDLRLhzzE2HDpjVOiUlCkgl7bcxmt7nmSt0fd0eaoA
o/N2ZfjxeGx6e/q3eoW3uoSxTOaMEklLx3zK1iTY8G3mSN4i4C8WZCcMEyYzcFy3McXWc6xyBU3G
VCqxecQAf+RN4LD0AsFRLC/ovOUzJ52lhTEEEbe10p00kXjFdAp+095Ubrxi0+OlSlgz967hR2mb
qNpIhNuECJUVBQa2cKwampEB0XXBoOXgJR5X2CWiswJ7XxEbtqXhpzOtNbpNhtTayH5BG3Ww9Xr+
+8dYNeooGhhy7yYEdOa6kAtT1+XIstUCFve2Un647UpH+MdYi6mGBTF3x+Y8+/j93z79iMn2gvdU
WldOf5ZVy2UyKXTSjpBDGXd9MA+8grUcOR7H2zI6MMlaCgcu1YIPC5+2VaK3cxih/tcxDUVLupBj
FgC/Ey4sBwcPUYIpfOWSuM5hdT9TNiYPF5x0m2vrVqtNxouV7PawsNP0cmgC4ovpQbAcZSnDGstl
wH8LOXYRPDp48hI0IGBwJuYlkSwxneXm0P71L30tO4iCL6zb3rRsUR/d7Y+TqPHp8KKFfLawfmYH
lj0YckGBn8MZw+5O2H2Il84TErzd1jM4nWflY5qMqDTBPWimyU71DRzaT3dPL6/9/d/6lh8caagp
jwb2SdgswdGG18HB05ZOO3DmFINdaIsK1QRrJFGTIbUSemHjgR9NTQ38pX/aP7bRe0GyIo7nDk9h
sH0wlYlrmhCZOJy/QWW1McC2f1yNru0fG4F3CwLvOTG7JRy030Hl6qEnZPAFB8vgAuaCm84z9Aec
Y4lKEsQ2TFq877LIeKWWeL+wfveiJ3MU6QalrVgIUheqdZpVMAZj1wgO4sFUDvCodXTGWGkR4OQP
VI9fx2ZrBt3Uci88/r088EWGobpJ1lMKX0oynXIUa3Uy6XxG7uHI4OwCB8dvC8ieb36VX6gKyaKM
C0fXcBiO7VtoKLneUDJOLSMIdHRmHZMhB66RCNGZiOyUYEHDFttFbTllGWxRIv8IG9c1FIx6zE2t
xXxL5USoGcDZ2x1GfKOWfosGcOEDMjoyfD2RRzCEaITtybMA74k5LTcRVv348T0VbmpJ9YL44Avw
62RpYBI+wmW4Nkn7cKku78cqzRz4MUhPKbGR2XSGCzCStOFOEhFhn/0j72c643UVpyMrZSmdf4a4
V+rD1kaZUgz5w1O//2XKSzR2ywTjCNaOIrU8woiDQeuijB1sFd4Y7Um2/g91y0wne6dlZjq0UpnJ
uXcNxpQUeqWuZN/f71/vT5yqxXosW6ADJSi3nYZ/C4sN2Xux2DdScPZE4oZSv7HYd7z7ar3veLnS
QS/sHvDjsUGt/vTz48Pw3euXHdyvggeIJIWIPYrCl/BzxLyB7UIMUuaghLBbE/fn+69m7c8jag0U
WdBAWVXvfz/+85v8+PSlfxlTPGAjF7gcNcLUB7B9JfgWHY3Iw8J4IYIFXymFRHTw4Adu2sGrWZYV
qYY0msxNFm607Gee94SO1f0bt82ZSVmOJeIUc/BytIlY3oMVLwz8cJ9ASykCtdt42JspVtzvetBN
rYNaUKzf61OvcU0wewq7YrPBB25L2Sh4fLwUkHNYIEKmzik4knyApcMCWHRB1HHXhRvWAs2LLXdw
UNPGx/7XsHsnOg/feJb4yWCTGMa2U2cVNV30icCpYqKx+U+qSV4/QU8Xb2pl2FxDIVqr4BPsamA5
/2NS/C7shQousBBiCqpLCAHCk8lIHYzUnBK8E5pk2Nbbd5lmLVX/dv2mlve4oIQcmvaqAo1Q6InO
RR6gBKNGwb6EPBocVgL25AiwhqNNmlmf3gH2Kfe8gsRQySnn1Obw4+HQPOz/if2/98gUeu4EbppD
L33JHsxJ5OrppMAyw5gQWV4YdMotc4W4Mm4Lv9YzvdOZPG8PRUUWtFNHva+1e757uvvwtX96HvYj
JE75s2pJHssXsqYe8xZIvId11QrOOwrfWPRKWPC6WN4W8b9McgURp1y/qSWfe7faCtOg4ZxpZ+Zb
64jCRAqgnO2IcGiCYd6CWGTaJlYp45PedmrP51lBPJ2Nu6kVsAta9bah4YwDBi4qRrgT/YwtEYhS
qhGVZ7ZwDBOPbLUJQbFEZ2xKsA8YTra9n3auNbz5elStVd8vadVzqS8gFfie35g5znAVhZ0hqsg9
JZ3CI4NjG4wR2EHOREoRdm4n2CpYxfyujWS7JckOmkwki/3Tb3dnGmqu9RnKk0bcQR0YSll57CtC
rJKIIRIO1oa2jPGwTj40uW0lFDyYmVAWNvSm0G88c67lnIVwmUneBZcVdhDwzkZEESRSBsm0SOq/
77QZr03lBjd/bh/gj5LO2oQ/xfxWziclPkmmvReeCrCeEaBKgsBghZKOgtGTaCZg7OTNu0nMV7aS
mBuh9ZLQ2jRCl4oDRMQse0cpdyXesag1AqhwgkC1tDMJaS+1UdIabDMz/3UZw3itEXW+5VnLGZsH
ib88jjEaTuBrJcVJefuzAHpSYq2lnZAITo29/sahJaacIZo4F5V+v4Hn8XqEZrxeKWBtv6CA7WVd
KjPlMTljtk6ItQxVKWADORiM2GbNwCCWhsH/9UYqbXUg1ynLptwk77OXVCr0+/kpandgzpyKD9A4
OGO3Gjqi/hbrNyH5l85dUAbpMsDFMtg+lXFJGi8C+I619Xu51U092X5Bgj0TfV27dyIw+P72ZAz8
/bGm4QsiYDgxgFuBqOsZ9lYPNgmsOA5LMgo4K/IfoVaoJrpOqlANrZXbL2x9u2E3LLNIjMJ9QjqQ
36syRUqMw4OCGdyXQ2awmwhsNEzaEWos2PrbuI8v91+jO76MqDUZFl7TnvIGceStQPju4fDt7+Mh
WinCdFQiyo5Fju1FiC0gnO9yyiKmhMiDm9qLpvdfY7W8jKgUOe7nJok9Hltkp+e7w7Dvn7r9NBpp
RoJRCSpogvwQCnuKvNSdyZgbMRkMFMI88Ztqzm/HOdZdqMmAWocjW9JBN5/V2X7+7vHB98/DKFCF
kgIuh4mIwZytQu7KPKI8JaFYTnBIcfnH7Plqpnes+mpso9/8ZOgJuNi1frCf9YfhZdi/PGL8Z0Sv
EMqOfKOOCAqHbWexzYF7HTprouhyEJEZjH/bTcHiCJPEt0lWjMXpkKkiPVsou+jZbndcyEU8vr5M
m22Jlh/GPGLU2RTeNU0x74OUvA5Oti75bJiRAuupNicjxlmuJCLGAbUWC1t0zw5HW0fjvmAS8rng
6S110yBWgzc6dVIifDKTFIxL7LrVKmebqWFxOy31CNt3LRlaBlRqqDkhDP64Owy8fRnff325+3L3
v2aQbswmYpTmsEDQrEsWkXkRG9YlHThu0XYzP9R0jvX3MR3VaLPwUhRrURHy0GMxUL7vPz+37O2k
WNWBwnbFdRcYEo7qjFW6InfgKWob4IlxvQlqcWGilZ15PrBWjJMFxZB/oT5pHuDvu4fP+/7+/nh3
/1Ki81W+lDLMfgnWxYAM4jFjhacnXRCME6W0y9tgUD6eZgowUy4zrVVSt+MavRb2AmUHVr8wbIWF
Vz48T0hMp1rBkW+ssaGDlZ+R5VOMjULKa68i7HmWblpG+Yd3KEt/WKonAIGPC1rshJxXht5G3wov
vQnGc8RRRjovsMoQ71523nEwguGF8LgZehhufwV7I/pKbL2QR+210ju6nPQ6PD7Ui58yfs7cgQrK
Uqowz4UN4IR1JjAKJw1JSpDAKTV/JM8VT5Ndz3G9jar1UgsnpR5oY5Z9h0uuv/+mf/j8Oi2LGAFu
AyESTkXwq7HSBr8tG0KCdZIikZ7Cnn3d72vuvhKfrAfVWswpJHa9IX3LIdMf+6e7+Wd7JWaQdPJG
wcaWY1SIdU06Z+BVESaiV1yHqK7rtjZnZaZVYyrNDFvSbEd2LeTOS3//+8ShMee4FxjFTHtwZCRy
YnHuLRqbSIUjwWE30blttv/bFGvu+Xi1Fv6wcGBaOhwO71GvfhjLHdcpSh24as5y2JEpNq5RJGDW
SXcqSLDSAh468k+gKJ2IsWa6nQfc1FoubHNWtQW//u7xy/DydLefYKZKIceXR0rdFBcig4EtuEGK
Uqo7m9HhoSEJJj3fmCGeTrRCAzYZUanS9wtbxI6r3bFtTEUo8NZGMIqemYwiYltkbMdPimKvugDj
rSDASJ5ViIj+vbFHdTLVap/qZMxNLfvCZ7kTvN/v6k7F+/vH/S3snb+cbnYubJOn00ipzKKOHckc
6UstbA4aM95OEEdlCdNtK6hqZ1qrrmrH1XqJJb2UaZgyb8HLgA10Hi0fi9wMI8yETjKPmMOcY2mz
Q8NHJGJ5EGQjcHYzyRp6djOsVmje5gg/7vnBjsGlL3fnyLhQ/Jzeo5o7hUDJDN5Lx0mgYC5I2aWc
sc/Ke29SHVo636iefqEQDH7U+/ps/Pz19fm3D3/79OM/+98C1mqjJclLiLGcjhxei+dYu0kKtjTB
uCL4kcwJl3MOMW7j8p5OsELkPR3SqLK0hgddaDmnuYECJn9+qIh8RorF4nLwhHLYdxCAUyGSAbZ+
EMWC4h7OkRyu5hwm960FGxYFG966ls83mEQo31qYQbySE9UyUh465hCsUIBzZWQgHTL+CWcoEiFf
Fa29cyPfwj6+O/ZiCnT+Rtf5lqVhJbufmKYYqUISEw4mdmfB1e6icLC5iyx4SqtiVTes5Tku2KF7
oY3gF3mQA+0siyml8wU6ULiEoBMIYIfdsFl0xiCNB8NIgFU2kvWXeL7nTT2zWRLH6GPzXZXGwvOb
GwMs8Dhc8h62mliSRQbMeHhxsLtmxgIRPpirL25yz0YouySUNf3kGX38Hk/Ct6eE6xTL2WFBdEII
An6sRCgFDoYf84hOCEeUW0+rTe7WiDKP8O9Iv2u2ZNTm7/3D4benu1OrtirV7COcjQTrTSFXiUYs
b5dwKwHnIVPYzzLIpYnf6vNMJln3fSaDbmq55xGDHTsMpkURaUovsCZ/ZGOGnSIxq1JHrEWPGk5N
T+ALoNwrRnMEayC8A0veP738r22NrquWztvVm1qP+ULfiZ41sN6fhof93X2DcK+j1NEp0MNh/sgi
JqHWtiOcKQ4rLrggriPcv911rUL2dPmmFo4vSLzTvV4MRL/etWHo5JTxNMPB6D0WtCvTge8GmzrH
jnIZrND2D4Sh18pIz5dr6eeQNPDjXjXJu6/D0xHLyh72YLjcfX74+vgMa//+fjizElEtCilj+V+0
mBEmLiIiJDx2eBkCjBfGZAfWsoxWE+ON2aZVO9uaeu24Ws+9XtJTs71uktcfH56/lhAwFvyuOqTW
SVAviA6cugjHHdbCJ+whYvBadUYovE2lifWEqzntyZhGrYXXJwm4PXXv2UNhFoadpFkyLjOVwVju
pEnIIQUGhWWw2xpCJXOGg06bAjnVBCu9aNMhlRKyX1Jip+mcCesf8ZuK04IZhDvyXSSYLMTOXotY
d1opi1F17h3ZuifDrdf3YrhYi7y0bBQ4Y3Uc6oenu0Ju9PJ4LjmG5cE+UDMevSnwANYJMlgaZDa2
nYs5g/gpGSbh6N3GRHiZZo3P+O36TS3vwppQA2mc4xf814vyS+45ZXCO6MKuRmLE+kTXSUqSxSL/
kOlm+a+IXks9zCEQ8D9NdeVI5zcHBpuUikVjsS+E4zEosRnKdR6TgJj35hlOxbANq6mdaq0rvB51
U8u/cKYfketqDnb2vJSVCdiSLCjDOCw2iViHWZkMyyFyawWx2l+HEx1vfQXTrAqsgGxzA3hPmDo0
/WgTIItTsesi9AaTCU5pJjqppceEMu2sAz/HEmdisFIJeh16o53ofVyNNhsL0usFlcTRtnWWaPuM
qYryKs6hcV7IRSXTTKpOMcQxowHPhRzhbLeRInHnInjWHzetxmFjeuJ5tf/9MqTWVJIFTa1qGvfB
/bmfYF++1bwIjQuoJNBhi9IRay0l0r+oJDsvhClBWjgRebTZbmRGmk60yos0HVQrZJde3aEtQfrh
8WGYALqfD0HCYzSggcjYiK0MQqFb2lGauc5OpcA2lSRObr+ymV0G1OIf+JL44PTODsAM5s3jbz9O
kLuYoSeznhERGAdDixljkZ4D9oCQQkeFgm/PKEvE5gTzZZ71Q/EyptKGLhjEWAfUZAEwvdZYIzII
orjF2nvsw3ECe4UJAcMxy6DAlo+Bv1O5dr9uvp8u3tRiLWxjXB2blXC7fxqGhx/uvpw2sdGjUkR+
UKXgUoCtkhKc3AIBXHh2sH0FrTphY/bCZEvdJt+wnmflHKnGVNrwha7UPbd8r2fZseE/L4Vya/yz
eQ820aQx+qgEJsaUwsw4cjZIA/ZKhD+V3poYG+++nhIbr9dq2HnAby+NaJJhY7rmwzs9FIFwBfsQ
+LrRSwSxM52HXzojs86W50zNJhtrnO3Kazlfr3QxZkGXPfZi1c76D68Pw3MBOqh60N9SlYjJkTVx
XXIEET9BHyedAssl5yCspyps2qIm86yQCF0G3NQiLyyU/U4U/+n+brd7fHz5OhakvUWXjD2Hgr2k
nAcWu0CwnF3gqZglBx1s9jEGOBddHQpu71cLs5vjA2EB5LFBM394eHwpttY0rXMGOnTZOx3hA88E
jD4eaCrByo7axDzR4FKEbQ1M02lW6janQ25qqefW7IENVO9aDB04y8PjF3BxMa4tT9CpY5OzyCGA
D5elxnpq0MMJY7rEZIgxZWOo+/NMjjcZrtkcb2NuaqXmKdSDIL1qWqBjnu5GArm0xxQw4VwhByCj
FBmCie0sRfqYJDU8AKpMvp4CHu+8YuGWaze1aPMv/tDDbtoks/fDwzCRWGGTTUlLYb7dwYfaJY7u
BQmic4Z6pLTMDvk1qbrevfV267VzYLxaCX2Y03/jj0PjlxbC4OHfn8LZK8Ja4ChiJIWDWRRKglwo
Tg3s/ZLajIWE27bK891XMpxvlxvJjwuSm4Oto5rPv3z9kIfhsDsl3xqSVnDBA9KShYJdmmCzsfDV
dAw2fxJdVslsg0+vZlirf5qOqXWZYxLuDsfh0KD0zQkB6sZ/rQyH5647xAhFTmyPbRxgbTMrUxRa
wVn83xEUrBJlL4y8qZWYa4ZbWBNvinfPL093u9fz3qtJVT2kMWluOubBz+MsIO0NYV12nDoHloba
9p19fHh+AZtuokoNBD0VYRUIejroptaKLqiqlK59iu9vT8AJ922dobAFUj2LlGzq4JzT48lnZHAd
ybCYosaGh02HzGyalSBbO6xSSS7Yh4M8mCaTOgHcHyFBa1x/whJx8CAwdWqQSFZ3FjsINIf9I2tq
rKB/Cq7/ZECtxsEuqTHYNgKEdNYfH0rgetq0MboaPJWDhBSCDCRmNMSkLtkIhgucVDnKbbGfZpK1
4E8zrFFovvcNisAaWUftrvrkAzWeuoRU83g0etcZCh8ZY44Fb5zy2xzY8c7X0LorsbWYn+iDLgS/
lwTf892Xw9kkLAa5R8w/6joQOsEeHbF5FnyNEDxJXKWk1HqC73K3WpIFHLDBWtUU0qMH+HdY8o8T
/5+MwBeKnShtmRZe8ii6JJwbmVOdxBQ7bFaCR5rhoW7ES3iba90dPQ24qcXWC7rsacNt8+3j7u5+
OG2B9ec9dpAaqX1EzAGPsCRUJkRx112i0gVOjOHbQDzm86wUxczG1Vod5iGnYdfrBo3rB3AHPz58
fX2p22FplKAKfNGCIgSX177zYJJ0DF4JmCkOC4C2tcOebr/WBXu6XIl+WOhvO+peWD2PzZ6mbvHE
qkgt90jhCedAwiYgVbKU8JcXGRwRp61k29komvmuhG+bkTeVMnNCwd3RCqNbdKJH+J8THV5teJkg
IyzdjMWmGTGt4GtjgnRKc8YDONlsWx6pmWItD1sNqlSxcyxv+BHOp5bu9iuCr3w3vODNL8Vy/HJA
eA0eK1VYz5IQoRSR2T1HfhcJXyMBm37jPjCdaW0rmI6p9NmRhY9vpwYuZ8VkwzzZcTm0pRPBZaE7
khDTh4AZ6Zy1HViYKSRqqSFha0HZ8G6qox5UKTQsmFXHge0atwobi16/Vpi+mDLgbIzq8GiTEip3
YDdiDS03HRzcGQlFlYrKeRbothJGnGatdBGv1cKz/YLwyrB+rLN52L8+PcMyxAD5G76zLQE1T0Sy
cKgkZEsEhwppatH4cFnz6BNcrOMfszvVcixU5B0HzZqH+PH7Qsb17fAFDhk0PiqyHyWJlEx2WqLR
YGDJOot0eUFqhqTHdhuD42ySNXDJZlit0HFhB4IfldYLuZfpV1HgVBFo0lGTJQiN8EZwcHMOZikD
fbJPET1xS3j+r8Mg47VK5OOcFQF+7KXUbRIFa8hak81FBwZGIOANIHatIRoOAPhApAxCUgenghIb
Uydvt19Nm7wNqMXvZ+LDty33DZnkd0P/lO+G+8Nf/sqV+mDHuNP4FzrcyYiMgdVsPXxELNnOWjgB
tM9W+kyYiZvcm/M0a6Aop8s3tbSHBRXUoHbVR/O3Tz++fft8pGwY/yihM4b08gZbPrADVLDOgG/d
EUWVdxgv2HZsnaZYLQdtvneU8rggum5RT8ZQyfe3t4/Hl9/6p+HHr4e+IeuJLDCpAiaryAgOiKiG
Hez3uLqdscZvj9m0M10L4LRja/20WdDP6ANvFkcxF4eneNd/fnh8frnbVxhTjIH4LoJZ4UeWWTb6
CspKLryISW7L0C/Ns7Zc5iNrzXa7uWas3+kZufdbULCwvZhSQihCNJzyjkXMcjuOkEFg1WKMFp4O
gQ/QbST0Xg81l2uVyGoOUL2n4riTcg6xcwv/hc/g6RXLwGeNk3ByJZIRtgP7pmDlsM4RBHMhMUQV
ZKJbW6Zn06yVdc0GTnWjct4MCj/CftpWvmKjybRsWRYzQiGTGigB3p3Fc9nD+oeNLCsEdsjMm+Sv
1r7Wd60l43ZBMnCZd0MtWaGcPUmFB5l2CYwFBkcDL2E/CkIZobpkjYK1bQ3st1eFutywFkgPc4HM
4djEhj9+GzGGBJ4p5tnbzr+QjDe2VFFj0iQp8N4dE4W1SDoO/7UNmKieZY13bjqm0mUBmBp/bBki
7g7Pv/yKLvZMD6IcUuiB7cgxmxCwmhded8fA1czghAXBtsUg4+0/fir27ooO5+uN/AufraWyf7cl
a5L4nzZigU9suLDgpCBSNfbFYoNSgM+ZwNsiMam4kXduYcY1+3hhaKWlPci5ljtNWW0iucPhaXh+
9ohdNrXtFsBWExh3wlnaWQ77JidIEwjHQMckQYJUG4V/B2Nlaa5q/7wMuKnFZgu6WM4PsxKTJpue
BA1RWkThwSVDEY2pWNuKWYngQkTxreUlq9v+6WIt8jyPvqd73hITuK9fywd6pli4lFdqAScTOvTU
YqRXCkQ+R0Y96xAASXmaNiYgJjOsph4mYyo9Dqyf63HgcBLXEbHbHxHBYURnfKzCE5gjt0rGLlJh
seUCvF9BOLhj4CuyFE3YhnfXTLESCasH1arM+1j2dKAHeSJBfjiO1J9nVK+zpc3AXYAtF2SWSMZn
qMV3YTpKPAXH3ilSYXrN7nVTzzg/ChihfVO9913/693nmQ2AwP1ao7XJvT+xj4LPiPnmbFgWYDpv
epiXu691Gr9dv6nF3C3IziVpSAL/8zI8PbxxI71FfCcxxURT8Ji38CRj+t8H5DbTsCwtjS5qp8n1
Sr3ZDBM1ZtdqFeYQAvCjJKI5id2nSRh0jOpKB8Z+BvtecLC/JLJucGvBoLQkWeEY3WgQu09rsP2f
KlHBjJmLSney6R2uXYHSud80oGIUlzNNnQO5ka+LK+s7MOtpp1KQzATDyDbk/tXJVkzIteG1ovMA
Nf7IGyay48v+/g4d6hVYB5UxmkMx+RyRFiXBOQwrotMMjGUuqNiaivkhlHneA3eoR1UasXnp0Z7x
w6DqV7f/+enx4XGiD0YnhBU2Z98huDls/DR3jmL9AlU5KOIN+Pabgp/l3u+wu1RjKg34gpXHpDm0
nNbf345WEUYIweH9gBWqxSgSmYaMB1bAsjxGMOhJsTtYasz/EeO2+lurGXO8dFPLt7C3SrtrzOwF
hK1J9t+cyjkN8anTpbkhJUR0wWxB1kkoQ2HHEn8UZGtNjXpMrc+83n7PFJX7U8/qS393//z1AkQJ
pthYXZ909s6rjjojxwPLZOSvYVzxwBBGUTecttWdbur55jsmP2AEs96G0AXCx6gR6LaQXo2At5In
Dfah7BRBnAJEEvdOGPD7snICnyS7bjee7ryyw4wXb2rhliTud+23+zIWIIxooCg4+WBK6L78UXBG
YWdUiXXCI7MoFg845ymSA9IYbHJqm8tdz7TyNVdjan3mXYd7PoCjQRt8v8f/926eiBjb8wwPYJJ2
QmmGsAPgrGRkT2NMSKMiEkFsQ/arpljD9KsG3dRSz79ofqT7Nkc0MhNiABWP8sowTtiaA15w1BTB
PJAiW4HtQIXMHHYARi35A8yIb1NcZUh8G3RTSz0PgQq9h7N1XJyIQlRiw6fFaTGhgAWZTHGrBXZK
YZdtBnfRZA0r1Hh0gFnU/Doj7093z/Wzn012U4s0P4tED4ernaV/GzIXciZzAcdWGu1Slx0DGwKP
JySh7XLCmJrUTm0DnG8mWU8FL5O5oNx6QRkxNOUaGVzjvqajTJ6ykBnrvC2Ub153BvyPTidNGHZ+
023UP6dbr+zl48Va5DnWOfx4ODb8M/HuWPorXkq/GMxa41dycFcFYrwoieT2ijJ4A2DFSeecVj5l
vw0waWGatfqs2cBarQUDQezgtLALleLTXWm1XJy7CGeNoR01sKh54PCGjBNI7kJU9rDmpd1eLv5u
orQZVSl3NAvv7Lg3DYPzWHjh71+Hl8dHZBicFk7E4BRLEjYq7hg6vrkzhGGBsA/KuQyOG9teBXKe
5FoJyHlQrcx+roykoqdNSWQVTpqUUZzgdmevC46/aJQF143D4WjBiQOXAmEJNXK5GK3J9Zbv5QlX
TsfFsVM1ZWnHbdXcH3SzNewQ5GdEHZqflYzYkYdHSPD20MVLyiCAigcD3BIwqDIVScuskqKbQYfe
+xSbQbVWB7Ok1X7fVH0692kS+yoNDBJJ9PSITiazJ7KTFOmNEfbWGcI7RzJYMOAVcb8pcHyaZGW/
GC9Wwh/U3IOVA4PDfskev/30/W8PE4Ygxj8wrKGg9lT7iMe+iJ2IEYzaAApYw32XlaZCpODlNhSZ
0zQru8J4caqFMfOaxz24Om0RUlECG3u+/TbcvnGhgetJEH0EPynYo61g8AIixk/BXOksJ7qTwrJE
UDu+DSoJbr+yCcCVm1pIuSD5cd8ETvv95w8fQWvY6kNfgdtGT7FJBHFA0K/GCjDwK2A3Q3AEIbkQ
fCP+49vd11J/b9cr+Xs1jzeZndENB2Z4fDjefX59KqsnPXy+exi+fTwM90scCEZJ2Hgtch4LBA8A
v8ShhS8DoY7AAWRz2NhftTjnarfV4uhK291uWNB2v+vpJJ/27fACxuqZeIAXZ1szLp1ythO2vBwr
OotgfQH8LkJtiD6v13VO7liLs98viHNgA5HTJNqXrxizn2T3CiSRkcoFhNzjnKPT5xR4TsGApQvf
TNIIY8uvJNKam1ZyHdXCY0K04yYs9vXx5f7u889oSg5I1n75GihysfAP9oMocSNwT72iPGOvI9gd
KsJficO5LW00mFq1atPCnM24ssW0w6baWXqcb5lWUd04SHdf9guZNbDQKfj4GKygEW1c3xmVYxdY
TMRJTIFvy6xdKUb+2BYjo3hmQWYuzK6J3/W/Hf7yV1MktkVghjZSQMhM7QsBlMMQi+1khBNLgG/k
s98WsnP/imtxOrhUidsf5w4R/GgaFtS78HP/MpZJPMAieX4uqJ/mxFBRMMGUIS5jDl5kbJrVgYKV
kHmnuHYW/FBj03U6jfruV8oizmMqTXZkvr/bXX88nOJDOf7zvCqFnfQEOviy8YkLhj60hk0DPAje
wQnEpQ2Mjc7EJD50vlM9/25uclkkNm0qi+++DLe/P+wv7RknORBYVCNeAsOHyD0sP0sJ7M0mWO3A
Ktm4Gb9NsOJPnq7e1FLOAxGw0e45X7MWRzjs55mpyCglgujYwfkukNIaWRMUGCcBznUGbrbYxiU+
neSKnXgacVPLPQ9F9IwcG46gCV/hCxjSw+fHpwn7ERySI7SAiOB1Ie9DkAlRyTDREVA/T3lQVDCd
Npbfvk2xCph6ul4poxayAb0aRPNRzVMLcMg+DPsq7QH7i5Ha5S5aaxG7NnRWOGQICSRJb4ig6r9L
e5wm25r2OA2vFV16a1oruVsCq5xmtgkfCYdKb6aCJWMQZQ+BkLhiCGRDUxcyl1JHrnKwfwCucr3n
8Xz9ppZXLyixM23u5vLpwdP47b5/+KXoM1K7UVWiTBG8q+Qj62A1wUqKWPdNBDiY4Hr56DJotBnm
7V/fuO+udDedB0yVActyfjLAj4eGQawvSI4F8O5lKJQ6I/U6P9mYBGxkLo3tTDTwrQVFOpvB/bKR
EZ2MzcJvs5pPM6xV9Y5XKw32er6t7WCDoHzOGv86vHz4x8Pjb/fD4TOYow93L3XmPoHLmLFkLpTO
D5nBYUGo10zhbSRw84PeFP1u51hWpx1Vq9WzBbUGfaxfzI94QhZC1wIhyE/9tQzDFhjFDFlzhgXg
DgsrJBw3RjjWiaCtBlcGzMBNoeNqmhUu0OmQWpU53Od+v2O6Kcz5qUCOTRY9PAA6+sPgF8viyZig
NHZhu4QFAbDBee4cLB7m4f+Y5Pmmc+c80woR+9vlm1rgJS0s29dBzcfn/qG//73UfH5/697+nn5l
RCHcBfhiUiNpIDFoh1vSJZe1T9hVty04Mbn9Wn/meUCtym4eHtvv+W4346Is/Spj6OnT0+N/fq9a
JC5HDjJpI8W8RZsQ013wuSkk3KYayUPZtvztwnyrrJXtwEq/vVp4VXvdZtcL7kRpV3qLrlVOK/p1
cz6SgKWayXWCK6zjAA/UI2BoSmAkMKwSlptCMu/MvbKJX/9H9TNYKMfaD4Pia8+ggSqq4b6iTAGs
VDpWA0nY5y03sIvEyDNifnn3x5S+Clw0G1YpdiRzZ/jAjDjWgerb6D5V/e3MgCEnwFYI1iEkM4md
NfCp5qRSjtIhl+omqwFvvGIw4KWpsIfjHAoWfjwcGuIL2DYfnr/2iDV1SYFIceJYxFdg4RiVUYku
KAziBJewCBbJCZj0NARrxbaexMlMaxh4lxG1LoNY0GWQRzsJ1rxBclySgLhxg2csBEJH2wT/xTVy
vDN4ATSRYExwLGa9GhtpbzkVauBztgH8cW+G6mv4BSFFqxo9luAwD6LDMng4SgQFPyzFLkZ47LBf
8cw37cHlxssPslxqhJ2bv4PYD82+BDr+8gIH6bn1QhleonlYpxE5N1knsBN1KgxVDCPbttOw22oO
JrBzm8qaxhlWJC/XbmopjwuiH1RTEuGH/zXcv21O+V8YryuY6BrTwCBesp7DM/eYHkJOcot1JlEG
agPsnm6bMVJNsuI3TofUiswxJeDHI1d8oeF5FKXtry0eI3wfCfz1zsG/RA40AS4wxucxrgarEVYo
3Z7qque5lu+qR1aaSTmvARmkkdwu+yXPH76eAe6+9g9FvzfnpKTzlIwMlokEw4RhSRBDRgAwt7IK
jGbQG/b/6xg45/t/wvuv9NfWg2qVzKJKQ+OdfHxwX7+eokWz3resqSRgbnXGKSQNUWAMl8Y9JmTw
WAoS3LaAfjPJWuyqGdYotLCM5I7z47pCdU7cw5IhvrPSIhWSUeCggL9IbOI6OYNMB39YmQ2K1Ers
5gfBoARpArbpS393f3obbxjUSpTieklP+AdKcO2Nwf5tpBigXndOKt/lCC5kIB5BnLdV6ZzmWqvP
OV2u9FBLX5cyu4ZmZ6xW+7bfo3tVyrzkByYRSpSf8M1JkIRjHBcp6pRQcDQH2mlwIi0RzMXstlfO
wTzXiubgcqPDfkEHu2vwwMfNw+1fcNJprQvRqhgZ2ApELHEyFqoKhPaS2F4pue4UBQ2QM8grs31P
u0wGMn9/e21Ta4ZWCu7nQF774UBlswV8RXPxQwETApv413GG0za5aMgHZjKJNIMNwhCpz4jO5pS6
pC13YDtTIcVmYsHZlFc4Bmdjb2rNFkyEwwya9/mEP36GR58UQLfY6IjuTLH73hk0vhT2T0kvO8q8
0wK+0bhtz2imug6MvlD0jIhUc92OlO/ab/Uw3H/8/i9/Zcq8YfeOf6EV7w3nWWN4CdmEDKXgithi
vNkYhVFSXy+tPN197XMsF29qARd2u6PYmVrqHz/+4+6ltRQsZeqDKm8hgHVDYwQfyiWsGLHYkqMT
qGAyHEUqBL7pe6vmWYnETIfUuoj5bnEkR9WSBfVf4H9K7OD57hItZxixzMaBoQYeFLhS2KWDEUvv
8UACgz5aqdI2pIp6jrWCpemYqSbHpQJ60K4FsR23he+G15enu4fHqWkw3QsIuFbwlsH6t1j6okEn
rzXvdKKwUihJZlvR63SetcjFZUSlj+rnFRdHLZmm8zO1KuJZO1kDCy6De9WpKDEUI9BPEBJxkMCo
M85lpjefrO/Xv1aDKs16Mt/Aj/3hWGDAwNXpX19+vjthq53z6USUUwkbUUovRwZnIYLXyCItgN2I
X4Dpa4V4U1rCKdUges7uWsu0UMl33JERwRn/9Zfn0yb3RorExZnQjCEVcNLYpOCQUYfDFqQQTJ9E
FVRUxhnVCFPfrhJlZxYez+FoGxTd26/DsP+5rgoGJ4Mgo4oJGInCOk8KJnomIoKly2R8B4N9vOVa
xh6vVYIOC542/GibJtILYPBpB8IC+RbB2BpFCQYLLYZhuAa7yUUsCHaBaXDGwcMgfwzB+DzZezDG
54GNcnOv8HjkQ1M/P8mNfnrd3b7uZqlRkgmieOUuB4NN9zF2xkjSCY81t4l5ua2yYjLHlczoOOCm
Fvq4oAnWiK9neUuaa6ZK5PCBBTAHJbaHcxoRRIq6ThOhlZQUw51/IMtbJrma5S0jJsrAFj+vDyo/
6iNtutq/ORcIwTl0Sn7YAM6Si6kLEhUIymG8gXUK7NwkbPK5YF9daW3/ZrZgcfrjXCaK5E4jNvH+
6fevcOYIdt7NyFiLVVjqRPKMg0ttE4GTxinWGaSJi9Rar12EXU7Ue0dzu0oUpg5zUZhp8TG/jq/k
w7+/Pj0i33h5N//CzGT1SxvWF4QnmUQA9x9rKDWDRepAdEOTgpfvhfKb0qyzSZY/gtmwSlWl93NV
9VE1RaHf3D388ulpeL6gSTCr8KO24OYUZw12F+8I6RhmjzgiHRhtTBdEpPA2CBy410t42xlWutWb
UZUuvV54bbtdC4Yz8mDkguG4iO1Gc3A0IwMVFxwR+NEUA6dNoQXDhLR+W8NZNdE1To7TkKkyVM2h
uuHHHWlimmOz18cDVjS/VGX+VrHkuCUdQURMHpEpFDOW2rMRQ1ebTanjeoaVit1qzFQPpuclr/Dj
IPYLBtipa38kbVszwCLYjSEo9CgR1l4iWa3gGEIjwsqsgxNhswF2mfGKAXYZVGs2yLlmVvZyQbMr
+rgQbDIidtph1hJzEQarSjPJxieWedqGD1zmuaLFTS3mfNmzXu+Oc66KEUi4lAotLRYdDYlWmC4W
rwu56w2Cl4P7SyUL4PoTs7XSYjLVerXFZNBNLf2SSmZH+SSN8uPDHYK3/vD719PXerxD5pXTiWK0
Ph1xznDGFUJVClqMQDCMmWSdZpbx6InNZp1O8doktchmQeSdpL2dQK8WwLXhCQ+aNzA6fT73FJOZ
MRZhb7KYfPNgLtPMMAYBR7RUMZp1lJn2zpVs+76fy7bf7eiphPhr//RSmqrY/3P4/aH/crc/Wwri
FPsa6wMpj4koEBBtBSzLdCzxDtzyAGc2bGe6OZjXbjyVjmNrXisdZ4wfa6PZ5X/8+FxjXCbFTYZ1
1THvSyo9wROLuYvaSxesT9pvMpFPt17pMRkvViJrpecia903MYKTzofh+ZeXx6+XSmOmSyzRWiQ7
paITGt3PgkQfMnijzhLrM5g6eZMdHMdp4jjNyq5ejZkqI5mZFQcdpDj28rAQJiiHHJI2TVifp1tI
Ib6QEmx7hsVamSI2CbFgH3FiETXdG7b5vD3Nc+W4PY2o9FGHBX3UoQ1Zh0/f3ta+ouGUguSR4FkU
DHglGKdGY1k4x0DyTQEOvO/KjgdXppIqMcyNHCXZ7rjEMXZSdSGwMX3+wjorFUFEB0vHll7DCZj3
PFtkqQ6Kqe32zmzOa5bPbPBNrdZ+QVfes8M79SZLX1myWVmO/OIGv7KE4VoBDjJNPGjGXJRZ/ncV
JluLSmrd+G5BNyuahhRsqHGvL4/fPF42g2IFle6TFDsaMUrhHPj8CMohhRLUgBOptllBb/de7ZUr
VyvJlVj4Aq2Qol4r3z9/fRoqi1Tm5EwgpqNSawzVIkWUDZ3OcDbAUkobS/THO6+UZpVrlbx7uiDv
Xg9aNuByxbI4n2Kcw5czZqLA+Ef0BtXpxBhyzOgOFKFYoRRiVgbOYHrd4b3ceSqaHoZZpgx/PHJz
nFVZwProazeSeJLgGQrsnOTaI/ENh6PfURE4FuWY7ZUWePMr1RZ4uRL8SOYrUx+pbuDN/zn8Olx6
7qUqce7MTBaii1ipBw8ZHF/NcieTUSFbq7Lc9OGOt16WebxWCzxvLMEfh2bbHP/lNJ5dhKaMREaR
qUkH3OfB0jU+yI5Qm4iP2lArtwu9Hsa+XJ8Kb/gcrRJ+3B8bJ92/3v9y+/uXHRIunbORYDiccwwq
ezQT4GQVzMAhpeETRigHVI54FYnZ2IraTrQSfmqH1UrNMw34I91NyeC/v/3m8fMl4FPcWk0cuuSI
QoQNkGAAOeKwz8rpEMBSZ+sM9ZPbVbKoORIz/LijxZw5m8s/teT2f/krAkziLlEyAwl2s4woKSI6
bFTLnTcxITKztd4EY/W6ZPObTwXci4WNYi+P7NAgpzRvfyw7UUIilM4Y8tdMRMHAYswCIQYtnB6O
erRgHL5/xmnehv35/vtfffcgOZ+ro7iwa4R9S8FuSb0izskuxwwPHXMyRjvWkSCk8gw/CPrHgt3v
R7mr8DaI3NMFPXY9XefdviDS/nP4n6/Dc0ktYy0XpkCo8uATOYv0zZiAKKd61p3MJDgFlnHaZk/O
JlkDZmiGVcrtd/NzE2uAxYEv92M8DC9Pu+kR5a0MUcNmqRT2b2ZKOmOj7ygV2ccgLQt8YwHz0261
ZPmpXir7OUc49rj3DWjxernWc8sjwEvVVtbKWoG4Uw4z5DwiirGHzVNKSjPFbMSmQEdTl3U16788
tlb3OD8b9gd6bOJrxQoBQaYs0GXT4uC+cM87hb3Z3DEkE5ACVhIS6VKD9Smbwzen+1+J3ZxGVBqA
ITbXYNC6qd26fGdf+v3Pd/A4hpcX8B2ezz4NHdEyAqyhKJLtAkMC1UKSIB3tEkvGR0eyCZsMo2/H
aW5P06xUNtSDGsXmNsf+CEfGIkJRwxpmwFbO2nfBINyoDxERlmLHlKQqSQH+t/gD2ETXCGDL5ang
Q3+cv5FhZ0TT7F94xsJPDk9mwj5Q8lb79PZ/cJOOMYnIFXrIYazrt9lim6v30kcJNizfzH4Gc11h
PIOrEy0GspvzZMGPpm+0KDbBBbJN0XNCGuzqTMBn7EgyWJ4fsCaGkS5ow5KmGlG8ruY0RnNjpYUE
LlXiDnPEuYEc7VHLGRMBAkgVtLLCBr97vVRgY1tPcelpVioT2jmOnQUE/HoMaXbEMw/mQLCM+a3E
BLPZ1ikKZkMrDQs7xEzDnjRcbJ/65+eWylYIKqzQXSYIEJNV7kxwostBae5SliZfZ4U43XNllx0v
TmWlRM2WAPyoMUs5lfXvH2O8e/5631eOLuEKli+GGiiCKDj46J2KWL7oCBwTLsC+sOXpX+6+LPjl
ei37vHMPftxLdWx8HfyXzZOGZytz8KbzRCGkGHYUaPhwDA1aJZrzImZk5eKc7rrm4ZwuTyVmRzpz
JwduwYyqizX8ff/8Eh/r3kIbPJUaQb9TQh7CFMCpgY1Tedg/ZdQubvPNzjdfcWbeLk8F59g4PxP8
IEjjmT0P+9cnzJ6FknVunnmQBo4kMGQN2BL4ucBfIlswZGWBA7dCXodxO991ZZN/u1yJPuz0XPRh
PzRt62cgqG/7h74h6pTMg9PFGPgS+J0zlkZfPnAwWuFLUUxtoxpt5lh7A/WoSpvjnJAIfhSSLO4t
P35cADdUgn3QZeMnwiJVFHgWiG7LwerurMJktrZU2iRjENt4sOazXd2BpgOn2knC5zunJPrIeLOi
vzxik3jVbMdPME4lapgV1t+mTnCvsT4oY04YOQrgUGAECxM2xjFmE60t99nAqWLqKOevTR3VcDgV
jA0H+Kj5mVcB3T6sw4osuU4KZDxyDGnNue+0sGAYeUptbhAnpjepZzd6YfZB8SntRBzAcft8f86+
Id5LoRksdfbggPLIsTUb/4ti/wNHFA84drOQkSe2Tj1R33kqmSZ2/sLhR3NosVtesKsMfIQ1JGNq
MeYNu6OhjiNNAgffUtkue5u5yRSe1zZ+qG9/OM10Peo9HzfVyzAzt8mMPJKGH/hh+O25aHZyxEaC
KGlsQcOTsKp1Dp3wCWGNE6LhgYXpeGbJei/0tsDndzDJD2+TrHmXkyGVIsqquSKql9bOFDnW2ZeJ
JkhmZRLP4Hzhy4lw4pqIGLEpBSJUNE7zrZq8t8XUY2pd+gVd9gM9zF/K/q3tZKIFuPSSw5fVZYts
MkgY6KXxXRTCu+yEFjxs1eJahe9vbdsPWMxzlk380ai2UOvNjX7+MIpxymmC3zD0T/3DpSUQHIAT
dgl4J8aT4DoEaUZuEQ02J2Wdkhbsf2SsdNtA4pYnXAuZLQ6eKo0B3JnS+GN/rOIyeehfXp+GfN9/
fp7AfYwheHAvsdWRYeOCc7lzSMqksV/XI5dg3AaVNJlhjV37MqLWoZcLOvT7/TT4+x3+4/7+G9gk
X7HG8a1muICVyMTBvJCuw7w6rB1uR+oXTcHFd45yGvLqzrt450pAOudWgB/VsYki/esu330ahqcf
HvG///JXdB/FKfVIiy1BZUrgLErw3FFOBmYELArTSQKrA0xT6sUmG6meaflx12Mm+hzpAnsU/Dio
Zo3/j+GljkMkxSTD+LoL8JlwQ8AVCJ5jSxnTeIQ4sSkOUW68LHW5VAs759UBDwHsAt0KOwLgVW2J
UkaHEQYnkDHXE+zPkRx8gohMG8zKbSXQ55uvCj1engrO6NyHhx93hInJZ10c5O8fHh/OhAdTywJD
3FMLQytYmwnDjhHxkiWRmHsMXeTaBRqYiHwdkG9lqkpmMS+UP8LC0g3S/U+PcJjf/gz32L++jHwF
5wYWXST1DoyxzGQnciqt37CtGIWVNYFj8WzyapOpsTDTCp7IfGClmZ6XSuCPxwYVabROPz09Hu/u
h78P91+Lk2NOx8EILhcp+JTwPeHLgEUc4aD2JHewk4LSlCewpLZDPVZTXUN5rAZWqvVzuxl+3LG2
u6EkLv459Ifh6ZTULO1TthwDjkQhsVVfoauvwIUzPGNJJTOJkQxuJ9ueP7lMci2HchlVqbObF3rA
j7Y3xwX/ZnT/vkw+QDbGvAi3hCLIEMFsQ0TwQuZoJ8FtczkyJ0LY7txcZrnm2VxGVfrs53YJ/tjv
pvibSB2OPvvbsVbogZwKRIPNERGIJ3nXeWF0Z7lHnDHwc/L6oVbd7yIO44TNuK8ZuCrgMasKzMF9
lxAvE764p4IxT+zYbDf+hU8YzlstfOgygkzwgEBUQlAwHIhJzgmb3aazbDLRSjz3MuCmlpktKMKE
WCqKDj8P+6rwXmUY7HnsmMBaRIZPN1tkVJcKbkEUSfxqnGVy32t10GXAVG52JMeZ3AzOObbn5XvA
BZFvQ7//eZj0W4yNmUFQ4rWBA8wVyueAWGC8yzmBNap15kuFPtMg9Nfh4W/frJXT4/C74fn/WBKi
VmFG0Vh+3Fuhzyr89O1pu250wKoJGeFDCQyB5QIHJ1Tibqo9C8YbrxT783SopWiUOCwowQ6s5pp9
hOk+3//lr4zjKVywl0/F2l54tP1tRxNWO+N26YiJnQJPgcEHZNw7n9A1TcZrtcBsWBCYE32yk8NP
395+un8FQ6SxJc4SR8J89LC3Z0TO5USSzhKtsArOimSJSNz9Sc9+WZZanxlWZvnRilPE5W/537cV
ddpZDxVS5pYzBP+1yOQO65ZIMPMMUxmsahHsn6RHI0Mjf78gvzpIMVZs/+0brGgcZtKHCK5WghXA
CbKtgUuMJB2hYyxHG8GIs0vJ4/9K+qkEtexq6VvqtTx9S3/75seZ3HD6RHB3FVJBF0g1jw/cd0Ja
ojhmwaL4s+T+cS4zJ8e5zPAJ6d1en2Sef/Apgssi4dCkFs0ASzDvQpE9CmslwcRJf9qjXpB4HuHC
H2GPoYd2i9nDFiPHSEopaFE5wGEGzhV8ygYpJsGAllkj0rXkEoxq6eW7kocrm0uoNhcujJ2LCj82
nafun5N8hRaqNB/wkqPOhjgwT5DPATZDGToQHD5vy01SAbGprueKyp1XLIB/VvmKItjCg5X7vT0u
IGq6n7LDPy5ic7BiEC+AYK05gc8DHNuAy5GCZwXbivbBRmJYJkvIoFOhT7dekft09aaWcuErVsIM
DW3GT/98fH2ZFMmPuPnROfCgwKvCmj1LPFaVCYQUz9JQRp1j78h7uuuawKfLlcSaL0i8N4OVbQXA
iZn+TWQELlXl6yAUMcTROpRYLyMlbN2Wmi6DL0XAalHKvvOgzzdfTfqfrk9FF4ySmejwo2C2IWV/
/O15eBqd+BbbKFAP+wRHrjOGaBgMzhmNlaqKWG9hH8/6uuyzu69xsDfDKk0snb8EYZVqmlzw370F
3fvd/ahIMVsKPJ8ySqrC3SYTbioE4flUx+BbTwmMFs/I9eRic/v1QpLpqEqRgc83GjEItWuYR/qX
Pg7Yq1pi5aMHbhgdiQkw6w/Pv1MWA1EUO3wVOElOYfKKMaPj9bb86u4r5vt0SK2BXPioBtVi6R9e
0PcY7mF3f/rh8fH++QwfA8eTIB+YGo3J8icer5SDBeBg3yQYOsfWEVNWuKQxy2SVeWdxL8626pvM
h9ZKqrmbKI6UNNvU6OQUbKHSctpi44IrxWDp2444ijkxEWEZIW6TiMRKHuFssBvcrLcJrnlab2Mq
NY52flBISg5HOqOWfcDbTVPBFoulbWGdxKRG4JiPx2gCkt1ZlnIH53CyKWluXXiXWLa5/0p35nzg
TS36sKCPJPqwrE85rS+KCHgDlCreeWLwG8sCHEgSOuQe0kYILY3apsjqYT0dUYsu6YLoO6xPrFIV
t20VijFWJ9hwMwnYJIA2HCwVDDm4YIINfIljdpqauF0VtlyqpGQzLmL4URLRxMbz3QPmYhpRM3MM
9BQdEwjNS0LuwJ91CIOnpOCRRP6OqOfbruKTna5XQhszDylIeGpN+cbfhkdc77vH/1S9IyEGifFk
lwmC2YMNZ7BwJgjUhSVKyfWKk8ttl4W+XJ8KrbiZfw+K73lPG7SBzz+//Dbgf4fHw4DFyXdPJcpW
gfaZlCWcCZiRCGnErHIR9lEF+wwHU0N7Id/BHFidZ838X/0HtZ4zokT4URDdpLm/ufsVTv0vX14f
TkXy7TKggnAHuiFvDAaswCBJWHIckgWfMUhv/DsKzidY02w+8qaW3iyoRI+iNqu+edz39zXFWvqy
Gw6H4XBJLDFCZKmyLMBX0QVvNOkoK8U2BJXESlfpZADtnVLXN9qrU65oe+2f1Gof53uDknvTUC6O
ceDD7bkkmakRZLjQE779jdpy7jV4/GB/ZXilCrcL7sHR4xTL/ZFl9/o328y0VpVcDZpqpKmer0FN
B9lw+BUup/xvON5pQb3D/0EzTKeULYiO/43M2GC7ZHBUk1bgjHhwB5eaLipcv3LfNSC/crGWd5gH
HjUjsgFj+fbTrQeX+ucv/dMvbbNkSPDUpQOjV3qHDNKs8xF0IOBEpZwYte/Ejopcny5dHLc/Yxpj
Lek9+XeNUCtaN6Nuak3VgvrUDrpVP78+FMO1BjalhIOCpMsZ3V2wWEH1yDvwHjM4aAp2l/C/S/Wz
QKtqn0fUKtN+SeVjA+4N//7vj8/NhpktFt92jGOw3CJrFWNYRC80CWDrWJf+d2mLsqwqihdrHdnc
oYClrw2fr8K5PCeaaYUWd0kYj5a3FgQ7hCxivCCPJhbbW3zZARam8vDN5/9K/Stc09f+xVRhsydz
H9Ds5dHQhhuhf9r9XmrJ+/20PFMy8WE8MIjNnmB3XUxagPECxqE3WKEgwDunYJ6Dk3tVy9kcaxVH
zbCpPlay+UdqlRyO9Qv8P1/v9riof/nx4wQMSp6qcaj5MIb+tDbJKB4RQhl2qGQwygP2byDRBx8t
fs9XdZrMs6zNZEClx2Fhf4Efh75Nvd4Pvy6Yv9bT5IjmHbNYbuEUQg672MXAsgrwn5jIO/Xilxuv
ZVovIyrRj3J+MtjjTkq5kAQP/VcsRRrFL4hhhLAAPkWwHASPInfWBKzcRAoDopkV78D8Nbe9lva+
jKoVOMw9u54MLR3oLTpXL8VAK/GuFkB0REUy0uHBxrAPkgcF57KPoXRZG6eC4+n6Ebc2yYpaK6On
6vXUzve4nvaHfb1ExmTLv+5efv6/Hl/bSFwKScBXhIWR6IsLxKaQgSEuLWPopHn2zmtq776iUDus
0kTs54u9V2AdNvxapap32qfPCypjlkwTkFxLj0ShWG+HOLWBKUXAahIuXD+Dz/ddkf3t8k0t3nx1
7CQ6RnOZf/w4Pnf9QY1I3Pi/KDl4G0aQ3HkiJBaGwIEilO4oHKcOP7L/r7Zv6Y7bSNLd81f0cjZg
5/uxzGdfzZXaGlPu7p0PCoWSeU2ROizKtubX34hEsQqJRxHuObOwTQNZmfEhXxGZEfE5wt6WfKj9
iuxDgZtaULEgfat7vhDwfJkJlqD73UCdxUyyQvgG7AdMjZQY7BBcoeczz16FFMX1zfBU97XY5mMt
czufzjvVd5OU2thTpZnL1oaGAbo2GJixmiFVnvO88QF2cemD0Cka6uN1W+9Tu/v20D6vD5NRgUps
K+Ymzs4iAdiEevFrWTwx8zJ+6nM6SJV10kiknD0GFWCopaNUgA4GJhxTxos3LtyGmtcYF79OVs1d
u1sYGjsxJA6YcL88VCEeYLndUlGId2SEuYic9xoZQzFmKIMpJjHxrcqe+jf0xFHlV9heHmaHebvD
fu7B0rFD358uwN3f//Y+NcfqDnzCli4109ko2kQYyUgyCwZz4KIJWkTu0P81XJ+U/+x366dNVbH1
eTsqtyj1GHQn+vlGAA93vO6x5nJq1MxvlspQc4oGpQQacjCn8VrXUAq6EjUupejZW9rGz5cmfn7r
fmm5bAVMsvmhSCcl280jfPHIoQyX1z/SEbNY3rcPFcIEOrqBAdjEDP3KWaaNZxTmllEC+h06m1zf
K36e178Cb16wwtaLBWy9muY2cM4txFIhEgFKq1Kw/lJMaK41aCRcBFBQBHq0iqC3kcpVDazcBI6L
1CDUbgHEXpv9OoiyJVWx2I4xljjqIJg5ytMIyjkjjUiunOZouY1MY97KBjilXIXp0M6Vke6w64Se
UBk839+6dx/epz++9s/3X15Tpi5S57nEvE6gomQH5jL3YDkawWJDsiGgpoBymTclobzW3grYK78Y
w+6pnh9493S/m6SdKo4DJ23m1Vdh4rcgtJSReNZEJWFkmiRhAVWxZHrlPtMUt1G5npu64sIwVWx6
RuYjsmeUT3qv/Hg8sdbAGMsD1xldkzFIPWN8gcsedE0dg/LMMmM2g3lzotWFxsAOQs4NyYPY7/am
djJ9QKLel1++HF8DxnEcotu7JIXUoZzjgH7sEw14VoUhRQQNYzBuFMX8B9kLHbetHbPGVnDNylXQ
7ILGcWiV5HrZG+Ku+6X/0l58IiShsIGLkrYNT7u9A+MM9FFO8a5XZ90IYqQ1UjAr9cZ0CFVTb3hI
nEpVoHZ8ob/2+ynb0GXnmybXE6gADu6dmREMyMtWwXziaN8Ex0C58tJZ4S3bFgA2b+otx495jGHB
QBeA9WxyyQT/vj9t/5cKMWfriPKl9mhxQVIHJl0jcUeGvQypCoRtIuWg64LKy7blhV5s7i2oo6Ij
tIL0hxlaQQ5CMTnP1eG6DubuJMKHeSFzCLoBBQpRCQ1zjbsG7FIhGOieVNDNGTrOLVzJ03EuU+E4
mJlrrqCU2N7OccT+6wtyNshTkAb+t6zrwTIfdaM9elNYqzEc3eJ2Bo+RVc6xzUhKG1dQlPc3tbDt
AgLTt3oFwemsQ+oTCl1QGBNpRN90sKowwyvG7goFo4w5o6RQOWwjTanbeQvJZJ9CwQ8LaFre7pbQ
4Cz8r2/98/fJ5IF17RYtRZw+Fmz67DMGhlrYbGNWjUE1SiqhOE8uhW05SVaavIpwWriGelBzqAwH
31yhOoBNt/t2OPTPA/QM/+/L/x+Hc8VkucqS5IYYDtYZ5mCxEg/iBCyFWWiimd6MclT7FXijUhUu
2XVzXErupkl6n5/wfPu3U2fievPwcP8Zw2V/7PFjTTwSiUzBBtDpNUP/Hviz8RyGqrYqc1DqtSHb
F4zF1q5gXSxfodaSzVFbULvqYJfuy5CcuNT6nx/T3/71vtL5qSOBuNgojSELKiMfsS5psmTUggmX
t3fjUP0VVEOBm1piugDDdjuhZvPv//bfkeXjcnBaFpIE67di1DVBgybPlUPfeckamzBOx2kPCv5m
CK9NXAHxWqSGsTAGGYFFnc+XkSGz+2lLB0VzrCAO55L0pB9mpxgL2jcCmT4w2w5YyTkiowYojpkJ
2Kg3Q1tr9grUtZ+MoTPW2Tl01lO7X2QRGSouvH35fhjonzFnTHP4UkUx5ewtYUk3zJqSLbtwNsWG
xehYkMrwbLdjn7d3Dfa8dIVY6AXE4iD6mkLaPX/+hsbexxbTVox7+ZTDakgdbwSNUkH/suAtuuGB
YhId6CmgYQaZoI/tNqCLza3AXCxbgZRzAw4e2m5yaeOOv356mt5mIIMRboNNyhGzcUC3GUkNur5w
ppxTLm/LhvZa+QqK19eV4JqLueB638L+Wwv+/bFbttKGzCIjOy0Fl2VMvgkR/cgY8tUxvB+IUYBV
GlgW2+bhcptr6BYL11j3C52k+722tsL68vTlvqsw0ilGqqiO3tOGebCyuaK2sYSHhmXvOdjtJvtt
pwV1WyvY6kIVJjM/94GHXbc/THLCfD7FQOC/F097gkjZOo3O03iMij7unmOaRBK0IIIoWLe3JQ8f
t7CWQnxcpgLUzS1QwfbcqsnhXOWn9brqjqcWo5MjcgJqlsDEoyFg1kHhOOjQBpZM2MJBQYGtdaMS
ttr0ar70lfIV8L1ZWCf3Zsq+4n5r7x9aWHJhnR1fu1NVGGQKmZjygTKws8EmVUhUYmXjPWAmyRPC
BGij2+hWJ22twKsLTTAtbPS9sBPn8RbabZ9/vaDhUt3KEmQvcfip5EBzRi4TVFWcY7kR1mhqRWBG
bIUCTVwDMby+qSVtl8Rv+SRE+vXHp3vvOYosbCAYgE58cEO8pXfWN8hYQkFz1jC//hSKU0tvgDmV
mmBaWAR722p9mGP6iJWCTKNcONxKBDXcBFMTPEMvG4WnBMSjuwTsXEYlk4jKydOwHdaosWu4RsUq
YId5iA88lMbUZx6+7X71T+3z/v+8i+k3+DrLFxU6awXWKPKNYHIHy03jpQWDO4QsFFg7im7qsSvN
rUT/rP+ghisXlouD3snDDO7nZ6xiEPVTe/z1WGsfTiTFfeMoXjHTEGDZT3iPKHJCGpOwLbv0YkPr
EGdFa3AL51eckHZyQzPiVYx372ecijkZnbOALcxjzt+IZPQ+cNCzkiTOUC5l3sypCA1c4VOEtze1
rPNZVjzbJrkr8benhv/yH0yLW0WG0Pistc2NyRKMaa0EZnxQDeNRK6NMzpZuFvz0+orwpxI3taxq
CcBucok5ZrYEBWzWBYwrlgptT8B4v5xDYxEJniN6j+f521h8zi1c47SE1xWGg+VzDIfOqvoIJ/gf
fjz3wch5SmrKs0K6SCQmoR4sDdTNM1eg4iWdiN6kD42qX4mSuxQYiy/4PNIPHjJCWS3+h5Mj2XCg
9Zf/UMWhYWCZBxU8wO5JG+lSxtwhmK2Yy0ZIzQAGWPxhk7k/aWQFSF2oBtPP+0LIfjeJFAgfJpRQ
YzDca8NcYA0h6LwjuWgsjQxzucCa4TnUSLaBucoHdX59U8s6V2WE3qlJ+qnwobD7VGfpGGYqHOid
2hdtDL1Ss2mgJ4M1Nlu9cSANVa8JXV7e1NLtFkTuTFevosevTy8PGL1yG+7SH+3Ly/OQG/ZCM0YN
Xnbc2lsxaDNGGq1howh4kMSRmtwhZQQhAuaF1F6yTZO6bm4FV1WmgmfV/HJAtGynJ3SF7UMPG+hz
bPsvoz2egXEgbmm5wlEGicdzkxRm01Iq4tUvbTShXhCwDrzaZBjULa3gqcrc1KIvjLCd7OUanpd2
1x4vRwlMQQcVZ2gGMyWi1i+CRZdvrxqrPeZBJtlkhcHW/M8BGpp6C9JQqgLVz1Jm40PNJhYApik6
Lmib5WjZ08iDsI1gaLchL4FB/gvnVNDJBcts3oimamMVTVWqRqP5EpreLqD56QVNovu+0rZ89i46
2AAlAcsTTF2HPOK5oRaWaWkNpypuxnJu4QqSc5kJjsMCDtu3is5w/OtjqPRFGD4SF+GU8KRRS1D3
nYU1OVGRMsDiGxnTTnVfkR3e1lIfFibIAfSJ3YJOEtpj1+6Rg+E410qIpZ4wmOYRc2tH2E0Mkrsr
EqjlkfBgNmI4t7EG41ygQlLix2ZIdnKSITyg88u35/s6ClYKhvTQMKHRIObo0+0LM6x33ApNzDZu
jlPdK4Kf3tZSH+ZzWRJKianOCgcSbbDmb8Mv989VzBUXwnjjkFwKXTgsA3XEURhLPDLQeXE+bLrt
KxWvSI6vxmJL0eq52GIPBlT9se8f+y9gZ3XYzooGkkOKiYH1zpgnoIEgs6rE2GkNi5GOUi1SDizI
P2lrBcqkVIVKi/lSJPWOT4iGOyQcLH2Bf7jjsS95BxQpN7CFx47qbPHqQBFktU0BJrSnspGZmxDB
1OCMb6ZALA1coT4s7yscdj/fxWUrSXsNBx6eXc5nKziMG02d4A0Yd3ihTJDhGkwpmC3cKRFpNHEz
nHE7V1CNi1XgdmZ+7QgPDxNGvFLJJUx0nHKERMN8aiQtWRNixgxRMHMooIF/gt7GzVY1cAXIQmyo
kJ2YL7tyb8zE636o4Nvu2D3ff8XjilOe3wugW1v4Hh0sUxSULY7rV/ax8Rn5uoLXKrhI8zbXtNXm
rsFbKH5To7ILUG2/X4D6qX/ov/QvF6ORcUnOHMyUUW1NJI1kEm0VgRmbrGpIZi6baPDKaDPMc1NX
sJ3L1IDsYQFQuy/XjfXvpinWRmCiSIbzkBsWNCZXj7bxTqODpEvCiJiJ5H8ezEo+NZRvbvjKnnfk
cKUXSgKTQs9Fb4WedkegVMkUQyNN8R0EtdgZwJJgK3WGe1gr/g0Epc0tfVIKjjEqPo8UhIeiN1Ou
9YeHIfPMP+7736c3h/DtMQtkaKJVftiOjESnLWmMDUI4HTbyQU1bWcvnMy1XYxLzwaaE2Yu+X8ZU
e3tO79gUsUZInhsRMa2i8bDPOuhCwoLNWVJQON2fQ/fGPdtCwQrfkiKhpOr1NHXwKGPCp+dvx1Nw
IeZuss75xnLsLcwVaZH6HCZXJEJKPDHfhmda/xqcabkKjdz1C2j6varXut/bX/sdnkcjrq9Px/uX
p+e/Pz2iu6BgwwQrFJyGcJ5gO28YEkdyz3TjpcrItyYVEpBvZEOdtLIKbVyowmW6hV4yh3Zf91L3
BBpuB4p7OP1x8kCsD8cVI5rjiVNAitfkFOh7sP+qlIkWsI+5bYTK0zZW8ztXpWpY85wT+LCf5KOZ
wfoA689w01vuRMsl4ZBDPGrlON5/ykAwJ7oEQ4KwJnKrLGMcti/2Z7CdGroO7VSoQtaKuVkBD1vC
Z8j6P16KDjj8efbpH5EPKepRhWiywbyaEWP9LeoZUmr4Bymh+FZQlxbWMV3KjCEZvXBxaDRY3Utp
CZE+Y/jr7uW5/e3+8fhrdRCtQyAKZhX0kUGCXs6R1cSDZpHgMVhUKqWtrH/l4v2H5+6XHqlU1m+h
lstWGOG7zjHaHZ+qhUgmeJqul0tEPqwcaFMpmmkI0jeYya3hAuFprRqqiedEWLnxlqZq6Aqx4WuR
MZhOHuZuMJ06tGwes3XX9Y/9T4+Y0OClfdyfLEUtTjou/oEKhwLpM1i6zBBMg8lBZaIqNklQz3kG
IzKErajmLa7Dm5etcBb/3SlO+MQ7wRezB35tkSHlex3ClTkYJbShhuMBkML7tXJHmoNNiRK+zfVl
2sYbKQRPpW5qwdUCGt2T3azX8BzsmP6AgVxnQonRBBFcw3iyMLfQez8q3UhhY9Qsci42M2qOmljH
MipUQekXdq3uYPhu/wZnXHMSpj4jii4rhSemmI/HCDAbNei9RkoClkdKXm5bMV4bOb16g0nuVKrC
dZhnmYeHLZvkqduXG6Mv58T53ZCsO6aPQ9ruhfs5QbMLntomGUxkqQhYWNzKRisPexknTMRNhv60
jZXUgpNSNchuvoPtCWknBssayA8hPT6D7vllGSiRsIQQgKcx6J4nCWPUQpcmobyymLl2W9zTUjsr
YBdK3lTY5mkE4KGRdr8R8OLhuAIgMRtyuihLeDSAt+DSpCS5ydltc+Ad178KcPFgfE/J/MAGHtrJ
Af++ff79/vHb1+ZwSd/yGhjESlqvEgIFRhh1sEiyLDCtl8BECQ6zABqnU/CEbOMki6fW1vKTDm8r
HIzPz2z2TE8PnvbtS9t2XX88jv7s//j6jE9m2AYPcuO5URhRaNDvljtDYf2XoknWKeaFcjRsRPXS
utJgmjY4Tb9aFatwiv3CzJPlgqNStO6/PMBofNw/o24QT39UkwzEFpHSJlCCShbsBq4cT6sUjQpZ
C7FpV3utey1B6fD2phZ3AYPq2CTZTuyP958fz+uDxji7kpVjiLdjPhCBB4TKSryUTQkVDtHQALsa
czmHbWc0VTNrKEZFKijtwm3fvtVmcss/+Af82HdPv/X1Wsey05QG3WR0euGKIxsHwURCYB5HZ4zf
dldet3AtW+xrmQpHt3C4vu8t7etD6Xh//LUk1j+yv/wH5qLCmU/pKTHV8D/F+y9LCwOpgS0LLC2j
A2zHyTeURWpoZpnxbevapbkVRJcCN7Xk+wU4Oz7xXYCfg3W2+/aCSQIfj5MIHyRJAU2JY1J0dHkO
MEOcBXtfY9o8baTY5koyb2UVzKRchelg50e1PeySk4Qf8envTy9Y1bfn3Tn+TKE/QyHzNi4HXKGV
wVPaADuOscaVgecxBjLoTYcW41ZW0IxKjHH0+3a+UsPD/SQNxmtASG67/tP9l/7v0MawhVXzB2wl
H3yCaU8wMy7e6HiH0aiaF5ISIuMmY2qhmZWUH/OCY3gHxuYb6oHtp4TCue/3u7b79eQdXUHSKiS8
y7G88MQIpCi0JdFCTpKxHLYFXU2aWOMmrApVUMSC5+xBkr2sZ9Hh/nH/ZfS1MEXw/sN3P3LVMOKW
wap9y3hZupXPKcekG1DzMPGup4BVcvQOFtnEmGGJ2ITw3NBq0uDT+wqX0nMV/aAsa+UWXHjKeHGr
mSBjTNugncFAxwi7asT8RegsEK3XPmWrZdyObGjqGrahRIVOt3PL/mAOZme3oCvpUCYhdNYGZXM0
DcWjGFD4MFEruj/BouG8lypsc38at3AN1FCiArVbUO8OOzNNhvnTO3R4z0/dt+MrJ6Kl5Xwds7YG
F4LBrK3eIOOnAFMKlCAORiOSopDA47a4o1H9KzAuBSoU+4XYaHi4Z7Xik58eX6ZpBkp6EmskjUI2
VGGWQaQc90GZRnruefY5WKm2yX+pfw3ApcQEQb+AAPMKDImb/vWp/BQzmHQ/9p9xR/tecnG9cmFx
WVKTlbT/PHoXoDtAr1Zg/TBY8TDTTzYsEUow3Yz8H8B5U5oa2GF+lXPoyW5iP5RmP7bdRFWgOUaO
pjmopJi4EpY2r0E1TTQba6Vwym7rmUv1VxJODQVuakkX5kff7flUfPgexdkeORAJpomj7ESTXf4u
p68RBlUUDTGY7Y7Auuw82qjS0cylIIpsW5zPba1BeX1fI+kWRtiB2kmq6fztWC55YOsqRJWjkGVi
DcGUqCSg8ylgMBktnMQJx8xZ0mw6h6waWEEwLjICIQls+FMQ8BAZ8E6ETR9/emX2K+dj5+nBCGwk
xpzie2WMDCRuQsTDcPTAcSapBnnkvPDO5218m6PWloCURiecTovyjSHKQgE2gSj5/qDtAPHh4bcv
zSVPwApEyWDzEDY3sOWnwTHNKTw6FtSBQpcwp/3/DsRl+SqIdk7/IyVor/ta//nbj9GXf81ieCXG
ir6mkDQ54WFdQo9b2E3B2s7IJ+xtCtQrso1ldNzMCufAqMQYjdnRmYkHDxXRraqpEh57vPz4rb8k
rl54dvYBYexWqHI6CYaE9HhLgyzuAhYQw7VtBIFODagpbEt0ttT+CrnCrGCNV9EFvAdlJr23De88
aOqMXPEcBeOYwl4hlxZYV2CCgLZEiEvEOku3eelfbXXzN1iMnkLgev41OjmN1974Nd49wlb67Zyq
bPZJoolSOUkbgrnukP6jsQojezwGk8VgmNf/5ieZNL35u0x+d1N/h/lybfa8P8g/8XE+PO37h/m8
IEkShsQOhGS8loV54ZCtI2kikbNVW5P+3KcYGnoL+FDqpkZ0WIC5ExPLYAvMK9PBW1g4wQ4CE9zC
UhcwrNpigLUWoGHTkMM24269yW3QVyZCb8T8IxygK6YTYR40zgint2BNCLT2VGG1l4w7CroRQ6gR
U7XB1twIR5NQwgqzLZfPuLFVJpml6HGUvF2Cc5gT4EwtihkablICfQmMVYUuY06oxiFFcMyaUCcS
LGR0I5q3Y8QnhcaYLJ2TrMDDbtdPx+nx5G5ZbDxaOCRf/8SBGCkVGdQn6BO8RhKgyDqCuWxEzDYR
7+jGReh4xc/y9e0YQUfV7J4WHmKoaoXgnbs738pMHTu0xptlMCSixUuwmGBXoZ43jGE0tTSY5GSL
9NM2llFMS1Vo2JyuFh5aNlHJ3/1gCKO0Ot3msOprh3EHmIssFbo6wpvkk/ZKOrDINx0En6pekX14
WYtsuwWRWzUhlnj3caCY//Z8XsvYkGFnSCugSqpFDD3QSEUqDVLU0Ub4jCQSWYOhsUn8upkVGHWh
Gs5+AQ4X+3bqC9U9tbfvuqfHH3v0iBhZqZaVlBDKcUwW5BqqMImryKTxXPiGoUOlhMWauE3nU1Ub
K3jGRSo0SCs2R2NoX2+35WC/CrBERiGCbu/lIuj1T4Rl8TheSpgsJf5LgTLGMPEFV4LTiIFGm44S
FppcATcvWEHcsflW2+2UnaRpfff49dvLPDkJpWcSQSudJQQjXkCpNtGAkgmLc0Kyx5AxG/qm26G6
nRVIVZkKzZ7NTYeuZx3bTdAcX9qHh35/SsMwvdovh4nUheiccbAGwILMNRjpXmGotPU0kAR2kCXb
IC02toZtsfAY5EHPyS1hvaZTV/hx6rWPYD4i5cs8oD2C6U4d0izB0MSgJdY4DLjMeNNvpQgb0+Vc
aW0N6eoPRmhhd+pmazo+3E1YVd8dn6CS03f74+X90+fPU2ZepVNmsLrnEDV6VSoYrGDQM02VTwx6
m29DutjSCsjFshN83RwfbKiTcP7BDfHs/DfCe3oy+MBUEY0hKzzSQxI6h3x7vLGwfDY5aemlkjlu
c3JYaeotxFXhCrKYkynBQ77b1QP4P/uXj233a/Oh7SovN2MTMxxwiIiev95gPnnoUUGMSDSyvO0k
5lT9MozTy0pse2jnYu/EYbJVvy8MGa9ZkstxuHEpO5CYwn+QhA2MTMdgi06eE5oJ2J6bFv2h5jVC
wEOdolVR0s52L9ASmN7LibyPvyIt1H5EhDKihY4uaEojrIIBI7AdXkrk0Dgig1MiB/j222S/tLKG
4FLiphbZLOCQ6iDEFMdH0G/PBvfdy/eH/u6Xvi/p4cpqANYP7sdWDSfI3gAGZFc2EtlqIsUoDWKa
6IN0wmSXt7k1TZuetbyO+OrP6s8wp09SSDh5sLPunFpQl+6UTDDYk0GtChmdaQJpnFRgDQbAbIMg
IrOtiK/fzIxLVDhAU5jjUHRH9FvMlIPlUbFROiOD0ABAeIHMs8w26IrSwMZFLA2w4vNNXqIrrW2m
o5yYIgioW0ApO7HfghLXjwqnsAp0+aQaornH/KZgIiZNG2WpYVQEQaX8H+D8E8SbQ/Ea6/xUCh7q
Tr2N9bnfD2QWlyFb4facR4fWGCGY6kUmhwyBAVYjGRkNHPre/Lu4Z21v/wazn9bfY9cufI/9fpJi
6P71eLy0gJd/344TujYjVIwOejzmQqdswFwIJoKKZh0Y2dZGYzfDP7dwBee5TA2oZwuAeiX3b/Om
gM6THkvgebFbOfTj7cCtahwLJlDdJMphLQLzDmxuULVTFBlUbEuETVvBzVpaxzgrOoGql6Du2xlv
7q/7p98f8QSvTtXoleUYSRaVBUM8cUyCyhswJTwse04prTZiOte/CuVcokKgtZoj0K2aHKCveAB/
iB9W/boVcp95Jxua8W5IUpiMsGE0lEQlHDXUb3OvmLaxQlU5KVWBRI1gBrLH8KgqWuLDu/cw5CQb
iH2HP4ZrLh1kkEY2WSakakZvRissrKfJJUsMMXrTESI0sCL9u/c3tWwL4+pQ9u/pFPrw/vbD+xKO
/+6HS8LCC38XYUhsA0pLQndSnsHo5p6hCyPoLIQrtS1+5dzGCoDX1ze1xAub90H1O1LB+PLQvV5y
Pn+DhRLJ00A/F7e85IV+/bP4IXkRItElVRSscE40NkTawNKACdVCjEluQ/N6rfrj0OAaqkmxGp06
LKAzxjC9gu543raW4TmwshIJtAFtBB1MLegnmmuMEOAMI7WTIX8O3vXNal5uDFDs5nlalOgonxyQ
fv785eG2XE6c0lKMXHuMAJWfuEYztGWsReZTBQaNlylSFsCksdsAXepfg3IpMQYhVTfz9oOHezI5
/ziRav/w/Ll9vP/vk+4yxDqejTM5HMDrhF4KsGCbQuaXfYLJhTSjkjGCZiV323ppvcmrxN9LP6gh
zzlSlNRUMn6N1vyH3f8L69TmzEtPMiaVRJZOLpxubM6xQWJDmyMYd0H9CdDjRjexnGPBmxqPWgDJ
iLnK3X5msFjD6WHqCY6uwwbTjrgIm7OjuYHlxaZglTQ+/Bs4r9JYLJet0B7mKa+VIrzbTdBi6vpX
utYlXzuNmR445hFkvjAfkMYnpRvGidNBoxvUplOexYbWSKQXio7BqXbu0gAPO9ZOSeuPR/hOd6fQ
uQst6GAAcLzsc8xoZ2FbkBG7j1N0N3YGdmoVfbJCWrat++q21pBVhcaY9NLxj+6smXYYLlqhfWkf
nj5X/3NJRsJvRTnIcj5gABUY3wb3BoPXmBITkDEjKIVu1dvUqXGLy7BGJSpMe27nmPo9ncQAlt8P
Y/p5aQzCBukDQVYHmijGwTGwTg06DTHmqM/MJ7MZyaSdK4gmJcfI2pbNF5O2bfeTcLEOs5nd/r2/
//zL7un5l6envUNuFeh7WIf33ybWWFSOcFJiUDHnD+GN5yV5aopeKiGE3DQUrzS3Rm2++oMx6B1h
Mz8weMjlJNHy3/vfjz/9+N5/636tN/cImotFWsHIE0HXKLReDGbSMsQnPBMjfBvAUQNrkEZFKhBm
fukGBnW35/uJivn15faH+C5VR95cU5tBOwH1SoN2gjfp6NzBUlRZukBglG4BgPUuy41vKnHbPV8Q
97Cn9UD74S493H++353iQji1QxQSHnIohvGjMTasEGHBu8bLYBvCWIQhpTzZFoVUtbEi/rjIGEdX
rMYJjs7oaZLu08nkxYOwOA5OKBhKrtGE3MgZ1KkgOahTUTdKUMGM82BQb9IRJ20tI5oUqjD1Sswx
9ZpPMph9bI945PGh7f5P//C1f/7Uf7nkxlOC3epBkVCJWFao1hgypGbaWNyYDJdZBiokc2obrHlz
a9jmJccA93KezUL1nMgJZfvH/nN7/HZ0H9+N7En0b8dDcExV5jFowsaApnBSjUUuLI8pcJW0jmzL
sXppZAXM+f1NLa1agACmyn4JwswLYnBfJSX7raImG8JkE11JMJd040zEIFjKaFQW9ln7J5BscIVY
Klmhs3y+mPWtspPDmJIh+CTQEmOGUWWa6cK7kIOIAs9AqcBbL1joXOEdhoVO8khMzpuOvNfaXEG6
UnqM9rBAHK0Oklu1m6M9ji+A17BmwwhVwTcSvfMAqwVDE1OtOMspbEfCcrMZ66zFK0hnZSucHZ2r
t4eOs0kQ6hC0/boeD/VivOSwgX98fiqv61tqsD21c5E0CWwzMEA1x6NE1iSvrCie2dvyWK63dg31
UvkauZ6P58NeTRm0Xy/07+7OJ1jC8GHHw37lxBtKQNEICR0ugwmNcQYMMwoqo8mWSb7JaBm1swLr
UuCmFnm+ax96jelmVnCMh2iFBXoMlGgWm5gdjkwtGu9BP1TSKUBDmd6W2GjS1pt4JqNSgwyzlRQe
KtbyrsL0dP/89HL3X+8ncfZMaI3LFSz8SMIpkJPBgUmZdYgkggootiV1G9e/AmJUokYw7xV4uCeT
XD+n3xeS3Jf7/67DamBljIHAJiZp8Xog0B2gzjYpZqMzEiZtuxGcNXIVy6VYDWh+bqMJDPzdYQHQ
TzFXVhUs5TInkXEkARJHMVElEw2VKkZrqDDb0oBdar8GAd/f1GLqueyMqrbWLfBg47kFy+Xj6Y8z
BDMMquSyQKcby6A3XIbeCLyJMFhFliI6kbZhOLWygmB4W8nPOjOXn7PD5Cbn4xM0/bxMNYM2g3ag
uRqCoSIuUMziCDtvyNAz0Ujnty1TkzbWUNSlKjSckwU0Uk68wU91fCuevpPLRLCJiKXUN4LjKacC
6w4zhjSB6QQbalTJ6j+B5tzGVTTnUjUaubBUgdKn6QKaYutXGUEiI85itLlX5Qwa7KUkYQEmgRLY
UQwPdDuQUv01DKXAWHzK5rlbNeX7dpLxD/bQeH/8+tB+v1ymkVdqTHIylqKwMgiJfM4BI1Ak8kMK
pGUxmTPBqEibDhVmja1AmhargAm+nwMTqp0k5L4fKUeHh6ffEenASTuQJ0wpudHYoPSWipJ+l4Gl
BAYU8xadoWBBM0GmhhJKQUk3Pim5Ee9Ck6ugF8pWyFs2X+3obq/s25E1UPuXry+jyXaJLgoqUmNS
o3JGohoKFqMRCRcRk6NPKdutfTu0sApveD1GxFg/70sGK8Ak9dWPfdd+/dg/o1bRQn9+6o8Dg7Ac
kr4WX1jCDOEhZFAGkNszB4xQMK4JUnoMXSByW+TYSmPLsFYKVyD53JkIH+4nbjY/wjAd8sde5ce0
DrQ1G0UjNV6tJiSoEgp5Fzl1HIyRuM3Zbd7cGsJpuQm4fgHczlg7Aff5G6iFT8/f49OX9v4xz7JD
4bQzEuO7U8OQ5Yaj7u2tyaC0YhZHSTnXfhu0urE1YHWpCpaaxwhophWx0z778vTSfzg7KFTbABuG
pfYyM88airmuuJMSNgIkYI8qEhGYj8RtA7XQ1BqyhaI3NRK6BK+bKLHTimASvzx1TxOEKcHYC8Q0
mUiPCF3jCOVN0MmDkkuCS/nfQfja2jaQr6UnOBfWF90pyq/irJivB5CBRQHTzDagn+P1a7SYiJlg
9ghnlAKFnsp/B+QVBuzFojW8/XxDYO2B0cMCvJ/OB2uiZBiN0lJc9kWCuYb+lQZPLVyi0mVkXY96
O54137zXt5XUO7sw+PZit6eLOYt+7L8+oE/b0/NrFpLRSQQxyWlYLIREu5YyPBfMHMmCjQpUiMQ3
rvl1G2to6lI3NYCFFaNvNX8L1dJllXAqUcegdyj6jytQuJyPGZVJ0FMyaMLJ/Tlc16+q5uXG2Djr
Z1dw8PDQ2X3lc3JyV7m6falobIiaNg49MnjUMOSU8I1VDmM5JMnbUrRN2lqBVReqMHE2H4UcdpjJ
+dhduhuYBmqrF7T7lCwMu1xO2Vnj0QRLWnkYgyQ6tsl+P1e+LP75dS34nLNZc9HtJ8lVjv1xng0r
aGE0V7kRlFsknlaNpxm3WW+l1gLwu42CX8uDdX59U8s4VxU45r6oF+O7fPf9y+7p4TjWEcqNOynZ
booSBDq4dDI3VgtMvIs87pm5RimkWdVG8m13aOe2VnC8vr6pRRYLODo6cRy4e/f+dPkLeiq/pRYn
Av4XNR0vAqESzArBwaAKKcEEQHuDgfAEdLjINkUOXtpYAXB+XyFQc644eCjkJMn93ae7f30Mw7XO
PHQHvrfiDG/QE6bsBxUAMzkrGFqOeg3mUtiWWHbeygqWWbkxJrE7zEcXjLjdJJvz3en4uD8Fr726
iHx4P9AsKB24V9ZgyCOMLIIXaFTpRmgOukwWNMttM2S1nRV0q+UrlAsJfbQ4KDIh/oDaCv3cx3v4
wWU9lnqIW8X4Cl72FFyDCceABGoa9BCIylFYodlGjPNWVuHNi46RSUbm5xWSdZ2c9t8rz9FAwciL
LVv+Qu+HDPaQd3irqyW6NuOxGGyjSYjogoGRuo0k4zrZ0QLPkZa2n68KckfoRNU83j/f397Bv+aB
qsVvliTCFawGnmLoi0+NF8Q3ycCCILkLlmxbF8YNrIAYFxkjUdzMlWbFezJJf9U9Px2Pg4d2+7y7
f3mes2BTUP118cPE/H1Z4z00hsBIar0UEmyGzWgCtjYEB7tLa+vQlsvXOPu5BgCL4Iw7bBHn7eGU
67Fy7VDBEQyAEBw9aRPoNR4jI2yGDStz9FkU/zPArxkm/yzw19+NP4Dt9/MhCw+nyUPPQ/bj0+/9
8zxbzTkaWRmhRYbVBLmrGs7AGvSSlXwLjIoMlbu0Ff5SW+ugl0qPoe743Cdc7zqLrIQzqC8vxwL3
06e7Ezrc7ZwVCpM7Rz5Qb8bGJPhLe29yZpETa7dig4rXocDLm1rIBcl70xm73Enw+4U0qIrapLQm
jVZ4HK0YmK8OiU44CzAsuZbpz4h/XfuryozBYLLTGZi9UocJn+vd0+N9t5AVB6MLMctKYQ4qsDyJ
8OFB8wgSoz3Qbxa3bGMcsUniZdqmE6NJgyu46kJjYD1duCzoqdlPsnDPA6ioKpw6JUOG00rGSEgj
SQStMFsB8yeLhuaofEoxhW05Y94IolqKn9K9UPOrqF5rSqcInrpfT34fpiSJoVahSutTZswnJATC
rI3ZCYxWgRWAo1nOiVdu29p3bmBN+tf3N7WkbEH8/WGylg2/HnfAIL2NLoL1h94MXp4CVnzCvAqg
OhDPuLJxu/RXPv3pdS373CUFHx6YshPZnzFRBjrf3z9CpQvcHTlI2ICSgCEENjbXFixT+PpgHQmN
Hkcmbksct9bWKqzF0hXKdh64Ag/tTrR0kaPk7vf7w4u7+zudZQLEM8cYYjSMIY2zwAB723gSeGND
ypheifhtiRJmjawAnBYbIzuIBdX1IGg3cUsEW/Lry9OX1+MERtXgX8kLw6AmKvPcaOSm5ujbZrRi
jZagsSpY3fK2PAhVGytYxkVqHHQJB2eTxDinCuYZvcaAmLTI8p4akViJ3AAbg+jc5JSYtTZqvy1x
2amx45UMrlXBt7TeSakKv5rTQcDDg53cZZzqGEfFo3q1+Bkw/pVaFhsMFgVFyEgMYyewrvCQg3Kw
d9n/jc8wFe7q15gWrj/Kgl190LIVk3Oy74/t1+OER8jDegP6nyVgAwB212CyAkxfwFxAKnOxcQiU
qtcglJeVyGZOCqwPlhs1HcfY8LAb1g7axipYMBvGUanQQTSWaQ5D11pBlARVY+NcvNS/JvylRIVg
gZoKHqp2wq44/P6f7a/n7645u6Wn6FEXFAakwxgDFMSYxoIx2qTErfJG8bAtdOrSxjUM+L5C0C14
5sBDMznkh/3i4fj1/vH20+mP4cDtFMN+UfwGShylQQmXsJ4YDCHiyIJhOJgawnAMKTYysU2YFhtb
hrdYdILULiBVu0k+p099G/1f/oMPw0ww9DyCFTLbHEwTFHoeKeMbJ/AwLSDvVY7ObktsVOpekR9f
1fKq+eHfoZdsksoVfjjWwCu5iRbBqSQbmZDRl4DwJlgwhogJsPUqvCjbKPdbSndV5KYWmS/g0HRy
4QIVXM6MKhQMqVNllg0N6CvvkMISk4niVV5wjri0LeXNqIVVDAtHRtDDdqazGkJ30k574o8X93j/
Zci/8uq2om9ZcdIp/0U01NIIamqDt80lKrSxsjhfM5lCFngeuw3NvLU1WPOSY3yMtrN1GB72ltbr
8Mv9519edn37pXJdBaPImJL9lmqHuY8NQY49mB+Nw4CmGEHT8zplzzYd9X96bWUFzOvrCgGfa0SF
BmU36aH7r2c2UbzpwjF2joWnFqkqHIWNH02LRDFsQRe3Yi3AtHPG6W0Avl4lFL28ryDAQjSHYKAT
JhCefu0fXz2H6mO8zCOHoQW6qcDbLuJU44WNDY1BC54ihx1xE4C6iRUUdaGbWup2DqWFvuDXoExz
gXKqlIANBGxUhWfEETYRQk2jtc3ZcQao6L8B50rHzAtWsLq5E6jhjIjDZAN5enoohqvQhRdKmWBg
98CrF4LpQHER1rA3SusFWD/cxuy24Sj1rsleXo7l5XJ+BwEP92qinBTezYcC+ad3s2xPSg6udoqp
DDOKN1QhHYoHq9XiaXHwTFOpA81805nhYmsrmJaKjhEKNmdLNkJwKumEIGUcgTFxKBzIToUhYPGg
dzSG+uENfnCYaCEV7UyKbaduiw0tg1ssWoEz82yu5aHk1WnDT3cRBPo5o2Pby/undt8/f3x++uP7
JUT4RB2HVC/WgHopNWZcIQ5MHGnwzsKIIFmWkm0ah2sNruBcKV1BtXs1h4pHDvXM+unx/nDf70sW
h0XHNCkcC96bRjEeT6enyE0SCbc2Rcpho90EcamhFXxLRcfgJBPzZQMetpMDu5++gu7Uh+/dQ385
zYbplwzFQxOLAQgZKV55jqBXO2Sx9cG4TU6fo8pXYFwKVMLLeaZtfLg/TGbYsX++aw99TVPmaAk+
D7BkK48xzrEp+bcyUV5b64zddhZ/qX1F+PP7WvZ5xKaRSh52XeUN84/o8nm5G8IYQ4ItR4DKrOAL
I6VnbDxzohE00KgdAcV502fHqpdFxjeVsGoeMmuUgulSb/+/Hf4AWdVrLvOifvGSnxOUsQSafswy
YvpKDRLbBCOfsmRVEjFsOtX9R/7XisD5XzeVaDs7l1dLMolG+a3vXp6e97vbf5Q/7vr2ufvloj8O
Zy8Ysoy8NUziRg9Do3HUkEZHjbm7RBJ5k3U1bmIFxKhEhcYyOUdjmWJdheYf9/v+Cbfa3dMfH1tk
cX9++dY+nLKtnDcWhdfcGmob/kADEnR7mAqqSUxgVLZJjSss1M6gFwahMW6aCZsEWMG+5afjj6Il
n++uWhpN7OSjHM/am4W9BnOmlP+if1zSxIsEaoLBJACKKzQPBGys3OYklfeKb8N9vKq6Xd7XCMx8
6dXKkAmX3/Drs2VwWgpQL8jGSFhiG/QbANXNpcY60Hy01SpSHUHv0dvFv2oVVEXGIEy7sH+Y9kAm
BBa/tw8PX9uvYw+jswog5MDcYBiJjqD6FgianmCs8ZCaDKNQe0pp3pYk75/zpsZQzq8rGLt5jhpj
Om46vQZj4cRhikg4byj3vvFRI/cyptovdLgARVIZQthGQXYW+a1jjoWCNzWgdgHlTrC1znr5/rU/
rgNUQWXNKTr9FvdfvGpUOCAtY8YT47jjfwrgp7q9RWylzBiWVYe5cQqbt52cRf2zRxKtcmXCxHDE
zgSa1xixU1LGStBekwXbIaGiHfBgMEJ/CVgEHY8yW7ptBJaGVmCUd5X43Tz4AR7u+klejX/eP+6f
fr84cl+0AvrqFZsws3fWDUGnX1jPKKzjeFsC+6xkVHMhN22z05ZWkExKjTG1fTs7uMWHsCrUmJ7v
8UALF/46zY7IXiouG4Ec0jCFwBrQATRLUCyFizr6beEO4/pXUIxKjBHseDvvFZwp7Upq0399DCO2
4Mp+I8lnDnp/MjisMPeyE5jGQNosLfSN2ZbZtW5hGU5dpgIkLF8AZNsJ02Xjvn59V5wHL7mxRs/O
2hE5GW7OO0Ewz7ywSMjBJGu8BzVC5Ew0JQnMmk3nOj/P2x09WkZ7/Tc1+v0S+p5NwqcapMh4rasp
F7aXiActirV6K4rXiEgYk1piBQKySKEXdIyqyVmA+ZoFLPqb1PCfx03+fGpyBe9S0RpmvwBT6Wky
qOY/+5ch+mCKsZw1ikxiVrZJVsBOzPH6X8A6YnlWAdd1kTadbf18buUNWLNyY0wd6eYHwB3VepJQ
9D48PH3b/9e3p0ty93IPxxg1NLAmMNSSLPGNFWCuOrBqLIFq4jZyi1H1yyhGBW5qSeeqRceknngr
jX5e94YRweicQTcNzuPykTEXF/zFiUjZkqC2XVdVDbwJoe6DXrbzLbaXAGECosMKPoQw+MaU3Isw
mrinpwhmD9qQQ84UR5z3VGPOiG2ff1TzivCjEiPZLWn1TOvBh/uJ79tP7850SxVFMcUzDQETO2ql
kJ8nNN4kULODAC1bcOnCgpJz921XHb2d6147cDsXqGTfzROO48NDYTZ4uN+5f+HRQoBv9fnp+bsH
rQ8THp9oPakFvQb9klyKRBFQB7TBsDOLZ++SgJXHmIVeUNA/OIS+HZ+RhvOvV+utxbMLn7bjQ3Q7
VoNf1oE9e//bWSwhSXFsYCUM1YAdW04xkG84egFbo5ENkTbQjFH8RkwEm9V4U7ctFwQS5iBHAt3d
pRH1KU4xdFePljdRIAFOhDXCeQrqBuU0UQmmYI4LYpzrqUXYL32T/a4EqEBh714t4ZMMjA0pPE0J
hwhJZOQq5phQrOSbhe2kSVkZ7jmJocTljiSZVFeL0h8WRDlYcfoaaM2lx5f7l4eiwZ0JYQ0pRzcl
KSXsBBpTc5jCecZw+SQ+N4oEDwPf5cGlaCTQcqWVXPt5/hZLemEJGeQ6xe3/s33+OvlWOKRRtBJ8
qFMCPd9gGmW0Gi3Yv8S6JqRok7eGGz8ZPGv13tRyLPRfL4Xc7Ypw6XH/9eke+a0HF7Nh4r8KKI29
jG7rkoENBlYO5D12DIYVgwnoFSYYtCIkmWsBr9VdC9ktrAt91+9PE694mH197l8waeTJFe4koUY2
vlPGWBvw2J2iVgq2G8+Y59EH2iCJC2ccVgY9GW6rFVfiHfqFaXjou2KRQeEf+99g7evLWfvgZX7u
YIKc18P3Y5YrMCMwIarCtKF4x8Zh+7NJpgTvhGe0lm6t3olwC9/ucBBc2EG4p2P/MuJHV/rWlhsK
za0OuA/ghTjNYM3jtxLEKgZmfkwlJ+ZYmnFFYxEomR9cl4f8NDHvvrbIuXD5KKZc1YENRGVuJNfo
2JvwuN34JgYpYJgxJ6bDqapmIsB+QQC8fBsE+PQ+LSwGFgOxMUEMGJjoE4C+WGBhNpHGDBYbJzJN
hsu5nqp1PXfrwYc7UJRK690v7eNjf4Yv1fkk2WVmwRBnDZPlJDnBhhEwZoxJr7WWVpT0DCMJqroq
KYzmcylgw9nRgS67sCY83Qp16QZbBCm5BFWkPDow6rQHQXQMjaURprpMKiRCAvOTTzGprhKl3c0X
atrud1qxIsovvx3OQgwkjkFq7ZC/h2CwPHGw9EnTUGasMDwwVW7LRq2fa6jaPZCFdg9Ug7Fe2v3y
3J13KWPoKKO2sIFZsM+TYxiZwXFXEDAUCXdWZUxnXbd/rmncPivze9I+PDTkRMr+3LcPGHv783G4
YJkPCO2Fgc0xNMrZgJsAaXwWtEE39xyMdFpNNoHFOmupDvPtiQnWSzZIdTw+3AqzNCqIhsEpYI2g
jiLjtggNZgxuiCeOGCLMkON/JM24rkoIoeyCEFZzNczQI1pK6HP5te/u8aS8379KRAq7OQ8wHcAs
F+ikECRprAVFAnDIaMFKD2SyWq1WWImlST8XS7M9o/Yi1ltqn8jI4wBaBCGMDfqokWBqRoXTJkQF
u9FIuFLnX9crrwVkSwJy2uvRdyvkE5jb+90PlzFFdelHTJNPA4b5Zd1ki37HXpMGVDHTBB0VGF9G
02p21wLOKq/l43xBPvg6gl/kG5/znORTt7xk8i//LWeWOA9T9AwvLa3ACCnnZWOYg30hUc7gk4Kh
rlflnDVSyynskpy23+8ucv7tPZpjrxOhHEImWJkJTsNocWHENRFUaZgHVgnjlRKcr/ftqL6JMPsF
YaTgdNSpAyMEwDnvXKIkd0BOWBhcSaJHWzS6MbBMNZQEsEypRLekVXkmVdYyzbM340PF9mOZ+pf2
ofpGhY1NM0oDjHqSDMoEmqtBem4HG7mgYGuaK9+ornIikl4SqX3V94ffYx6Xy7gfDo4NGa6OgsDk
oxq+UcLsTYJmE4ijWcR1ecb1TcTpFsRRu37XXcT5YYcZBoZLjWtDPUQqaOC5ybRkqItIhgjDjDht
QPXwXlRLay3jrJFaTrU0uqArxz15ylB8/myXbMkBRrzCr2dpSWSqkFhUS7xFEDSCxsS4W5WsqraW
an5uBA+NNif1pPz8x/5z/4f/dv+w75+vfj7DooYJ6RqmHEEHSFCcXCje3IJSQ2iOaVXIeSuVpIbO
tVl4uKd89P3uuv6xn80ExlgMSK0CfYhiYdQdtXhER0XgiRsT1r9dXeVEpIVdAHQjzcYiLWnZmnJc
+V0juEe/fQ5LKq6rXFFkUCLK+ysSrSnc0LZZEKjdmX4s0PfH7pfnp1eClKsdmmOOYA2DuesYnlkI
UAENjLqgtTAMPhwnV+RcaqiWt12Yu6YTvSJjecemry4EMwHX/QQ7ZzmjFMUTDxRFDluSobizX5mm
a+YuNLygkZl9p+3o6419CM7GG+y2t5QP5jgT2knoVAcfB5Vm3fiEmbMZfC5BONVufdWdV14LuF8a
b/teqZFa9DNOoZf7x58PD0/tS9W7r72Knm6WG1hByoFYljj6DJJoZw9bROSa5FUZl+qfSDlX95lV
LbFyJGV4egTD/rl/7L5fX1ISVcZIzGqRkbjc5gZWQYPuMdFTgYypZF3WWSs3tVC7JUn3BzPSkn6O
7fPv94+Xy2567nY9HKnhiER3NoUZGB1sj+iuqzGBOMPzmKw9qKGerY/ItSYmwvZLwvZ9v7siLFsS
1mXpYLMNTWQY/0o0b3yE+S1Cgh0vwNKUxHZh2aKwi2PgoFt9RVi++GUjC5zC2pg9JirweEchlWoy
iSFKBdZXSdu7UVi+JKwmc2FbPCoczfufy/aE7Ahv7IHaKzCNPTJL4gFKCsjbgjTR1GsZfSLUhHV5
Z63c1EItfNbW7ki3H0l6Bwr34+dRhvKr8ytmQqnCdNuh3Fypxkb4xplGH4ROnAm/Lu5yU7XMdlHm
A+/G47Z/fn58Wup+vP4EU5s1kZSLqQirFg+hycyQFKWG9erKxBpVWwvVigWhWsH3o5l//H78uVDf
LYglvAyEKdOwkvw3MbDdMsz8EBNSvMNnI+ti1RVXgnVkYSx2hLfi9LXK5vXzvgzr/f1z8eY7r6CU
lS1IUycwYEBYdAG2mTdIfNqQyHl2oIja6qJhqPKvb1Q+kVIsSdlzW0nZj+hTLtdFF6IWLUkAHRFG
HEPPHicV+pb5JgSCnoJGBUmuCTqrfyLkwsDrcDephDy2j/cl0/j5YoKdMgkbk4ImmH0CE/YR2M49
A+su8uC5VdpETa9JN624Fo7qJeH0bqfHwsH0uqiOQguct6boGZpakbP0sIcH5NrGDYeUEzpGbEYK
0cIttCrdqOZaMLGwJ3b28GqmlIORT93T40/ux4+Dy/R5PaRcDExj5pT7TObslNYGj3Lx5CCAyecy
6OE0kKQx/ZEdKxrfhuqOf73aTiXuvl+YL/uDtv3wHT8xQqZSYqY/sKpU8QfMJJAgMAc5cgUh74Dl
uNkI2NBtDpgmb0XCWdW1YIe5Ki52hrcnK/nbcf/zl8uQQ58PPGmEVZhSD4POKTxISHjxxPFOlVNQ
cIWTSY0Vbqjlr5PKbv4/Q04OVw==
````

### vq-dense-reinvestment-cpu-sample-v1/native/receipt.json

Original bytes: 22027. SHA-256: `19dfaa92742f2aec87b3f64a756b37d2f7720ccff4214aaf2089ccda0c43e75f`.

Normalized bytes: 22027. SHA-256: `19dfaa92742f2aec87b3f64a756b37d2f7720ccff4214aaf2089ccda0c43e75f`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 5.0519623079757192,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.0763868330104742,
    3.4173039580055047,
    3.6147795830038376,
    3.8053122500132304,
    3.9849230000108946,
    4.1648649160051718,
    4.339853416022379,
    4.531721916020615,
    4.709809000021778,
    7.1343631659983657,
    7.3663338750193361,
    7.5454968330159318,
    7.7428307500085793,
    7.9209982500178739,
    8.1355386250070296,
    8.3046735830139369,
    8.4532309159985743,
    8.6502438750176225,
    8.8311839160160162,
    9.0279857080022339,
    9.2114862500166055,
    9.3991540000133682,
    9.5849553750013001,
    9.7754415410163347,
    9.9797978750139009,
    10.169315416016616,
    10.346300166012952,
    10.523199707997264,
    10.744855124998139,
    10.948721958004171,
    11.14639041601913,
    11.317196500021964,
    11.585749833000591,
    11.860458166018361,
    12.130709165998269,
    12.412236250005662,
    12.615208750008605,
    12.810695457999827,
    13.000504875002662,
    13.180256291001569,
    13.353562000003876,
    13.555673333001323,
    13.760170458001085,
    13.952409375022398,
    14.127500666014384,
    14.344294083013665,
    14.562233208009275,
    14.822573458019178,
    14.99551520802197,
    15.155144999996992,
    15.321604750002734,
    15.506431540998165,
    15.673662583023543,
    15.837266750022536,
    16.000419666001108,
    16.207002416020259,
    16.384862750011962,
    16.566964916011784,
    16.725644375022966,
    16.888498208019882,
    17.084922458016081,
    17.265942333004205,
    17.445687041006749,
    17.61452141602058,
    17.817372290999629,
    17.975698666006792,
    18.168765541020548,
    18.359847625019029,
    18.527364750014385,
    18.691866541019408,
    18.870853291009553,
    19.041585666011088,
    19.202578750002431,
    19.361148333002347,
    19.523455665999791,
    19.678714500012575,
    19.825651000021026,
    19.997692083008587,
    20.150963833002606,
    20.297852750023594,
    20.48248383300961,
    20.656952250021277,
    20.839431916014291,
    21.004455832997337,
    21.18257450000965,
    21.347330999997212,
    21.492492083023535,
    21.648365041008219,
    21.8343515410088,
    22.014676666003652,
    22.168732707999879,
    22.325041333009722,
    22.473108333011623,
    22.618975416000467,
    22.770014416018967,
    22.937025000021094,
    23.090131500008283,
    23.244386375008617,
    23.422330541012343,
    23.621900666010333,
    23.792497250018641,
    23.948032790998695,
    24.114253208012087,
    24.274951500003226,
    24.434099791018525,
    24.575114791019587,
    24.747822583012749,
    24.892423083016183,
    25.053914375021122,
    25.205588125012582,
    25.356482958013657,
    25.558557458018186,
    25.746207625023089,
    25.906373541016364,
    26.063908250012901,
    26.231743208016269,
    26.389628875011113,
    26.562280291022034,
    26.713975791004486,
    26.880162750021555,
    27.067750500020338,
    27.250022000022,
    27.406271166022634,
    27.554279416013742,
    27.7126144580252,
    27.871721166011412,
    28.05360858302447,
    28.21513337502256
  ],
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
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
    11,
    321,
    6587,
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
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
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
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25204064256,
    "swapins" : 24,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.34091712499503046,
    0.19747562499833293,
    0.19053266700939275,
    0.17961074999766424,
    0.17994191599427722,
    0.17498850001720712,
    0.19186849999823608,
    0.17808708400116302,
    2.4245541659765877,
    0.23197070902097039,
    0.17916295799659565,
    0.19733391699264757,
    0.1781675000092946,
    0.21454037498915568,
    0.16913495800690725,
    0.14855733298463747,
    0.19701295901904814,
    0.18094004099839367,
    0.19680179198621772,
    0.1835005420143716,
    0.18766774999676272,
    0.18580137498793192,
    0.19048616601503454,
    0.20435633399756625,
    0.18951754100271501,
    0.17698474999633618,
    0.17689954198431224,
    0.22165541700087488,
    0.20386683300603181,
    0.19766845801495947,
    0.17080608400283381,
    0.26855333297862671,
    0.2747083330177702,
    0.27025099997990765,
    0.28152708400739357,
    0.20297250000294298,
    0.19548670799122192,
    0.18980941700283438,
    0.17975141599890776,
    0.17330570900230668,
    0.20211133299744688,
    0.20449712499976158,
    0.19223891702131368,
    0.17509129099198617,
    0.21679341699928045,
    0.21793912499560975,
    0.26034025000990368,
    0.17294175000279211,
    0.15962979197502136,
    0.16645975000574253,
    0.1848267909954302,
    0.16723104202537797,
    0.16360416699899361,
    0.1631529159785714,
    0.20658275001915172,
    0.17786033399170265,
    0.18210216599982232,
    0.15867945901118219,
    0.16285383299691603,
    0.19642424999619834,
    0.18101987498812377,
    0.17974470800254494,
    0.16883437501383014,
    0.20285087497904897,
    0.15832637500716373,
    0.19306687501375563,
    0.19108208399848081,
    0.16751712499535643,
    0.16450179100502282,
    0.17898674999014474,
    0.17073237500153482,
    0.16099308399134316,
    0.15856958299991675,
    0.16230733299744315,
    0.15525883401278406,
    0.14693650000845082,
    0.17204108298756182,
    0.15327174999401905,
    0.14688891702098772,
    0.18463108298601583,
    0.17446841701166704,
    0.18247966599301435,
    0.16502391698304564,
    0.17811866701231338,
    0.16475649998756126,
    0.14516108302632347,
    0.15587295798468404,
    0.18598650000058115,
    0.18032512499485165,
    0.15405604199622758,
    0.15630862500984222,
    0.14806700000190176,
    0.14586708298884332,
    0.15103900001849979,
    0.16701058400212787,
    0.15310649998718873,
    0.15425487500033341,
    0.17794416600372642,
    0.19957012499799021,
    0.17059658400830813,
    0.15553554098005407,
    0.16622041701339185,
    0.16069829199113883,
    0.15914829101529904,
    0.14101500000106171,
    0.17270779199316166,
    0.14460050000343472,
    0.16149129200493917,
    0.15167374999145977,
    0.15089483300107531,
    0.20207450000452809,
    0.18765016700490378,
    0.16016591599327512,
    0.15753470899653621,
    0.16783495800336823,
    0.15788566699484363,
    0.17265141601092182,
    0.15169549998245202,
    0.16618695901706815,
    0.18758774999878369,
    0.18227150000166148,
    0.15624916600063443,
    0.14800824999110773,
    0.15833504201145843,
    0.1591067079862114,
    0.18188741701305844,
    0.16152479199809022
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.383900999993784,
  "metadata_seconds" : 0.13391333300387487,
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
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7758551112,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "4dad7f7432d8d40aede62cb654fb0d77f8756c2017b3d6afc12745fee5804286",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 28.215150833013467,
  "request_vm_after" : {
    "reclaimableBytes" : 18123161600,
    "swapins" : 24,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17333878784,
    "swapins" : 24,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.0763868330104742,
  "validation_receipt_sha256" : "240ae706cf5b0a02bb8788b99306ad4f45cb3507785f16e5c240e2de70085be5",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-dense-reinvestment-cpu-sample-v1/supervision/identity.json

Original bytes: 3178. SHA-256: `9bcd0a58f678696e3ed0ae6b48cdff6aae3cd576b741215d0035c1c945da33cc`.

Normalized bytes: 3122. SHA-256: `bc71e09251e0d19550a58042630132bc546c4db30c349388a664616bda710522`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-dense-reinvestment-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/bench/quantization/dense-reinvestment-cost-v1.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-reinvestment-cpu-sample-v1/native",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-reinvestment-cost-v1/validation-reinvest/receipt.json",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24024285184,
    "swapins": 24,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   459800.\nPages active:                                 859507.\nPages inactive:                               823607.\nPages speculative:                             86956.\nPages throttled:                                   0.\nPages wired down:                             185552.\nPages purgeable:                                1305.\n\"Translation faults\":                     1875557419.\nPages copy-on-write:                        92088867.\nPages zero filled:                        3110267187.\nPages reactivated:                         171537928.\nPages purged:                               12176186.\nFile-backed pages:                           1005221.\nAnonymous pages:                              764849.\nPages stored in compressor:                  1230117.\nPages occupied by compressor:                 669695.\nDecompressions:                             93586845.\nCompressions:                              106206578.\nPageins:                                  2062737789.\nPageouts:                                     464538.\nSwapins:                                          24.\nSwapouts:                                       2908.\nPages tagged:                                 128639.\nPages tagged resident:                         85885.\nPages tagged compressed:                       42754.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5185.\nPages tag-storage free:                          482.\nPages tag-storage non-tag pageable:            92629.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6448000.\nTagged compressions:                          671875.\nTagged decompressions:                        561832.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-dense-reinvestment-cpu-sample-v1/supervision/receipt.json

Original bytes: 2138. SHA-256: `dd4eaa5d46129a1b645aa1bdd96507b1cca0ba03f62cceddccc22801ab1521a5`.

Normalized bytes: 2138. SHA-256: `dd4eaa5d46129a1b645aa1bdd96507b1cca0ba03f62cceddccc22801ab1521a5`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7758551112,
  "samples": 1514,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24362123264,
    "swapins": 24,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   469351.\nPages active:                                 853379.\nPages inactive:                               826486.\nPages speculative:                             83395.\nPages throttled:                                   0.\nPages wired down:                             178913.\nPages purgeable:                                 119.\n\"Translation faults\":                     1877097553.\nPages copy-on-write:                        92187938.\nPages zero filled:                        3111381771.\nPages reactivated:                         171598962.\nPages purged:                               12183795.\nFile-backed pages:                           1017476.\nAnonymous pages:                              745784.\nPages stored in compressor:                  1239943.\nPages occupied by compressor:                 672264.\nDecompressions:                             93794185.\nCompressions:                              106474451.\nPageins:                                  2072966711.\nPageouts:                                     465124.\nSwapins:                                          24.\nSwapouts:                                       2908.\nPages tagged:                                 129784.\nPages tagged resident:                         85427.\nPages tagged compressed:                       44357.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5185.\nPages tag-storage free:                         1724.\nPages tag-storage non-tag pageable:            91387.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6740736.\nTagged compressions:                          673960.\nTagged decompressions:                        562308.\n"
  },
  "seconds": 87.898475916998
}
````

### vq-dense-reinvestment-cpu-sample-v1/supervision/stdout.txt

Original bytes: 22028. SHA-256: `9f77a4047ceb8885a7762efe14f9a13a28a4c8e6a0a4f387d4b4a55b3ea16e43`.

Normalized bytes: 22028. SHA-256: `9f77a4047ceb8885a7762efe14f9a13a28a4c8e6a0a4f387d4b4a55b3ea16e43`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 5.0519623079757192,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.0763868330104742,
    3.4173039580055047,
    3.6147795830038376,
    3.8053122500132304,
    3.9849230000108946,
    4.1648649160051718,
    4.339853416022379,
    4.531721916020615,
    4.709809000021778,
    7.1343631659983657,
    7.3663338750193361,
    7.5454968330159318,
    7.7428307500085793,
    7.9209982500178739,
    8.1355386250070296,
    8.3046735830139369,
    8.4532309159985743,
    8.6502438750176225,
    8.8311839160160162,
    9.0279857080022339,
    9.2114862500166055,
    9.3991540000133682,
    9.5849553750013001,
    9.7754415410163347,
    9.9797978750139009,
    10.169315416016616,
    10.346300166012952,
    10.523199707997264,
    10.744855124998139,
    10.948721958004171,
    11.14639041601913,
    11.317196500021964,
    11.585749833000591,
    11.860458166018361,
    12.130709165998269,
    12.412236250005662,
    12.615208750008605,
    12.810695457999827,
    13.000504875002662,
    13.180256291001569,
    13.353562000003876,
    13.555673333001323,
    13.760170458001085,
    13.952409375022398,
    14.127500666014384,
    14.344294083013665,
    14.562233208009275,
    14.822573458019178,
    14.99551520802197,
    15.155144999996992,
    15.321604750002734,
    15.506431540998165,
    15.673662583023543,
    15.837266750022536,
    16.000419666001108,
    16.207002416020259,
    16.384862750011962,
    16.566964916011784,
    16.725644375022966,
    16.888498208019882,
    17.084922458016081,
    17.265942333004205,
    17.445687041006749,
    17.61452141602058,
    17.817372290999629,
    17.975698666006792,
    18.168765541020548,
    18.359847625019029,
    18.527364750014385,
    18.691866541019408,
    18.870853291009553,
    19.041585666011088,
    19.202578750002431,
    19.361148333002347,
    19.523455665999791,
    19.678714500012575,
    19.825651000021026,
    19.997692083008587,
    20.150963833002606,
    20.297852750023594,
    20.48248383300961,
    20.656952250021277,
    20.839431916014291,
    21.004455832997337,
    21.18257450000965,
    21.347330999997212,
    21.492492083023535,
    21.648365041008219,
    21.8343515410088,
    22.014676666003652,
    22.168732707999879,
    22.325041333009722,
    22.473108333011623,
    22.618975416000467,
    22.770014416018967,
    22.937025000021094,
    23.090131500008283,
    23.244386375008617,
    23.422330541012343,
    23.621900666010333,
    23.792497250018641,
    23.948032790998695,
    24.114253208012087,
    24.274951500003226,
    24.434099791018525,
    24.575114791019587,
    24.747822583012749,
    24.892423083016183,
    25.053914375021122,
    25.205588125012582,
    25.356482958013657,
    25.558557458018186,
    25.746207625023089,
    25.906373541016364,
    26.063908250012901,
    26.231743208016269,
    26.389628875011113,
    26.562280291022034,
    26.713975791004486,
    26.880162750021555,
    27.067750500020338,
    27.250022000022,
    27.406271166022634,
    27.554279416013742,
    27.7126144580252,
    27.871721166011412,
    28.05360858302447,
    28.21513337502256
  ],
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
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
    11,
    321,
    6587,
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
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
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
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25204064256,
    "swapins" : 24,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.34091712499503046,
    0.19747562499833293,
    0.19053266700939275,
    0.17961074999766424,
    0.17994191599427722,
    0.17498850001720712,
    0.19186849999823608,
    0.17808708400116302,
    2.4245541659765877,
    0.23197070902097039,
    0.17916295799659565,
    0.19733391699264757,
    0.1781675000092946,
    0.21454037498915568,
    0.16913495800690725,
    0.14855733298463747,
    0.19701295901904814,
    0.18094004099839367,
    0.19680179198621772,
    0.1835005420143716,
    0.18766774999676272,
    0.18580137498793192,
    0.19048616601503454,
    0.20435633399756625,
    0.18951754100271501,
    0.17698474999633618,
    0.17689954198431224,
    0.22165541700087488,
    0.20386683300603181,
    0.19766845801495947,
    0.17080608400283381,
    0.26855333297862671,
    0.2747083330177702,
    0.27025099997990765,
    0.28152708400739357,
    0.20297250000294298,
    0.19548670799122192,
    0.18980941700283438,
    0.17975141599890776,
    0.17330570900230668,
    0.20211133299744688,
    0.20449712499976158,
    0.19223891702131368,
    0.17509129099198617,
    0.21679341699928045,
    0.21793912499560975,
    0.26034025000990368,
    0.17294175000279211,
    0.15962979197502136,
    0.16645975000574253,
    0.1848267909954302,
    0.16723104202537797,
    0.16360416699899361,
    0.1631529159785714,
    0.20658275001915172,
    0.17786033399170265,
    0.18210216599982232,
    0.15867945901118219,
    0.16285383299691603,
    0.19642424999619834,
    0.18101987498812377,
    0.17974470800254494,
    0.16883437501383014,
    0.20285087497904897,
    0.15832637500716373,
    0.19306687501375563,
    0.19108208399848081,
    0.16751712499535643,
    0.16450179100502282,
    0.17898674999014474,
    0.17073237500153482,
    0.16099308399134316,
    0.15856958299991675,
    0.16230733299744315,
    0.15525883401278406,
    0.14693650000845082,
    0.17204108298756182,
    0.15327174999401905,
    0.14688891702098772,
    0.18463108298601583,
    0.17446841701166704,
    0.18247966599301435,
    0.16502391698304564,
    0.17811866701231338,
    0.16475649998756126,
    0.14516108302632347,
    0.15587295798468404,
    0.18598650000058115,
    0.18032512499485165,
    0.15405604199622758,
    0.15630862500984222,
    0.14806700000190176,
    0.14586708298884332,
    0.15103900001849979,
    0.16701058400212787,
    0.15310649998718873,
    0.15425487500033341,
    0.17794416600372642,
    0.19957012499799021,
    0.17059658400830813,
    0.15553554098005407,
    0.16622041701339185,
    0.16069829199113883,
    0.15914829101529904,
    0.14101500000106171,
    0.17270779199316166,
    0.14460050000343472,
    0.16149129200493917,
    0.15167374999145977,
    0.15089483300107531,
    0.20207450000452809,
    0.18765016700490378,
    0.16016591599327512,
    0.15753470899653621,
    0.16783495800336823,
    0.15788566699484363,
    0.17265141601092182,
    0.15169549998245202,
    0.16618695901706815,
    0.18758774999878369,
    0.18227150000166148,
    0.15624916600063443,
    0.14800824999110773,
    0.15833504201145843,
    0.1591067079862114,
    0.18188741701305844,
    0.16152479199809022
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.383900999993784,
  "metadata_seconds" : 0.13391333300387487,
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
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7758551112,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "4dad7f7432d8d40aede62cb654fb0d77f8756c2017b3d6afc12745fee5804286",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 28.215150833013467,
  "request_vm_after" : {
    "reclaimableBytes" : 18123161600,
    "swapins" : 24,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17333878784,
    "swapins" : 24,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.0763868330104742,
  "validation_receipt_sha256" : "240ae706cf5b0a02bb8788b99306ad4f45cb3507785f16e5c240e2de70085be5",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-dense-reinvestment-cpu-sample-v1/supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### frozen-dense-reinvestment-v1/build-identity.json

Original bytes: 31715. SHA-256: `dd1195f26f31549af5284601bcc480b08992d64643753322ae737698672df5a3`.

Normalized bytes: 31715. SHA-256: `dd1195f26f31549af5284601bcc480b08992d64643753322ae737698672df5a3`.

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
    "Sources/Slotstream/VQCheckpoint.swift": "5b6d5877b28ea19ad3624dfe1d660db3a2dab7da19212e060c097da1712b7c17",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQDenseOverlay.swift": "0102f31346cb84048b551265696cd4bcf4dd7f2a73c60be6840d654f9c4a2978",
    "Sources/Slotstream/VQExpert.swift": "b62435a1dec9cde5dd294db83909ea2b559554fed284f028df50cd0c92d682cb",
    "Sources/Slotstream/VQExpertKernels.swift": "3d0a9c22935d8984583ea59cf94a923f31ac03f8944ae570abb0b6b9749ded86",
    "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
    "Sources/Slotstream/VQModelProbe.swift": "4425a383cfce125065b3ba829272e640837596de3c0bc2e7f6940866c9de55e8",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
    "Sources/Slotstream/VQRecord.swift": "3688d7bdaf9730e0cfd13635ac550706539585c91edaae9a13336e6e63db2616",
    "Sources/Slotstream/VQRecordBank.swift": "61d399967fa738ff864c544972adc0c57e07de60516a0afa49091adc2c231ce9",
    "Sources/Slotstream/VQRecordCache.swift": "2fe427a6a60f464100cf2ffc407bf869290ab9d0cc81b9ae38bde65b9dc52d5b",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "c2941bd4926d848d778d65a15602a1706b69a000be5724462aea73eab1a6cb6b",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "e5c9db25339aebdfa1efbb3b1f88d69103deb4a79d70c06a092e8d0a6e0d24ad",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "a621961d592d240820a8da9904d896795ef2716f9a7b20ad372b89589c778399",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "d72ab83f9b4a43f28db4df3cbe35ce1b04e45387f0e0d40324ccc7e142c18023",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "1539fa20986c554865714a5b17d23c5563917419fd044ec2ab3972b8608f9355",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "5e31622154a5dff25a5ca7a03bee7d695af1fb6431cbab62d73d8c7c9a2dd49f",
  "binary_sha256": "4dad7f7432d8d40aede62cb654fb0d77f8756c2017b3d6afc12745fee5804286",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````
