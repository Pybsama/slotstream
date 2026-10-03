---
type: run
created: 2026-10-03T08:45:35.328834+00:00
updated: 2026-10-03T08:45:35.328834+00:00
summary: Matched serial and parallel VQ read pilot improves bounded generation
binary: 7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f
captured_at: 2026-10-03
command: Exact sequential producer and diagnostic commands are preserved in the driver and supervision identity transcripts below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Matched serial and parallel VQ read pilot improves bounded generation
tool: bounded VQ research diagnostics
---

The frozen same-binary, same-artifact comparison changes demanded-read concurrency only. Resident text, fixed 512/96 banks, empty starting caches, original forty-four prompt tokens, greedy sampling, 128 generated samples and the 10 GB process bound are held constant. Both modes first pass independent sixteen-step full-vocabulary validation. All six measurements are eligible under the frozen observed thermal, power, paging, ambient-override and sample-count conditions. There are three interleaved pairs, no replacement runs, and no competing model, build or storage benchmark initiated by the operator. Authentication reads all 138 main payloads before timing, so these are not cold-SSD results.

Every measured 128-token output is identical. Serial generation rates are 2.998757929836414, 3.06688649430021 and 3.0836054017856114 tokens/s. Parallel rates are 4.278707709321652, 4.278021258198011 and 4.2850604644405115. The median paired ratio is 1.3949069410128767, approximately 39.49 percent faster. Median serial and parallel first-token latency is 9.257755416998407 and 3.4169932910008356 seconds. Full request, initial stalls and all emission intervals remain recorded. Separate validation timing is excluded. The complete output remains capped reasoning, not a completed-task quality result; EOS is unexercised.

Sixteen metadata/validation refusals and two actual serial/parallel profile-receipt cross-binding refusals pass on the final binary before model output is created. The comparison proves a narrow prototype improvement on this M5 Pro. It remains well below the target and does not establish production-pack superiority, a universal worker count, larger-budget performance, held-out quality or hardware qualification. Production defaults and supported packs remain unchanged.

Local home prefixes are replaced with <HOME>. Original byte counts and SHA-256 values identify unmodified local transcripts. Tensor fixture payloads, frozen executables and source archives remain in the bounded research directory; manifests bind their hashes. These experimental runs do not qualify a production speed profile, task quality or an alternative production pack. No model is installed or activated.

### vq_read_pair_pilot.py

Original bytes: 7183. SHA-256: `e7bdd1486970e8b8fcc80e816d23ad4bc39575ecd144bbe54ea48d935e7244ef`.

````text
#!/usr/bin/env python3
"""Frozen same-artifact serial/parallel read comparison, with no promotion."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil
import statistics
import sys

from quantization_logit_run import digest, supervise

PROTOCOL_SHA = '8009cdf7ff516f8159e35ef03343bfa27d64564ba147553b59acc8a2d4f71f10'


def run(options):
    root = Path(__file__).resolve().parent.parent
    binary, research, out = options.binary.resolve(), options.research_root.resolve(), options.out.resolve()
    source = root / 'bench/quantization/read-pair-v1.json'
    if digest(source) != PROTOCOL_SHA:
        raise ValueError('read-pair protocol differs from its frozen identity')
    protocol = json.loads(source.read_text())
    identity = json.loads((binary.parent / 'build-identity.json').read_text())
    producer = {k: identity[k] for k in ('binary_sha256', 'metallib_sha256')}
    drivers = {str(Path(module.__file__).resolve().relative_to(root)): digest(Path(module.__file__).resolve())
               for module in list(sys.modules.values()) if getattr(module, '__file__', None)
               and Path(module.__file__).resolve().parent == root / 'Tools'}
    drivers[str(Path(__file__).resolve().relative_to(root))] = digest(Path(__file__))
    if binary.name != 'slotstream':
        raise ValueError('use the source-bound CLI executable')
    out.mkdir(parents=False, exist_ok=False)
    shutil.copy2(source, out / 'protocol.json')
    for name, expected in protocol['profiles'].items():
        profile = root / 'bench/quantization' / name
        if digest(profile) != expected:
            raise ValueError('native comparison profile changed')
        shutil.copy2(profile, out / name)
    record = dict(schema=1, scope=protocol['scope'], qualification='unproven', complete=False,
                  started_at=datetime.now(timezone.utc).isoformat(), protocol_sha256=PROTOCOL_SHA,
                  producer=producer, source_archive_sha256=identity['source_archive_sha256'], drivers=drivers, runs=[])
    expected_tokens = None

    def save():
        (out / 'run.json').write_text(json.dumps(record, indent=2) + '\n')

    def verify():
        for name, key in [('slotstream', 'binary_sha256'), ('mlx.metallib', 'metallib_sha256'),
                          ('build-source.tar.gz', 'source_archive_sha256')]:
            if digest(binary.parent / name) != identity[key]:
                raise ValueError('comparison producer changed')
        if digest(source) != PROTOCOL_SHA or digest(out / 'protocol.json') != PROTOCOL_SHA:
            raise ValueError('comparison protocol changed')
        for name, expected in protocol['profiles'].items():
            if digest(out / name) != expected:
                raise ValueError('native comparison profile changed')
        for name, expected in drivers.items():
            if digest(root / name) != expected:
                raise ValueError('comparison driver changed')

    def invoke(arm, name, measurement=False):
        nonlocal expected_tokens
        verify()
        profile_name = protocol['arms'][arm]
        native = json.loads((out / profile_name).read_text())
        reference_inventory = next(key for key, value in native['references'].items() if value['pack'] == protocol['pack'])
        command = [str(binary), 'quantization-performance-pilot', '--source-directory', str(research / 'candidate-3.2'),
                   '--source-inventory', str(research / 'inventory-3.2/inventory.json'),
                   '--profile', str(out / profile_name), '--output', str(out / name)]
        if measurement:
            command += ['--measure', '--validation-receipt', str(out / ('validation-' + arm) / 'receipt.json')]
        observed = supervise(command, out / (name + '-supervision'), protocol['resources']['run_timeout_seconds'])
        path = out / name / 'receipt.json'
        receipt = json.loads(path.read_text())
        if (not receipt['passed'] or receipt['producer'] != producer
                or receipt['profile_sha256'] != protocol['profiles'][profile_name]
                or receipt['inventory_sha256'] != reference_inventory
                or receipt['mode'] != ('measurement' if measurement else 'validation')
                or receipt['cache_after']['parallel_read_lanes'] != (12 if arm == 'parallel' else 0)):
            raise ValueError('comparison receipt changed its artifact, profile, mode or producer')
        same_tokens = True
        if measurement:
            if expected_tokens is None:
                expected_tokens = receipt['generated']
            same_tokens = receipt['generated'] == expected_tokens
        row = dict(name=name, arm=arm, mode=receipt['mode'], receipt_sha256=digest(path), supervision=observed,
                   timing_eligible=receipt['observed_timing_eligible'], timing_exclusions=receipt['timing_exclusions'],
                   exact_generated_sequence=same_tokens,
                   generated_sha256=hashlib.sha256(json.dumps(receipt['generated']).encode()).hexdigest())
        for key in ('committed_tokens', 'committed_decode_tokens_per_second', 'ttft_seconds', 'request_seconds', 'peak_process_bytes'):
            row[key] = receipt.get(key)
        record['runs'].append(row)
        save()
        if not same_tokens:
            raise ValueError('serial and parallel complete generated sequences differ')
        verify()
        print(json.dumps({key: value for key, value in row.items() if key != 'supervision'}), flush=True)

    save()
    try:
        for arm in protocol['arms']:
            invoke(arm, 'validation-' + arm)
        for index, order in enumerate(protocol['rounds'], 1):
            for arm in order:
                invoke(arm, f'round-{index}-{arm}', measurement=True)
        timings = [row for row in record['runs'] if row['mode'] == 'measurement']
        record['all_observed_timings_eligible'] = all(row['timing_eligible'] for row in timings)
        if record['all_observed_timings_eligible']:
            record['medians'] = {arm: {
                key: statistics.median(row[key] for row in timings if row['arm'] == arm)
                for key in ('committed_decode_tokens_per_second', 'ttft_seconds', 'request_seconds')}
                for arm in protocol['arms']}
            by_name = {row['name']: row for row in timings}
            record['paired_decode_ratios'] = [
                by_name[f'round-{i}-parallel']['committed_decode_tokens_per_second'] /
                by_name[f'round-{i}-serial']['committed_decode_tokens_per_second'] for i in range(1, 4)]
            record['median_paired_decode_ratio'] = statistics.median(record['paired_decode_ratios'])
        record['complete'] = True
        record['finished_at'] = datetime.now(timezone.utc).isoformat()
        save()
    except BaseException as error:
        record['failure'] = str(error)
        save()
        raise


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('binary', 'research-root', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
````

### vq-read-pair-v1.log

Original bytes: 4256. SHA-256: `70f1177126c3e2eb62a072aa70452795630eb6bc8972bcd5d2337eaec3c35004`.

````text
{"name": "validation-serial", "arm": "serial", "mode": "validation", "receipt_sha256": "0f07363316d910373ff5e8fc9379f9f32d655bda6b7c8128a5897712fe5a9e17", "timing_eligible": false, "timing_exclusions": ["validation mode hashes logits", "too few committed tokens"], "exact_generated_sequence": true, "generated_sha256": "73bf8d8ae425be08f582c1dede821fbe98494b6beaf1cec3c9501b88d8ea07bb", "committed_tokens": 16, "committed_decode_tokens_per_second": 2.1454313923443924, "ttft_seconds": 9.450928915990517, "request_seconds": 16.442549915984273, "peak_process_bytes": 7918573688}
{"name": "validation-parallel", "arm": "parallel", "mode": "validation", "receipt_sha256": "5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996", "timing_eligible": false, "timing_exclusions": ["validation mode hashes logits", "too few committed tokens"], "exact_generated_sequence": true, "generated_sha256": "73bf8d8ae425be08f582c1dede821fbe98494b6beaf1cec3c9501b88d8ea07bb", "committed_tokens": 16, "committed_decode_tokens_per_second": 3.627852584268295, "ttft_seconds": 3.4646286249917466, "request_seconds": 7.599325666989898, "peak_process_bytes": 8072911088}
{"name": "round-1-serial", "arm": "serial", "mode": "measurement", "receipt_sha256": "f9dfde92d3b1b6717ac8e1871d6ba7c602b199090695d5994bfebde61376662b", "timing_eligible": true, "timing_exclusions": [], "exact_generated_sequence": true, "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395", "committed_tokens": 128, "committed_decode_tokens_per_second": 2.998757929836414, "ttft_seconds": 9.330406832974404, "request_seconds": 51.68129495799076, "peak_process_bytes": 7874975792}
{"name": "round-1-parallel", "arm": "parallel", "mode": "measurement", "receipt_sha256": "72f380fe488efb2712dec3a8f69e2d2dc7cb13d1a1f8e3e844d2b29abe380f68", "timing_eligible": true, "timing_exclusions": [], "exact_generated_sequence": true, "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395", "committed_tokens": 128, "committed_decode_tokens_per_second": 4.278707709321652, "ttft_seconds": 3.365528958995128, "request_seconds": 33.04741229201318, "peak_process_bytes": 8049334440}
{"name": "round-2-parallel", "arm": "parallel", "mode": "measurement", "receipt_sha256": "420440bd60b3a84a8341410dc3b6dd2483403bd5a8ba535b0d79961e03508fd2", "timing_eligible": true, "timing_exclusions": [], "exact_generated_sequence": true, "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395", "committed_tokens": 128, "committed_decode_tokens_per_second": 4.278021258198011, "ttft_seconds": 3.4169932910008356, "request_seconds": 33.103635499981465, "peak_process_bytes": 8041257104}
{"name": "round-2-serial", "arm": "serial", "mode": "measurement", "receipt_sha256": "58bb2da729a1d16079d6674a24e121b00cbd1718e2b88db218ca1d1cc9aa9e7b", "timing_eligible": true, "timing_exclusions": [], "exact_generated_sequence": true, "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395", "committed_tokens": 128, "committed_decode_tokens_per_second": 3.06688649430021, "ttft_seconds": 9.257755416998407, "request_seconds": 50.66785045899451, "peak_process_bytes": 7874549832}
{"name": "round-3-serial", "arm": "serial", "mode": "measurement", "receipt_sha256": "6fbc9e1d29c84353ece06d2ca464f622b60c1611a52d6581e037dac28bcd1023", "timing_eligible": true, "timing_exclusions": [], "exact_generated_sequence": true, "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395", "committed_tokens": 128, "committed_decode_tokens_per_second": 3.0836054017856114, "ttft_seconds": 9.25681487499969, "request_seconds": 50.44238979101647, "peak_process_bytes": 7875385416}
{"name": "round-3-parallel", "arm": "parallel", "mode": "measurement", "receipt_sha256": "27bfeedbe7e66d9085d936e8771ea9e70120b2d78587065b1edd7d9efd858f3a", "timing_eligible": true, "timing_exclusions": [], "exact_generated_sequence": true, "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395", "committed_tokens": 128, "committed_decode_tokens_per_second": 4.2850604644405115, "ttft_seconds": 3.560547500004759, "request_seconds": 33.198421834007604, "peak_process_bytes": 8029690024}
````

### vq-read-pair-v1/protocol.json

Original bytes: 1724. SHA-256: `8009cdf7ff516f8159e35ef03343bfa27d64564ba147553b59acc8a2d4f71f10`.

````text
{
  "schema": 1,
  "profile": "vq-parallel-read-pair-v1",
  "scope": "same-binary same-artifact bounded engineering comparison; no product qualification",
  "pack": "3.2",
  "profiles": {
    "performance-pilot-v1.json": "8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5",
    "performance-pilot-v2.json": "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7"
  },
  "arms": {
    "serial": "performance-pilot-v1.json",
    "parallel": "performance-pilot-v2.json"
  },
  "rounds": [
    [
      "serial",
      "parallel"
    ],
    [
      "parallel",
      "serial"
    ],
    [
      "serial",
      "parallel"
    ]
  ],
  "resources": {
    "validation_runs": 2,
    "timing_runs": 6,
    "run_timeout_seconds": 1800,
    "maximum_process_bytes": 10000000000,
    "minimum_reclaimable_bytes": 13000000000,
    "additional_weights_bytes": 0,
    "paid_compute_usd": 0
  },
  "contract": "Two separate exact full-logit prefix validations, followed by six interleaved measurements. Freeze one source-bound executable and Metal library for both arms. Native profiles hold prompt, sampling, cache capacities, text residency, resources and timer semantics constant; only demanded-read concurrency changes. Every measured generated sequence must exactly match the first serial sequence, including full length and EOS behavior. Preserve all per-run and supervision evidence; no retries, dropped slow runs or best-of selection. Publish medians and paired ratios only when all observed timings are eligible. Clear cache/model state per process; never claim a cold SSD after full authentication. These descriptive three-pair data do not establish a confidence bound or >=20 tokens/s qualification."
}
````

### vq-read-pair-v1/performance-pilot-v1.json

Original bytes: 14224. SHA-256: `8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5`.

````text
{
  "checkpoint": "Qwen/Qwen3.8-Flash-Next",
  "checkpoint_revision": "de4b8e4d43b917e7706784d8bb445c9af86a3540",
  "tokenizer_sha256": "0997f410c57a1f4e53b09e4be8f4a172d90edd9564368fb0847030937229b9f3",
  "text": "<|im_start|>user\nExplain in two short paragraphs how a local mixture-of-experts model can use SSD streaming when its weights exceed RAM. Distinguish a saved memory ceiling from current allocation.<|im_end|>\n<|im_start|>assistant\n<think>\n",
  "text_sha256": "2423950dce73c0bee4a35e59a45904858ccc85bce5d661610e74b6905a2f828a",
  "prompt": [
    248045,
    846,
    198,
    814,
    20139,
    303,
    1330,
    2716,
    41228,
    1204,
    264,
    2136,
    20340,
    8404,
    17830,
    15089,
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
    414,
    85596,
    264,
    6568,
    4779,
    21482,
    494,
    1428,
    23014,
    13,
    248046,
    198,
    248045,
    74455,
    198,
    248068,
    198
  ],
  "sampling": "argmax-first-index",
  "eos_token_id": 248044,
  "schema": 1,
  "profile": "vq-greedy128-performance-pilot-v1",
  "scope": "experimental single-context non-speculative pilot, not complete-configuration qualification",
  "max_new_tokens": 128,
  "minimum_committed_tokens": 64,
  "validation_steps": 16,
  "configuration": {
    "resident_text": true,
    "main_bank_records": 512,
    "secondary_bank_records": 96,
    "mtp": false,
    "vision": false,
    "context_limit": 2054,
    "process_bound_bytes": 10000000000
  },
  "resources": {
    "validation_runs": 2,
    "timing_runs": 6,
    "run_timeout_seconds": 1800,
    "minimum_reclaimable_bytes": 13000000000,
    "minimum_remaining_headroom_bytes": 3000000000,
    "additional_weights_bytes": 0,
    "paid_compute_usd": 0
  },
  "rounds": [
    [
      "3.2",
      "4.4"
    ],
    [
      "4.4",
      "3.2"
    ],
    [
      "3.2",
      "4.4"
    ]
  ],
  "protocol": {
    "validation": "Separate process verifies all sixteen complete Float32 vocabulary arrays and autoregressive samples against the pinned independent greedy reference with state observation disabled. Required before measurement for this exact binary, metallib, profile and inventory.",
    "cache_state": "All 138 main payloads are fully authenticated through owned descriptors before the request. New model state and empty expert banks per process; resident text loaded before request. OS page cache is uncontrolled after these reads and is not described as cold SSD. No warmup generation.",
    "timer": "Monotonic request start immediately before first forward; emission after forward returns and sample is ready. TTFT is first committed emission minus request start. Committed decode rate is (emitted non-EOS tokens minus one) / (last committed emission minus first committed emission). Report total request and load durations separately; EOS and setup are excluded from decode numerator.",
    "observation": "Full state/logit hashing and trace callbacks disabled in measurement. Existing finite checks, headroom checks, cache arithmetic and synchronization retained. Operating conditions observed between emissions and included in inter-emission time.",
    "eligibility": "No paging increase during request, nominal observed thermal state, low-power mode off, at least 64 committed tokens, no development overrides, independent supervision completed and preflight excludes competing model/compiler jobs; operator reviews the task list and runs no storage study during the pilot. Preserve ineligible runs, no replacement runs or best-of selection.",
    "comparison": "Report every run, paired medians only if all six timing runs are eligible. No baseline speedup or >=20 tokens/s qualification from this pilot. No held-out quality inference."
  },
  "references": {
    "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe": {
      "pack": "3.2",
      "manifest_sha256": "30708c5b7188bf76ec0548da7603672d99cf1871371a5c1366db0e4ecac03db6",
      "generated": [
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
        24797
      ],
      "logits": [
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            44,
            248320
          ],
          "dtype": "F32",
          "bytes": 43704320,
          "sha256": "88a5dda18125a2db2d6ee80cce7cb639cd93c65fd2c3aefe520380f311379456"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "605444ab7ee3fda8e6b91ef9f529fde40230b72f3df8dce9ed8fb4b350d6a9e5"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "99bc1be04bbdc44892da0e741c6398e3cddc3ae9e02133141cb65f2d1a047f13"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "cb4f78ec48189e3b003c9b4ba573041f7bc17c00be2b54d8b2bb602e52062bae"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "25e3628dc501312e25dcf41de2f7ff0ef2a7b2eba5c0cabf3cb7040f2ea64fcf"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "8afa673c720d2e12935049bc68ab23bd47f36c624271f09a6e47de1d7411cee1"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "b6aada687bd352edd05e0bb931e3c368dbbdbce2f9cb0f69b2b1107b395583df"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "88c3d2503ed5cbac6b099b01f9c494d900a1faa6cf5a8d182e53bfba0ba3730a"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "e4b42eabb8b0eb7b88931deded0f9fb9f5d9ceb6898842a349c545fe203508de"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "cbdbb0987cba9adb0c3fa12134cd096b5e527fa04ebf6e8c794bf1e6a309890e"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "55d945e09227d0a0b551479752c8673f42ae9cb5c75432b78ec1d668426b638a"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "22978c1b4fc2195f60ad469761062246f897555752869e9de2e012ee26f7323c"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "a3dc7d30b80c1b7e36e4aca23ab69eca40d1a09fb1ae780c327c4a3f2f533b53"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "83b373f83d65dc593a800d87cf62f8775867c7271d8bd05f4a41f12742f61c62"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "45665722f236ed23e4e2125ab60b280e4c849f7a4d028184333aaa3ff6559cee"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "f4df8a60fdcfa89e67687c173b1a92d6bee5960c76ecd40c589728e919a569e2"
        }
      ]
    },
    "a30ded4e88270d33dfcca8e9b6c414a69cf82f0ad27d20bb3fe71b2b1c14ccac": {
      "pack": "4.4",
      "manifest_sha256": "eeac2656cad7f6219dbc3a6d6192a69c3d1f9f5c6f70522ae0fb65b4f8b63036",
      "generated": [
        760,
        1156,
        369,
        9859,
        883,
        264,
        10597,
        8282,
        25,
        1204,
        264,
        2136,
        20340,
        8404,
        17830,
        15089
      ],
      "logits": [
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            44,
            248320
          ],
          "dtype": "F32",
          "bytes": 43704320,
          "sha256": "2e6b345c237073597e640c487fc06bd98f0b045e281255f0f8a97e2e2c557896"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "8363d8acc400c6f2cc2ab108322bcc460c04aebe349070ec2d024426d446e865"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "784091dcaab6504fc4bd814bcbf75a3efc30b1681395abbc9d4174d71e7aa06c"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "b9ea4f6e5aec60322a64cededd59239ad7807644d0f6b038a3c4509945bd06f9"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d49dba44345d6f65295a5a0c69d55dd56d7a24bbef00b5a2f2b805c331346cfd"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d4188f818e7f661dc80e3de80bb50b2944d2f5d50d236a1751291c7a22e829fc"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "982cf849b688656d524002f563206f733c142ccdda6a7829be9c7cec9374be2d"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d10e28be9ae60331ae88162f265834fd6535ab2ad50372846ca8a72222eb1395"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "2060db74a9f9d4c35a40fd5b3eeb14484d98c6a4cd495b99740c3fd4094c1bfd"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "f4d055b09e4e9b3b45bc8ac87099be4c0043efbf45bb55db09b3fac45b818f99"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d2b257165b941b925c15023fe9303cdc9eed28046dd8629eff0715814344b53d"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d83e6015a9160f128be575eb8c07f7b9c7925b569d64fdeecbb966406586fceb"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d30f6ab08ef0504b5b1702b4aa698561e8ebc0ab8f8d552a6a4531f0e873b8d1"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "5dbef9981894a2e54f9282bc2e0a8cc8b17f1ef5ffac896a4ae3f97ce2ec22a4"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "5412216db718a4b7046bdc8ea9364cf2e7cd0ddfb38ebcfdc5aea1243885281f"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d59b4009feeb2bc8bed679bd48e516db4d189e23ced4def0a03cfb8c75d758ed"
        }
      ]
    }
  }
}
````

### vq-read-pair-v1/performance-pilot-v2.json

Original bytes: 14500. SHA-256: `611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7`.

````text
{
  "checkpoint": "Qwen/Qwen3.8-Flash-Next",
  "checkpoint_revision": "de4b8e4d43b917e7706784d8bb445c9af86a3540",
  "tokenizer_sha256": "0997f410c57a1f4e53b09e4be8f4a172d90edd9564368fb0847030937229b9f3",
  "text": "<|im_start|>user\nExplain in two short paragraphs how a local mixture-of-experts model can use SSD streaming when its weights exceed RAM. Distinguish a saved memory ceiling from current allocation.<|im_end|>\n<|im_start|>assistant\n<think>\n",
  "text_sha256": "2423950dce73c0bee4a35e59a45904858ccc85bce5d661610e74b6905a2f828a",
  "prompt": [
    248045,
    846,
    198,
    814,
    20139,
    303,
    1330,
    2716,
    41228,
    1204,
    264,
    2136,
    20340,
    8404,
    17830,
    15089,
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
    414,
    85596,
    264,
    6568,
    4779,
    21482,
    494,
    1428,
    23014,
    13,
    248046,
    198,
    248045,
    74455,
    198,
    248068,
    198
  ],
  "sampling": "argmax-first-index",
  "eos_token_id": 248044,
  "schema": 1,
  "profile": "vq-greedy128-parallel-read-performance-pilot-v2",
  "scope": "experimental single-context non-speculative pilot, not complete-configuration qualification",
  "max_new_tokens": 128,
  "minimum_committed_tokens": 64,
  "validation_steps": 16,
  "configuration": {
    "resident_text": true,
    "main_bank_records": 512,
    "secondary_bank_records": 96,
    "mtp": false,
    "vision": false,
    "context_limit": 2054,
    "process_bound_bytes": 10000000000,
    "parallel_read_lanes": 12,
    "maximum_read_staging_bytes": 128000000
  },
  "resources": {
    "validation_runs": 2,
    "timing_runs": 6,
    "run_timeout_seconds": 1800,
    "minimum_reclaimable_bytes": 13000000000,
    "minimum_remaining_headroom_bytes": 3000000000,
    "additional_weights_bytes": 0,
    "paid_compute_usd": 0
  },
  "rounds": [
    [
      "3.2",
      "4.4"
    ],
    [
      "4.4",
      "3.2"
    ],
    [
      "3.2",
      "4.4"
    ]
  ],
  "protocol": {
    "validation": "Separate process verifies all sixteen complete Float32 vocabulary arrays and autoregressive samples against the pinned independent greedy reference with state observation disabled. Required before measurement for this exact binary, metallib, profile and inventory.",
    "cache_state": "All 138 main payloads are fully authenticated through owned descriptors before the request. New model state and empty expert banks per process; resident text loaded before request. OS page cache is uncontrolled after these reads and is not described as cold SSD. No warmup generation.",
    "timer": "Monotonic request start immediately before first forward; emission after forward returns and sample is ready. TTFT is first committed emission minus request start. Committed decode rate is (emitted non-EOS tokens minus one) / (last committed emission minus first committed emission). Report total request and load durations separately; EOS and setup are excluded from decode numerator.",
    "observation": "Full state/logit hashing and trace callbacks disabled in measurement. Existing finite checks, headroom checks, cache arithmetic and synchronization retained. Operating conditions observed between emissions and included in inter-emission time. Demanded cache-miss reads use at most twelve CPU lanes, complete within the fixed staging reservation and join before serialized cache publication. Large immutable prefill is unchanged.",
    "eligibility": "No paging increase during request, nominal observed thermal state, low-power mode off, at least 64 committed tokens, no development overrides, independent supervision completed and preflight excludes competing model/compiler jobs; operator reviews the task list and runs no storage study during the pilot. Preserve ineligible runs, no replacement runs or best-of selection.",
    "comparison": "Report every run, paired medians only if all six timing runs are eligible. No baseline speedup or >=20 tokens/s qualification from this pilot. No held-out quality inference."
  },
  "references": {
    "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe": {
      "pack": "3.2",
      "manifest_sha256": "30708c5b7188bf76ec0548da7603672d99cf1871371a5c1366db0e4ecac03db6",
      "generated": [
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
        24797
      ],
      "logits": [
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            44,
            248320
          ],
          "dtype": "F32",
          "bytes": 43704320,
          "sha256": "88a5dda18125a2db2d6ee80cce7cb639cd93c65fd2c3aefe520380f311379456"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "605444ab7ee3fda8e6b91ef9f529fde40230b72f3df8dce9ed8fb4b350d6a9e5"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "99bc1be04bbdc44892da0e741c6398e3cddc3ae9e02133141cb65f2d1a047f13"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "cb4f78ec48189e3b003c9b4ba573041f7bc17c00be2b54d8b2bb602e52062bae"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "25e3628dc501312e25dcf41de2f7ff0ef2a7b2eba5c0cabf3cb7040f2ea64fcf"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "8afa673c720d2e12935049bc68ab23bd47f36c624271f09a6e47de1d7411cee1"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "b6aada687bd352edd05e0bb931e3c368dbbdbce2f9cb0f69b2b1107b395583df"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "88c3d2503ed5cbac6b099b01f9c494d900a1faa6cf5a8d182e53bfba0ba3730a"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "e4b42eabb8b0eb7b88931deded0f9fb9f5d9ceb6898842a349c545fe203508de"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "cbdbb0987cba9adb0c3fa12134cd096b5e527fa04ebf6e8c794bf1e6a309890e"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "55d945e09227d0a0b551479752c8673f42ae9cb5c75432b78ec1d668426b638a"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "22978c1b4fc2195f60ad469761062246f897555752869e9de2e012ee26f7323c"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "a3dc7d30b80c1b7e36e4aca23ab69eca40d1a09fb1ae780c327c4a3f2f533b53"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "83b373f83d65dc593a800d87cf62f8775867c7271d8bd05f4a41f12742f61c62"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "45665722f236ed23e4e2125ab60b280e4c849f7a4d028184333aaa3ff6559cee"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "f4df8a60fdcfa89e67687c173b1a92d6bee5960c76ecd40c589728e919a569e2"
        }
      ]
    },
    "a30ded4e88270d33dfcca8e9b6c414a69cf82f0ad27d20bb3fe71b2b1c14ccac": {
      "pack": "4.4",
      "manifest_sha256": "eeac2656cad7f6219dbc3a6d6192a69c3d1f9f5c6f70522ae0fb65b4f8b63036",
      "generated": [
        760,
        1156,
        369,
        9859,
        883,
        264,
        10597,
        8282,
        25,
        1204,
        264,
        2136,
        20340,
        8404,
        17830,
        15089
      ],
      "logits": [
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            44,
            248320
          ],
          "dtype": "F32",
          "bytes": 43704320,
          "sha256": "2e6b345c237073597e640c487fc06bd98f0b045e281255f0f8a97e2e2c557896"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "8363d8acc400c6f2cc2ab108322bcc460c04aebe349070ec2d024426d446e865"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "784091dcaab6504fc4bd814bcbf75a3efc30b1681395abbc9d4174d71e7aa06c"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "b9ea4f6e5aec60322a64cededd59239ad7807644d0f6b038a3c4509945bd06f9"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d49dba44345d6f65295a5a0c69d55dd56d7a24bbef00b5a2f2b805c331346cfd"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d4188f818e7f661dc80e3de80bb50b2944d2f5d50d236a1751291c7a22e829fc"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "982cf849b688656d524002f563206f733c142ccdda6a7829be9c7cec9374be2d"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d10e28be9ae60331ae88162f265834fd6535ab2ad50372846ca8a72222eb1395"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "2060db74a9f9d4c35a40fd5b3eeb14484d98c6a4cd495b99740c3fd4094c1bfd"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "f4d055b09e4e9b3b45bc8ac87099be4c0043efbf45bb55db09b3fac45b818f99"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d2b257165b941b925c15023fe9303cdc9eed28046dd8629eff0715814344b53d"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d83e6015a9160f128be575eb8c07f7b9c7925b569d64fdeecbb966406586fceb"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d30f6ab08ef0504b5b1702b4aa698561e8ebc0ab8f8d552a6a4531f0e873b8d1"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "5dbef9981894a2e54f9282bc2e0a8cc8b17f1ef5ffac896a4ae3f97ce2ec22a4"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "5412216db718a4b7046bdc8ea9364cf2e7cd0ddfb38ebcfdc5aea1243885281f"
        },
        {
          "layer": 48,
          "name": "logits",
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "d59b4009feeb2bc8bed679bd48e516db4d189e23ced4def0a03cfb8c75d758ed"
        }
      ]
    }
  }
}
````

### vq-read-pair-v1/run.json

Original bytes: 25006. SHA-256: `1c9fe4ecd70965ecb92c4db49ee50440f2ad004524209de0d36105d0936f1a03`.

````text
{
  "schema": 1,
  "scope": "same-binary same-artifact bounded engineering comparison; no product qualification",
  "qualification": "unproven",
  "complete": true,
  "started_at": "2026-10-03T08:25:10.585581+00:00",
  "protocol_sha256": "8009cdf7ff516f8159e35ef03343bfa27d64564ba147553b59acc8a2d4f71f10",
  "producer": {
    "binary_sha256": "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "source_archive_sha256": "f232d15c7fd904c317793e650bcfdf385d6e504a31b9fd704dbd1ca57ead686e",
  "drivers": {
    "Tools/vq_read_pair_pilot.py": "e7bdd1486970e8b8fcc80e816d23ad4bc39575ecd144bbe54ea48d935e7244ef",
    "Tools/prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472",
    "Tools/memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc",
    "Tools/context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34",
    "Tools/quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb",
    "Tools/vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e",
    "Tools/vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
    "Tools/quantization_logit_run.py": "877d3236a4973a526b4386a037efea3a6a0bbfdb45847a915e60d3c864041bbb"
  },
  "runs": [
    {
      "name": "validation-serial",
      "arm": "serial",
      "mode": "validation",
      "receipt_sha256": "0f07363316d910373ff5e8fc9379f9f32d655bda6b7c8128a5897712fe5a9e17",
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7918573688,
        "samples": 775,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24868143104,
          "swapins": 16,
          "swapouts": 2904,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   477606.\nPages active:                                 857920.\nPages inactive:                               818303.\nPages speculative:                             78209.\nPages throttled:                                   0.\nPages wired down:                             179462.\nPages purgeable:                                 874.\n\"Translation faults\":                     1490542195.\nPages copy-on-write:                        76851274.\nPages zero filled:                        2371734072.\nPages reactivated:                          96724048.\nPages purged:                               11286274.\nFile-backed pages:                           1039351.\nAnonymous pages:                              715081.\nPages stored in compressor:                  1256766.\nPages occupied by compressor:                 673219.\nDecompressions:                             43736688.\nCompressions:                               54264521.\nPageins:                                  1119012319.\nPageouts:                                     371487.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127650.\nPages tagged resident:                         83545.\nPages tagged compressed:                       44105.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          866.\nPages tag-storage non-tag pageable:            92228.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6712064.\nTagged compressions:                          496902.\nTagged decompressions:                        402661.\n"
        },
        "seconds": 45.660787542001344
      },
      "timing_eligible": false,
      "timing_exclusions": [
        "validation mode hashes logits",
        "too few committed tokens"
      ],
      "exact_generated_sequence": true,
      "generated_sha256": "73bf8d8ae425be08f582c1dede821fbe98494b6beaf1cec3c9501b88d8ea07bb",
      "committed_tokens": 16,
      "committed_decode_tokens_per_second": 2.1454313923443924,
      "ttft_seconds": 9.450928915990517,
      "request_seconds": 16.442549915984273,
      "peak_process_bytes": 7918573688
    },
    {
      "name": "validation-parallel",
      "arm": "parallel",
      "mode": "validation",
      "receipt_sha256": "5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996",
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 8072911088,
        "samples": 630,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 25108447232,
          "swapins": 16,
          "swapouts": 2904,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   487134.\nPages active:                                 845495.\nPages inactive:                               814908.\nPages speculative:                             77809.\nPages throttled:                                   0.\nPages wired down:                             178111.\nPages purgeable:                                  72.\n\"Translation faults\":                     1491459328.\nPages copy-on-write:                        76864214.\nPages zero filled:                        2372768658.\nPages reactivated:                          96762431.\nPages purged:                               11290051.\nFile-backed pages:                           1045292.\nAnonymous pages:                              692920.\nPages stored in compressor:                  1270440.\nPages occupied by compressor:                 680955.\nDecompressions:                             44280458.\nCompressions:                               54848797.\nPageins:                                  1124193693.\nPageouts:                                     372460.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127234.\nPages tagged resident:                         83658.\nPages tagged compressed:                       43576.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                         1254.\nPages tag-storage non-tag pageable:            91840.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6599232.\nTagged compressions:                          497373.\nTagged decompressions:                        403610.\n"
        },
        "seconds": 36.812763958005235
      },
      "timing_eligible": false,
      "timing_exclusions": [
        "validation mode hashes logits",
        "too few committed tokens"
      ],
      "exact_generated_sequence": true,
      "generated_sha256": "73bf8d8ae425be08f582c1dede821fbe98494b6beaf1cec3c9501b88d8ea07bb",
      "committed_tokens": 16,
      "committed_decode_tokens_per_second": 3.627852584268295,
      "ttft_seconds": 3.4646286249917466,
      "request_seconds": 7.599325666989898,
      "peak_process_bytes": 8072911088
    },
    {
      "name": "round-1-serial",
      "arm": "serial",
      "mode": "measurement",
      "receipt_sha256": "f9dfde92d3b1b6717ac8e1871d6ba7c602b199090695d5994bfebde61376662b",
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7874975792,
        "samples": 1370,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24882085888,
          "swapins": 16,
          "swapouts": 2904,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   475836.\nPages active:                                 859375.\nPages inactive:                               849441.\nPages speculative:                             48940.\nPages throttled:                                   0.\nPages wired down:                             179023.\nPages purgeable:                                6211.\n\"Translation faults\":                     1492217770.\nPages copy-on-write:                        76884946.\nPages zero filled:                        2376595744.\nPages reactivated:                          96792353.\nPages purged:                               11291664.\nFile-backed pages:                           1036635.\nAnonymous pages:                              721121.\nPages stored in compressor:                  1248159.\nPages occupied by compressor:                 671596.\nDecompressions:                             44878351.\nCompressions:                               55452841.\nPageins:                                  1129613018.\nPageouts:                                     372833.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127486.\nPages tagged resident:                         84490.\nPages tagged compressed:                       42996.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5201.\nPages tag-storage free:                         1139.\nPages tag-storage non-tag pageable:            91956.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6483904.\nTagged compressions:                          497748.\nTagged decompressions:                        404559.\n"
        },
        "seconds": 80.95857929100748
      },
      "timing_eligible": true,
      "timing_exclusions": [],
      "exact_generated_sequence": true,
      "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 2.998757929836414,
      "ttft_seconds": 9.330406832974404,
      "request_seconds": 51.68129495799076,
      "peak_process_bytes": 7874975792
    },
    {
      "name": "round-1-parallel",
      "arm": "parallel",
      "mode": "measurement",
      "receipt_sha256": "72f380fe488efb2712dec3a8f69e2d2dc7cb13d1a1f8e3e844d2b29abe380f68",
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 8049334440,
        "samples": 1062,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24884903936,
          "swapins": 16,
          "swapouts": 2904,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   486560.\nPages active:                                 846700.\nPages inactive:                               843328.\nPages speculative:                             54246.\nPages throttled:                                   0.\nPages wired down:                             178030.\nPages purgeable:                                 377.\n\"Translation faults\":                     1492942751.\nPages copy-on-write:                        76903112.\nPages zero filled:                        2380420407.\nPages reactivated:                          96850395.\nPages purged:                               11294865.\nFile-backed pages:                           1031917.\nAnonymous pages:                              712357.\nPages stored in compressor:                  1255721.\nPages occupied by compressor:                 675494.\nDecompressions:                             45412361.\nCompressions:                               56017716.\nPageins:                                  1134992066.\nPageouts:                                     373189.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127419.\nPages tagged resident:                         84477.\nPages tagged compressed:                       42942.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5201.\nPages tag-storage free:                         1088.\nPages tag-storage non-tag pageable:            92007.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6462144.\nTagged compressions:                          497888.\nTagged decompressions:                        404750.\n"
        },
        "seconds": 62.32916170798126
      },
      "timing_eligible": true,
      "timing_exclusions": [],
      "exact_generated_sequence": true,
      "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 4.278707709321652,
      "ttft_seconds": 3.365528958995128,
      "request_seconds": 33.04741229201318,
      "peak_process_bytes": 8049334440
    },
    {
      "name": "round-2-parallel",
      "arm": "parallel",
      "mode": "measurement",
      "receipt_sha256": "420440bd60b3a84a8341410dc3b6dd2483403bd5a8ba535b0d79961e03508fd2",
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 8041257104,
        "samples": 1067,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24781553664,
          "swapins": 16,
          "swapouts": 2904,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   485959.\nPages active:                                 855658.\nPages inactive:                               845653.\nPages speculative:                             54451.\nPages throttled:                                   0.\nPages wired down:                             178003.\nPages purgeable:                                 597.\n\"Translation faults\":                     1493724138.\nPages copy-on-write:                        76917112.\nPages zero filled:                        2384261766.\nPages reactivated:                          96905621.\nPages purged:                               11297927.\nFile-backed pages:                           1025990.\nAnonymous pages:                              729772.\nPages stored in compressor:                  1236390.\nPages occupied by compressor:                 664456.\nDecompressions:                             45968341.\nCompressions:                               56582880.\nPageins:                                  1140368680.\nPageouts:                                     373548.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 128143.\nPages tagged resident:                         85021.\nPages tagged compressed:                       43122.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1542.\nPages tag-storage non-tag pageable:            91554.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6500544.\nTagged compressions:                          498170.\nTagged decompressions:                        404847.\n"
        },
        "seconds": 62.53970487500192
      },
      "timing_eligible": true,
      "timing_exclusions": [],
      "exact_generated_sequence": true,
      "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 4.278021258198011,
      "ttft_seconds": 3.4169932910008356,
      "request_seconds": 33.103635499981465,
      "peak_process_bytes": 8041257104
    },
    {
      "name": "round-2-serial",
      "arm": "serial",
      "mode": "measurement",
      "receipt_sha256": "58bb2da729a1d16079d6674a24e121b00cbd1718e2b88db218ca1d1cc9aa9e7b",
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7874549832,
        "samples": 1358,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24899534848,
          "swapins": 16,
          "swapouts": 2904,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   475341.\nPages active:                                 849043.\nPages inactive:                               865765.\nPages speculative:                             49105.\nPages throttled:                                   0.\nPages wired down:                             177857.\nPages purgeable:                                1002.\n\"Translation faults\":                     1494523458.\nPages copy-on-write:                        76951389.\nPages zero filled:                        2388097049.\nPages reactivated:                          96948137.\nPages purged:                               11301845.\nFile-backed pages:                           1043404.\nAnonymous pages:                              720509.\nPages stored in compressor:                  1243807.\nPages occupied by compressor:                 666698.\nDecompressions:                             46525977.\nCompressions:                               57176358.\nPageins:                                  1145731339.\nPageouts:                                     373966.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127463.\nPages tagged resident:                         83689.\nPages tagged compressed:                       43774.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1774.\nPages tag-storage non-tag pageable:            91322.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6629504.\nTagged compressions:                          500466.\nTagged decompressions:                        405754.\n"
        },
        "seconds": 80.19700479198946
      },
      "timing_eligible": true,
      "timing_exclusions": [],
      "exact_generated_sequence": true,
      "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 3.06688649430021,
      "ttft_seconds": 9.257755416998407,
      "request_seconds": 50.66785045899451,
      "peak_process_bytes": 7874549832
    },
    {
      "name": "round-3-serial",
      "arm": "serial",
      "mode": "measurement",
      "receipt_sha256": "6fbc9e1d29c84353ece06d2ca464f622b60c1611a52d6581e037dac28bcd1023",
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7875385416,
        "samples": 1353,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24778981376,
          "swapins": 16,
          "swapouts": 2904,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   475450.\nPages active:                                 867578.\nPages inactive:                               856358.\nPages speculative:                             49770.\nPages throttled:                                   0.\nPages wired down:                             177786.\nPages purgeable:                                 828.\n\"Translation faults\":                     1495271303.\nPages copy-on-write:                        76967220.\nPages zero filled:                        2391914403.\nPages reactivated:                          96994782.\nPages purged:                               11303510.\nFile-backed pages:                           1036111.\nAnonymous pages:                              737595.\nPages stored in compressor:                  1226991.\nPages occupied by compressor:                 656636.\nDecompressions:                             47113217.\nCompressions:                               57773574.\nPageins:                                  1151087802.\nPageouts:                                     374318.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127224.\nPages tagged resident:                         81281.\nPages tagged compressed:                       45943.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1623.\nPages tag-storage non-tag pageable:            91473.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    7073472.\nTagged compressions:                          502758.\nTagged decompressions:                        405820.\n"
        },
        "seconds": 79.83209508299478
      },
      "timing_eligible": true,
      "timing_exclusions": [],
      "exact_generated_sequence": true,
      "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 3.0836054017856114,
      "ttft_seconds": 9.25681487499969,
      "request_seconds": 50.44238979101647,
      "peak_process_bytes": 7875385416
    },
    {
      "name": "round-3-parallel",
      "arm": "parallel",
      "mode": "measurement",
      "receipt_sha256": "27bfeedbe7e66d9085d936e8771ea9e70120b2d78587065b1edd7d9efd858f3a",
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 8029690024,
        "samples": 1067,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24953356288,
          "swapins": 16,
          "swapouts": 2904,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   485022.\nPages active:                                 855004.\nPages inactive:                               846224.\nPages speculative:                             53454.\nPages throttled:                                   0.\nPages wired down:                             177818.\nPages purgeable:                                 408.\n\"Translation faults\":                     1495962982.\nPages copy-on-write:                        76984563.\nPages zero filled:                        2395739277.\nPages reactivated:                          97062114.\nPages purged:                               11307583.\nFile-backed pages:                           1037602.\nAnonymous pages:                              717080.\nPages stored in compressor:                  1245374.\nPages occupied by compressor:                 666452.\nDecompressions:                             47631514.\nCompressions:                               58334167.\nPageins:                                  1156454262.\nPageouts:                                     374771.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127102.\nPages tagged resident:                         79855.\nPages tagged compressed:                       47247.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1599.\nPages tag-storage non-tag pageable:            91497.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    7314176.\nTagged compressions:                          504628.\nTagged decompressions:                        406382.\n"
        },
        "seconds": 62.61363816697849
      },
      "timing_eligible": true,
      "timing_exclusions": [],
      "exact_generated_sequence": true,
      "generated_sha256": "d235ccc0429f33f59235d6d9297c200ff953f0b84143f65a267736ae13362395",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 4.2850604644405115,
      "ttft_seconds": 3.560547500004759,
      "request_seconds": 33.198421834007604,
      "peak_process_bytes": 8029690024
    }
  ],
  "all_observed_timings_eligible": true,
  "medians": {
    "serial": {
      "committed_decode_tokens_per_second": 3.06688649430021,
      "ttft_seconds": 9.257755416998407,
      "request_seconds": 50.66785045899451
    },
    "parallel": {
      "committed_decode_tokens_per_second": 4.278707709321652,
      "ttft_seconds": 3.4169932910008356,
      "request_seconds": 33.103635499981465
    }
  },
  "paired_decode_ratios": [
    1.426826642707723,
    1.3949069410128767,
    1.3896267213564932
  ],
  "median_paired_decode_ratio": 1.3949069410128767,
  "finished_at": "2026-10-03T08:33:43.114505+00:00"
}
````

### vq-performance-refusals-v2/results.json

Original bytes: 5087. SHA-256: `15bff72c39034459ff2dd11bc3b673266a16fc391777efa2b4053dde06b5764f`.

````text
[
  {
    "case": "profile-change",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires the frozen performance profile\n",
    "expected_error": "frozen performance profile",
    "output_exists": false
  },
  {
    "case": "profile-bound",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot metadata exceeds its bound\n",
    "expected_error": "metadata exceeds its bound",
    "output_exists": false
  },
  {
    "case": "missing-validation",
    "passed": true,
    "code": 64,
    "stdout": "",
    "stderr": "Error: --measure requires --validation-receipt; validation mode accepts neither\nUsage: slotstream quantization-performance-pilot --source-directory <source-directory> --source-inventory <source-inventory> --profile <profile> --output <output> [--measure] [--validation-receipt <validation-receipt>]\n  See 'slotstream quantization-performance-pilot --help' for more information.\n",
    "expected_error": "--measure requires --validation-receipt",
    "output_exists": false
  },
  {
    "case": "orphan-validation",
    "passed": true,
    "code": 64,
    "stdout": "",
    "stderr": "Error: --measure requires --validation-receipt; validation mode accepts neither\nUsage: slotstream quantization-performance-pilot --source-directory <source-directory> --source-inventory <source-inventory> --profile <profile> --output <output> [--measure] [--validation-receipt <validation-receipt>]\n  See 'slotstream quantization-performance-pilot --help' for more information.\n",
    "expected_error": "--measure requires --validation-receipt",
    "output_exists": false
  },
  {
    "case": "ambient-override",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires no developer overrides\n",
    "expected_error": "requires no developer overrides",
    "output_exists": false
  },
  {
    "case": "wrong-mode",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  },
  {
    "case": "failed-validation",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  },
  {
    "case": "wrong-profile-binding",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  },
  {
    "case": "wrong-inventory",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  },
  {
    "case": "wrong-binary",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  },
  {
    "case": "wrong-metallib",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  },
  {
    "case": "short-sequence",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  },
  {
    "case": "short-logit-proof",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  },
  {
    "case": "wrong-logit-proof",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  },
  {
    "case": "over-budget-validation",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  },
  {
    "case": "negative-peak",
    "passed": true,
    "code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "expected_error": "successful matching lean-path validation receipt",
    "output_exists": false
  }
]
````

### vq-performance-refusals-v2.log

Original bytes: 118. SHA-256: `aa1980e99f67ddbf18e767893ee66bdb0af14e1bb1a9c6b4dd40e36d5653f701`.

````text
{"passed": 16, "output": "<HOME>/Projects/slotstream/.build/quantization-research/vq-performance-refusals-v2"}
````

### vq-read-profile-refusals-v1.py

Original bytes: 1127. SHA-256: `9b40f6a4dd249824e16b0412fd528797afa15b34e986962a0f22312aa47892b0`.

````text
from pathlib import Path
import subprocess,json
r=Path('.build/quantization-research').resolve();b=r/'frozen-parallel-read-v2/slotstream';out=r/'vq-read-profile-refusals-v1';out.mkdir();rows=[]
for arm,opposite in [('serial','parallel'),('parallel','serial')]:
 profile='performance-pilot-v1.json' if arm=='serial' else 'performance-pilot-v2.json';target=out/arm
 command=[str(b),'quantization-performance-pilot','--source-directory',str(r/'candidate-3.2'),'--source-inventory',str(r/'inventory-3.2/inventory.json'),'--profile',str(r/'vq-read-pair-v1'/profile),'--output',str(target),'--measure','--validation-receipt',str(r/'vq-read-pair-v1'/('validation-'+opposite)/'receipt.json')]
 p=subprocess.run(command,capture_output=True,text=True,timeout=30);passed=p.returncode!=0 and 'successful matching lean-path validation receipt' in p.stderr and not target.exists();rows.append(dict(arm=arm,command=command,passed=passed,exit_code=p.returncode,stdout=p.stdout,stderr=p.stderr,output_exists=target.exists()));(out/'results.json').write_text(json.dumps(rows,indent=2)+'\n');assert passed
print(json.dumps({'passed':len(rows)}))
````

### vq-read-profile-refusals-v1/results.json

Original bytes: 2107. SHA-256: `c063e4882a5e026f61afd54feb2f072bb0257e4939c2d78138b4c18ccfd562ae`.

````text
[
  {
    "arm": "serial",
    "command": [
      "<HOME>/Projects/slotstream/.build/quantization-research/frozen-parallel-read-v2/slotstream",
      "quantization-performance-pilot",
      "--source-directory",
      "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
      "--source-inventory",
      "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
      "--profile",
      "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/performance-pilot-v1.json",
      "--output",
      "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-profile-refusals-v1/serial",
      "--measure",
      "--validation-receipt",
      "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-parallel/receipt.json"
    ],
    "passed": true,
    "exit_code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "output_exists": false
  },
  {
    "arm": "parallel",
    "command": [
      "<HOME>/Projects/slotstream/.build/quantization-research/frozen-parallel-read-v2/slotstream",
      "quantization-performance-pilot",
      "--source-directory",
      "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
      "--source-inventory",
      "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
      "--profile",
      "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/performance-pilot-v2.json",
      "--output",
      "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-profile-refusals-v1/parallel",
      "--measure",
      "--validation-receipt",
      "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-serial/receipt.json"
    ],
    "passed": true,
    "exit_code": 1,
    "stdout": "",
    "stderr": "Error: VQ pilot requires a successful matching lean-path validation receipt\n",
    "output_exists": false
  }
]
````

### vq-read-profile-refusals-v1.log

Original bytes: 14. SHA-256: `dbddc493d9d4ee900a7c5ec519e11c341edf45f85383e063e29297380a8544a2`.

````text
{"passed": 2}
````

### vq-read-pair-v1/validation-serial/receipt.json

Original bytes: 6724. SHA-256: `0f07363316d910373ff5e8fc9379f9f32d655bda6b7c8128a5897712fe5a9e17`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 11276,
    "hits" : 2379,
    "loads" : 11884,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "parallel_read_lanes" : 0,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 0,
    "total_capacity" : 608
  },
  "committed_decode_tokens_per_second" : 2.1454313923443924,
  "committed_tokens" : 16,
  "emission_seconds" : [
    9.4509289159905165,
    10.615624583006138,
    11.191928707994521,
    11.658397958002752,
    12.064918165997369,
    12.511870082991663,
    12.906330375000834,
    13.342328666010872,
    13.725964665994979,
    14.177422082982957,
    14.557364415988559,
    14.999851958011277,
    15.368712082999991,
    15.70416679099435,
    15.994019790989114,
    16.442529791005654
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
    24797
  ],
  "initial_vm" : {
    "reclaimableBytes" : 26027966464,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    1.1646956670156214,
    0.57630412498838268,
    0.46646925000823103,
    0.40652020799461752,
    0.44695191699429415,
    0.3944602920091711,
    0.43599829101003706,
    0.38363599998410791,
    0.45145741698797792,
    0.37994233300560154,
    0.44248754202271812,
    0.36886012498871423,
    0.33545470799435861,
    0.2898529999947641,
    0.44851000001654029
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 28.962600333004957,
  "metadata_seconds" : 0.11396116699324921,
  "mode" : "validation",
  "observed_logit_hashes" : [
    "88a5dda18125a2db2d6ee80cce7cb639cd93c65fd2c3aefe520380f311379456",
    "605444ab7ee3fda8e6b91ef9f529fde40230b72f3df8dce9ed8fb4b350d6a9e5",
    "99bc1be04bbdc44892da0e741c6398e3cddc3ae9e02133141cb65f2d1a047f13",
    "cb4f78ec48189e3b003c9b4ba573041f7bc17c00be2b54d8b2bb602e52062bae",
    "25e3628dc501312e25dcf41de2f7ff0ef2a7b2eba5c0cabf3cb7040f2ea64fcf",
    "8afa673c720d2e12935049bc68ab23bd47f36c624271f09a6e47de1d7411cee1",
    "b6aada687bd352edd05e0bb931e3c368dbbdbce2f9cb0f69b2b1107b395583df",
    "88c3d2503ed5cbac6b099b01f9c494d900a1faa6cf5a8d182e53bfba0ba3730a",
    "e4b42eabb8b0eb7b88931deded0f9fb9f5d9ceb6898842a349c545fe203508de",
    "cbdbb0987cba9adb0c3fa12134cd096b5e527fa04ebf6e8c794bf1e6a309890e",
    "55d945e09227d0a0b551479752c8673f42ae9cb5c75432b78ec1d668426b638a",
    "22978c1b4fc2195f60ad469761062246f897555752869e9de2e012ee26f7323c",
    "a3dc7d30b80c1b7e36e4aca23ab69eca40d1a09fb1ae780c327c4a3f2f533b53",
    "83b373f83d65dc593a800d87cf62f8775867c7271d8bd05f4a41f12742f61c62",
    "45665722f236ed23e4e2125ab60b280e4c849f7a4d028184333aaa3ff6559cee",
    "f4df8a60fdcfa89e67687c173b1a92d6bee5960c76ecd40c589728e919a569e2"
  ],
  "observed_timing_eligible" : false,
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
    }
  ],
  "pack" : "3.2",
  "passed" : true,
  "peak_mlx_bytes" : 6782306844,
  "peak_process_bytes" : 7918573688,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-performance-pilot-v1",
  "profile_sha256" : "8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5",
  "qualification" : "unproven",
  "request_seconds" : 16.442549915984273,
  "request_vm_after" : {
    "reclaimableBytes" : 18489753600,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18375704576,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "resident_text" : {
    "dense_hits" : 784,
    "embedding_hits" : 16,
    "largest_load_copy_bytes" : 635699200,
    "payload_bytes" : 5318309400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [
    "validation mode hashes logits",
    "too few committed tokens"
  ],
  "ttft_seconds" : 9.4509289159905165,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/validation-serial-supervision/identity.json

Original bytes: 2764. SHA-256: `e8e08e38d3b36118401988cc318849af1d853d88168bf9c1228b59224994b4ce`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/performance-pilot-v1.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-serial"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24488476672,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   365466.\nPages active:                                 908135.\nPages inactive:                               877182.\nPages speculative:                            108784.\nPages throttled:                                   0.\nPages wired down:                             178066.\nPages purgeable:                                2776.\n\"Translation faults\":                     1489772259.\nPages copy-on-write:                        76840804.\nPages zero filled:                        2370694251.\nPages reactivated:                          96636282.\nPages purged:                               11283813.\nFile-backed pages:                           1126416.\nAnonymous pages:                              767685.\nPages stored in compressor:                  1221524.\nPages occupied by compressor:                 646779.\nDecompressions:                             43083855.\nCompressions:                               53553389.\nPageins:                                  1113598014.\nPageouts:                                     371137.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 129777.\nPages tagged resident:                         86176.\nPages tagged compressed:                       43601.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          995.\nPages tag-storage non-tag pageable:            92099.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6604480.\nTagged compressions:                          494042.\nTagged decompressions:                        400858.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-read-pair-v1/validation-serial-supervision/receipt.json

Original bytes: 2140. SHA-256: `63c166ca984a0bf046d9493137f763036ca9eed2b08080ea8acea3450b63a2e1`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7918573688,
  "samples": 775,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24868143104,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   477606.\nPages active:                                 857920.\nPages inactive:                               818303.\nPages speculative:                             78209.\nPages throttled:                                   0.\nPages wired down:                             179462.\nPages purgeable:                                 874.\n\"Translation faults\":                     1490542195.\nPages copy-on-write:                        76851274.\nPages zero filled:                        2371734072.\nPages reactivated:                          96724048.\nPages purged:                               11286274.\nFile-backed pages:                           1039351.\nAnonymous pages:                              715081.\nPages stored in compressor:                  1256766.\nPages occupied by compressor:                 673219.\nDecompressions:                             43736688.\nCompressions:                               54264521.\nPageins:                                  1119012319.\nPageouts:                                     371487.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127650.\nPages tagged resident:                         83545.\nPages tagged compressed:                       44105.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          866.\nPages tag-storage non-tag pageable:            92228.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6712064.\nTagged compressions:                          496902.\nTagged decompressions:                        402661.\n"
  },
  "seconds": 45.660787542001344
}
````

### vq-read-pair-v1/validation-serial-supervision/stdout.txt

Original bytes: 6725. SHA-256: `33bd90034edb8ef14b6f83e083bc021dfb4d906140790f92e9af93563925656e`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 11276,
    "hits" : 2379,
    "loads" : 11884,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "parallel_read_lanes" : 0,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 0,
    "total_capacity" : 608
  },
  "committed_decode_tokens_per_second" : 2.1454313923443924,
  "committed_tokens" : 16,
  "emission_seconds" : [
    9.4509289159905165,
    10.615624583006138,
    11.191928707994521,
    11.658397958002752,
    12.064918165997369,
    12.511870082991663,
    12.906330375000834,
    13.342328666010872,
    13.725964665994979,
    14.177422082982957,
    14.557364415988559,
    14.999851958011277,
    15.368712082999991,
    15.70416679099435,
    15.994019790989114,
    16.442529791005654
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
    24797
  ],
  "initial_vm" : {
    "reclaimableBytes" : 26027966464,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    1.1646956670156214,
    0.57630412498838268,
    0.46646925000823103,
    0.40652020799461752,
    0.44695191699429415,
    0.3944602920091711,
    0.43599829101003706,
    0.38363599998410791,
    0.45145741698797792,
    0.37994233300560154,
    0.44248754202271812,
    0.36886012498871423,
    0.33545470799435861,
    0.2898529999947641,
    0.44851000001654029
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 28.962600333004957,
  "metadata_seconds" : 0.11396116699324921,
  "mode" : "validation",
  "observed_logit_hashes" : [
    "88a5dda18125a2db2d6ee80cce7cb639cd93c65fd2c3aefe520380f311379456",
    "605444ab7ee3fda8e6b91ef9f529fde40230b72f3df8dce9ed8fb4b350d6a9e5",
    "99bc1be04bbdc44892da0e741c6398e3cddc3ae9e02133141cb65f2d1a047f13",
    "cb4f78ec48189e3b003c9b4ba573041f7bc17c00be2b54d8b2bb602e52062bae",
    "25e3628dc501312e25dcf41de2f7ff0ef2a7b2eba5c0cabf3cb7040f2ea64fcf",
    "8afa673c720d2e12935049bc68ab23bd47f36c624271f09a6e47de1d7411cee1",
    "b6aada687bd352edd05e0bb931e3c368dbbdbce2f9cb0f69b2b1107b395583df",
    "88c3d2503ed5cbac6b099b01f9c494d900a1faa6cf5a8d182e53bfba0ba3730a",
    "e4b42eabb8b0eb7b88931deded0f9fb9f5d9ceb6898842a349c545fe203508de",
    "cbdbb0987cba9adb0c3fa12134cd096b5e527fa04ebf6e8c794bf1e6a309890e",
    "55d945e09227d0a0b551479752c8673f42ae9cb5c75432b78ec1d668426b638a",
    "22978c1b4fc2195f60ad469761062246f897555752869e9de2e012ee26f7323c",
    "a3dc7d30b80c1b7e36e4aca23ab69eca40d1a09fb1ae780c327c4a3f2f533b53",
    "83b373f83d65dc593a800d87cf62f8775867c7271d8bd05f4a41f12742f61c62",
    "45665722f236ed23e4e2125ab60b280e4c849f7a4d028184333aaa3ff6559cee",
    "f4df8a60fdcfa89e67687c173b1a92d6bee5960c76ecd40c589728e919a569e2"
  ],
  "observed_timing_eligible" : false,
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
    }
  ],
  "pack" : "3.2",
  "passed" : true,
  "peak_mlx_bytes" : 6782306844,
  "peak_process_bytes" : 7918573688,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-performance-pilot-v1",
  "profile_sha256" : "8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5",
  "qualification" : "unproven",
  "request_seconds" : 16.442549915984273,
  "request_vm_after" : {
    "reclaimableBytes" : 18489753600,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18375704576,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "resident_text" : {
    "dense_hits" : 784,
    "embedding_hits" : 16,
    "largest_load_copy_bytes" : 635699200,
    "payload_bytes" : 5318309400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [
    "validation mode hashes logits",
    "too few committed tokens"
  ],
  "ttft_seconds" : 9.4509289159905165,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/validation-serial-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-read-pair-v1/validation-parallel/receipt.json

Original bytes: 6757. SHA-256: `5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 11276,
    "hits" : 2379,
    "loads" : 11884,
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
  "committed_decode_tokens_per_second" : 3.6278525842682949,
  "committed_tokens" : 16,
  "emission_seconds" : [
    3.4646286249917466,
    4.137357333995169,
    4.4219446250062902,
    4.6767859999963548,
    4.9197800839901902,
    5.1667337089893408,
    5.4206323749967851,
    5.6703674999880604,
    5.9124947089876514,
    6.1621219999797177,
    6.4043406669807155,
    6.6492745839932468,
    6.8865518340026028,
    7.1185897089890204,
    7.3443228339892812,
    7.5993059999891557
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
    24797
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25907019776,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.67272870900342241,
    0.28458729101112112,
    0.25484137499006465,
    0.24299408399383537,
    0.24695362499915063,
    0.25389866600744426,
    0.24973512499127537,
    0.24212720899959095,
    0.24962729099206626,
    0.24221866700099781,
    0.24493391701253131,
    0.23727725000935607,
    0.23203787498641759,
    0.22573312500026077,
    0.25498316599987447
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 28.94160816600197,
  "metadata_seconds" : 0.11814091698033735,
  "mode" : "validation",
  "observed_logit_hashes" : [
    "88a5dda18125a2db2d6ee80cce7cb639cd93c65fd2c3aefe520380f311379456",
    "605444ab7ee3fda8e6b91ef9f529fde40230b72f3df8dce9ed8fb4b350d6a9e5",
    "99bc1be04bbdc44892da0e741c6398e3cddc3ae9e02133141cb65f2d1a047f13",
    "cb4f78ec48189e3b003c9b4ba573041f7bc17c00be2b54d8b2bb602e52062bae",
    "25e3628dc501312e25dcf41de2f7ff0ef2a7b2eba5c0cabf3cb7040f2ea64fcf",
    "8afa673c720d2e12935049bc68ab23bd47f36c624271f09a6e47de1d7411cee1",
    "b6aada687bd352edd05e0bb931e3c368dbbdbce2f9cb0f69b2b1107b395583df",
    "88c3d2503ed5cbac6b099b01f9c494d900a1faa6cf5a8d182e53bfba0ba3730a",
    "e4b42eabb8b0eb7b88931deded0f9fb9f5d9ceb6898842a349c545fe203508de",
    "cbdbb0987cba9adb0c3fa12134cd096b5e527fa04ebf6e8c794bf1e6a309890e",
    "55d945e09227d0a0b551479752c8673f42ae9cb5c75432b78ec1d668426b638a",
    "22978c1b4fc2195f60ad469761062246f897555752869e9de2e012ee26f7323c",
    "a3dc7d30b80c1b7e36e4aca23ab69eca40d1a09fb1ae780c327c4a3f2f533b53",
    "83b373f83d65dc593a800d87cf62f8775867c7271d8bd05f4a41f12742f61c62",
    "45665722f236ed23e4e2125ab60b280e4c849f7a4d028184333aaa3ff6559cee",
    "f4df8a60fdcfa89e67687c173b1a92d6bee5960c76ecd40c589728e919a569e2"
  ],
  "observed_timing_eligible" : false,
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
    }
  ],
  "pack" : "3.2",
  "passed" : true,
  "peak_mlx_bytes" : 6782306844,
  "peak_process_bytes" : 8072911088,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 7.5993256669898983,
  "request_vm_after" : {
    "reclaimableBytes" : 18512232448,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18561531904,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "resident_text" : {
    "dense_hits" : 784,
    "embedding_hits" : 16,
    "largest_load_copy_bytes" : 635699200,
    "payload_bytes" : 5318309400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [
    "validation mode hashes logits",
    "too few committed tokens"
  ],
  "ttft_seconds" : 3.4646286249917466,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/validation-parallel-supervision/identity.json

Original bytes: 2766. SHA-256: `83d89c628e8268697518584b14007673f581a64c40e1270d28d0a7a42508bcdb`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/performance-pilot-v2.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-parallel"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24870141952,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   466265.\nPages active:                                 856464.\nPages inactive:                               832709.\nPages speculative:                             78373.\nPages throttled:                                   0.\nPages wired down:                             178395.\nPages purgeable:                                 878.\n\"Translation faults\":                     1490545883.\nPages copy-on-write:                        76851650.\nPages zero filled:                        2371735763.\nPages reactivated:                          96724048.\nPages purged:                               11286274.\nFile-backed pages:                           1050810.\nAnonymous pages:                              716736.\nPages stored in compressor:                  1256484.\nPages occupied by compressor:                 673048.\nDecompressions:                             43736976.\nCompressions:                               54264521.\nPageins:                                  1119023542.\nPageouts:                                     371487.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127710.\nPages tagged resident:                         83609.\nPages tagged compressed:                       44101.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          383.\nPages tag-storage non-tag pageable:            92711.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6711808.\nTagged compressions:                          496902.\nTagged decompressions:                        402665.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-read-pair-v1/validation-parallel-supervision/receipt.json

Original bytes: 2140. SHA-256: `7406bbb07b354347b4f9ec464a4f2a34a86bf873bc64ee8c5eb89b7067b1cc1a`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 8072911088,
  "samples": 630,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 25108447232,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   487134.\nPages active:                                 845495.\nPages inactive:                               814908.\nPages speculative:                             77809.\nPages throttled:                                   0.\nPages wired down:                             178111.\nPages purgeable:                                  72.\n\"Translation faults\":                     1491459328.\nPages copy-on-write:                        76864214.\nPages zero filled:                        2372768658.\nPages reactivated:                          96762431.\nPages purged:                               11290051.\nFile-backed pages:                           1045292.\nAnonymous pages:                              692920.\nPages stored in compressor:                  1270440.\nPages occupied by compressor:                 680955.\nDecompressions:                             44280458.\nCompressions:                               54848797.\nPageins:                                  1124193693.\nPageouts:                                     372460.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127234.\nPages tagged resident:                         83658.\nPages tagged compressed:                       43576.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                         1254.\nPages tag-storage non-tag pageable:            91840.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6599232.\nTagged compressions:                          497373.\nTagged decompressions:                        403610.\n"
  },
  "seconds": 36.812763958005235
}
````

### vq-read-pair-v1/validation-parallel-supervision/stdout.txt

Original bytes: 6758. SHA-256: `bba6897407e06f3e869d83b6eeba806a9a56df63022776cd902eecc731935068`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 11276,
    "hits" : 2379,
    "loads" : 11884,
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
  "committed_decode_tokens_per_second" : 3.6278525842682949,
  "committed_tokens" : 16,
  "emission_seconds" : [
    3.4646286249917466,
    4.137357333995169,
    4.4219446250062902,
    4.6767859999963548,
    4.9197800839901902,
    5.1667337089893408,
    5.4206323749967851,
    5.6703674999880604,
    5.9124947089876514,
    6.1621219999797177,
    6.4043406669807155,
    6.6492745839932468,
    6.8865518340026028,
    7.1185897089890204,
    7.3443228339892812,
    7.5993059999891557
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
    24797
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25907019776,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.67272870900342241,
    0.28458729101112112,
    0.25484137499006465,
    0.24299408399383537,
    0.24695362499915063,
    0.25389866600744426,
    0.24973512499127537,
    0.24212720899959095,
    0.24962729099206626,
    0.24221866700099781,
    0.24493391701253131,
    0.23727725000935607,
    0.23203787498641759,
    0.22573312500026077,
    0.25498316599987447
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 28.94160816600197,
  "metadata_seconds" : 0.11814091698033735,
  "mode" : "validation",
  "observed_logit_hashes" : [
    "88a5dda18125a2db2d6ee80cce7cb639cd93c65fd2c3aefe520380f311379456",
    "605444ab7ee3fda8e6b91ef9f529fde40230b72f3df8dce9ed8fb4b350d6a9e5",
    "99bc1be04bbdc44892da0e741c6398e3cddc3ae9e02133141cb65f2d1a047f13",
    "cb4f78ec48189e3b003c9b4ba573041f7bc17c00be2b54d8b2bb602e52062bae",
    "25e3628dc501312e25dcf41de2f7ff0ef2a7b2eba5c0cabf3cb7040f2ea64fcf",
    "8afa673c720d2e12935049bc68ab23bd47f36c624271f09a6e47de1d7411cee1",
    "b6aada687bd352edd05e0bb931e3c368dbbdbce2f9cb0f69b2b1107b395583df",
    "88c3d2503ed5cbac6b099b01f9c494d900a1faa6cf5a8d182e53bfba0ba3730a",
    "e4b42eabb8b0eb7b88931deded0f9fb9f5d9ceb6898842a349c545fe203508de",
    "cbdbb0987cba9adb0c3fa12134cd096b5e527fa04ebf6e8c794bf1e6a309890e",
    "55d945e09227d0a0b551479752c8673f42ae9cb5c75432b78ec1d668426b638a",
    "22978c1b4fc2195f60ad469761062246f897555752869e9de2e012ee26f7323c",
    "a3dc7d30b80c1b7e36e4aca23ab69eca40d1a09fb1ae780c327c4a3f2f533b53",
    "83b373f83d65dc593a800d87cf62f8775867c7271d8bd05f4a41f12742f61c62",
    "45665722f236ed23e4e2125ab60b280e4c849f7a4d028184333aaa3ff6559cee",
    "f4df8a60fdcfa89e67687c173b1a92d6bee5960c76ecd40c589728e919a569e2"
  ],
  "observed_timing_eligible" : false,
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
    }
  ],
  "pack" : "3.2",
  "passed" : true,
  "peak_mlx_bytes" : 6782306844,
  "peak_process_bytes" : 8072911088,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 7.5993256669898983,
  "request_vm_after" : {
    "reclaimableBytes" : 18512232448,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18561531904,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "resident_text" : {
    "dense_hits" : 784,
    "embedding_hits" : 16,
    "largest_load_copy_bytes" : 635699200,
    "payload_bytes" : 5318309400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [
    "validation mode hashes logits",
    "too few committed tokens"
  ],
  "ttft_seconds" : 3.4646286249917466,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/validation-parallel-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-read-pair-v1/round-1-serial/receipt.json

Original bytes: 21461. SHA-256: `f9dfde92d3b1b6717ac8e1871d6ba7c602b199090695d5994bfebde61376662b`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 48625,
    "hits" : 18790,
    "loads" : 49233,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "parallel_read_lanes" : 0,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 0,
    "total_capacity" : 608
  },
  "committed_decode_tokens_per_second" : 2.998757929836414,
  "committed_tokens" : 128,
  "emission_seconds" : [
    9.3304068329744041,
    10.45636545799789,
    10.956687625002814,
    11.422494500002358,
    11.825449333002325,
    12.259852540999418,
    12.655408915976295,
    13.098703707975801,
    13.509865125000942,
    14.027973457996268,
    14.428666374995373,
    14.865996624983381,
    15.223618040996371,
    15.554272624984151,
    15.840711665980052,
    16.282416082976852,
    16.646424582984764,
    16.908834374975413,
    17.26897987499251,
    17.59791737498017,
    17.994156040978851,
    18.381001082976582,
    18.699696707975818,
    19.039931415987667,
    19.478486457985127,
    19.89748629098176,
    20.269371957983822,
    20.641502624988789,
    20.982043083000463,
    21.493265500001144,
    21.895675374980783,
    22.239060790976509,
    22.65931616598391,
    22.990620249998756,
    23.296701374987606,
    23.585081540979445,
    23.876139624975622,
    24.162435165984789,
    24.419577415974345,
    24.69731899999897,
    25.065273499989416,
    25.424520125001436,
    25.858916415978456,
    26.196091999998316,
    26.603390499978559,
    26.986723415990127,
    27.302773624978727,
    27.630376916000387,
    27.967554832983296,
    28.40075312499539,
    28.79254383299849,
    29.092233332979959,
    29.359582957986277,
    29.655490915989503,
    30.024830374983139,
    30.316699791001156,
    30.557923874992412,
    30.896028749994002,
    31.22839799997746,
    31.573703749978449,
    31.864767999999458,
    32.153522707987577,
    32.432813374995021,
    32.688738457974978,
    32.989582332986174,
    33.286291165975854,
    33.537166832975345,
    33.878839540993795,
    34.164941665978404,
    34.474166707979748,
    34.745152916002553,
    35.002084082982037,
    35.279823165998096,
    35.675660082983086,
    36.139046707976377,
    36.610462915996322,
    37.060550290974788,
    37.512134332995629,
    37.7817673329846,
    38.078596499981359,
    38.389576916000806,
    38.669492624991108,
    38.942976124992128,
    39.289932665997185,
    39.534538124979008,
    39.788653124996927,
    40.127092332986649,
    40.433169374999125,
    40.772595957998419,
    41.093245707976166,
    41.415623165987199,
    41.711912915983703,
    41.992500708001899,
    42.308497833000729,
    42.620050249999622,
    42.902268332982203,
    43.217109915975016,
    43.471197832986945,
    43.758379040984437,
    44.017102207988501,
    44.289589708001586,
    44.545412665989716,
    44.771140957978787,
    45.031160540995188,
    45.320314290991519,
    45.573796749988105,
    45.839328707981622,
    46.076000957982615,
    46.319662583002355,
    46.566163790994324,
    46.845832499995595,
    47.112144165992504,
    47.411678582982859,
    47.746093790978193,
    48.061809540988179,
    48.301340665988391,
    48.611192374984967,
    48.897330582985887,
    49.140562040993245,
    49.444772124988958,
    49.696716165984981,
    49.976143457985017,
    50.259677707974333,
    50.541388957994059,
    50.819992332981201,
    51.087188707984751,
    51.41783908297657,
    51.681274415983353
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
    "reclaimableBytes" : 26133725184,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    1.1259586250234861,
    0.50032216700492427,
    0.46580687499954365,
    0.40295483299996704,
    0.43440320799709298,
    0.39555637497687712,
    0.44329479199950583,
    0.41116141702514142,
    0.51810833299532533,
    0.40069291699910536,
    0.43733024998800829,
    0.35762141601298936,
    0.33065458398777992,
    0.28643904099590145,
    0.44170441699679941,
    0.36400850000791252,
    0.26240979199064896,
    0.36014550001709722,
    0.32893749998765998,
    0.39623866599868052,
    0.38684504199773073,
    0.31869562499923632,
    0.34023470801184885,
    0.43855504199746065,
    0.4189998329966329,
    0.37188566700206138,
    0.37213066700496711,
    0.34054045801167376,
    0.51122241700068116,
    0.40240987497963943,
    0.34338541599572636,
    0.42025537500740029,
    0.33130408401484601,
    0.30608112498885021,
    0.28838016599183902,
    0.29105808399617672,
    0.28629554100916721,
    0.25714224998955615,
    0.2777415840246249,
    0.36795449999044649,
    0.35924662501201965,
    0.43439629097701982,
    0.33717558401986025,
    0.40729849998024292,
    0.38333291601156816,
    0.31605020898859948,
    0.32760329102165997,
    0.33717791698290966,
    0.43319829201209359,
    0.39179070800310001,
    0.29968949998146854,
    0.26734962500631809,
    0.29590795800322667,
    0.36933945899363607,
    0.29186941601801664,
    0.24122408399125561,
    0.3381048750015907,
    0.33236924998345785,
    0.34530575000098906,
    0.29106425002100877,
    0.28875470798811875,
    0.27929066700744443,
    0.25592508297995664,
    0.30084387501119636,
    0.29670883298967965,
    0.25087566699949093,
    0.34167270801845007,
    0.28610212498460896,
    0.30922504200134426,
    0.27098620802280493,
    0.25693116697948426,
    0.27773908301605843,
    0.39583691698499024,
    0.46338662499329075,
    0.47141620801994577,
    0.45008737497846596,
    0.45158404202084057,
    0.26963299998897128,
    0.29682916699675843,
    0.31098041601944715,
    0.27991570899030194,
    0.27348350000102073,
    0.34695654100505635,
    0.24460545898182318,
    0.25411500001791865,
    0.33843920798972249,
    0.30607704201247543,
    0.33942658299929462,
    0.32064974997774698,
    0.32237745801103301,
    0.29628974999650382,
    0.28058779201819561,
    0.31599712499883026,
    0.31155241699889302,
    0.28221808298258111,
    0.31484158299281262,
    0.25408791701192968,
    0.28718120799749158,
    0.25872316700406373,
    0.27248750001308508,
    0.25582295798812993,
    0.22572829198907129,
    0.26001958301640116,
    0.28915374999633059,
    0.2534824589965865,
    0.2655319579935167,
    0.23667225000099279,
    0.24366162501974031,
    0.24650120799196884,
    0.27966870900127105,
    0.26631166599690914,
    0.29953441699035466,
    0.33441520799533464,
    0.31571575000998564,
    0.23953112500021234,
    0.30985170899657533,
    0.28613820800092071,
    0.24323145800735801,
    0.30421008399571292,
    0.25194404099602252,
    0.27942729200003669,
    0.28353424998931587,
    0.28171125001972541,
    0.27860337498714216,
    0.2671963750035502,
    0.33065037499181926,
    0.26343533300678246
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 28.990428874996724,
  "metadata_seconds" : 0.11765387500054203,
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
  "peak_process_bytes" : 7874975792,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-performance-pilot-v1",
  "profile_sha256" : "8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5",
  "qualification" : "unproven",
  "request_seconds" : 51.681294957990758,
  "request_vm_after" : {
    "reclaimableBytes" : 17853218816,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18608095232,
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
  "ttft_seconds" : 9.3304068329744041,
  "validation_receipt_sha256" : "0f07363316d910373ff5e8fc9379f9f32d655bda6b7c8128a5897712fe5a9e17",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-1-serial-supervision/identity.json

Original bytes: 2923. SHA-256: `9d8adfa306181ecd444815b1c42f7d22257fa27f67a1739983f6b3749ee04f84`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/performance-pilot-v1.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/round-1-serial",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-serial/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 25093013504,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   474928.\nPages active:                                 842438.\nPages inactive:                               829300.\nPages speculative:                             77815.\nPages throttled:                                   0.\nPages wired down:                             179180.\nPages purgeable:                                  62.\n\"Translation faults\":                     1491462076.\nPages copy-on-write:                        76864592.\nPages zero filled:                        2372770833.\nPages reactivated:                          96762431.\nPages purged:                               11290051.\nFile-backed pages:                           1056566.\nAnonymous pages:                              692987.\nPages stored in compressor:                  1269319.\nPages occupied by compressor:                 680920.\nDecompressions:                             44280519.\nCompressions:                               54848797.\nPageins:                                  1124204880.\nPageouts:                                     372460.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127234.\nPages tagged resident:                         83658.\nPages tagged compressed:                       43576.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                         1055.\nPages tag-storage non-tag pageable:            92039.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6599232.\nTagged compressions:                          497373.\nTagged decompressions:                        403610.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-read-pair-v1/round-1-serial-supervision/receipt.json

Original bytes: 2140. SHA-256: `219a7edf48aaeeac60317d54a303384f4c7210a4eb9b9a756b4b0837aba225a1`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7874975792,
  "samples": 1370,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24882085888,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   475836.\nPages active:                                 859375.\nPages inactive:                               849441.\nPages speculative:                             48940.\nPages throttled:                                   0.\nPages wired down:                             179023.\nPages purgeable:                                6211.\n\"Translation faults\":                     1492217770.\nPages copy-on-write:                        76884946.\nPages zero filled:                        2376595744.\nPages reactivated:                          96792353.\nPages purged:                               11291664.\nFile-backed pages:                           1036635.\nAnonymous pages:                              721121.\nPages stored in compressor:                  1248159.\nPages occupied by compressor:                 671596.\nDecompressions:                             44878351.\nCompressions:                               55452841.\nPageins:                                  1129613018.\nPageouts:                                     372833.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127486.\nPages tagged resident:                         84490.\nPages tagged compressed:                       42996.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5201.\nPages tag-storage free:                         1139.\nPages tag-storage non-tag pageable:            91956.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6483904.\nTagged compressions:                          497748.\nTagged decompressions:                        404559.\n"
  },
  "seconds": 80.95857929100748
}
````

### vq-read-pair-v1/round-1-serial-supervision/stdout.txt

Original bytes: 21462. SHA-256: `89feed2163449fe459566dbc4c25e2ccf51cfec264922605e6c65d8869d313ee`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 48625,
    "hits" : 18790,
    "loads" : 49233,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "parallel_read_lanes" : 0,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 0,
    "total_capacity" : 608
  },
  "committed_decode_tokens_per_second" : 2.998757929836414,
  "committed_tokens" : 128,
  "emission_seconds" : [
    9.3304068329744041,
    10.45636545799789,
    10.956687625002814,
    11.422494500002358,
    11.825449333002325,
    12.259852540999418,
    12.655408915976295,
    13.098703707975801,
    13.509865125000942,
    14.027973457996268,
    14.428666374995373,
    14.865996624983381,
    15.223618040996371,
    15.554272624984151,
    15.840711665980052,
    16.282416082976852,
    16.646424582984764,
    16.908834374975413,
    17.26897987499251,
    17.59791737498017,
    17.994156040978851,
    18.381001082976582,
    18.699696707975818,
    19.039931415987667,
    19.478486457985127,
    19.89748629098176,
    20.269371957983822,
    20.641502624988789,
    20.982043083000463,
    21.493265500001144,
    21.895675374980783,
    22.239060790976509,
    22.65931616598391,
    22.990620249998756,
    23.296701374987606,
    23.585081540979445,
    23.876139624975622,
    24.162435165984789,
    24.419577415974345,
    24.69731899999897,
    25.065273499989416,
    25.424520125001436,
    25.858916415978456,
    26.196091999998316,
    26.603390499978559,
    26.986723415990127,
    27.302773624978727,
    27.630376916000387,
    27.967554832983296,
    28.40075312499539,
    28.79254383299849,
    29.092233332979959,
    29.359582957986277,
    29.655490915989503,
    30.024830374983139,
    30.316699791001156,
    30.557923874992412,
    30.896028749994002,
    31.22839799997746,
    31.573703749978449,
    31.864767999999458,
    32.153522707987577,
    32.432813374995021,
    32.688738457974978,
    32.989582332986174,
    33.286291165975854,
    33.537166832975345,
    33.878839540993795,
    34.164941665978404,
    34.474166707979748,
    34.745152916002553,
    35.002084082982037,
    35.279823165998096,
    35.675660082983086,
    36.139046707976377,
    36.610462915996322,
    37.060550290974788,
    37.512134332995629,
    37.7817673329846,
    38.078596499981359,
    38.389576916000806,
    38.669492624991108,
    38.942976124992128,
    39.289932665997185,
    39.534538124979008,
    39.788653124996927,
    40.127092332986649,
    40.433169374999125,
    40.772595957998419,
    41.093245707976166,
    41.415623165987199,
    41.711912915983703,
    41.992500708001899,
    42.308497833000729,
    42.620050249999622,
    42.902268332982203,
    43.217109915975016,
    43.471197832986945,
    43.758379040984437,
    44.017102207988501,
    44.289589708001586,
    44.545412665989716,
    44.771140957978787,
    45.031160540995188,
    45.320314290991519,
    45.573796749988105,
    45.839328707981622,
    46.076000957982615,
    46.319662583002355,
    46.566163790994324,
    46.845832499995595,
    47.112144165992504,
    47.411678582982859,
    47.746093790978193,
    48.061809540988179,
    48.301340665988391,
    48.611192374984967,
    48.897330582985887,
    49.140562040993245,
    49.444772124988958,
    49.696716165984981,
    49.976143457985017,
    50.259677707974333,
    50.541388957994059,
    50.819992332981201,
    51.087188707984751,
    51.41783908297657,
    51.681274415983353
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
    "reclaimableBytes" : 26133725184,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    1.1259586250234861,
    0.50032216700492427,
    0.46580687499954365,
    0.40295483299996704,
    0.43440320799709298,
    0.39555637497687712,
    0.44329479199950583,
    0.41116141702514142,
    0.51810833299532533,
    0.40069291699910536,
    0.43733024998800829,
    0.35762141601298936,
    0.33065458398777992,
    0.28643904099590145,
    0.44170441699679941,
    0.36400850000791252,
    0.26240979199064896,
    0.36014550001709722,
    0.32893749998765998,
    0.39623866599868052,
    0.38684504199773073,
    0.31869562499923632,
    0.34023470801184885,
    0.43855504199746065,
    0.4189998329966329,
    0.37188566700206138,
    0.37213066700496711,
    0.34054045801167376,
    0.51122241700068116,
    0.40240987497963943,
    0.34338541599572636,
    0.42025537500740029,
    0.33130408401484601,
    0.30608112498885021,
    0.28838016599183902,
    0.29105808399617672,
    0.28629554100916721,
    0.25714224998955615,
    0.2777415840246249,
    0.36795449999044649,
    0.35924662501201965,
    0.43439629097701982,
    0.33717558401986025,
    0.40729849998024292,
    0.38333291601156816,
    0.31605020898859948,
    0.32760329102165997,
    0.33717791698290966,
    0.43319829201209359,
    0.39179070800310001,
    0.29968949998146854,
    0.26734962500631809,
    0.29590795800322667,
    0.36933945899363607,
    0.29186941601801664,
    0.24122408399125561,
    0.3381048750015907,
    0.33236924998345785,
    0.34530575000098906,
    0.29106425002100877,
    0.28875470798811875,
    0.27929066700744443,
    0.25592508297995664,
    0.30084387501119636,
    0.29670883298967965,
    0.25087566699949093,
    0.34167270801845007,
    0.28610212498460896,
    0.30922504200134426,
    0.27098620802280493,
    0.25693116697948426,
    0.27773908301605843,
    0.39583691698499024,
    0.46338662499329075,
    0.47141620801994577,
    0.45008737497846596,
    0.45158404202084057,
    0.26963299998897128,
    0.29682916699675843,
    0.31098041601944715,
    0.27991570899030194,
    0.27348350000102073,
    0.34695654100505635,
    0.24460545898182318,
    0.25411500001791865,
    0.33843920798972249,
    0.30607704201247543,
    0.33942658299929462,
    0.32064974997774698,
    0.32237745801103301,
    0.29628974999650382,
    0.28058779201819561,
    0.31599712499883026,
    0.31155241699889302,
    0.28221808298258111,
    0.31484158299281262,
    0.25408791701192968,
    0.28718120799749158,
    0.25872316700406373,
    0.27248750001308508,
    0.25582295798812993,
    0.22572829198907129,
    0.26001958301640116,
    0.28915374999633059,
    0.2534824589965865,
    0.2655319579935167,
    0.23667225000099279,
    0.24366162501974031,
    0.24650120799196884,
    0.27966870900127105,
    0.26631166599690914,
    0.29953441699035466,
    0.33441520799533464,
    0.31571575000998564,
    0.23953112500021234,
    0.30985170899657533,
    0.28613820800092071,
    0.24323145800735801,
    0.30421008399571292,
    0.25194404099602252,
    0.27942729200003669,
    0.28353424998931587,
    0.28171125001972541,
    0.27860337498714216,
    0.2671963750035502,
    0.33065037499181926,
    0.26343533300678246
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 28.990428874996724,
  "metadata_seconds" : 0.11765387500054203,
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
  "peak_process_bytes" : 7874975792,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-performance-pilot-v1",
  "profile_sha256" : "8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5",
  "qualification" : "unproven",
  "request_seconds" : 51.681294957990758,
  "request_vm_after" : {
    "reclaimableBytes" : 17853218816,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18608095232,
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
  "ttft_seconds" : 9.3304068329744041,
  "validation_receipt_sha256" : "0f07363316d910373ff5e8fc9379f9f32d655bda6b7c8128a5897712fe5a9e17",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-1-serial-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-read-pair-v1/round-1-parallel/receipt.json

Original bytes: 21486. SHA-256: `72f380fe488efb2712dec3a8f69e2d2dc7cb13d1a1f8e3e844d2b29abe380f68`.

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
  "committed_decode_tokens_per_second" : 4.2787077093216519,
  "committed_tokens" : 128,
  "emission_seconds" : [
    3.3655289589951281,
    4.0258468340034597,
    4.2849735420022625,
    4.539466167014325,
    4.7827733340091072,
    5.0299307919922285,
    5.2739386670000385,
    5.5226394170022104,
    5.7629597919876687,
    6.011381624994101,
    6.251435499987565,
    6.4962365840037819,
    6.7318352499860339,
    6.9617975000001024,
    7.188661249994766,
    7.4409624169929884,
    7.6863907919905614,
    7.8992934169946238,
    8.1403342089906801,
    8.3763292089861352,
    8.6173719170037657,
    8.8599730840069242,
    9.0958957090042531,
    9.3293646670063026,
    9.5793944170000032,
    9.8215022920048796,
    10.059259458997985,
    10.302155292010866,
    10.541809708985966,
    10.803975666989572,
    11.053224458999466,
    11.2926352499926,
    11.541862084006425,
    11.774115125008393,
    12.001378084009048,
    12.225699250004254,
    12.452158125001006,
    12.668108999991091,
    12.879058583988808,
    13.105353333987296,
    13.348081542004365,
    13.595641958992928,
    13.832280750008067,
    14.069206000014674,
    14.319817417010199,
    14.568675499991514,
    14.802944333991036,
    15.038433209003415,
    15.278623458987568,
    15.516846584010636,
    15.818771666992689,
    16.066086292004911,
    16.280314458999783,
    16.507279084005859,
    16.748453084001085,
    16.979232209007023,
    17.189233999990392,
    17.429070959013188,
    17.664724875008687,
    17.90163962499355,
    18.125756916997489,
    18.341130292013986,
    18.559274458995787,
    18.765271125012077,
    18.99216241700924,
    19.217472209013067,
    19.427237958996557,
    19.66160254200804,
    19.915450083994074,
    20.154873583989684,
    20.373542292014463,
    20.588614750013221,
    20.803199958987534,
    21.046755374991335,
    21.278841166989878,
    21.51778816699516,
    21.744672333996277,
    21.978444417007267,
    22.193430791987339,
    22.421689125010744,
    22.657111500011524,
    22.875024209002731,
    23.088261500000954,
    23.330274542007828,
    23.5335716670088,
    23.746747416997096,
    23.985953833995154,
    24.213996375008719,
    24.453006249997998,
    24.690116250014398,
    24.923770833993331,
    25.152153625007486,
    25.377307791990461,
    25.609558791999007,
    25.8476448339934,
    26.073268542008009,
    26.306525499996496,
    26.51866208401043,
    26.747903292009141,
    26.958403208991513,
    27.177161291998345,
    27.392647000000579,
    27.58295700000599,
    27.796164333994966,
    28.019798208988504,
    28.234783333988162,
    28.447547749994555,
    28.639322041999549,
    28.848674500011839,
    29.048838833987247,
    29.271747874998255,
    29.486951917002443,
    29.716908792004688,
    29.959349667013157,
    30.189831249997951,
    30.394792792008957,
    30.629764749988681,
    30.857618084002752,
    31.061269083991647,
    31.293825291999383,
    31.501368291996187,
    31.723440542002209,
    31.94459954201011,
    32.144511166989105,
    32.358301542000845,
    32.582620625005802,
    32.822992083994905,
    33.047388209000928
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
    "reclaimableBytes" : 17853218816,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.66031787500833161,
    0.25912670799880289,
    0.25449262501206249,
    0.24330716699478216,
    0.24715745798312128,
    0.24400787500781007,
    0.24870075000217184,
    0.24032037498545833,
    0.24842183300643228,
    0.24005387499346398,
    0.24480108401621692,
    0.23559866598225199,
    0.22996225001406856,
    0.22686374999466352,
    0.25230116699822247,
    0.24542837499757297,
    0.21290262500406243,
    0.24104079199605621,
    0.23599499999545515,
    0.2410427080176305,
    0.24260116700315848,
    0.23592262499732897,
    0.23346895800204948,
    0.25002974999370053,
    0.24210787500487641,
    0.23775716699310578,
    0.24289583301288076,
    0.23965441697509959,
    0.26216595800360665,
    0.2492487920098938,
    0.23941079099313356,
    0.24922683401382528,
    0.23225304100196809,
    0.22726295900065452,
    0.22432116599520668,
    0.22645887499675155,
    0.21595087499008514,
    0.21094958399771713,
    0.22629474999848753,
    0.24272820801706985,
    0.24756041698856279,
    0.23663879101513885,
    0.2369252500066068,
    0.25061141699552536,
    0.24885808298131451,
    0.23426883399952203,
    0.23548887501237914,
    0.24019024998415262,
    0.23822312502306886,
    0.30192508298205212,
    0.24731462501222268,
    0.21422816699487157,
    0.22696462500607595,
    0.24117399999522604,
    0.23077912500593811,
    0.21000179098336957,
    0.23983695902279578,
    0.23565391599549912,
    0.23691474998486228,
    0.22411729200393893,
    0.21537337501649745,
    0.21814416698180139,
    0.20599666601628996,
    0.22689129199716263,
    0.22530979200382717,
    0.20976574998348951,
    0.23436458301148377,
    0.25384754198603332,
    0.23942349999560975,
    0.21866870802477933,
    0.21507245799875818,
    0.21458520897431299,
    0.24355541600380093,
    0.23208579199854285,
    0.23894700000528246,
    0.22688416700111702,
    0.23377208301099017,
    0.21498637498007156,
    0.2282583330234047,
    0.23542237500078045,
    0.21791270899120718,
    0.21323729099822231,
    0.24201304200687446,
    0.2032971250009723,
    0.21317574998829514,
    0.23920641699805856,
    0.22804254101356491,
    0.23900987498927861,
    0.23711000001640059,
    0.23365458397893235,
    0.22838279101415537,
    0.22515416698297486,
    0.23225100000854582,
    0.23808604199439287,
    0.22562370801460929,
    0.23325695798848756,
    0.21213658401393332,
    0.22924120799871162,
    0.21049991698237136,
    0.21875808300683275,
    0.21548570800223388,
    0.19031000000541098,
    0.21320733398897573,
    0.22363387499353848,
    0.21498512499965727,
    0.21276441600639373,
    0.19177429200499319,
    0.2093524580122903,
    0.20016433397540823,
    0.2229090410110075,
    0.21520404200418852,
    0.22995687500224449,
    0.24244087500846945,
    0.23048158298479393,
    0.2049615420110058,
    0.23497195797972381,
    0.22785333401407115,
    0.20365099998889491,
    0.23255620800773613,
    0.2075429999968037,
    0.22207225000602193,
    0.22115900000790134,
    0.19991162497899495,
    0.21379037501174025,
    0.22431908300495706,
    0.24037145898910239,
    0.22439612500602379
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 29.005059792019892,
  "metadata_seconds" : 0.11512304097414017,
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
  "peak_process_bytes" : 8049334440,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 33.047412292013178,
  "request_vm_after" : {
    "reclaimableBytes" : 17929601024,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18527518720,
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
  "ttft_seconds" : 3.3655289589951281,
  "validation_receipt_sha256" : "5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-1-parallel-supervision/identity.json

Original bytes: 2927. SHA-256: `9873f1ee600d78dc3659e2d2bf780b7e6f3b1a4862354380ff29c318486c8224`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/performance-pilot-v2.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/round-1-parallel",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-parallel/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24898699264,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   466610.\nPages active:                                 856329.\nPages inactive:                               863317.\nPages speculative:                             48941.\nPages throttled:                                   0.\nPages wired down:                             177957.\nPages purgeable:                                5186.\n\"Translation faults\":                     1492220446.\nPages copy-on-write:                        76885327.\nPages zero filled:                        2376596870.\nPages reactivated:                          96792353.\nPages purged:                               11291664.\nFile-backed pages:                           1047900.\nAnonymous pages:                              720687.\nPages stored in compressor:                  1248151.\nPages occupied by compressor:                 671595.\nDecompressions:                             44878365.\nCompressions:                               55452841.\nPageins:                                  1129624201.\nPageouts:                                     372833.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127485.\nPages tagged resident:                         84490.\nPages tagged compressed:                       42995.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5201.\nPages tag-storage free:                          845.\nPages tag-storage non-tag pageable:            92250.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6483392.\nTagged compressions:                          497748.\nTagged decompressions:                        404560.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-read-pair-v1/round-1-parallel-supervision/receipt.json

Original bytes: 2140. SHA-256: `32918a30b525d7b01b1b15da4c6933ed324aaae77478161cc24ba3a3bbf3a7a5`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 8049334440,
  "samples": 1062,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24884903936,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   486560.\nPages active:                                 846700.\nPages inactive:                               843328.\nPages speculative:                             54246.\nPages throttled:                                   0.\nPages wired down:                             178030.\nPages purgeable:                                 377.\n\"Translation faults\":                     1492942751.\nPages copy-on-write:                        76903112.\nPages zero filled:                        2380420407.\nPages reactivated:                          96850395.\nPages purged:                               11294865.\nFile-backed pages:                           1031917.\nAnonymous pages:                              712357.\nPages stored in compressor:                  1255721.\nPages occupied by compressor:                 675494.\nDecompressions:                             45412361.\nCompressions:                               56017716.\nPageins:                                  1134992066.\nPageouts:                                     373189.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127419.\nPages tagged resident:                         84477.\nPages tagged compressed:                       42942.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5201.\nPages tag-storage free:                         1088.\nPages tag-storage non-tag pageable:            92007.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6462144.\nTagged compressions:                          497888.\nTagged decompressions:                        404750.\n"
  },
  "seconds": 62.32916170798126
}
````

### vq-read-pair-v1/round-1-parallel-supervision/stdout.txt

Original bytes: 21487. SHA-256: `c348b8fd8685b98467bf69ba9d55de404a1a4677cee31b18218d9abd6b34264a`.

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
  "committed_decode_tokens_per_second" : 4.2787077093216519,
  "committed_tokens" : 128,
  "emission_seconds" : [
    3.3655289589951281,
    4.0258468340034597,
    4.2849735420022625,
    4.539466167014325,
    4.7827733340091072,
    5.0299307919922285,
    5.2739386670000385,
    5.5226394170022104,
    5.7629597919876687,
    6.011381624994101,
    6.251435499987565,
    6.4962365840037819,
    6.7318352499860339,
    6.9617975000001024,
    7.188661249994766,
    7.4409624169929884,
    7.6863907919905614,
    7.8992934169946238,
    8.1403342089906801,
    8.3763292089861352,
    8.6173719170037657,
    8.8599730840069242,
    9.0958957090042531,
    9.3293646670063026,
    9.5793944170000032,
    9.8215022920048796,
    10.059259458997985,
    10.302155292010866,
    10.541809708985966,
    10.803975666989572,
    11.053224458999466,
    11.2926352499926,
    11.541862084006425,
    11.774115125008393,
    12.001378084009048,
    12.225699250004254,
    12.452158125001006,
    12.668108999991091,
    12.879058583988808,
    13.105353333987296,
    13.348081542004365,
    13.595641958992928,
    13.832280750008067,
    14.069206000014674,
    14.319817417010199,
    14.568675499991514,
    14.802944333991036,
    15.038433209003415,
    15.278623458987568,
    15.516846584010636,
    15.818771666992689,
    16.066086292004911,
    16.280314458999783,
    16.507279084005859,
    16.748453084001085,
    16.979232209007023,
    17.189233999990392,
    17.429070959013188,
    17.664724875008687,
    17.90163962499355,
    18.125756916997489,
    18.341130292013986,
    18.559274458995787,
    18.765271125012077,
    18.99216241700924,
    19.217472209013067,
    19.427237958996557,
    19.66160254200804,
    19.915450083994074,
    20.154873583989684,
    20.373542292014463,
    20.588614750013221,
    20.803199958987534,
    21.046755374991335,
    21.278841166989878,
    21.51778816699516,
    21.744672333996277,
    21.978444417007267,
    22.193430791987339,
    22.421689125010744,
    22.657111500011524,
    22.875024209002731,
    23.088261500000954,
    23.330274542007828,
    23.5335716670088,
    23.746747416997096,
    23.985953833995154,
    24.213996375008719,
    24.453006249997998,
    24.690116250014398,
    24.923770833993331,
    25.152153625007486,
    25.377307791990461,
    25.609558791999007,
    25.8476448339934,
    26.073268542008009,
    26.306525499996496,
    26.51866208401043,
    26.747903292009141,
    26.958403208991513,
    27.177161291998345,
    27.392647000000579,
    27.58295700000599,
    27.796164333994966,
    28.019798208988504,
    28.234783333988162,
    28.447547749994555,
    28.639322041999549,
    28.848674500011839,
    29.048838833987247,
    29.271747874998255,
    29.486951917002443,
    29.716908792004688,
    29.959349667013157,
    30.189831249997951,
    30.394792792008957,
    30.629764749988681,
    30.857618084002752,
    31.061269083991647,
    31.293825291999383,
    31.501368291996187,
    31.723440542002209,
    31.94459954201011,
    32.144511166989105,
    32.358301542000845,
    32.582620625005802,
    32.822992083994905,
    33.047388209000928
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
    "reclaimableBytes" : 17853218816,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.66031787500833161,
    0.25912670799880289,
    0.25449262501206249,
    0.24330716699478216,
    0.24715745798312128,
    0.24400787500781007,
    0.24870075000217184,
    0.24032037498545833,
    0.24842183300643228,
    0.24005387499346398,
    0.24480108401621692,
    0.23559866598225199,
    0.22996225001406856,
    0.22686374999466352,
    0.25230116699822247,
    0.24542837499757297,
    0.21290262500406243,
    0.24104079199605621,
    0.23599499999545515,
    0.2410427080176305,
    0.24260116700315848,
    0.23592262499732897,
    0.23346895800204948,
    0.25002974999370053,
    0.24210787500487641,
    0.23775716699310578,
    0.24289583301288076,
    0.23965441697509959,
    0.26216595800360665,
    0.2492487920098938,
    0.23941079099313356,
    0.24922683401382528,
    0.23225304100196809,
    0.22726295900065452,
    0.22432116599520668,
    0.22645887499675155,
    0.21595087499008514,
    0.21094958399771713,
    0.22629474999848753,
    0.24272820801706985,
    0.24756041698856279,
    0.23663879101513885,
    0.2369252500066068,
    0.25061141699552536,
    0.24885808298131451,
    0.23426883399952203,
    0.23548887501237914,
    0.24019024998415262,
    0.23822312502306886,
    0.30192508298205212,
    0.24731462501222268,
    0.21422816699487157,
    0.22696462500607595,
    0.24117399999522604,
    0.23077912500593811,
    0.21000179098336957,
    0.23983695902279578,
    0.23565391599549912,
    0.23691474998486228,
    0.22411729200393893,
    0.21537337501649745,
    0.21814416698180139,
    0.20599666601628996,
    0.22689129199716263,
    0.22530979200382717,
    0.20976574998348951,
    0.23436458301148377,
    0.25384754198603332,
    0.23942349999560975,
    0.21866870802477933,
    0.21507245799875818,
    0.21458520897431299,
    0.24355541600380093,
    0.23208579199854285,
    0.23894700000528246,
    0.22688416700111702,
    0.23377208301099017,
    0.21498637498007156,
    0.2282583330234047,
    0.23542237500078045,
    0.21791270899120718,
    0.21323729099822231,
    0.24201304200687446,
    0.2032971250009723,
    0.21317574998829514,
    0.23920641699805856,
    0.22804254101356491,
    0.23900987498927861,
    0.23711000001640059,
    0.23365458397893235,
    0.22838279101415537,
    0.22515416698297486,
    0.23225100000854582,
    0.23808604199439287,
    0.22562370801460929,
    0.23325695798848756,
    0.21213658401393332,
    0.22924120799871162,
    0.21049991698237136,
    0.21875808300683275,
    0.21548570800223388,
    0.19031000000541098,
    0.21320733398897573,
    0.22363387499353848,
    0.21498512499965727,
    0.21276441600639373,
    0.19177429200499319,
    0.2093524580122903,
    0.20016433397540823,
    0.2229090410110075,
    0.21520404200418852,
    0.22995687500224449,
    0.24244087500846945,
    0.23048158298479393,
    0.2049615420110058,
    0.23497195797972381,
    0.22785333401407115,
    0.20365099998889491,
    0.23255620800773613,
    0.2075429999968037,
    0.22207225000602193,
    0.22115900000790134,
    0.19991162497899495,
    0.21379037501174025,
    0.22431908300495706,
    0.24037145898910239,
    0.22439612500602379
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 29.005059792019892,
  "metadata_seconds" : 0.11512304097414017,
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
  "peak_process_bytes" : 8049334440,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 33.047412292013178,
  "request_vm_after" : {
    "reclaimableBytes" : 17929601024,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18527518720,
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
  "ttft_seconds" : 3.3655289589951281,
  "validation_receipt_sha256" : "5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-1-parallel-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-read-pair-v1/round-2-serial/receipt.json

Original bytes: 21452. SHA-256: `58bb2da729a1d16079d6674a24e121b00cbd1718e2b88db218ca1d1cc9aa9e7b`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 48625,
    "hits" : 18790,
    "loads" : 49233,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "parallel_read_lanes" : 0,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 0,
    "total_capacity" : 608
  },
  "committed_decode_tokens_per_second" : 3.0668864943002099,
  "committed_tokens" : 128,
  "emission_seconds" : [
    9.2577554169984069,
    10.316573084011907,
    10.828774583991617,
    11.286911417002557,
    11.682232459017541,
    12.109944916999666,
    12.50340449999203,
    12.946599749993766,
    13.326924791996134,
    13.771246374992188,
    14.142987583996728,
    14.591823958995519,
    14.937404958996922,
    15.270504500018433,
    15.567220541997813,
    16.017651250003837,
    16.387729792011669,
    16.652018875000067,
    17.009613083995646,
    17.342497292003827,
    17.734564042009879,
    18.112359499995364,
    18.435182624991285,
    18.774574750015745,
    19.240054624999175,
    19.687793167016935,
    20.059742500016,
    20.424323792016366,
    20.763011250004638,
    21.251819124998292,
    21.655656999995699,
    21.994290292001097,
    22.418994292005664,
    22.743250250001438,
    23.042199209012324,
    23.329551792005077,
    23.620605625008466,
    23.905592166993301,
    24.160310709004989,
    24.437850542017259,
    24.804452500015032,
    25.151847667002585,
    25.504101041995455,
    25.832570291997399,
    26.239605209004367,
    26.629529958998319,
    26.942950166994706,
    27.272606959013501,
    27.613416709005833,
    27.959810917003779,
    28.295767667004839,
    28.587960584001848,
    28.855644875002326,
    29.151932834007312,
    29.522761041997001,
    29.811295416991925,
    30.053217834007228,
    30.393832125002518,
    30.728999334009131,
    31.061290999990888,
    31.340728750015842,
    31.619192042009672,
    31.896179584000492,
    32.150378833990544,
    32.44964412500849,
    32.749153875018237,
    32.998816042003455,
    33.33446841701516,
    33.617981084011262,
    33.927983583998866,
    34.200886625010753,
    34.457049666991225,
    34.757476792001398,
    35.148404959007166,
    35.571816875017248,
    35.954089209000813,
    36.254102459002752,
    36.563462042016909,
    36.828247124998597,
    37.122775625000941,
    37.433818084013183,
    37.71355387501535,
    37.989245834003668,
    38.333565125009045,
    38.57831341700512,
    38.829786375019467,
    39.172839750011917,
    39.495462499995483,
    39.847178708994761,
    40.166871666995576,
    40.489939958992181,
    40.784405000013066,
    41.063033874990651,
    41.375029709015507,
    41.686694167001406,
    41.967750209005317,
    42.27987079200102,
    42.532676000002539,
    42.819143875007285,
    43.07653829199262,
    43.349664875015151,
    43.603916291991482,
    43.82909362501232,
    44.089712917018915,
    44.378242417005822,
    44.631793375010602,
    44.895410291996086,
    45.13048966700444,
    45.375975584000116,
    45.620719500002451,
    45.900093125004787,
    46.16709337499924,
    46.463400917011313,
    46.798341042012908,
    47.110962542006746,
    47.34881037499872,
    47.660534499998903,
    47.948900292016333,
    48.189705083990702,
    48.495084374997532,
    48.74254025000846,
    49.021708584012231,
    49.297507459006738,
    49.538023917004466,
    49.810187750001205,
    50.075449541996932,
    50.404776167008094,
    50.667830499995034
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
    "reclaimableBytes" : 17728389120,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    1.0588176670134999,
    0.51220149997971021,
    0.45813683301093988,
    0.39532104201498441,
    0.42771245798212476,
    0.39345958299236372,
    0.44319525000173599,
    0.38032504200236872,
    0.44432158299605362,
    0.37174120900454,
    0.44883637499879114,
    0.34558100000140257,
    0.33309954102151096,
    0.29671604197937995,
    0.45043070800602436,
    0.37007854200783186,
    0.26428908298839815,
    0.35759420899557881,
    0.3328842080081813,
    0.39206675000605173,
    0.37779545798548497,
    0.32282312499592081,
    0.33939212502446026,
    0.46547987498342991,
    0.44773854201775976,
    0.37194933299906552,
    0.36458129200036637,
    0.33868745798827149,
    0.48880787499365397,
    0.4038378749974072,
    0.33863329200539738,
    0.42470400000456721,
    0.32425595799577422,
    0.29894895901088603,
    0.28735258299275301,
    0.29105383300338872,
    0.28498654198483564,
    0.25471854201168753,
    0.27753983301226981,
    0.36660195799777284,
    0.34739516698755324,
    0.35225337499286979,
    0.3284692500019446,
    0.40703491700696759,
    0.38992474999395199,
    0.31342020799638703,
    0.32965679201879539,
    0.34080974999233149,
    0.34639420799794607,
    0.33595675000105985,
    0.29219291699700989,
    0.26768429100047797,
    0.29628795900498517,
    0.37082820798968896,
    0.28853437499492429,
    0.24192241701530293,
    0.3406142909952905,
    0.33516720900661312,
    0.33229166598175652,
    0.27943775002495386,
    0.27846329199383035,
    0.27698754199082032,
    0.25419924999005161,
    0.29926529101794586,
    0.29950975000974722,
    0.24966216698521748,
    0.33565237501170486,
    0.28351266699610278,
    0.3100024999876041,
    0.27290304101188667,
    0.25616304198047146,
    0.30042712501017377,
    0.39092816700576805,
    0.42341191601008177,
    0.38227233398356475,
    0.30001325000193901,
    0.30935958301415667,
    0.2647850829816889,
    0.29452850000234321,
    0.31104245901224203,
    0.27973579100216739,
    0.27569195898831822,
    0.34431929100537673,
    0.24474829199607484,
    0.25147295801434666,
    0.3430533749924507,
    0.32262274998356588,
    0.35171620899927802,
    0.31969295800081454,
    0.32306829199660569,
    0.29446504102088511,
    0.27862887497758493,
    0.31199583402485587,
    0.31166445798589848,
    0.28105604200391099,
    0.31212058299570344,
    0.25280520800151862,
    0.28646787500474602,
    0.25739441698533483,
    0.27312658302253112,
    0.2542514169763308,
    0.22517733302083798,
    0.26061929200659506,
    0.28852949998690747,
    0.25355095800478011,
    0.26361691698548384,
    0.23507937500835396,
    0.24548591699567623,
    0.24474391600233503,
    0.27937362500233576,
    0.26700024999445304,
    0.2963075420120731,
    0.33494012500159442,
    0.31262149999383837,
    0.23784783299197443,
    0.31172412500018254,
    0.28836579201743007,
    0.24080479197436944,
    0.30537929100682959,
    0.24745587501092814,
    0.27916833400377072,
    0.27579887499450706,
    0.24051645799772814,
    0.27216383299673907,
    0.26526179199572653,
    0.32932662501116283,
    0.2630543329869397
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 29.243724625004688,
  "metadata_seconds" : 0.11969737501931377,
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
  "peak_mlx_bytes" : 6782306832,
  "peak_process_bytes" : 7874549832,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-performance-pilot-v1",
  "profile_sha256" : "8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5",
  "qualification" : "unproven",
  "request_seconds" : 50.667850458994508,
  "request_vm_after" : {
    "reclaimableBytes" : 17956700160,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18634522624,
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
  "ttft_seconds" : 9.2577554169984069,
  "validation_receipt_sha256" : "0f07363316d910373ff5e8fc9379f9f32d655bda6b7c8128a5897712fe5a9e17",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-2-serial-supervision/identity.json

Original bytes: 2923. SHA-256: `8a610541a614c6c7b9c841feaa03bc302bc70ef11ca35c4c254dd8be8b82bc75`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/performance-pilot-v1.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/round-2-serial",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-serial/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24786173952,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   474958.\nPages active:                                 852559.\nPages inactive:                               860045.\nPages speculative:                             54457.\nPages throttled:                                   0.\nPages wired down:                             178003.\nPages purgeable:                                 609.\n\"Translation faults\":                     1493726860.\nPages copy-on-write:                        76917496.\nPages zero filled:                        2384262877.\nPages reactivated:                          96905621.\nPages purged:                               11297927.\nFile-backed pages:                           1037261.\nAnonymous pages:                              729800.\nPages stored in compressor:                  1236366.\nPages occupied by compressor:                 664452.\nDecompressions:                             45968371.\nCompressions:                               56582880.\nPageins:                                  1140379864.\nPageouts:                                     373548.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 128143.\nPages tagged resident:                         85021.\nPages tagged compressed:                       43122.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1328.\nPages tag-storage non-tag pageable:            91768.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6500544.\nTagged compressions:                          498170.\nTagged decompressions:                        404847.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-read-pair-v1/round-2-serial-supervision/receipt.json

Original bytes: 2140. SHA-256: `02ad291681b227d66224e88f981cc18abf0e3f058571ed4759e8d6fbb267d65c`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7874549832,
  "samples": 1358,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24899534848,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   475341.\nPages active:                                 849043.\nPages inactive:                               865765.\nPages speculative:                             49105.\nPages throttled:                                   0.\nPages wired down:                             177857.\nPages purgeable:                                1002.\n\"Translation faults\":                     1494523458.\nPages copy-on-write:                        76951389.\nPages zero filled:                        2388097049.\nPages reactivated:                          96948137.\nPages purged:                               11301845.\nFile-backed pages:                           1043404.\nAnonymous pages:                              720509.\nPages stored in compressor:                  1243807.\nPages occupied by compressor:                 666698.\nDecompressions:                             46525977.\nCompressions:                               57176358.\nPageins:                                  1145731339.\nPageouts:                                     373966.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127463.\nPages tagged resident:                         83689.\nPages tagged compressed:                       43774.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1774.\nPages tag-storage non-tag pageable:            91322.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6629504.\nTagged compressions:                          500466.\nTagged decompressions:                        405754.\n"
  },
  "seconds": 80.19700479198946
}
````

### vq-read-pair-v1/round-2-serial-supervision/stdout.txt

Original bytes: 21453. SHA-256: `793a9f5d7a98019a249d916d28fc7f33035cdfb8b28f19c73e169b73a51be68d`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 48625,
    "hits" : 18790,
    "loads" : 49233,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "parallel_read_lanes" : 0,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 0,
    "total_capacity" : 608
  },
  "committed_decode_tokens_per_second" : 3.0668864943002099,
  "committed_tokens" : 128,
  "emission_seconds" : [
    9.2577554169984069,
    10.316573084011907,
    10.828774583991617,
    11.286911417002557,
    11.682232459017541,
    12.109944916999666,
    12.50340449999203,
    12.946599749993766,
    13.326924791996134,
    13.771246374992188,
    14.142987583996728,
    14.591823958995519,
    14.937404958996922,
    15.270504500018433,
    15.567220541997813,
    16.017651250003837,
    16.387729792011669,
    16.652018875000067,
    17.009613083995646,
    17.342497292003827,
    17.734564042009879,
    18.112359499995364,
    18.435182624991285,
    18.774574750015745,
    19.240054624999175,
    19.687793167016935,
    20.059742500016,
    20.424323792016366,
    20.763011250004638,
    21.251819124998292,
    21.655656999995699,
    21.994290292001097,
    22.418994292005664,
    22.743250250001438,
    23.042199209012324,
    23.329551792005077,
    23.620605625008466,
    23.905592166993301,
    24.160310709004989,
    24.437850542017259,
    24.804452500015032,
    25.151847667002585,
    25.504101041995455,
    25.832570291997399,
    26.239605209004367,
    26.629529958998319,
    26.942950166994706,
    27.272606959013501,
    27.613416709005833,
    27.959810917003779,
    28.295767667004839,
    28.587960584001848,
    28.855644875002326,
    29.151932834007312,
    29.522761041997001,
    29.811295416991925,
    30.053217834007228,
    30.393832125002518,
    30.728999334009131,
    31.061290999990888,
    31.340728750015842,
    31.619192042009672,
    31.896179584000492,
    32.150378833990544,
    32.44964412500849,
    32.749153875018237,
    32.998816042003455,
    33.33446841701516,
    33.617981084011262,
    33.927983583998866,
    34.200886625010753,
    34.457049666991225,
    34.757476792001398,
    35.148404959007166,
    35.571816875017248,
    35.954089209000813,
    36.254102459002752,
    36.563462042016909,
    36.828247124998597,
    37.122775625000941,
    37.433818084013183,
    37.71355387501535,
    37.989245834003668,
    38.333565125009045,
    38.57831341700512,
    38.829786375019467,
    39.172839750011917,
    39.495462499995483,
    39.847178708994761,
    40.166871666995576,
    40.489939958992181,
    40.784405000013066,
    41.063033874990651,
    41.375029709015507,
    41.686694167001406,
    41.967750209005317,
    42.27987079200102,
    42.532676000002539,
    42.819143875007285,
    43.07653829199262,
    43.349664875015151,
    43.603916291991482,
    43.82909362501232,
    44.089712917018915,
    44.378242417005822,
    44.631793375010602,
    44.895410291996086,
    45.13048966700444,
    45.375975584000116,
    45.620719500002451,
    45.900093125004787,
    46.16709337499924,
    46.463400917011313,
    46.798341042012908,
    47.110962542006746,
    47.34881037499872,
    47.660534499998903,
    47.948900292016333,
    48.189705083990702,
    48.495084374997532,
    48.74254025000846,
    49.021708584012231,
    49.297507459006738,
    49.538023917004466,
    49.810187750001205,
    50.075449541996932,
    50.404776167008094,
    50.667830499995034
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
    "reclaimableBytes" : 17728389120,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    1.0588176670134999,
    0.51220149997971021,
    0.45813683301093988,
    0.39532104201498441,
    0.42771245798212476,
    0.39345958299236372,
    0.44319525000173599,
    0.38032504200236872,
    0.44432158299605362,
    0.37174120900454,
    0.44883637499879114,
    0.34558100000140257,
    0.33309954102151096,
    0.29671604197937995,
    0.45043070800602436,
    0.37007854200783186,
    0.26428908298839815,
    0.35759420899557881,
    0.3328842080081813,
    0.39206675000605173,
    0.37779545798548497,
    0.32282312499592081,
    0.33939212502446026,
    0.46547987498342991,
    0.44773854201775976,
    0.37194933299906552,
    0.36458129200036637,
    0.33868745798827149,
    0.48880787499365397,
    0.4038378749974072,
    0.33863329200539738,
    0.42470400000456721,
    0.32425595799577422,
    0.29894895901088603,
    0.28735258299275301,
    0.29105383300338872,
    0.28498654198483564,
    0.25471854201168753,
    0.27753983301226981,
    0.36660195799777284,
    0.34739516698755324,
    0.35225337499286979,
    0.3284692500019446,
    0.40703491700696759,
    0.38992474999395199,
    0.31342020799638703,
    0.32965679201879539,
    0.34080974999233149,
    0.34639420799794607,
    0.33595675000105985,
    0.29219291699700989,
    0.26768429100047797,
    0.29628795900498517,
    0.37082820798968896,
    0.28853437499492429,
    0.24192241701530293,
    0.3406142909952905,
    0.33516720900661312,
    0.33229166598175652,
    0.27943775002495386,
    0.27846329199383035,
    0.27698754199082032,
    0.25419924999005161,
    0.29926529101794586,
    0.29950975000974722,
    0.24966216698521748,
    0.33565237501170486,
    0.28351266699610278,
    0.3100024999876041,
    0.27290304101188667,
    0.25616304198047146,
    0.30042712501017377,
    0.39092816700576805,
    0.42341191601008177,
    0.38227233398356475,
    0.30001325000193901,
    0.30935958301415667,
    0.2647850829816889,
    0.29452850000234321,
    0.31104245901224203,
    0.27973579100216739,
    0.27569195898831822,
    0.34431929100537673,
    0.24474829199607484,
    0.25147295801434666,
    0.3430533749924507,
    0.32262274998356588,
    0.35171620899927802,
    0.31969295800081454,
    0.32306829199660569,
    0.29446504102088511,
    0.27862887497758493,
    0.31199583402485587,
    0.31166445798589848,
    0.28105604200391099,
    0.31212058299570344,
    0.25280520800151862,
    0.28646787500474602,
    0.25739441698533483,
    0.27312658302253112,
    0.2542514169763308,
    0.22517733302083798,
    0.26061929200659506,
    0.28852949998690747,
    0.25355095800478011,
    0.26361691698548384,
    0.23507937500835396,
    0.24548591699567623,
    0.24474391600233503,
    0.27937362500233576,
    0.26700024999445304,
    0.2963075420120731,
    0.33494012500159442,
    0.31262149999383837,
    0.23784783299197443,
    0.31172412500018254,
    0.28836579201743007,
    0.24080479197436944,
    0.30537929100682959,
    0.24745587501092814,
    0.27916833400377072,
    0.27579887499450706,
    0.24051645799772814,
    0.27216383299673907,
    0.26526179199572653,
    0.32932662501116283,
    0.2630543329869397
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 29.243724625004688,
  "metadata_seconds" : 0.11969737501931377,
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
  "peak_mlx_bytes" : 6782306832,
  "peak_process_bytes" : 7874549832,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-performance-pilot-v1",
  "profile_sha256" : "8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5",
  "qualification" : "unproven",
  "request_seconds" : 50.667850458994508,
  "request_vm_after" : {
    "reclaimableBytes" : 17956700160,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18634522624,
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
  "ttft_seconds" : 9.2577554169984069,
  "validation_receipt_sha256" : "0f07363316d910373ff5e8fc9379f9f32d655bda6b7c8128a5897712fe5a9e17",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-2-serial-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-read-pair-v1/round-2-parallel/receipt.json

Original bytes: 21479. SHA-256: `420440bd60b3a84a8341410dc3b6dd2483403bd5a8ba535b0d79961e03508fd2`.

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
  "committed_decode_tokens_per_second" : 4.2780212581980113,
  "committed_tokens" : 128,
  "emission_seconds" : [
    3.4169932910008356,
    4.0624616249988321,
    4.3230477909964975,
    4.5751575409958605,
    4.8174385409802198,
    5.0642454999906477,
    5.3099724159983452,
    5.5601182909740601,
    5.8014381249959115,
    6.048963332985295,
    6.2884596249787137,
    6.5347042909997981,
    6.7702294579939917,
    7.0010029159893747,
    7.2248707079852466,
    7.4777809160004836,
    7.7271488329861313,
    7.944639332999941,
    8.1888684159785043,
    8.426111332984874,
    8.6677752909890842,
    8.9107800829806365,
    9.1488469999749213,
    9.3830197499773931,
    9.6321644159907009,
    9.8734832079790067,
    10.112396874988917,
    10.35542212499422,
    10.594658374990104,
    10.85282016597921,
    11.101607832999434,
    11.34277716599172,
    11.59224758297205,
    11.828560415975517,
    12.056476165977074,
    12.283251916000154,
    12.511311915994156,
    12.727351374982391,
    12.941938582982402,
    13.166002457990544,
    13.407683665980585,
    13.654348165990086,
    13.891938457993092,
    14.130531124974368,
    14.380697290995158,
    14.629489332990488,
    14.858576250000624,
    15.094488082977477,
    15.338512040994829,
    15.574543582974002,
    15.809956915996736,
    16.034823457972379,
    16.245016374974512,
    16.471739582979353,
    16.713746040972183,
    16.940674624987878,
    17.150151332985843,
    17.388865415996406,
    17.625842832989292,
    17.86245833299472,
    18.087374665978132,
    18.308035832975293,
    18.531057790998602,
    18.738288749998901,
    18.964398707990767,
    19.190753165981732,
    19.407352207985241,
    19.641127332986798,
    19.868369790987344,
    20.11449037498096,
    20.336059290973935,
    20.549121999996714,
    20.765306582994526,
    21.011959082999965,
    21.244800832995679,
    21.484175749996211,
    21.713662832975388,
    21.947199874994112,
    22.164580040989676,
    22.441562290972797,
    22.677413165976759,
    22.895378957997309,
    23.109168332972331,
    23.352060457982589,
    23.554487124987645,
    23.767492999992101,
    24.007191374985268,
    24.236153999983799,
    24.477258874976542,
    24.71501200000057,
    24.949353624979267,
    25.17808108299505,
    25.405173290986568,
    25.638977582973894,
    25.87715037498856,
    26.104477249988122,
    26.336326040996937,
    26.544745957973646,
    26.773763415985741,
    26.988749207986984,
    27.207352832978358,
    27.42362629098352,
    27.615685207973002,
    27.82891266598017,
    28.048839874973055,
    28.261630665976554,
    28.473137249995489,
    28.666975707979873,
    28.876453582983231,
    29.07704779098276,
    29.299390332977055,
    29.514992999989772,
    29.750837332976516,
    29.997983957990073,
    30.230396582977846,
    30.435640790994512,
    30.675358999986202,
    30.915074999997159,
    31.119754540995928,
    31.35369991598418,
    31.560060666000936,
    31.783931665995624,
    32.008835915999953,
    32.209343249996891,
    32.426827624993166,
    32.651172582991421,
    32.890278790990124,
    33.103615290980088
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
    "reclaimableBytes" : 17929601024,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.64546833399799652,
    0.26058616599766538,
    0.25210974999936298,
    0.24228099998435937,
    0.24680695901042782,
    0.24572691600769758,
    0.25014587497571483,
    0.24131983402185142,
    0.24752520798938349,
    0.23949629199341871,
    0.24624466602108441,
    0.23552516699419357,
    0.23077345799538307,
    0.22386779199587181,
    0.252910208015237,
    0.24936791698564775,
    0.21749050001380965,
    0.24422908297856338,
    0.23724291700636968,
    0.24166395800421014,
    0.24300479199155234,
    0.23806691699428484,
    0.23417275000247173,
    0.24914466601330787,
    0.24131879198830575,
    0.23891366700991057,
    0.24302525000530295,
    0.23923624999588355,
    0.25816179098910652,
    0.24878766702022403,
    0.24116933299228549,
    0.2494704169803299,
    0.23631283300346695,
    0.22791575000155717,
    0.22677575002308004,
    0.22805999999400228,
    0.2160394589882344,
    0.21458720800001174,
    0.22406387500814162,
    0.241681207990041,
    0.24666450000950135,
    0.23759029200300574,
    0.23859266698127612,
    0.25016616602079011,
    0.24879204199532978,
    0.22908691701013595,
    0.23591183297685347,
    0.24402395801735111,
    0.2360315419791732,
    0.23541333302273415,
    0.22486654197564349,
    0.21019291700213216,
    0.22672320800484158,
    0.24200645799282938,
    0.22692858401569538,
    0.2094767079979647,
    0.23871408301056363,
    0.23697741699288599,
    0.23661550000542775,
    0.22491633298341185,
    0.22066116699716076,
    0.22302195802330971,
    0.20723095900029875,
    0.22610995799186639,
    0.22635445799096487,
    0.21659904200350866,
    0.23377512500155717,
    0.22724245800054632,
    0.24612058399361558,
    0.22156891599297523,
    0.21306270902277902,
    0.21618458299781196,
    0.24665250000543892,
    0.23284174999571405,
    0.23937491700053215,
    0.22948708297917619,
    0.23353704201872461,
    0.21738016599556431,
    0.27698224998312071,
    0.23585087500396185,
    0.21796579202055,
    0.21378937497502193,
    0.24289212501025759,
    0.20242666700505652,
    0.21300587500445545,
    0.23969837499316782,
    0.22896262499853037,
    0.24110487499274313,
    0.23775312502402812,
    0.23434162497869693,
    0.22872745801578276,
    0.22709220799151808,
    0.233804291987326,
    0.2381727920146659,
    0.22732687499956228,
    0.23184879100881517,
    0.20841991697670892,
    0.22901745801209472,
    0.21498579200124368,
    0.21860362499137409,
    0.21627345800516196,
    0.19205891698948108,
    0.21322745800716802,
    0.21992720899288543,
    0.21279079100349918,
    0.21150658401893452,
    0.19383845798438415,
    0.20947787500335835,
    0.20059420799952932,
    0.22234254199429415,
    0.21560266701271757,
    0.23584433298674412,
    0.24714662501355633,
    0.2324126249877736,
    0.20524420801666565,
    0.23971820899168961,
    0.23971600001095794,
    0.20467954099876806,
    0.2339453749882523,
    0.20636075001675636,
    0.22387099999468774,
    0.22490425000432879,
    0.20050733399693854,
    0.21748437499627471,
    0.22434495799825527,
    0.2391062079987023,
    0.21333649998996407
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 29.179190499999095,
  "metadata_seconds" : 0.11847350001335144,
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
  "peak_process_bytes" : 8041257104,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 33.103635499981465,
  "request_vm_after" : {
    "reclaimableBytes" : 17728389120,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18604539904,
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
  "ttft_seconds" : 3.4169932910008356,
  "validation_receipt_sha256" : "5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-2-parallel-supervision/identity.json

Original bytes: 2927. SHA-256: `2f944bb2fbd8cd070ec1e44a7b55163d04e3713a4a91ca8238d2ec5feb8824b1`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/performance-pilot-v2.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/round-2-parallel",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-parallel/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24882610176,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   475141.\nPages active:                                 843682.\nPages inactive:                               857722.\nPages speculative:                             54257.\nPages throttled:                                   0.\nPages wired down:                             178032.\nPages purgeable:                                 377.\n\"Translation faults\":                     1492946134.\nPages copy-on-write:                        76903500.\nPages zero filled:                        2380421570.\nPages reactivated:                          96850395.\nPages purged:                               11294865.\nFile-backed pages:                           1043196.\nAnonymous pages:                              712465.\nPages stored in compressor:                  1255655.\nPages occupied by compressor:                 675446.\nDecompressions:                             45412433.\nCompressions:                               56017716.\nPageins:                                  1135003250.\nPageouts:                                     373189.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127419.\nPages tagged resident:                         84477.\nPages tagged compressed:                       42942.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5201.\nPages tag-storage free:                          894.\nPages tag-storage non-tag pageable:            92201.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6462144.\nTagged compressions:                          497888.\nTagged decompressions:                        404750.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-read-pair-v1/round-2-parallel-supervision/receipt.json

Original bytes: 2140. SHA-256: `f7bad88e1e3479c0e909a13a384021723bf10e8d820d36ed0a05eebfe36206e5`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 8041257104,
  "samples": 1067,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24781553664,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   485959.\nPages active:                                 855658.\nPages inactive:                               845653.\nPages speculative:                             54451.\nPages throttled:                                   0.\nPages wired down:                             178003.\nPages purgeable:                                 597.\n\"Translation faults\":                     1493724138.\nPages copy-on-write:                        76917112.\nPages zero filled:                        2384261766.\nPages reactivated:                          96905621.\nPages purged:                               11297927.\nFile-backed pages:                           1025990.\nAnonymous pages:                              729772.\nPages stored in compressor:                  1236390.\nPages occupied by compressor:                 664456.\nDecompressions:                             45968341.\nCompressions:                               56582880.\nPageins:                                  1140368680.\nPageouts:                                     373548.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 128143.\nPages tagged resident:                         85021.\nPages tagged compressed:                       43122.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1542.\nPages tag-storage non-tag pageable:            91554.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6500544.\nTagged compressions:                          498170.\nTagged decompressions:                        404847.\n"
  },
  "seconds": 62.53970487500192
}
````

### vq-read-pair-v1/round-2-parallel-supervision/stdout.txt

Original bytes: 21480. SHA-256: `c271b3416f31e31bb89e8ccfe329fc5bb26f2576a066d8aa0c9716e50924480e`.

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
  "committed_decode_tokens_per_second" : 4.2780212581980113,
  "committed_tokens" : 128,
  "emission_seconds" : [
    3.4169932910008356,
    4.0624616249988321,
    4.3230477909964975,
    4.5751575409958605,
    4.8174385409802198,
    5.0642454999906477,
    5.3099724159983452,
    5.5601182909740601,
    5.8014381249959115,
    6.048963332985295,
    6.2884596249787137,
    6.5347042909997981,
    6.7702294579939917,
    7.0010029159893747,
    7.2248707079852466,
    7.4777809160004836,
    7.7271488329861313,
    7.944639332999941,
    8.1888684159785043,
    8.426111332984874,
    8.6677752909890842,
    8.9107800829806365,
    9.1488469999749213,
    9.3830197499773931,
    9.6321644159907009,
    9.8734832079790067,
    10.112396874988917,
    10.35542212499422,
    10.594658374990104,
    10.85282016597921,
    11.101607832999434,
    11.34277716599172,
    11.59224758297205,
    11.828560415975517,
    12.056476165977074,
    12.283251916000154,
    12.511311915994156,
    12.727351374982391,
    12.941938582982402,
    13.166002457990544,
    13.407683665980585,
    13.654348165990086,
    13.891938457993092,
    14.130531124974368,
    14.380697290995158,
    14.629489332990488,
    14.858576250000624,
    15.094488082977477,
    15.338512040994829,
    15.574543582974002,
    15.809956915996736,
    16.034823457972379,
    16.245016374974512,
    16.471739582979353,
    16.713746040972183,
    16.940674624987878,
    17.150151332985843,
    17.388865415996406,
    17.625842832989292,
    17.86245833299472,
    18.087374665978132,
    18.308035832975293,
    18.531057790998602,
    18.738288749998901,
    18.964398707990767,
    19.190753165981732,
    19.407352207985241,
    19.641127332986798,
    19.868369790987344,
    20.11449037498096,
    20.336059290973935,
    20.549121999996714,
    20.765306582994526,
    21.011959082999965,
    21.244800832995679,
    21.484175749996211,
    21.713662832975388,
    21.947199874994112,
    22.164580040989676,
    22.441562290972797,
    22.677413165976759,
    22.895378957997309,
    23.109168332972331,
    23.352060457982589,
    23.554487124987645,
    23.767492999992101,
    24.007191374985268,
    24.236153999983799,
    24.477258874976542,
    24.71501200000057,
    24.949353624979267,
    25.17808108299505,
    25.405173290986568,
    25.638977582973894,
    25.87715037498856,
    26.104477249988122,
    26.336326040996937,
    26.544745957973646,
    26.773763415985741,
    26.988749207986984,
    27.207352832978358,
    27.42362629098352,
    27.615685207973002,
    27.82891266598017,
    28.048839874973055,
    28.261630665976554,
    28.473137249995489,
    28.666975707979873,
    28.876453582983231,
    29.07704779098276,
    29.299390332977055,
    29.514992999989772,
    29.750837332976516,
    29.997983957990073,
    30.230396582977846,
    30.435640790994512,
    30.675358999986202,
    30.915074999997159,
    31.119754540995928,
    31.35369991598418,
    31.560060666000936,
    31.783931665995624,
    32.008835915999953,
    32.209343249996891,
    32.426827624993166,
    32.651172582991421,
    32.890278790990124,
    33.103615290980088
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
    "reclaimableBytes" : 17929601024,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.64546833399799652,
    0.26058616599766538,
    0.25210974999936298,
    0.24228099998435937,
    0.24680695901042782,
    0.24572691600769758,
    0.25014587497571483,
    0.24131983402185142,
    0.24752520798938349,
    0.23949629199341871,
    0.24624466602108441,
    0.23552516699419357,
    0.23077345799538307,
    0.22386779199587181,
    0.252910208015237,
    0.24936791698564775,
    0.21749050001380965,
    0.24422908297856338,
    0.23724291700636968,
    0.24166395800421014,
    0.24300479199155234,
    0.23806691699428484,
    0.23417275000247173,
    0.24914466601330787,
    0.24131879198830575,
    0.23891366700991057,
    0.24302525000530295,
    0.23923624999588355,
    0.25816179098910652,
    0.24878766702022403,
    0.24116933299228549,
    0.2494704169803299,
    0.23631283300346695,
    0.22791575000155717,
    0.22677575002308004,
    0.22805999999400228,
    0.2160394589882344,
    0.21458720800001174,
    0.22406387500814162,
    0.241681207990041,
    0.24666450000950135,
    0.23759029200300574,
    0.23859266698127612,
    0.25016616602079011,
    0.24879204199532978,
    0.22908691701013595,
    0.23591183297685347,
    0.24402395801735111,
    0.2360315419791732,
    0.23541333302273415,
    0.22486654197564349,
    0.21019291700213216,
    0.22672320800484158,
    0.24200645799282938,
    0.22692858401569538,
    0.2094767079979647,
    0.23871408301056363,
    0.23697741699288599,
    0.23661550000542775,
    0.22491633298341185,
    0.22066116699716076,
    0.22302195802330971,
    0.20723095900029875,
    0.22610995799186639,
    0.22635445799096487,
    0.21659904200350866,
    0.23377512500155717,
    0.22724245800054632,
    0.24612058399361558,
    0.22156891599297523,
    0.21306270902277902,
    0.21618458299781196,
    0.24665250000543892,
    0.23284174999571405,
    0.23937491700053215,
    0.22948708297917619,
    0.23353704201872461,
    0.21738016599556431,
    0.27698224998312071,
    0.23585087500396185,
    0.21796579202055,
    0.21378937497502193,
    0.24289212501025759,
    0.20242666700505652,
    0.21300587500445545,
    0.23969837499316782,
    0.22896262499853037,
    0.24110487499274313,
    0.23775312502402812,
    0.23434162497869693,
    0.22872745801578276,
    0.22709220799151808,
    0.233804291987326,
    0.2381727920146659,
    0.22732687499956228,
    0.23184879100881517,
    0.20841991697670892,
    0.22901745801209472,
    0.21498579200124368,
    0.21860362499137409,
    0.21627345800516196,
    0.19205891698948108,
    0.21322745800716802,
    0.21992720899288543,
    0.21279079100349918,
    0.21150658401893452,
    0.19383845798438415,
    0.20947787500335835,
    0.20059420799952932,
    0.22234254199429415,
    0.21560266701271757,
    0.23584433298674412,
    0.24714662501355633,
    0.2324126249877736,
    0.20524420801666565,
    0.23971820899168961,
    0.23971600001095794,
    0.20467954099876806,
    0.2339453749882523,
    0.20636075001675636,
    0.22387099999468774,
    0.22490425000432879,
    0.20050733399693854,
    0.21748437499627471,
    0.22434495799825527,
    0.2391062079987023,
    0.21333649998996407
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 29.179190499999095,
  "metadata_seconds" : 0.11847350001335144,
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
  "peak_process_bytes" : 8041257104,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 33.103635499981465,
  "request_vm_after" : {
    "reclaimableBytes" : 17728389120,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18604539904,
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
  "ttft_seconds" : 3.4169932910008356,
  "validation_receipt_sha256" : "5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-2-parallel-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-read-pair-v1/round-3-serial/receipt.json

Original bytes: 21453. SHA-256: `6fbc9e1d29c84353ece06d2ca464f622b60c1611a52d6581e037dac28bcd1023`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 48625,
    "hits" : 18790,
    "loads" : 49233,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "parallel_read_lanes" : 0,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 0,
    "total_capacity" : 608
  },
  "committed_decode_tokens_per_second" : 3.0836054017856114,
  "committed_tokens" : 128,
  "emission_seconds" : [
    9.2568148749996908,
    10.33923362501082,
    10.847963041014737,
    11.312222958018538,
    11.714342749997741,
    12.148402958002407,
    12.541523040999891,
    12.971332540997537,
    13.369189375021961,
    13.807504291005898,
    14.177447875001235,
    14.606906583008822,
    14.957390916009899,
    15.297803207999095,
    15.585076916002436,
    16.028702375013381,
    16.394769500009716,
    16.657123833021615,
    17.016940875008004,
    17.347367625014158,
    17.732561041018926,
    18.11853004101431,
    18.429914291016757,
    18.773801916016964,
    19.217138583015185,
    19.653293083014432,
    19.99334645800991,
    20.361990958015667,
    20.701698125019902,
    21.183503625012236,
    21.591586666007061,
    21.931047500023851,
    22.361650458013173,
    22.683030208019773,
    22.98469800001476,
    23.273798916023225,
    23.562861500016879,
    23.849221833021147,
    24.103652250021696,
    24.37991712501389,
    24.74387166602537,
    25.093275541003095,
    25.448401000001468,
    25.778051291010343,
    26.18220104102511,
    26.565368583018426,
    26.881348041002639,
    27.231645332998596,
    27.5688005410193,
    27.920357374998275,
    28.260100333020091,
    28.552714290999575,
    28.8189674160094,
    29.115799625025829,
    29.488080083014211,
    29.775111458002357,
    30.016419541003415,
    30.35892845800845,
    30.697396875009872,
    31.01798816601513,
    31.305313375021797,
    31.592812583025079,
    31.880268166016322,
    32.135685665998608,
    32.433268749999115,
    32.731174665997969,
    32.980148791015381,
    33.317446041008225,
    33.598632708017249,
    33.910082916001556,
    34.185858666023705,
    34.443414250010392,
    34.720336166006746,
    35.049843958026031,
    35.386554916010937,
    35.712637541000731,
    36.008341125008883,
    36.316107165999711,
    36.581472457997734,
    36.873355000017909,
    37.184483625023859,
    37.465341958013596,
    37.740165541006718,
    38.083861416002037,
    38.325967500015395,
    38.577659041009611,
    38.916730333003215,
    39.223411000013584,
    39.561191916000098,
    39.877130250009941,
    40.200305166014004,
    40.494587958004558,
    40.771327750000637,
    41.081743665999966,
    41.395768625021446,
    41.677972375007812,
    41.990026250015944,
    42.244031291018473,
    42.532304041000316,
    42.790058958024019,
    43.064290500013158,
    43.315321041009156,
    43.54087941601756,
    43.80115233300603,
    44.08831645801547,
    44.34119441601797,
    44.606437625014223,
    44.841978125012247,
    45.084993958007544,
    45.339171375002479,
    45.620335000014165,
    45.88734212500276,
    46.189790500007803,
    46.527361915999791,
    46.842376041022362,
    47.082820291019743,
    47.400946166017093,
    47.68672745799995,
    47.92805208300706,
    48.235437583003659,
    48.485257916006958,
    48.766582416021265,
    49.069664041016949,
    49.31194141600281,
    49.58585650002351,
    49.851268375001382,
    50.179386375006288,
    50.442369916010648
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
    "reclaimableBytes" : 17956700160,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    1.0824187500111293,
    0.50872941600391641,
    0.46425991700380109,
    0.402119791979203,
    0.43406020800466649,
    0.39312008299748413,
    0.42980949999764562,
    0.39785683402442373,
    0.43831491598393768,
    0.36994358399533667,
    0.42945870800758712,
    0.35048433300107718,
    0.34041229198919609,
    0.28727370800334029,
    0.44362545901094563,
    0.36606712499633431,
    0.26235433301189914,
    0.35981704198638909,
    0.33042675000615418,
    0.38519341600476764,
    0.38596899999538437,
    0.31138425000244752,
    0.34388762500020675,
    0.44333666699822061,
    0.43615449999924749,
    0.3400533749954775,
    0.36864450000575744,
    0.33970716700423509,
    0.48180549999233335,
    0.40808304099482484,
    0.33946083401679061,
    0.43060295798932202,
    0.32137975000659935,
    0.30166779199498706,
    0.28910091600846499,
    0.2890625839936547,
    0.28636033300426789,
    0.25443041700054891,
    0.27626487499219365,
    0.36395454101148061,
    0.34940387497772463,
    0.35512545899837278,
    0.32965029100887477,
    0.40414975001476705,
    0.38316754199331626,
    0.31597945798421279,
    0.35029729199595749,
    0.33715520802070387,
    0.35155683397897519,
    0.33974295802181587,
    0.29261395797948353,
    0.26625312500982545,
    0.29683220901642926,
    0.37228045798838139,
    0.28703137498814613,
    0.24130808300105855,
    0.34250891700503416,
    0.33846841700142249,
    0.32059129100525752,
    0.28732520900666714,
    0.28749920800328255,
    0.28745558299124241,
    0.25541749998228624,
    0.29758308400050737,
    0.29790591599885374,
    0.24897412501741201,
    0.33729724999284372,
    0.28118666700902395,
    0.31145020798430778,
    0.27577575002214871,
    0.25755558398668654,
    0.27692191599635407,
    0.32950779201928526,
    0.33671095798490569,
    0.32608262498979457,
    0.29570358400815167,
    0.30776604099082761,
    0.26536529199802317,
    0.29188254202017561,
    0.31112862500594929,
    0.28085833298973739,
    0.27482358299312182,
    0.34369587499531917,
    0.24210608401335776,
    0.25169154099421576,
    0.33907129199360497,
    0.30668066701036878,
    0.33778091598651372,
    0.31593833400984295,
    0.32317491600406356,
    0.29428279199055396,
    0.27673979199607857,
    0.31041591599932872,
    0.31402495902148075,
    0.28220374998636544,
    0.31205387500813231,
    0.25400504100252874,
    0.28827274998184294,
    0.25775491702370346,
    0.27423154198913835,
    0.25103054099599831,
    0.22555837500840425,
    0.26027291698846966,
    0.28716412500943989,
    0.25287795800250024,
    0.26524320899625309,
    0.23554049999802373,
    0.24301583299529739,
    0.2541774169949349,
    0.28116362501168624,
    0.26700712498859502,
    0.30244837500504218,
    0.33757141599198803,
    0.31501412502257153,
    0.24044424999738112,
    0.31812587499734946,
    0.28578129198285751,
    0.24132462500710972,
    0.30738549999659881,
    0.24982033300329931,
    0.28132450001430698,
    0.30308162499568425,
    0.24227737498586066,
    0.27391508402070031,
    0.26541187497787178,
    0.32811800000490621,
    0.26298354100435972
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 29.094485333014745,
  "metadata_seconds" : 0.11787558399373665,
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
  "peak_mlx_bytes" : 6782306832,
  "peak_process_bytes" : 7875385416,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-performance-pilot-v1",
  "profile_sha256" : "8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5",
  "qualification" : "unproven",
  "request_seconds" : 50.442389791016467,
  "request_vm_after" : {
    "reclaimableBytes" : 17787551744,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18611945472,
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
  "ttft_seconds" : 9.2568148749996908,
  "validation_receipt_sha256" : "0f07363316d910373ff5e8fc9379f9f32d655bda6b7c8128a5897712fe5a9e17",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-3-serial-supervision/identity.json

Original bytes: 2923. SHA-256: `a62cd4111090f2bdb26abc6b6d5705ce9ed1da935c4381a73b7d1b9b9bec2dd6`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/performance-pilot-v1.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/round-3-serial",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-serial/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24905596928,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   464455.\nPages active:                                 844857.\nPages inactive:                               880157.\nPages speculative:                             49112.\nPages throttled:                                   0.\nPages wired down:                             178923.\nPages purgeable:                                 986.\n\"Translation faults\":                     1494526186.\nPages copy-on-write:                        76951766.\nPages zero filled:                        2388098166.\nPages reactivated:                          96948137.\nPages purged:                               11301845.\nFile-backed pages:                           1054676.\nAnonymous pages:                              719450.\nPages stored in compressor:                  1243804.\nPages occupied by compressor:                 666697.\nDecompressions:                             46525986.\nCompressions:                               57176358.\nPageins:                                  1145742523.\nPageouts:                                     373966.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127463.\nPages tagged resident:                         83689.\nPages tagged compressed:                       43774.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1566.\nPages tag-storage non-tag pageable:            91530.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6629504.\nTagged compressions:                          500466.\nTagged decompressions:                        405754.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-read-pair-v1/round-3-serial-supervision/receipt.json

Original bytes: 2140. SHA-256: `64cd37d7b8b7926effda416c1f378820e1aab0c1827ebfb5ff38b694490066d9`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7875385416,
  "samples": 1353,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24778981376,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   475450.\nPages active:                                 867578.\nPages inactive:                               856358.\nPages speculative:                             49770.\nPages throttled:                                   0.\nPages wired down:                             177786.\nPages purgeable:                                 828.\n\"Translation faults\":                     1495271303.\nPages copy-on-write:                        76967220.\nPages zero filled:                        2391914403.\nPages reactivated:                          96994782.\nPages purged:                               11303510.\nFile-backed pages:                           1036111.\nAnonymous pages:                              737595.\nPages stored in compressor:                  1226991.\nPages occupied by compressor:                 656636.\nDecompressions:                             47113217.\nCompressions:                               57773574.\nPageins:                                  1151087802.\nPageouts:                                     374318.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127224.\nPages tagged resident:                         81281.\nPages tagged compressed:                       45943.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1623.\nPages tag-storage non-tag pageable:            91473.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    7073472.\nTagged compressions:                          502758.\nTagged decompressions:                        405820.\n"
  },
  "seconds": 79.83209508299478
}
````

### vq-read-pair-v1/round-3-serial-supervision/stdout.txt

Original bytes: 21454. SHA-256: `eb861fd571fc5b57d4c680787cb007774d86562a221876697d6dfca799828714`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "evictions" : 48625,
    "hits" : 18790,
    "loads" : 49233,
    "maximum_bank_capacity" : 512,
    "maximum_book_bytes" : 2082816,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 96,
    "occupied_records" : 608,
    "parallel_read_lanes" : 0,
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
    "parallel_read_lanes" : 0,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 1194393600,
    "resident_book_bytes" : 0,
    "total_capacity" : 608
  },
  "committed_decode_tokens_per_second" : 3.0836054017856114,
  "committed_tokens" : 128,
  "emission_seconds" : [
    9.2568148749996908,
    10.33923362501082,
    10.847963041014737,
    11.312222958018538,
    11.714342749997741,
    12.148402958002407,
    12.541523040999891,
    12.971332540997537,
    13.369189375021961,
    13.807504291005898,
    14.177447875001235,
    14.606906583008822,
    14.957390916009899,
    15.297803207999095,
    15.585076916002436,
    16.028702375013381,
    16.394769500009716,
    16.657123833021615,
    17.016940875008004,
    17.347367625014158,
    17.732561041018926,
    18.11853004101431,
    18.429914291016757,
    18.773801916016964,
    19.217138583015185,
    19.653293083014432,
    19.99334645800991,
    20.361990958015667,
    20.701698125019902,
    21.183503625012236,
    21.591586666007061,
    21.931047500023851,
    22.361650458013173,
    22.683030208019773,
    22.98469800001476,
    23.273798916023225,
    23.562861500016879,
    23.849221833021147,
    24.103652250021696,
    24.37991712501389,
    24.74387166602537,
    25.093275541003095,
    25.448401000001468,
    25.778051291010343,
    26.18220104102511,
    26.565368583018426,
    26.881348041002639,
    27.231645332998596,
    27.5688005410193,
    27.920357374998275,
    28.260100333020091,
    28.552714290999575,
    28.8189674160094,
    29.115799625025829,
    29.488080083014211,
    29.775111458002357,
    30.016419541003415,
    30.35892845800845,
    30.697396875009872,
    31.01798816601513,
    31.305313375021797,
    31.592812583025079,
    31.880268166016322,
    32.135685665998608,
    32.433268749999115,
    32.731174665997969,
    32.980148791015381,
    33.317446041008225,
    33.598632708017249,
    33.910082916001556,
    34.185858666023705,
    34.443414250010392,
    34.720336166006746,
    35.049843958026031,
    35.386554916010937,
    35.712637541000731,
    36.008341125008883,
    36.316107165999711,
    36.581472457997734,
    36.873355000017909,
    37.184483625023859,
    37.465341958013596,
    37.740165541006718,
    38.083861416002037,
    38.325967500015395,
    38.577659041009611,
    38.916730333003215,
    39.223411000013584,
    39.561191916000098,
    39.877130250009941,
    40.200305166014004,
    40.494587958004558,
    40.771327750000637,
    41.081743665999966,
    41.395768625021446,
    41.677972375007812,
    41.990026250015944,
    42.244031291018473,
    42.532304041000316,
    42.790058958024019,
    43.064290500013158,
    43.315321041009156,
    43.54087941601756,
    43.80115233300603,
    44.08831645801547,
    44.34119441601797,
    44.606437625014223,
    44.841978125012247,
    45.084993958007544,
    45.339171375002479,
    45.620335000014165,
    45.88734212500276,
    46.189790500007803,
    46.527361915999791,
    46.842376041022362,
    47.082820291019743,
    47.400946166017093,
    47.68672745799995,
    47.92805208300706,
    48.235437583003659,
    48.485257916006958,
    48.766582416021265,
    49.069664041016949,
    49.31194141600281,
    49.58585650002351,
    49.851268375001382,
    50.179386375006288,
    50.442369916010648
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
    "reclaimableBytes" : 17956700160,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    1.0824187500111293,
    0.50872941600391641,
    0.46425991700380109,
    0.402119791979203,
    0.43406020800466649,
    0.39312008299748413,
    0.42980949999764562,
    0.39785683402442373,
    0.43831491598393768,
    0.36994358399533667,
    0.42945870800758712,
    0.35048433300107718,
    0.34041229198919609,
    0.28727370800334029,
    0.44362545901094563,
    0.36606712499633431,
    0.26235433301189914,
    0.35981704198638909,
    0.33042675000615418,
    0.38519341600476764,
    0.38596899999538437,
    0.31138425000244752,
    0.34388762500020675,
    0.44333666699822061,
    0.43615449999924749,
    0.3400533749954775,
    0.36864450000575744,
    0.33970716700423509,
    0.48180549999233335,
    0.40808304099482484,
    0.33946083401679061,
    0.43060295798932202,
    0.32137975000659935,
    0.30166779199498706,
    0.28910091600846499,
    0.2890625839936547,
    0.28636033300426789,
    0.25443041700054891,
    0.27626487499219365,
    0.36395454101148061,
    0.34940387497772463,
    0.35512545899837278,
    0.32965029100887477,
    0.40414975001476705,
    0.38316754199331626,
    0.31597945798421279,
    0.35029729199595749,
    0.33715520802070387,
    0.35155683397897519,
    0.33974295802181587,
    0.29261395797948353,
    0.26625312500982545,
    0.29683220901642926,
    0.37228045798838139,
    0.28703137498814613,
    0.24130808300105855,
    0.34250891700503416,
    0.33846841700142249,
    0.32059129100525752,
    0.28732520900666714,
    0.28749920800328255,
    0.28745558299124241,
    0.25541749998228624,
    0.29758308400050737,
    0.29790591599885374,
    0.24897412501741201,
    0.33729724999284372,
    0.28118666700902395,
    0.31145020798430778,
    0.27577575002214871,
    0.25755558398668654,
    0.27692191599635407,
    0.32950779201928526,
    0.33671095798490569,
    0.32608262498979457,
    0.29570358400815167,
    0.30776604099082761,
    0.26536529199802317,
    0.29188254202017561,
    0.31112862500594929,
    0.28085833298973739,
    0.27482358299312182,
    0.34369587499531917,
    0.24210608401335776,
    0.25169154099421576,
    0.33907129199360497,
    0.30668066701036878,
    0.33778091598651372,
    0.31593833400984295,
    0.32317491600406356,
    0.29428279199055396,
    0.27673979199607857,
    0.31041591599932872,
    0.31402495902148075,
    0.28220374998636544,
    0.31205387500813231,
    0.25400504100252874,
    0.28827274998184294,
    0.25775491702370346,
    0.27423154198913835,
    0.25103054099599831,
    0.22555837500840425,
    0.26027291698846966,
    0.28716412500943989,
    0.25287795800250024,
    0.26524320899625309,
    0.23554049999802373,
    0.24301583299529739,
    0.2541774169949349,
    0.28116362501168624,
    0.26700712498859502,
    0.30244837500504218,
    0.33757141599198803,
    0.31501412502257153,
    0.24044424999738112,
    0.31812587499734946,
    0.28578129198285751,
    0.24132462500710972,
    0.30738549999659881,
    0.24982033300329931,
    0.28132450001430698,
    0.30308162499568425,
    0.24227737498586066,
    0.27391508402070031,
    0.26541187497787178,
    0.32811800000490621,
    0.26298354100435972
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 29.094485333014745,
  "metadata_seconds" : 0.11787558399373665,
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
  "peak_mlx_bytes" : 6782306832,
  "peak_process_bytes" : 7875385416,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-performance-pilot-v1",
  "profile_sha256" : "8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5",
  "qualification" : "unproven",
  "request_seconds" : 50.442389791016467,
  "request_vm_after" : {
    "reclaimableBytes" : 17787551744,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 18611945472,
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
  "ttft_seconds" : 9.2568148749996908,
  "validation_receipt_sha256" : "0f07363316d910373ff5e8fc9379f9f32d655bda6b7c8128a5897712fe5a9e17",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-3-serial-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-read-pair-v1/round-3-parallel/receipt.json

Original bytes: 21490. SHA-256: `27bfeedbe7e66d9085d936e8771ea9e70120b2d78587065b1edd7d9efd858f3a`.

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
  "committed_decode_tokens_per_second" : 4.2850604644405115,
  "committed_tokens" : 128,
  "emission_seconds" : [
    3.5605475000047591,
    4.242845667002257,
    4.5024548340006731,
    4.7566618749988265,
    4.9970847500080708,
    5.2462920420221053,
    5.4914412920188624,
    5.7395497920224443,
    5.9799299169972073,
    6.2278112500207499,
    6.4694267090235371,
    6.7153515420213807,
    6.951933584001381,
    7.1822260420012753,
    7.4069582090014592,
    7.6611352500040084,
    7.9081398340058513,
    8.1218218340072781,
    8.3629595000238623,
    8.598321167024551,
    8.8387455000192858,
    9.0814515000092797,
    9.318622167018475,
    9.5511345000122674,
    9.8006575420149602,
    10.043324541999027,
    10.28432587502175,
    10.530055084003834,
    10.769672791997436,
    11.027363875007723,
    11.27703645901056,
    11.522168791998411,
    11.771813750005094,
    12.005874459020561,
    12.233504875010112,
    12.458953125023982,
    12.687537000019802,
    12.902967084024567,
    13.11445854199701,
    13.338982042012503,
    13.583036625001114,
    13.831271333998302,
    14.065762500016717,
    14.303689125023084,
    14.555649792018812,
    14.802531042019837,
    15.032073167007184,
    15.268265625025379,
    15.510958958999254,
    15.748060250014532,
    15.986555625015171,
    16.211551250016782,
    16.424766167008784,
    16.653800833999412,
    16.897171875025379,
    17.123642917023972,
    17.334880084003089,
    17.574829667020822,
    17.811697791999904,
    18.050818000017898,
    18.274889375024941,
    18.490044917009072,
    18.70955920900451,
    18.915816334018018,
    19.141341250011465,
    19.366957667021779,
    19.575105124997208,
    19.809838375018444,
    20.031538292008918,
    20.269684209022671,
    20.488829125009943,
    20.700901375006652,
    20.917643459019018,
    21.160775666998234,
    21.394549709017156,
    21.631919959007064,
    21.859741749998648,
    22.09377529201447,
    22.311577500018757,
    22.541786459012656,
    22.775883084017551,
    22.994230667012744,
    23.208954750007251,
    23.496467709017452,
    23.702385625016177,
    23.915424875012832,
    24.154368584015174,
    24.382382500014501,
    24.624154917022679,
    24.860640875005629,
    25.094727084011538,
    25.327810750022763,
    25.553028374997666,
    25.787436209007865,
    26.026182333996985,
    26.254464124998776,
    26.486562375008361,
    26.695420667005237,
    26.924406334001105,
    27.136296292010229,
    27.354723625001498,
    27.569565792015055,
    27.760794875008287,
    27.974070334021235,
    28.193591084011132,
    28.406393292010762,
    28.619383209006628,
    28.813640042004408,
    29.023551792022772,
    29.224594750005053,
    29.445781542017357,
    29.661397750023752,
    29.888835917023243,
    30.131703209015541,
    30.359743584005628,
    30.565400459017837,
    30.800218500022311,
    31.029123292013537,
    31.234008500003256,
    31.464779333997285,
    31.67019341699779,
    31.891428417002317,
    32.109543209022377,
    32.306728042021859,
    32.522170292009832,
    32.745504834019812,
    32.98473212501267,
    33.198402334004641
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
    "reclaimableBytes" : 25368903680,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.6822981669974979,
    0.25960916699841619,
    0.25420704099815339,
    0.24042287500924431,
    0.24920729201403446,
    0.24514924999675713,
    0.24810850000358187,
    0.24038012497476302,
    0.24788133302354254,
    0.24161545900278725,
    0.24592483299784362,
    0.23658204198000021,
    0.2302924579998944,
    0.22473216700018384,
    0.25417704100254923,
    0.24700458400184289,
    0.21368200000142679,
    0.24113766601658426,
    0.23536166700068861,
    0.24042433299473487,
    0.24270599998999387,
    0.23717066700919531,
    0.23251233299379237,
    0.24952304200269282,
    0.24266699998406693,
    0.24100133302272297,
    0.24572920898208395,
    0.23961770799360238,
    0.25769108301028609,
    0.24967258400283754,
    0.24513233298785053,
    0.24964495800668374,
    0.23406070901546627,
    0.22763041598955169,
    0.22544825001386926,
    0.22858387499582022,
    0.21543008400476538,
    0.21149145797244273,
    0.22452350001549348,
    0.24405458298861049,
    0.24823470899718814,
    0.23449116601841524,
    0.23792662500636652,
    0.25196066699572839,
    0.24688125000102445,
    0.22954212498734705,
    0.23619245801819488,
    0.24269333397387527,
    0.23710129101527855,
    0.23849537500063889,
    0.22499562500161119,
    0.21321491699200124,
    0.22903466699062847,
    0.24337104102596641,
    0.22647104199859314,
    0.21123716697911732,
    0.23994958301773295,
    0.23686812497908249,
    0.23912020801799372,
    0.22407137500704266,
    0.21515554198413156,
    0.21951429199543782,
    0.2062571250135079,
    0.22552491599344648,
    0.22561641701031476,
    0.20814745797542855,
    0.23473325002123602,
    0.22169991699047387,
    0.23814591701375321,
    0.21914491598727182,
    0.21207224999670871,
    0.21674208401236683,
    0.24313220797921531,
    0.23377404201892205,
    0.23737024998990819,
    0.22782179099158384,
    0.2340335420158226,
    0.21780220800428651,
    0.2302089589938987,
    0.23409662500489503,
    0.21834758299519308,
    0.21472408299450763,
    0.28751295901020057,
    0.20591791599872522,
    0.21303924999665469,
    0.23894370900234208,
    0.22801391599932685,
    0.24177241700817831,
    0.23648595798294991,
    0.23408620900590904,
    0.23308366601122543,
    0.22521762497490272,
    0.23440783401019871,
    0.23874612498912029,
    0.22828179100179113,
    0.23209825000958517,
    0.20885829199687578,
    0.22898566699586809,
    0.2118899580091238,
    0.21842733299126849,
    0.21484216701355763,
    0.19122908299323171,
    0.21327545901294798,
    0.21952074998989701,
    0.2128022079996299,
    0.21298991699586622,
    0.19425683299778029,
    0.20991175001836382,
    0.20104295798228122,
    0.22118679201230407,
    0.21561620800639503,
    0.22743816699949093,
    0.2428672919922974,
    0.228040374990087,
    0.20565687501220964,
    0.23481804100447334,
    0.22890479199122638,
    0.20488520798971877,
    0.23077083399402909,
    0.20541408300050534,
    0.22123500000452623,
    0.21811479202006012,
    0.19718483299948275,
    0.2154422499879729,
    0.22333454200997949,
    0.23922729099285789,
    0.21367020899197087
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 29.143386541982181,
  "metadata_seconds" : 0.11875587500981055,
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
  "peak_process_bytes" : 8029690024,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 33.198421834007604,
  "request_vm_after" : {
    "reclaimableBytes" : 18028740608,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 20053508096,
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
  "ttft_seconds" : 3.5605475000047591,
  "validation_receipt_sha256" : "5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-3-parallel-supervision/identity.json

Original bytes: 2927. SHA-256: `d728a1de1294be95a244bac8461fe7a33b388703a3861bc5d578b581deaecaf1`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/performance-pilot-v2.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/round-3-parallel",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-read-pair-v1/validation-parallel/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24783552512,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   464457.\nPages active:                                 864463.\nPages inactive:                               870750.\nPages speculative:                             49775.\nPages throttled:                                   0.\nPages wired down:                             177786.\nPages purgeable:                                 828.\n\"Translation faults\":                     1495273975.\nPages copy-on-write:                        76967603.\nPages zero filled:                        2391915493.\nPages reactivated:                          96994782.\nPages purged:                               11303510.\nFile-backed pages:                           1047383.\nAnonymous pages:                              737605.\nPages stored in compressor:                  1226987.\nPages occupied by compressor:                 656635.\nDecompressions:                             47113226.\nCompressions:                               57773574.\nPageins:                                  1151098990.\nPageouts:                                     374318.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127224.\nPages tagged resident:                         81281.\nPages tagged compressed:                       45943.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1352.\nPages tag-storage non-tag pageable:            91744.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    7073472.\nTagged compressions:                          502758.\nTagged decompressions:                        405820.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-read-pair-v1/round-3-parallel-supervision/receipt.json

Original bytes: 2140. SHA-256: `f2a9796e9256cdf63ed2373a4e6fd93e724429aeeb3f7b02617eecf639af3c2b`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 8029690024,
  "samples": 1067,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24953356288,
    "swapins": 16,
    "swapouts": 2904,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   485022.\nPages active:                                 855004.\nPages inactive:                               846224.\nPages speculative:                             53454.\nPages throttled:                                   0.\nPages wired down:                             177818.\nPages purgeable:                                 408.\n\"Translation faults\":                     1495962982.\nPages copy-on-write:                        76984563.\nPages zero filled:                        2395739277.\nPages reactivated:                          97062114.\nPages purged:                               11307583.\nFile-backed pages:                           1037602.\nAnonymous pages:                              717080.\nPages stored in compressor:                  1245374.\nPages occupied by compressor:                 666452.\nDecompressions:                             47631514.\nCompressions:                               58334167.\nPageins:                                  1156454262.\nPageouts:                                     374771.\nSwapins:                                          16.\nSwapouts:                                       2904.\nPages tagged:                                 127102.\nPages tagged resident:                         79855.\nPages tagged compressed:                       47247.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1599.\nPages tag-storage non-tag pageable:            91497.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    7314176.\nTagged compressions:                          504628.\nTagged decompressions:                        406382.\n"
  },
  "seconds": 62.61363816697849
}
````

### vq-read-pair-v1/round-3-parallel-supervision/stdout.txt

Original bytes: 21491. SHA-256: `11a9f8a5dfe3c08ab917593e4edd15a4aad53f6205c61c8de7850d7157c587fe`.

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
  "committed_decode_tokens_per_second" : 4.2850604644405115,
  "committed_tokens" : 128,
  "emission_seconds" : [
    3.5605475000047591,
    4.242845667002257,
    4.5024548340006731,
    4.7566618749988265,
    4.9970847500080708,
    5.2462920420221053,
    5.4914412920188624,
    5.7395497920224443,
    5.9799299169972073,
    6.2278112500207499,
    6.4694267090235371,
    6.7153515420213807,
    6.951933584001381,
    7.1822260420012753,
    7.4069582090014592,
    7.6611352500040084,
    7.9081398340058513,
    8.1218218340072781,
    8.3629595000238623,
    8.598321167024551,
    8.8387455000192858,
    9.0814515000092797,
    9.318622167018475,
    9.5511345000122674,
    9.8006575420149602,
    10.043324541999027,
    10.28432587502175,
    10.530055084003834,
    10.769672791997436,
    11.027363875007723,
    11.27703645901056,
    11.522168791998411,
    11.771813750005094,
    12.005874459020561,
    12.233504875010112,
    12.458953125023982,
    12.687537000019802,
    12.902967084024567,
    13.11445854199701,
    13.338982042012503,
    13.583036625001114,
    13.831271333998302,
    14.065762500016717,
    14.303689125023084,
    14.555649792018812,
    14.802531042019837,
    15.032073167007184,
    15.268265625025379,
    15.510958958999254,
    15.748060250014532,
    15.986555625015171,
    16.211551250016782,
    16.424766167008784,
    16.653800833999412,
    16.897171875025379,
    17.123642917023972,
    17.334880084003089,
    17.574829667020822,
    17.811697791999904,
    18.050818000017898,
    18.274889375024941,
    18.490044917009072,
    18.70955920900451,
    18.915816334018018,
    19.141341250011465,
    19.366957667021779,
    19.575105124997208,
    19.809838375018444,
    20.031538292008918,
    20.269684209022671,
    20.488829125009943,
    20.700901375006652,
    20.917643459019018,
    21.160775666998234,
    21.394549709017156,
    21.631919959007064,
    21.859741749998648,
    22.09377529201447,
    22.311577500018757,
    22.541786459012656,
    22.775883084017551,
    22.994230667012744,
    23.208954750007251,
    23.496467709017452,
    23.702385625016177,
    23.915424875012832,
    24.154368584015174,
    24.382382500014501,
    24.624154917022679,
    24.860640875005629,
    25.094727084011538,
    25.327810750022763,
    25.553028374997666,
    25.787436209007865,
    26.026182333996985,
    26.254464124998776,
    26.486562375008361,
    26.695420667005237,
    26.924406334001105,
    27.136296292010229,
    27.354723625001498,
    27.569565792015055,
    27.760794875008287,
    27.974070334021235,
    28.193591084011132,
    28.406393292010762,
    28.619383209006628,
    28.813640042004408,
    29.023551792022772,
    29.224594750005053,
    29.445781542017357,
    29.661397750023752,
    29.888835917023243,
    30.131703209015541,
    30.359743584005628,
    30.565400459017837,
    30.800218500022311,
    31.029123292013537,
    31.234008500003256,
    31.464779333997285,
    31.67019341699779,
    31.891428417002317,
    32.109543209022377,
    32.306728042021859,
    32.522170292009832,
    32.745504834019812,
    32.98473212501267,
    33.198402334004641
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
    "reclaimableBytes" : 25368903680,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "inter_token_seconds" : [
    0.6822981669974979,
    0.25960916699841619,
    0.25420704099815339,
    0.24042287500924431,
    0.24920729201403446,
    0.24514924999675713,
    0.24810850000358187,
    0.24038012497476302,
    0.24788133302354254,
    0.24161545900278725,
    0.24592483299784362,
    0.23658204198000021,
    0.2302924579998944,
    0.22473216700018384,
    0.25417704100254923,
    0.24700458400184289,
    0.21368200000142679,
    0.24113766601658426,
    0.23536166700068861,
    0.24042433299473487,
    0.24270599998999387,
    0.23717066700919531,
    0.23251233299379237,
    0.24952304200269282,
    0.24266699998406693,
    0.24100133302272297,
    0.24572920898208395,
    0.23961770799360238,
    0.25769108301028609,
    0.24967258400283754,
    0.24513233298785053,
    0.24964495800668374,
    0.23406070901546627,
    0.22763041598955169,
    0.22544825001386926,
    0.22858387499582022,
    0.21543008400476538,
    0.21149145797244273,
    0.22452350001549348,
    0.24405458298861049,
    0.24823470899718814,
    0.23449116601841524,
    0.23792662500636652,
    0.25196066699572839,
    0.24688125000102445,
    0.22954212498734705,
    0.23619245801819488,
    0.24269333397387527,
    0.23710129101527855,
    0.23849537500063889,
    0.22499562500161119,
    0.21321491699200124,
    0.22903466699062847,
    0.24337104102596641,
    0.22647104199859314,
    0.21123716697911732,
    0.23994958301773295,
    0.23686812497908249,
    0.23912020801799372,
    0.22407137500704266,
    0.21515554198413156,
    0.21951429199543782,
    0.2062571250135079,
    0.22552491599344648,
    0.22561641701031476,
    0.20814745797542855,
    0.23473325002123602,
    0.22169991699047387,
    0.23814591701375321,
    0.21914491598727182,
    0.21207224999670871,
    0.21674208401236683,
    0.24313220797921531,
    0.23377404201892205,
    0.23737024998990819,
    0.22782179099158384,
    0.2340335420158226,
    0.21780220800428651,
    0.2302089589938987,
    0.23409662500489503,
    0.21834758299519308,
    0.21472408299450763,
    0.28751295901020057,
    0.20591791599872522,
    0.21303924999665469,
    0.23894370900234208,
    0.22801391599932685,
    0.24177241700817831,
    0.23648595798294991,
    0.23408620900590904,
    0.23308366601122543,
    0.22521762497490272,
    0.23440783401019871,
    0.23874612498912029,
    0.22828179100179113,
    0.23209825000958517,
    0.20885829199687578,
    0.22898566699586809,
    0.2118899580091238,
    0.21842733299126849,
    0.21484216701355763,
    0.19122908299323171,
    0.21327545901294798,
    0.21952074998989701,
    0.2128022079996299,
    0.21298991699586622,
    0.19425683299778029,
    0.20991175001836382,
    0.20104295798228122,
    0.22118679201230407,
    0.21561620800639503,
    0.22743816699949093,
    0.2428672919922974,
    0.228040374990087,
    0.20565687501220964,
    0.23481804100447334,
    0.22890479199122638,
    0.20488520798971877,
    0.23077083399402909,
    0.20541408300050534,
    0.22123500000452623,
    0.21811479202006012,
    0.19718483299948275,
    0.2154422499879729,
    0.22333454200997949,
    0.23922729099285789,
    0.21367020899197087
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 29.143386541982181,
  "metadata_seconds" : 0.11875587500981055,
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
  "peak_process_bytes" : 8029690024,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "7595c39b3b5ec5e3aad210706dd1c43577f41ca077169bf8fdb00412b9006c8f",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq-greedy128-parallel-read-performance-pilot-v2",
  "profile_sha256" : "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
  "qualification" : "unproven",
  "request_seconds" : 33.198421834007604,
  "request_vm_after" : {
    "reclaimableBytes" : 18028740608,
    "swapins" : 16,
    "swapouts" : 2904
  },
  "request_vm_before" : {
    "reclaimableBytes" : 20053508096,
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
  "ttft_seconds" : 3.5605475000047591,
  "validation_receipt_sha256" : "5e0debbf54e2281cea3e5bc8027128e8d7cb15b107d254e8e37ae878c8912996",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-read-pair-v1/round-3-parallel-supervision/stderr.txt

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
