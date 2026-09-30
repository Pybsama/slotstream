---
type: reference
id: 01m3sncy83p0c6sdxhykmrtkar
created: 2026-09-30T17:22:05.699307+00:00
updated: 2026-09-30T17:22:25.726744+00:00
summary: Routed-expert record sizes per layer of the VQ 2.1-bit build, read from its safetensors headers at the revision issue 7 inspected.
captured_at: 2026-09-30T16:55:09Z
title: 'Qwen3.8-Flash-Next VQ 2.1-bit: routed-expert record sizes by layer'
url: https://huggingface.co/TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw/tree/8684640a3956b01c47f5d47f9b999e2ab8b985f1
---
# Qwen3.8-Flash-Next VQ 2.1-bit: routed-expert record sizes by layer

Read on 2026-09-30 at 16:55Z from
<https://huggingface.co/TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw> at revision
`8684640a3956b01c47f5d47f9b999e2ab8b985f1`, the revision
[#7](https://github.com/carloslfu/slotstream/issues/7) inspected and
[[sources/references/2026/09/2026-09-28-qwen-flash-next-vq-model-card]] records.
No weights were downloaded: `model.safetensors.index.json` names the shards,
and for each shard holding routed experts (`mlp.switch_mlp`) an HTTP range read
fetched the 8-byte header length and then the JSON header, which gives every
tensor's dtype, shape and byte range. The collected headers hash to SHA-256
`a37bf2bffcd03e48c4c8f5fc528a4dd5010c0347c3d2fb620d483c3a4015cd2e`.

Each layer stores its 512 routed experts as `codes` and `vq_scales` per
projection, which scale with the experts, and one `codebook` per projection,
shared by all 512. A record's bytes below are its three projections' codes and
scales, what an expert slot would hold.

Readout script, run over the collected headers:

```python
import json
headers = json.load(open("headers.json"))
tensors = {}
for shard, header in headers.items():
    for name, t in header.items():
        if name != "__metadata__":
            tensors[name] = (shard, t["dtype"], t["shape"], t["data_offsets"][1] - t["data_offsets"][0])
print("layer | gate_proj codes | up_proj codes | down_proj codes | codebooks (gate, up, down) | bytes per routed expert (codes + vq_scales)")
for layer in range(48):
    p = f"model.layers.{layer}.mlp.switch_mlp."
    codes = [tensors[p + proj + ".codes"] for proj in ("gate_proj", "up_proj", "down_proj")]
    books = [tensors[p + proj + ".codebook"][2] for proj in ("gate_proj", "up_proj", "down_proj")]
    scales = [tensors[p + proj + ".vq_scales"] for proj in ("gate_proj", "up_proj", "down_proj")]
    experts = codes[0][2][0]
    per_expert = sum(c[3] for c in codes + scales) // experts
    print(f"{layer} | {codes[0][1]} {codes[0][2]} | {codes[1][1]} {codes[1][2]} | {codes[2][1]} {codes[2][2]} | "
          f"{books[0]} {books[1]} {books[2]} | {per_expert}")
```

Its complete output:

```
layer | gate_proj codes | up_proj codes | down_proj codes | codebooks (gate, up, down) | bytes per routed expert (codes + vq_scales)
0 | U8 [512, 640, 1280] | U8 [512, 640, 1280] | U8 [512, 2560, 320] | [256, 2] [256, 2] [256, 2] | 2611200
1 | U8 [512, 640, 1280] | U8 [512, 640, 1280] | U8 [512, 2560, 320] | [256, 2] [256, 2] [256, 2] | 2611200
2 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
3 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
4 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
5 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
6 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
7 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
8 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
9 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
10 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
11 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
12 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
13 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
14 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
15 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
16 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
17 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
18 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
19 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
20 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
21 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
22 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
23 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
24 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
25 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
26 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
27 | U32 [512, 640, 160] | U32 [512, 640, 160] | U32 [512, 2560, 40] | [256, 4] [256, 4] [256, 4] | 1382400
28 | U32 [512, 640, 160] | U32 [512, 640, 160] | U32 [512, 2560, 40] | [256, 4] [256, 4] [256, 4] | 1382400
29 | U32 [512, 640, 160] | U32 [512, 640, 160] | U32 [512, 2560, 40] | [256, 4] [256, 4] [256, 4] | 1382400
30 | U32 [512, 640, 160] | U32 [512, 640, 160] | U32 [512, 2560, 40] | [256, 4] [256, 4] [256, 4] | 1382400
31 | U32 [512, 640, 160] | U32 [512, 640, 160] | U32 [512, 2560, 40] | [256, 4] [256, 4] [256, 4] | 1382400
32 | U32 [512, 640, 160] | U32 [512, 640, 160] | U32 [512, 2560, 40] | [256, 4] [256, 4] [256, 4] | 1382400
33 | U32 [512, 640, 160] | U32 [512, 640, 160] | U32 [512, 2560, 40] | [256, 4] [256, 4] [256, 4] | 1382400
34 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
35 | U32 [512, 640, 160] | U32 [512, 640, 160] | U32 [512, 2560, 40] | [256, 4] [256, 4] [256, 4] | 1382400
36 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
37 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
38 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
39 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
40 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
41 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
42 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
43 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
44 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
45 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
46 | U32 [512, 640, 140] | U32 [512, 640, 140] | U32 [512, 2560, 40] | [16384, 8] [16384, 8] [256, 4] | 1280000
47 | U32 [512, 640, 160] | U32 [512, 640, 160] | U32 [512, 2560, 40] | [256, 4] [256, 4] [256, 4] | 1382400
```

Summary of the output: 37 layers at 1,280,000 bytes per expert, the nine
layers whose gate and up projections use d=4/K=256 codebooks (27 to 33, 35
and 47) at 1,382,400, and layers 0 and 1, with d=2/K=256 codebooks, at
2,611,200.
