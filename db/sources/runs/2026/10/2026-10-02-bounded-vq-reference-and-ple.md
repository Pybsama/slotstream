---
type: run
created: 2026-10-03T00:06:03.407988+00:00
updated: 2026-10-03T00:06:03.407988+00:00
summary: Bounded full VQ reference traversal, native baseline logits and native PLE storage checks; experimental only.
binary: Frozen source-bound native builds and complete Python instrument identities below
captured_at: 2026-10-02
command: Exact commands and inputs described below; source-bound tools are preserved in the implementation commit
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Bounded VQ reference and native PLE execution
tool: vq_model_reference.py, vq_ple_reference_check.py, quantization-logits and quantization-check
---

The pinned VQ 3.2 artifact was downloaded and all tensor files were checked against the immutable full-file map. Each reference run independently rehashes those files, pins its source and installed runtime bytes, holds the shared model lock, checks actual headroom, and supervises process memory and OS pressure. No candidate was activated in the app or the production loader.

The first traversal attempt failed because its second preflight tried to reacquire the process's own lock. The second passed, but review found that an environment-only decode-chunk setting could be resolved after that variable had been removed. Both results remain below. The corrected third proof sets the runtime variable directly, verifies the ordinary and layer-streamed first four layers bit for bit across a 512-token/EOS boundary, and is the required proof for both complete 48-layer forwards. The first full forward uses the six-token fixture; the second uses the 513-token fixture. These establish bounded execution, not native full-model parity or task quality.

Commands for the corrected reference use `.venv/bin/python Tools/vq_model_reference.py --model .build/quantization-research/candidate-3.2 --inventory .build/quantization-research/inventory-3.2/inventory.json --architecture .build/quantization-research/qwen4_exp-pr1788.py`. The proof adds `--tokens .build/quantization-research/vq-order-tokens.json --layers 4 --prove-order --out .build/quantization-research/vq-order-proof-3.2-v3`. Full runs instead pass `--order-proof .build/quantization-research/vq-order-proof-3.2-v3/receipt.json`, the corresponding frozen token file and new full-reference output directory.

PLE reference checks use the hash-pinned upstream VQPLEEmbedding class, bounded positional reads, and the independent scalar F16 oracle. The native CPU reader uses the same required F16-product-to-BF16 sequence and checked positional reads from a private verified fixture file. Its real-row gate covers the three inspected PLE layouts with ordered and duplicate requests. It retains only codebooks and per-call results; it does not implement the product's persistent row cache or checkpoint admission.

Native baseline producers ran sequentially under the preserved external supervisor, with a bounded pool, deployed arithmetic, MTP/vision off, complete head batches before selected full-vocabulary rows, continuous process observation and OS-pressure cancellation. The first uses six tokens; the second crosses the prompt-chunk boundary. Their reconstructible source archives and binaries are retained in the named local frozen directories. The new PLE native checks ran `slotstream quantization-check --fixture-directory .build/quantization-research/fixtures-<rung>` for 2.1, 3.2 and 4.4.

These are functional and numerical checks. A candidate transfer ran during portions of this work. Timings are not clean performance evidence, and no throughput or hardware profile is qualified. Original log failures are preserved. The initial static-runner registration failed and was repaired; later reference unit tests pass. Subsequent complete static/catalogue reruns are recorded separately.

Local home prefixes are replaced with `<HOME>` and trailing blank lines are normalized at transcript boundaries below. Original byte counts and digests refer to the unmodified captured files. No model tensors or binary logits are copied into this record.

### ple-reference-tools-tests.log

Original bytes: 114; SHA-256: `2fdf7a432a53fceb691486981be60fcb65192fbaa6b7627e6b3fe3a0c95917bf`.

````text
...............
----------------------------------------------------------------------
Ran 15 tests in 0.009s

OK
````

### ple-reference-tools-tests-v2.log

Original bytes: 115; SHA-256: `25d718152414a917d6eb4a014d599eff20a2b538451c2591d104ace11b9de0dd`.

````text
................
----------------------------------------------------------------------
Ran 16 tests in 0.009s

OK
````

### ple-reference-tools-tests-v3.log

Original bytes: 116; SHA-256: `5300be4d76a19a89ba13180c9823bf33fb05a639d4155d08af8630be905734de`.

````text
.................
----------------------------------------------------------------------
Ran 17 tests in 0.011s

OK
````

### ple-reference-tools-tests-v4.log

Original bytes: 116; SHA-256: `938170522077765b26f6292b200d0dbc0f8d4d0557fa800d07bbf54446c026ff`.

````text
.................
----------------------------------------------------------------------
Ran 17 tests in 0.010s

OK
````

### ple-static-runner.log

Original bytes: 7870; SHA-256: `b7be4f3f4026f04924a6652c68c3eb1c416e391b8c7e874c4c204153b1a24ade`.

````text
.FF......FF...FFFF.....F...F..
======================================================================
FAIL: test_default_release_is_used_and_forwarded (__main__.StaticBinarySelection)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 113, in test_default_release_is_used_and_forwarded
    self.expect_selected({}, 'release')
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 104, in expect_selected
    self.assertEqual(p.returncode, 0, p.stdout+p.stderr)
AssertionError: 2 != 0 : /Library/Developer/CommandLineTools/usr/bin/python3: can't open file '/private/var/folders/d4/t1c8ltbx5s3_11cs9y6gjh8m0000gp/T/slotstream-static-selection-xyz97pfu/Tools/vq_ple_stream_test.py': [Errno 2] No such file or directory


======================================================================
FAIL: test_every_optimization_suite_runs_before_native_checks (__main__.StaticBinarySelection)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 206, in test_every_optimization_suite_runs_before_native_checks
    self.assertEqual(p.returncode, 0, p.stdout+p.stderr)
AssertionError: 2 != 0 : /Library/Developer/CommandLineTools/usr/bin/python3: can't open file '/private/var/folders/d4/t1c8ltbx5s3_11cs9y6gjh8m0000gp/T/slotstream-static-selection-bem5igc8/Tools/vq_ple_stream_test.py': [Errno 2] No such file or directory


======================================================================
FAIL: test_failed_memory_override_matrix_stops_acceptance (__main__.StaticBinarySelection)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 142, in test_failed_memory_override_matrix_stops_acceptance
    self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
AssertionError: 2 != 23 : /Library/Developer/CommandLineTools/usr/bin/python3: can't open file '/private/var/folders/d4/t1c8ltbx5s3_11cs9y6gjh8m0000gp/T/slotstream-static-selection-oulsubth/Tools/vq_ple_stream_test.py': [Errno 2] No such file or directory


======================================================================
FAIL: test_failed_native_memory_regression_stops_acceptance (__main__.StaticBinarySelection)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 127, in test_failed_native_memory_regression_stops_acceptance
    self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
AssertionError: 2 != 23 : /Library/Developer/CommandLineTools/usr/bin/python3: can't open file '/private/var/folders/d4/t1c8ltbx5s3_11cs9y6gjh8m0000gp/T/slotstream-static-selection-3xu5_jcy/Tools/vq_ple_stream_test.py': [Errno 2] No such file or directory


======================================================================
FAIL: test_failed_pull_interrupt_gate_stops_acceptance (__main__.StaticBinarySelection)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 147, in test_failed_pull_interrupt_gate_stops_acceptance
    self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
AssertionError: 2 != 23 : /Library/Developer/CommandLineTools/usr/bin/python3: can't open file '/private/var/folders/d4/t1c8ltbx5s3_11cs9y6gjh8m0000gp/T/slotstream-static-selection-sud371bs/Tools/vq_ple_stream_test.py': [Errno 2] No such file or directory


======================================================================
FAIL: test_frozen_override_takes_precedence_over_legacy_bin (__main__.StaticBinarySelection)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 163, in test_frozen_override_takes_precedence_over_legacy_bin
    self.expect_selected({'BIN': str(self.binaries['legacy']),
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 104, in expect_selected
    self.assertEqual(p.returncode, 0, p.stdout+p.stderr)
AssertionError: 2 != 0 : /Library/Developer/CommandLineTools/usr/bin/python3: can't open file '/private/var/folders/d4/t1c8ltbx5s3_11cs9y6gjh8m0000gp/T/slotstream-static-selection-st7y012u/Tools/vq_ple_stream_test.py': [Errno 2] No such file or directory


======================================================================
FAIL: test_frozen_override_with_spaces_is_used_and_forwarded (__main__.StaticBinarySelection)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 160, in test_frozen_override_with_spaces_is_used_and_forwarded
    self.expect_selected({'SLOTSTREAM_TEST_BINARY': str(self.binaries['frozen'])}, 'frozen')
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 104, in expect_selected
    self.assertEqual(p.returncode, 0, p.stdout+p.stderr)
AssertionError: 2 != 0 : /Library/Developer/CommandLineTools/usr/bin/python3: can't open file '/private/var/folders/d4/t1c8ltbx5s3_11cs9y6gjh8m0000gp/T/slotstream-static-selection-pjl8hpe9/Tools/vq_ple_stream_test.py': [Errno 2] No such file or directory


======================================================================
FAIL: test_legacy_bin_override_is_used_and_forwarded (__main__.StaticBinarySelection)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 157, in test_legacy_bin_override_is_used_and_forwarded
    self.expect_selected({'BIN': str(self.binaries['legacy'])}, 'legacy')
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 104, in expect_selected
    self.assertEqual(p.returncode, 0, p.stdout+p.stderr)
AssertionError: 2 != 0 : /Library/Developer/CommandLineTools/usr/bin/python3: can't open file '/private/var/folders/d4/t1c8ltbx5s3_11cs9y6gjh8m0000gp/T/slotstream-static-selection-cxurixol/Tools/vq_ple_stream_test.py': [Errno 2] No such file or directory


======================================================================
FAIL: test_missing_pull_interrupt_gate_stops_acceptance (__main__.StaticBinarySelection)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 154, in test_missing_pull_interrupt_gate_stops_acceptance
    self.assertEqual([row['arguments'] for row in rows], [['runtime-check'], ['pull-check']])
AssertionError: Lists differ: [] != [['runtime-check'], ['pull-check']]

Second list contains 2 additional elements.
First extra element 0:
['runtime-check']

- []
+ [['runtime-check'], ['pull-check']]

======================================================================
FAIL: test_selected_binary_failure_stops_without_fallback (__main__.StaticBinarySelection)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/static_gates_binary_test.py", line 174, in test_selected_binary_failure_stops_without_fallback
    self.assertEqual(p.returncode, 23)
AssertionError: 2 != 23

----------------------------------------------------------------------
Ran 30 tests in 10.965s

FAILED (failures=10)
````

### ple-static-runner-fixed.log

Original bytes: 130; SHA-256: `6454df77fdcd800f831f28042b2a6f51e86df125df7b934caf0365f30ce0b0a7`.

````text
..............................
----------------------------------------------------------------------
Ran 30 tests in 21.158s

OK
````

### ple-static-runner-final.log

Original bytes: 130; SHA-256: `352aff345a919186a8367b6707cf27a432a1b102001e5c8919401fbb2e0c6c8e`.

````text
..............................
----------------------------------------------------------------------
Ran 30 tests in 21.485s

OK
````

### ple-reference-v1.log

Original bytes: 208; SHA-256: `b022d925a97c8c18cd718a968485f7f62f047702c0fab707f80398a0476394ef`.

````text
<HOME>/Projects/slotstream/Tools/vq_ple_stream.py:230: SyntaxWarning: invalid escape sequence '\.'
  if not re.fullmatch('[a-zA-Z0-9_-]+\.safetensors', path):
{"cases": 12, "peak_mlx_bytes": 27616240}
````

### ple-reference-v1/receipt.json

Original bytes: 7061; SHA-256: `592d18722eea9e6c608b3cd87a9003624eb6072e06b80ce41894e02d274d9715`.

````text
{
  "schema": 1,
  "runtime_sha256": "1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8",
  "mlx": "0.32.2",
  "scope": "selected real PLE rows, storage and F16-product/BF16 parity; not full model quality",
  "peak_mlx_bytes": 27616240,
  "cases": [
    {
      "revision": "8684640a3956b01c47f5d47f9b999e2ab8b985f1",
      "fixture_sha256": "aa4dc90d40710180a5f5ba041a11d33acbf846212a60e598214d7c4f52ee01d0",
      "manifest_sha256": "c2c63045886e44074d975144eb29683a5608694ff13399d401fbca3deaea5825",
      "dimensions": 8,
      "entries": 256,
      "shape": [
        1
      ],
      "equal_bf16_bits": true,
      "output_sha256": "c2a39b56822e5db3462a1a46b1671ea2d459326aaab9755cb032a8bbf0918fce",
      "cumulative_payload_bytes_read": 4126,
      "max_rows": 1,
      "max_result_bytes": 30
    },
    {
      "revision": "8684640a3956b01c47f5d47f9b999e2ab8b985f1",
      "fixture_sha256": "aa4dc90d40710180a5f5ba041a11d33acbf846212a60e598214d7c4f52ee01d0",
      "manifest_sha256": "c2c63045886e44074d975144eb29683a5608694ff13399d401fbca3deaea5825",
      "dimensions": 8,
      "entries": 256,
      "shape": [
        2,
        3
      ],
      "equal_bf16_bits": true,
      "output_sha256": "da46603005a0ff9ccf949d00f9b5b23a454441ea0da68b5500aa1cb40363fdd2",
      "cumulative_payload_bytes_read": 4276,
      "max_rows": 6,
      "max_result_bytes": 180
    },
    {
      "revision": "8684640a3956b01c47f5d47f9b999e2ab8b985f1",
      "fixture_sha256": "aa4dc90d40710180a5f5ba041a11d33acbf846212a60e598214d7c4f52ee01d0",
      "manifest_sha256": "c2c63045886e44074d975144eb29683a5608694ff13399d401fbca3deaea5825",
      "dimensions": 8,
      "entries": 256,
      "shape": [
        512
      ],
      "equal_bf16_bits": true,
      "output_sha256": "caef53e34e6f62b22bdae9b75f49447822ebf69d1f8748962738b4cfb6ba191b",
      "cumulative_payload_bytes_read": 4486,
      "max_rows": 512,
      "max_result_bytes": 15360
    },
    {
      "revision": "8684640a3956b01c47f5d47f9b999e2ab8b985f1",
      "fixture_sha256": "aa4dc90d40710180a5f5ba041a11d33acbf846212a60e598214d7c4f52ee01d0",
      "manifest_sha256": "c2c63045886e44074d975144eb29683a5608694ff13399d401fbca3deaea5825",
      "dimensions": 8,
      "entries": 256,
      "shape": [
        8192
      ],
      "equal_bf16_bits": true,
      "output_sha256": "cf718260dc21f9f11affe28b159cc24dba0b24377d82db2e410ffcc36962d5d6",
      "cumulative_payload_bytes_read": 4696,
      "max_rows": 8192,
      "max_result_bytes": 245760
    },
    {
      "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
      "fixture_sha256": "497780bf485a2c6f10087038b9e0aa421d0d7c3c28369070882b27fbce0dfb1e",
      "manifest_sha256": "2bd28f49f31d95342e09ebebf9644803478742b2a93f31eff138f4faa0d9a231",
      "dimensions": 4,
      "entries": 2048,
      "shape": [
        1
      ],
      "equal_bf16_bits": true,
      "output_sha256": "0fe843a36857f4bb426ea445c1c40705a88fae77d92a07f2e6a1a72aad11ac2f",
      "cumulative_payload_bytes_read": 16449,
      "max_rows": 1,
      "max_result_bytes": 65
    },
    {
      "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
      "fixture_sha256": "497780bf485a2c6f10087038b9e0aa421d0d7c3c28369070882b27fbce0dfb1e",
      "manifest_sha256": "2bd28f49f31d95342e09ebebf9644803478742b2a93f31eff138f4faa0d9a231",
      "dimensions": 4,
      "entries": 2048,
      "shape": [
        2,
        3
      ],
      "equal_bf16_bits": true,
      "output_sha256": "6a385a43d5a7ba05815dbc636086bf6b67ed0e01c11315ba8810b0815f13d004",
      "cumulative_payload_bytes_read": 16774,
      "max_rows": 6,
      "max_result_bytes": 390
    },
    {
      "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
      "fixture_sha256": "497780bf485a2c6f10087038b9e0aa421d0d7c3c28369070882b27fbce0dfb1e",
      "manifest_sha256": "2bd28f49f31d95342e09ebebf9644803478742b2a93f31eff138f4faa0d9a231",
      "dimensions": 4,
      "entries": 2048,
      "shape": [
        512
      ],
      "equal_bf16_bits": true,
      "output_sha256": "e8a32b54d293f5a96b272e3ed91eb8567b96361259ef953c0329e0e3331f0840",
      "cumulative_payload_bytes_read": 17229,
      "max_rows": 512,
      "max_result_bytes": 33280
    },
    {
      "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
      "fixture_sha256": "497780bf485a2c6f10087038b9e0aa421d0d7c3c28369070882b27fbce0dfb1e",
      "manifest_sha256": "2bd28f49f31d95342e09ebebf9644803478742b2a93f31eff138f4faa0d9a231",
      "dimensions": 4,
      "entries": 2048,
      "shape": [
        8192
      ],
      "equal_bf16_bits": true,
      "output_sha256": "c626a369208374a8222570061e0e4eecfa3406b6857752e31afca332b1c00d96",
      "cumulative_payload_bytes_read": 17684,
      "max_rows": 8192,
      "max_result_bytes": 532480
    },
    {
      "revision": "0f35dc817238bdbabdac208db731470cd30a7c0a",
      "fixture_sha256": "78b7c9d327da0d1bc699a77b5b2834a0f8c86fe69a8df86329caa42bb9d49540",
      "manifest_sha256": "a85085451f949f8f1cd2d060515f424a96fbd3e76a42db7106f07a6392c8ccaf",
      "dimensions": 2,
      "entries": 256,
      "shape": [
        1
      ],
      "equal_bf16_bits": true,
      "output_sha256": "f5b440829714772616cf3b4730de88df57612981e26e4a9076f99cf775008b8b",
      "cumulative_payload_bytes_read": 1114,
      "max_rows": 1,
      "max_result_bytes": 90
    },
    {
      "revision": "0f35dc817238bdbabdac208db731470cd30a7c0a",
      "fixture_sha256": "78b7c9d327da0d1bc699a77b5b2834a0f8c86fe69a8df86329caa42bb9d49540",
      "manifest_sha256": "a85085451f949f8f1cd2d060515f424a96fbd3e76a42db7106f07a6392c8ccaf",
      "dimensions": 2,
      "entries": 256,
      "shape": [
        2,
        3
      ],
      "equal_bf16_bits": true,
      "output_sha256": "dfdc3b5c5c959f158b626c9de1aa47ab1a26ac8a8315501519f74928b5b3ac52",
      "cumulative_payload_bytes_read": 1564,
      "max_rows": 6,
      "max_result_bytes": 540
    },
    {
      "revision": "0f35dc817238bdbabdac208db731470cd30a7c0a",
      "fixture_sha256": "78b7c9d327da0d1bc699a77b5b2834a0f8c86fe69a8df86329caa42bb9d49540",
      "manifest_sha256": "a85085451f949f8f1cd2d060515f424a96fbd3e76a42db7106f07a6392c8ccaf",
      "dimensions": 2,
      "entries": 256,
      "shape": [
        512
      ],
      "equal_bf16_bits": true,
      "output_sha256": "56fe8932b5a6641358e6168e09992bd5ed110837644eb0bf9703cb658a8a1d86",
      "cumulative_payload_bytes_read": 2194,
      "max_rows": 512,
      "max_result_bytes": 46080
    },
    {
      "revision": "0f35dc817238bdbabdac208db731470cd30a7c0a",
      "fixture_sha256": "78b7c9d327da0d1bc699a77b5b2834a0f8c86fe69a8df86329caa42bb9d49540",
      "manifest_sha256": "a85085451f949f8f1cd2d060515f424a96fbd3e76a42db7106f07a6392c8ccaf",
      "dimensions": 2,
      "entries": 256,
      "shape": [
        8192
      ],
      "equal_bf16_bits": true,
      "output_sha256": "2aa901c732ae4040005207486d466451b775eb662b6f394635cc1501c8363637",
      "cumulative_payload_bytes_read": 2824,
      "max_rows": 8192,
      "max_result_bytes": 737280
    }
  ]
}
````

### candidate-3.2/verified.json

Original bytes: 23302; SHA-256: `ec76e8ddf0a7038ad51f3a08cabf12e2c22ca199b15d4b94c71688c1a73b8d7e`.

````text
{
  "schema": 1,
  "repo": "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-3.2bpw",
  "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
  "hub_metadata_sha256": "0bef64eb7d61fb01ea7c711792c515d01adf665d7842d44e821402896ea7c91b",
  "files": [
    {
      "path": "model-00001.safetensors",
      "bytes": 3502305114,
      "sha256": "1ca54446f012d2a781a6eb02e3fcfcc2fa65c47cdfdc4546529d13a5d5f87882"
    },
    {
      "path": "model-00012.safetensors",
      "bytes": 6258175824,
      "sha256": "fd7d2a6affa49dfef75a7e3bc17fdcaf3ff41cfea3b4a6c864fb77aa26803f03"
    },
    {
      "path": "model-00013.safetensors",
      "bytes": 6471407889,
      "sha256": "dbeca49799014bc1544d063e44f71507b5c2edb3c8324760fe28e5eba02a6763"
    },
    {
      "path": "model-00014.safetensors",
      "bytes": 6547978262,
      "sha256": "bf1081d0179b5af4855d2f3e059f30c309cf5784aa817952f6e337d0c6db3113"
    },
    {
      "path": "model-00015.safetensors",
      "bytes": 6471407935,
      "sha256": "352b217523b66bd4eed580613350321d040e149f507031daa03ad1fe2cf1eee4"
    },
    {
      "path": "model-00016.safetensors",
      "bytes": 6857620951,
      "sha256": "f3939379a777eaa299d6121e29b05791e8d62610866b7afc79f9f9d77c0cb8fe"
    },
    {
      "path": "model-00017.safetensors",
      "bytes": 6679034951,
      "sha256": "821d087a8b8b02edf4f772cac2b1213609f4f122aa4dad8b7ce57bd9a010e865"
    },
    {
      "path": "model-00018.safetensors",
      "bytes": 6733521211,
      "sha256": "daf98df45b5fb37cab8a6f0b31e0808e9ab40f8344df5951a6fd84847d3f8823"
    },
    {
      "path": "model-00019.safetensors",
      "bytes": 3457093298,
      "sha256": "bdad9f2d2a8eca68c43ce2aa2ba8aaf7549b7973c9161064b7d99a1f983f3f1d"
    },
    {
      "path": "model-ple-0000.safetensors",
      "bytes": 162517607,
      "sha256": "afc521da8d961dae57fedd1e8e83ec1ea90f0219fef9380292cf98fa7e4890a4"
    },
    {
      "path": "model-ple-0001.safetensors",
      "bytes": 162517605,
      "sha256": "88d257de1795330b12b6d3bafde06ae2d58faa6abe18692564cc956848b14ba8"
    },
    {
      "path": "model-ple-0002.safetensors",
      "bytes": 162517610,
      "sha256": "ee40231265b4756356ef901c329c53175f63ec231dfca12d788ea933efcde7c6"
    },
    {
      "path": "model-ple-0003.safetensors",
      "bytes": 162517613,
      "sha256": "cfb91ee873286c6c6354d0ca8d6b3876fc3f5e952db28ca9850433e56e4e89b4"
    },
    {
      "path": "model-ple-0004.safetensors",
      "bytes": 162517613,
      "sha256": "fcb7ce810eb21cc850ddfada8d01b98454c8bb340eaa426c90a4fe28a98d93e3"
    },
    {
      "path": "model-ple-0005.safetensors",
      "bytes": 162517611,
      "sha256": "1770b48fc71c288787b6c7cf990f648ba2e619963a511e63e57ecbb1e44bd80e"
    },
    {
      "path": "model-ple-0006.safetensors",
      "bytes": 162517611,
      "sha256": "7e95b0f59fa4a43d2642743e66ce44fdc4fd9eb680a039d9471af643b9ec34c0"
    },
    {
      "path": "model-ple-0007.safetensors",
      "bytes": 162517611,
      "sha256": "f36b0365c209fd4b4aa3e2e64b68da757d6a81230ce82c2a79c09e710e6f271d"
    },
    {
      "path": "model-ple-0008.safetensors",
      "bytes": 162517613,
      "sha256": "10533f12013664d92a022710dcfb0d413c25fbab8d4101789f7b8dd4b2e8a00b"
    },
    {
      "path": "model-ple-0009.safetensors",
      "bytes": 162517613,
      "sha256": "dd333253c9b5a03d268884a9605ef1774b73cb5c8712d97276bbf45ab398865f"
    },
    {
      "path": "model-ple-0010.safetensors",
      "bytes": 162517613,
      "sha256": "b03102a664bb1018f64e9f27e509907b1015abcdb7a4236c2680ba2bf95be4b0"
    },
    {
      "path": "model-ple-0011.safetensors",
      "bytes": 162517613,
      "sha256": "235505f9931c14b9bcaec9aee500d9fda7fe92a7498e2d5e1666ac772389590e"
    },
    {
      "path": "model-ple-0012.safetensors",
      "bytes": 162517613,
      "sha256": "3b822899b22602f43f46627c494b2ed72d55a599f21007d102275db48c1980d1"
    },
    {
      "path": "model-ple-0013.safetensors",
      "bytes": 162517610,
      "sha256": "75fe8aec0fe2418d29d022707054056d8d43b23b3ac9f287d17e739358d81ca2"
    },
    {
      "path": "model-ple-0014.safetensors",
      "bytes": 162517613,
      "sha256": "dec4b62c141bc920481f805b5d1d0c977d8e6e5467fc991b1ccf3ef767525d04"
    },
    {
      "path": "model-ple-0015.safetensors",
      "bytes": 162517613,
      "sha256": "2131d1273c6d8e4048e5dccf2c0bc2f4dc0155039440c1615af8961e7458ca96"
    },
    {
      "path": "model-ple-0016.safetensors",
      "bytes": 162517613,
      "sha256": "619c2346969d498c410685382675799b7513e863b244267d5f8b2c10c1d9bd15"
    },
    {
      "path": "model-ple-0017.safetensors",
      "bytes": 162517613,
      "sha256": "6d2d4b909048f096515817338705ff0d788d19bce58494e8e60ec3de80aca59d"
    },
    {
      "path": "model-ple-0018.safetensors",
      "bytes": 162517611,
      "sha256": "2511e6b82f4d2e8ec06dec6015d0e17e6b902ef71ad4489cec7e193fbcb20683"
    },
    {
      "path": "model-ple-0019.safetensors",
      "bytes": 162517613,
      "sha256": "ca116d6607f42778b392732c52a8c5cf78cc2a09f1df1b7b1f0b8a205b7dd12a"
    },
    {
      "path": "model-ple-0020.safetensors",
      "bytes": 162517611,
      "sha256": "560b678650666f70c251d69cd9ecd8d74a1fd6512d3b93278fdb6cada0bef491"
    },
    {
      "path": "model-ple-0021.safetensors",
      "bytes": 162517611,
      "sha256": "02cc6286c06a0f7213a06c198de0f783dc2006aa101e5c273dd468d96a3b36c3"
    },
    {
      "path": "model-ple-0022.safetensors",
      "bytes": 162517613,
      "sha256": "bfa8ec493ed26ca9df0815ade40723076c4c2a0efa99d63394ded79e22c68471"
    },
    {
      "path": "model-ple-0023.safetensors",
      "bytes": 162517613,
      "sha256": "6b92bc0a930b0b58514bda524055e43d7765495ee9102dc4937af1204e6956f8"
    },
    {
      "path": "model-ple-0024.safetensors",
      "bytes": 162517610,
      "sha256": "d38fc7b9fb7c89089231f4be8b32ae327cd91a2f57bf0427b645dc4e1ebc8dc9"
    },
    {
      "path": "model-ple-0025.safetensors",
      "bytes": 162517613,
      "sha256": "82cd3cdbca99e7458b92835fc3e10218911be6d5e61120d2a38dd40945efba74"
    },
    {
      "path": "model-ple-0026.safetensors",
      "bytes": 162517611,
      "sha256": "5990f836831ca48d69b8b73dba105a2307b2c9af21645feb35fb51ab28d44f99"
    },
    {
      "path": "model-ple-0027.safetensors",
      "bytes": 162517613,
      "sha256": "f7968ac46a0d5345ae72ae73c2db1a45ad0dff78c26426370c9edf1d22eb87cb"
    },
    {
      "path": "model-ple-0028.safetensors",
      "bytes": 162517611,
      "sha256": "21577a9c503308ab3c217f18fc5decaad21fc2bd3ede644417f347d5a591e94e"
    },
    {
      "path": "model-ple-0029.safetensors",
      "bytes": 162517613,
      "sha256": "2618f593b776753dc1d5f3115de1af1c0bafb82b7fc95ecb81f75201cdcd5c52"
    },
    {
      "path": "model-ple-0030.safetensors",
      "bytes": 162517613,
      "sha256": "ef68104b40e2fcebadf4b0dbb5ce333a6148962ad0f55d44591a217ccc81a7a6"
    },
    {
      "path": "model-ple-0031.safetensors",
      "bytes": 162517611,
      "sha256": "b5267312bfba57a9405f046d2f9c0d599355b8e5d662c82328bed82b0fd38b7f"
    },
    {
      "path": "model-ple-0032.safetensors",
      "bytes": 162517613,
      "sha256": "d1e6e9fa6fe50bc0b4a06b198642ab54160226bdbc2a1e3353d15783e43d6c03"
    },
    {
      "path": "model-ple-0033.safetensors",
      "bytes": 162517610,
      "sha256": "b5c87a349d0396a3452093554750a0a27d33c48c330a4502fc1bb98a59335205"
    },
    {
      "path": "model-ple-0034.safetensors",
      "bytes": 162517610,
      "sha256": "285b2201f4f4e9b67088b8e8bb6041e37312d2181c8de16276725fcbb25b1a38"
    },
    {
      "path": "model-ple-0035.safetensors",
      "bytes": 162517610,
      "sha256": "93a26a1da52b6401eb41226e500a01ea018c1159237cc4f29a565b8bef0e9b45"
    },
    {
      "path": "model-ple-0036.safetensors",
      "bytes": 162517610,
      "sha256": "9998f9200470eef3cbe081ca56a4742488bb40bd5e5dc5535378725c1d21cac7"
    },
    {
      "path": "model-ple-0037.safetensors",
      "bytes": 162517608,
      "sha256": "f43647a4b891fec60d70f8e0b263e24973d8fa57a2f6a611fe1d8935172c956d"
    },
    {
      "path": "model-ple-0038.safetensors",
      "bytes": 162517608,
      "sha256": "23f63c7ec3e87131c6fe94b0829977ba1b666efa4e584ff347292bc26be7a2a8"
    },
    {
      "path": "model-ple-0039.safetensors",
      "bytes": 162517610,
      "sha256": "78d89ca54a6864e73f28e642de947701c35d0c63bbebf412f33efda77217c22e"
    },
    {
      "path": "model-ple-0040.safetensors",
      "bytes": 162517607,
      "sha256": "1fbf0971973efc3630a7c25a3d9cabb7ed8b767dd0d6702edbe9f024945885fa"
    },
    {
      "path": "model-ple-0041.safetensors",
      "bytes": 162517610,
      "sha256": "9d0b5564573dfddf08f469b7a31336154bf0530f9ba70ffbd6e9fdc6c9973281"
    },
    {
      "path": "model-ple-0042.safetensors",
      "bytes": 162517610,
      "sha256": "ca6749808a672652a9e8d7af63c561dcbd96bb7d323234889c52e0f5df10a628"
    },
    {
      "path": "model-ple-0043.safetensors",
      "bytes": 162517610,
      "sha256": "a14a3348e2a64a4a4ef81d2360fb5ea2115352b193ef244f294d420626c2b881"
    },
    {
      "path": "model-ple-0044.safetensors",
      "bytes": 162517610,
      "sha256": "433deb399679ecfc31c6d75bd834a03c843a16febc451b59be9b68693e970e8c"
    },
    {
      "path": "model-ple-0045.safetensors",
      "bytes": 162517610,
      "sha256": "792712c26814c4a0934ea6f5a3bcbbf59ff223822b8e124cf138e3487a4e5635"
    },
    {
      "path": "model-ple-0046.safetensors",
      "bytes": 162517610,
      "sha256": "bd6e7759629fa915d7109ea8a9a9dc4af7a387c46cb80beb5d8e84b73e133f3b"
    },
    {
      "path": "model-ple-0047.safetensors",
      "bytes": 162517610,
      "sha256": "4ea59dc70c9442cc1d4450449b385c92a0c4af012b9b76518d5cd47a1375964c"
    },
    {
      "path": "model-ple-0048.safetensors",
      "bytes": 162517610,
      "sha256": "24c22607b7755eb4274cc571cbbab57c65fe0b60d64004f4d42213be3b687b56"
    },
    {
      "path": "model-ple-0049.safetensors",
      "bytes": 162517610,
      "sha256": "c44400085f024c6794d5ad7a7add34a8eea00557f65231cec6105bdd23df0c93"
    },
    {
      "path": "model-ple-0050.safetensors",
      "bytes": 162517610,
      "sha256": "0d917d5a73de9b4c6897a87e828bd7c42b514020390d069d193b5f7973ad533a"
    },
    {
      "path": "model-ple-0051.safetensors",
      "bytes": 162517607,
      "sha256": "a08657f80cf4bcfa76b58e2a95712e42732a4d07e1f196dbfbfbeedc29d8c32b"
    },
    {
      "path": "model-ple-0052.safetensors",
      "bytes": 162517610,
      "sha256": "9226c169066fc804824ece61af6c1df482deff3d642e26abeb3aa75759585fc2"
    },
    {
      "path": "model-ple-0053.safetensors",
      "bytes": 162517610,
      "sha256": "62c5eba712f90243988d3e3fd2fcead8fa9137e2283b8c046734c187b1e2260d"
    },
    {
      "path": "model-ple-0054.safetensors",
      "bytes": 162517610,
      "sha256": "2f37ce6dccb627e0929203888b88041af4efb05268d5eb4673ae0c8336d9524d"
    },
    {
      "path": "model-ple-0055.safetensors",
      "bytes": 162517608,
      "sha256": "06a665c9049dd04a8918861a7fdd049ebd085fda0b83bcd3b73a477ec79afb93"
    },
    {
      "path": "model-ple-0056.safetensors",
      "bytes": 162517610,
      "sha256": "83c2223c3cbf4faa536f502903c1361dfad54846e64a536d23aaca420d5cba3b"
    },
    {
      "path": "model-ple-0057.safetensors",
      "bytes": 162517610,
      "sha256": "02451943cf460f6c96aa8db6b3686bc2c9505cc91dffe766c836c75e85f09102"
    },
    {
      "path": "model-ple-0058.safetensors",
      "bytes": 162517610,
      "sha256": "1f6dd757ef355bf3f76276305ba34d982ec23cbb05da5cb47703a96743299b57"
    },
    {
      "path": "model-ple-0059.safetensors",
      "bytes": 162517608,
      "sha256": "049296bf4068be836e80ca09becc0c5c4f72ff440bf60ad21129c86eb2118e89"
    },
    {
      "path": "model-ple-0060.safetensors",
      "bytes": 162517610,
      "sha256": "25d6d1681f56066b77f8f4ddfd230be952e23b77cec0c2c308e8fcf619a527f0"
    },
    {
      "path": "model-ple-0061.safetensors",
      "bytes": 162517608,
      "sha256": "7bb8894ebd25717f21018cfc0ad947fce817add4fea44cc3f036fa0a3f644449"
    },
    {
      "path": "model-ple-0062.safetensors",
      "bytes": 162517607,
      "sha256": "1801f8fca0278a59e7a21cc7b00e8e90ff4a404a51b0c5442a9bd5b0be8eb153"
    },
    {
      "path": "model-ple-0063.safetensors",
      "bytes": 162517610,
      "sha256": "f7cf87ee4d57c10eb199258f28cb10879fd56da2a5250f666194e163b48ddb89"
    },
    {
      "path": "model-ple-0064.safetensors",
      "bytes": 162517610,
      "sha256": "309eb81cab15b0e01389709716f132c6b408779c0b94ad6234e4afa0e18f3448"
    },
    {
      "path": "model-ple-0065.safetensors",
      "bytes": 162517610,
      "sha256": "48ad0ebf5e60bbd213a88d0339aa74822cbc62a8a77e974c14ba2eba46dcbe4a"
    },
    {
      "path": "model-ple-0066.safetensors",
      "bytes": 162517610,
      "sha256": "f75fcd2d2eb0f286aaadc904b238c7ed88608c5becaa38c5d851fa5e702295ef"
    },
    {
      "path": "model-ple-0067.safetensors",
      "bytes": 162517610,
      "sha256": "327f4bf8675784e64e1c4302bb189d486607b86111983c7a0f5482af8fe21fd8"
    },
    {
      "path": "model-ple-0068.safetensors",
      "bytes": 162517610,
      "sha256": "20213bbdf517b9df9839c77cf9120c77f5072d4513a35abb7cb039819bd42c65"
    },
    {
      "path": "model-ple-0069.safetensors",
      "bytes": 162517610,
      "sha256": "9f236b1b81bf433e8e76a9f8d1fc0d1ff4bf900ef353e923e8e37171a11523b2"
    },
    {
      "path": "model-ple-0070.safetensors",
      "bytes": 162517610,
      "sha256": "c64629906cbd1abe2408bf3784a462211d28c393e27824fff33ea113b1c75117"
    },
    {
      "path": "model-ple-0071.safetensors",
      "bytes": 162517610,
      "sha256": "fe342b78522eaba1a9c2cba14d20035cff8b7b74c5f5d9361e3037b4c418d135"
    },
    {
      "path": "model-ple-0072.safetensors",
      "bytes": 162517608,
      "sha256": "6a11f577a83081bd16861c8538ac1bfa2aef0b58ce2c0d7fb32c5f50146691eb"
    },
    {
      "path": "model-ple-0073.safetensors",
      "bytes": 162517607,
      "sha256": "16d2779d4b9f6445e8ab8a49cad28848873f0e94685ebd600a3465d871dfcd31"
    },
    {
      "path": "model-ple-0074.safetensors",
      "bytes": 162517610,
      "sha256": "b054ac7da852120da25cb48c9693c0827d801f8cb9c1b41e4da2ae374ce42872"
    },
    {
      "path": "model-ple-0075.safetensors",
      "bytes": 162517608,
      "sha256": "978176ca44098355777347b1c1a14e1561cddd94e4c3d6bb33a90eb1ee9c44c2"
    },
    {
      "path": "model-ple-0076.safetensors",
      "bytes": 162517610,
      "sha256": "acd5ef57a7d82d03b08f12f9b1700ef76364a1841535e200bdf100f46b8f709c"
    },
    {
      "path": "model-ple-0077.safetensors",
      "bytes": 162517610,
      "sha256": "204679b56ea9ac00db0f51a241700a0e4bdf8beef2e458c01bdb671b92b84d55"
    },
    {
      "path": "model-ple-0078.safetensors",
      "bytes": 162517610,
      "sha256": "394607441cbd6810ef38ca26f6995d5a393986e4b3339cd257970aba085f2dd1"
    },
    {
      "path": "model-ple-0079.safetensors",
      "bytes": 162517610,
      "sha256": "91dd8cd888a0cfc4ac75945da9c498b9e7dc3c1ad50917f6adf9af8739d685ef"
    },
    {
      "path": "model-ple-0080.safetensors",
      "bytes": 162517610,
      "sha256": "d0f118aa55478c643f9ff7b7ee3e33645c98e49da42beedea257eb391e0fcf72"
    },
    {
      "path": "model-ple-0081.safetensors",
      "bytes": 162517610,
      "sha256": "587bd7f4048e0bcd779a538a806b1a41b0f5e6def044fb3d2561f19bebc2ccb5"
    },
    {
      "path": "model-ple-0082.safetensors",
      "bytes": 162517610,
      "sha256": "a48600c0601c9f2a1990b18858bdb405ab9a14816dd5df92721e3760923995b7"
    },
    {
      "path": "model-ple-0083.safetensors",
      "bytes": 162517610,
      "sha256": "8e328c737557d53c1e5fd20f4a38532880c3b4ceac791e5b5abb2ad1a139d7ec"
    },
    {
      "path": "model-ple-0084.safetensors",
      "bytes": 162517607,
      "sha256": "ca74795ff320ef322a5ad18e16e203f9b339f05985dc372486d599e048b8ba7e"
    },
    {
      "path": "model-ple-0085.safetensors",
      "bytes": 162517610,
      "sha256": "2016322ea29b115a41d77ac721e3a6f6cc97f79347a44e4299995f719531fbdc"
    },
    {
      "path": "model-ple-0086.safetensors",
      "bytes": 162517610,
      "sha256": "310ec136b99da85665a777c1af0d76c7fec3594493cba3325b364d93cc8b8f72"
    },
    {
      "path": "model-ple-0087.safetensors",
      "bytes": 162517610,
      "sha256": "9c41ea77c63d9004da58c3eb2b7ef66861e4380d693aacb2968c956126a237dc"
    },
    {
      "path": "model-ple-0088.safetensors",
      "bytes": 162517610,
      "sha256": "977cbe624b1bfb8fdb73b85805f602445b3111ca688a22aed8963a21cb5efc90"
    },
    {
      "path": "model-ple-0089.safetensors",
      "bytes": 162517608,
      "sha256": "d972a657cd9e2f4183413cc1b752c85db56aa4b4bb689940f67865e207511481"
    },
    {
      "path": "model-ple-0090.safetensors",
      "bytes": 162517610,
      "sha256": "debd7840af204142c101925b20fa9a4298bd3714920cf7b166cc82ac7c94ce40"
    },
    {
      "path": "model-ple-0091.safetensors",
      "bytes": 162517610,
      "sha256": "41f5d56a82395b13965d62021219b4eb5f1574c5aa31a193089803b5f946b5fd"
    },
    {
      "path": "model-ple-0092.safetensors",
      "bytes": 162517608,
      "sha256": "949f535a481e09597cfd42ca43e8cb14a9d3b79eed45d01581be81de7d68a1c0"
    },
    {
      "path": "model-ple-0093.safetensors",
      "bytes": 162517610,
      "sha256": "c0eebebd4ba4820b0b5a7085e8a0a37c5e49627fbdd95c3843fc9b9b3968e117"
    },
    {
      "path": "model-ple-0094.safetensors",
      "bytes": 162517610,
      "sha256": "4c2bff7f6727406b84a16a01696cc45cb579fd7ac47e8fda726c394e905c61ea"
    },
    {
      "path": "model-ple-0095.safetensors",
      "bytes": 162517607,
      "sha256": "6cd49bd827a3eeda6371463ffc35c707cb162ad15c5303ce2ead7d47e38484ad"
    },
    {
      "path": "model-ple-0096.safetensors",
      "bytes": 162517610,
      "sha256": "fc67d36a73d0f5fd501ff6667e32d278ee7e0cc778d18153a9ef3e6ac35e9ccb"
    },
    {
      "path": "model-ple-0097.safetensors",
      "bytes": 162517610,
      "sha256": "a3c7502c6f3a295bdb0e996f8064d7426ba332ab82c0c0db32e7974505fcbc1d"
    },
    {
      "path": "model-ple-0098.safetensors",
      "bytes": 162517610,
      "sha256": "481b2379c89537b25635b2b925307a6b12587b10958105c592785f59e5ed1004"
    },
    {
      "path": "model-ple-0099.safetensors",
      "bytes": 162517610,
      "sha256": "8d9745597ea7f8a654ad377984e0f0f1d66c8bd369df9b59d9cde302820410cd"
    },
    {
      "path": "model-ple-0100.safetensors",
      "bytes": 162517610,
      "sha256": "8c39dd99293f0efa7f196c1a37d5e4736b549bd2069a1bfc434729f9ed2e2e16"
    },
    {
      "path": "model-ple-0101.safetensors",
      "bytes": 162517608,
      "sha256": "76cd50cff886f8868306a600653726c0bc168c67ad4e265daf0496ab464eefbe"
    },
    {
      "path": "model-ple-0102.safetensors",
      "bytes": 162517610,
      "sha256": "e746dcc52b2f09b532be90caa6d191be4687d1369b6eb9cc913697c9615b8b6e"
    },
    {
      "path": "model-ple-0103.safetensors",
      "bytes": 162517610,
      "sha256": "2ae23393e9af7142d351bdc621d8b8c00fe44802fe2fe66919c9de0fd7007678"
    },
    {
      "path": "model-ple-0104.safetensors",
      "bytes": 162517610,
      "sha256": "a988c5c4a85adcb7239d1d4115b3e0c87210a09ddd4e21de6e50167b03604b2a"
    },
    {
      "path": "model-ple-0105.safetensors",
      "bytes": 162517608,
      "sha256": "909943b88e46cbdb376664b1a527717ad21b0cb1c7fc4f1d295b4ac72b63a8d5"
    },
    {
      "path": "model-ple-0106.safetensors",
      "bytes": 162517607,
      "sha256": "c91504b3a44c99bc12c31de2d1baa02a2562f7b464f5a2fda8e1f15a3ad43bc5"
    },
    {
      "path": "model-ple-0107.safetensors",
      "bytes": 162517610,
      "sha256": "3502f12368c58f3067eb6342ef82c968150288884122329d6035110b47ae8fb3"
    },
    {
      "path": "model-ple-0108.safetensors",
      "bytes": 162517610,
      "sha256": "973a052a6a893d66cc43959819705ebcfa2668a99758c5d0f09510e2221f697c"
    },
    {
      "path": "model-ple-0109.safetensors",
      "bytes": 162517610,
      "sha256": "b724fb08e3d9351a161a9069fd4d26e3bfd1851a081505a86f66a1a60910fdaa"
    },
    {
      "path": "model-ple-0110.safetensors",
      "bytes": 162517610,
      "sha256": "3cd154bad96d838f57e76ac95062c9d3443e8cf7f5c822793278349622158515"
    },
    {
      "path": "model-ple-0111.safetensors",
      "bytes": 162517608,
      "sha256": "7a411ca43991ff4adcf6a02d95b30c03a96314d95a7aa9c646965812fb2f0a3d"
    },
    {
      "path": "model-ple-0112.safetensors",
      "bytes": 162517610,
      "sha256": "99abf89c0b81e6d3799b9c77e859fbcde7398a058f869caf99592589d5f84d26"
    },
    {
      "path": "model-ple-0113.safetensors",
      "bytes": 162517610,
      "sha256": "5e854033c09fe5fedb76eea86d47e3b1279588be4d535cf81f7a778a84e8f3a2"
    },
    {
      "path": "model-ple-0114.safetensors",
      "bytes": 162517608,
      "sha256": "e41b78cad79790843e787ad3126301a7a33af35ecb0891187c377c5ebfe3e4f1"
    },
    {
      "path": "model-ple-0115.safetensors",
      "bytes": 162517610,
      "sha256": "9684a7c1e72774a31b44903726597c570349f99d278b017a4fc13c17982a80c8"
    },
    {
      "path": "model-ple-0116.safetensors",
      "bytes": 162517610,
      "sha256": "244a848266570bb400d50d511688a3cb32e59b731f727b975ba237d5a930856a"
    },
    {
      "path": "model-ple-0117.safetensors",
      "bytes": 162517607,
      "sha256": "568a88cfc67c70231f748854c97676f6155ebdaedc74e510256a7afe23eef8de"
    },
    {
      "path": "model-ple-0118.safetensors",
      "bytes": 162517610,
      "sha256": "fbca21b8658be6f0bc40ab1d0a470f9ab1ab1279afbc5ce95a182381a9c7dbff"
    },
    {
      "path": "model-ple-0119.safetensors",
      "bytes": 162517610,
      "sha256": "82562aa00fcf4a789e4c5fdb606361f1fdb6d20445df49251360cb61ef7a6992"
    },
    {
      "path": "model-ple-0120.safetensors",
      "bytes": 162517610,
      "sha256": "f9de874fc99605f9647f8872d710b85f6fd1976dc9e0bbcc8ac34b906b861e2a"
    },
    {
      "path": "model-ple-0121.safetensors",
      "bytes": 162517610,
      "sha256": "cebfff2bdf1e595848c1f2a5b09a839daa94bcbe19568d55ac2f73547b173924"
    },
    {
      "path": "model-ple-0122.safetensors",
      "bytes": 162517610,
      "sha256": "ebac49b8750e5ce87127f7bf581c66258af8e29f4dbf69bf79bf41f657184acc"
    },
    {
      "path": "model-ple-0123.safetensors",
      "bytes": 162517610,
      "sha256": "4ff0a08cb2e8cd8d8336efde2548b9c3d7138530eb7b1dd781c487ddb79c5d20"
    },
    {
      "path": "model-ple-0124.safetensors",
      "bytes": 162517608,
      "sha256": "ebcc18d3a223d058a7123c01ae802767c33333a78b10728477fd08c66a16a216"
    },
    {
      "path": "model-ple-0125.safetensors",
      "bytes": 162517610,
      "sha256": "d06a59cc2dd33358f16dacdaa5f0d76862fc45ca55d9e488464c293b36fb318b"
    },
    {
      "path": "model-ple-0126.safetensors",
      "bytes": 162517610,
      "sha256": "c91374cc105583946b461ed814ff6a2c2a8524ad53c7f1792f7309d8ede39ee3"
    },
    {
      "path": "model-ple-0127.safetensors",
      "bytes": 162517610,
      "sha256": "aeb7c8164e7d0223aefc283262fc80538023349301010c5a791710cd098278c3"
    },
    {
      "path": "model-vision-graft.safetensors",
      "bytes": 897899165,
      "sha256": "2888816f9b254d588a3cc32e8ba9b24e7f093e0a1fa266f6288482fb1a5d127b"
    },
    {
      "path": "mtp-head-q6.safetensors",
      "bytes": 2297560747,
      "sha256": "31e237a3c58f51508850287dda6d78ab4c454b704ae2d4b737934af233c78585"
    }
  ]
}
````

### fetch-candidate-3.2.py

Original bytes: 1931; SHA-256: `216556641bdac43826754df9ca4f02c292a66f91a1c3bfafef810df0924f0968`.

````text
import os
os.environ['HF_HUB_DISABLE_XET']='1'
os.environ['HF_HUB_DOWNLOAD_TIMEOUT']='60'
os.environ['HF_HUB_DISABLE_PROGRESS_BARS']='1'
import hashlib,json,shutil,time
from pathlib import Path
from huggingface_hub import hf_hub_download
root=Path('.build/quantization-research')
invdir=root/'inventory-3.2'
inv=json.loads((invdir/'inventory.json').read_text())
hub=json.loads((invdir/'hub-files.json').read_text())
assert hub['sha']==inv['revision']
files=[f for f in hub['siblings'] if f['rfilename'].endswith('.safetensors')]
assert sum(f['size'] for f in files)<85_000_000_000
out=root/'candidate-3.2';out.mkdir(exist_ok=True)
assert shutil.disk_usage(out).free>sum(f['size'] for f in files)+50_000_000_000
for name in ('config.json','model.safetensors.index.json','model.py'):
 shutil.copyfile(invdir/name,out/name)
receipts=[]
for f in files:
 name=f['rfilename'];assert '/' not in name and f['size']==f['lfs']['size']
 path=Path(hf_hub_download(inv['repo'],name,revision=inv['revision'],local_dir=out,token=False))
 h=hashlib.sha256();before=path.stat()
 with path.open('rb') as source:
  while True:
   data=source.read(8_000_000)
   if not data:break
   h.update(data)
 after=path.stat();assert (before.st_ino,before.st_size,before.st_mtime_ns)==(after.st_ino,after.st_size,after.st_mtime_ns)
 assert before.st_size==f['size'] and h.hexdigest()==f['lfs']['sha256']
 receipts.append({'path':name,'bytes':before.st_size,'sha256':h.hexdigest()})
 (out/'verified-progress.json').write_text(json.dumps({'revision':inv['revision'],'files':receipts},indent=2)+'\n')
 print(json.dumps({'verified':len(receipts),'of':len(files),'path':name,'bytes':before.st_size}),flush=True)
(out/'verified.json').write_text(json.dumps({'schema':1,'repo':inv['repo'],'revision':inv['revision'],'hub_metadata_sha256':hashlib.sha256((invdir/'hub-files.json').read_bytes()).hexdigest(),'files':receipts},indent=2)+'\n')
print('complete',flush=True)
````

### fetch-candidate-3.2.log

Original bytes: 12116; SHA-256: `8c212051d6d04e7c653d69e26f728c7ad32d2ed87f4db12973e6d5a54203e43e`.

````text
{"verified": 1, "of": 139, "path": "model-00001.safetensors", "bytes": 3502305114}
Warning: You are sending unauthenticated requests to the HF Hub. Please set a HF_TOKEN to enable higher rate limits and faster downloads.
{"verified": 2, "of": 139, "path": "model-00012.safetensors", "bytes": 6258175824}
{"verified": 3, "of": 139, "path": "model-00013.safetensors", "bytes": 6471407889}
{"verified": 4, "of": 139, "path": "model-00014.safetensors", "bytes": 6547978262}
{"verified": 5, "of": 139, "path": "model-00015.safetensors", "bytes": 6471407935}
{"verified": 6, "of": 139, "path": "model-00016.safetensors", "bytes": 6857620951}
{"verified": 7, "of": 139, "path": "model-00017.safetensors", "bytes": 6679034951}
{"verified": 8, "of": 139, "path": "model-00018.safetensors", "bytes": 6733521211}
{"verified": 9, "of": 139, "path": "model-00019.safetensors", "bytes": 3457093298}
{"verified": 10, "of": 139, "path": "model-ple-0000.safetensors", "bytes": 162517607}
{"verified": 11, "of": 139, "path": "model-ple-0001.safetensors", "bytes": 162517605}
{"verified": 12, "of": 139, "path": "model-ple-0002.safetensors", "bytes": 162517610}
{"verified": 13, "of": 139, "path": "model-ple-0003.safetensors", "bytes": 162517613}
{"verified": 14, "of": 139, "path": "model-ple-0004.safetensors", "bytes": 162517613}
{"verified": 15, "of": 139, "path": "model-ple-0005.safetensors", "bytes": 162517611}
{"verified": 16, "of": 139, "path": "model-ple-0006.safetensors", "bytes": 162517611}
{"verified": 17, "of": 139, "path": "model-ple-0007.safetensors", "bytes": 162517611}
{"verified": 18, "of": 139, "path": "model-ple-0008.safetensors", "bytes": 162517613}
{"verified": 19, "of": 139, "path": "model-ple-0009.safetensors", "bytes": 162517613}
{"verified": 20, "of": 139, "path": "model-ple-0010.safetensors", "bytes": 162517613}
{"verified": 21, "of": 139, "path": "model-ple-0011.safetensors", "bytes": 162517613}
{"verified": 22, "of": 139, "path": "model-ple-0012.safetensors", "bytes": 162517613}
{"verified": 23, "of": 139, "path": "model-ple-0013.safetensors", "bytes": 162517610}
{"verified": 24, "of": 139, "path": "model-ple-0014.safetensors", "bytes": 162517613}
{"verified": 25, "of": 139, "path": "model-ple-0015.safetensors", "bytes": 162517613}
{"verified": 26, "of": 139, "path": "model-ple-0016.safetensors", "bytes": 162517613}
{"verified": 27, "of": 139, "path": "model-ple-0017.safetensors", "bytes": 162517613}
{"verified": 28, "of": 139, "path": "model-ple-0018.safetensors", "bytes": 162517611}
{"verified": 29, "of": 139, "path": "model-ple-0019.safetensors", "bytes": 162517613}
{"verified": 30, "of": 139, "path": "model-ple-0020.safetensors", "bytes": 162517611}
{"verified": 31, "of": 139, "path": "model-ple-0021.safetensors", "bytes": 162517611}
{"verified": 32, "of": 139, "path": "model-ple-0022.safetensors", "bytes": 162517613}
{"verified": 33, "of": 139, "path": "model-ple-0023.safetensors", "bytes": 162517613}
{"verified": 34, "of": 139, "path": "model-ple-0024.safetensors", "bytes": 162517610}
{"verified": 35, "of": 139, "path": "model-ple-0025.safetensors", "bytes": 162517613}
{"verified": 36, "of": 139, "path": "model-ple-0026.safetensors", "bytes": 162517611}
{"verified": 37, "of": 139, "path": "model-ple-0027.safetensors", "bytes": 162517613}
{"verified": 38, "of": 139, "path": "model-ple-0028.safetensors", "bytes": 162517611}
{"verified": 39, "of": 139, "path": "model-ple-0029.safetensors", "bytes": 162517613}
{"verified": 40, "of": 139, "path": "model-ple-0030.safetensors", "bytes": 162517613}
{"verified": 41, "of": 139, "path": "model-ple-0031.safetensors", "bytes": 162517611}
{"verified": 42, "of": 139, "path": "model-ple-0032.safetensors", "bytes": 162517613}
{"verified": 43, "of": 139, "path": "model-ple-0033.safetensors", "bytes": 162517610}
{"verified": 44, "of": 139, "path": "model-ple-0034.safetensors", "bytes": 162517610}
{"verified": 45, "of": 139, "path": "model-ple-0035.safetensors", "bytes": 162517610}
{"verified": 46, "of": 139, "path": "model-ple-0036.safetensors", "bytes": 162517610}
{"verified": 47, "of": 139, "path": "model-ple-0037.safetensors", "bytes": 162517608}
{"verified": 48, "of": 139, "path": "model-ple-0038.safetensors", "bytes": 162517608}
{"verified": 49, "of": 139, "path": "model-ple-0039.safetensors", "bytes": 162517610}
{"verified": 50, "of": 139, "path": "model-ple-0040.safetensors", "bytes": 162517607}
{"verified": 51, "of": 139, "path": "model-ple-0041.safetensors", "bytes": 162517610}
{"verified": 52, "of": 139, "path": "model-ple-0042.safetensors", "bytes": 162517610}
{"verified": 53, "of": 139, "path": "model-ple-0043.safetensors", "bytes": 162517610}
{"verified": 54, "of": 139, "path": "model-ple-0044.safetensors", "bytes": 162517610}
{"verified": 55, "of": 139, "path": "model-ple-0045.safetensors", "bytes": 162517610}
{"verified": 56, "of": 139, "path": "model-ple-0046.safetensors", "bytes": 162517610}
{"verified": 57, "of": 139, "path": "model-ple-0047.safetensors", "bytes": 162517610}
{"verified": 58, "of": 139, "path": "model-ple-0048.safetensors", "bytes": 162517610}
{"verified": 59, "of": 139, "path": "model-ple-0049.safetensors", "bytes": 162517610}
{"verified": 60, "of": 139, "path": "model-ple-0050.safetensors", "bytes": 162517610}
{"verified": 61, "of": 139, "path": "model-ple-0051.safetensors", "bytes": 162517607}
{"verified": 62, "of": 139, "path": "model-ple-0052.safetensors", "bytes": 162517610}
{"verified": 63, "of": 139, "path": "model-ple-0053.safetensors", "bytes": 162517610}
{"verified": 64, "of": 139, "path": "model-ple-0054.safetensors", "bytes": 162517610}
{"verified": 65, "of": 139, "path": "model-ple-0055.safetensors", "bytes": 162517608}
{"verified": 66, "of": 139, "path": "model-ple-0056.safetensors", "bytes": 162517610}
{"verified": 67, "of": 139, "path": "model-ple-0057.safetensors", "bytes": 162517610}
{"verified": 68, "of": 139, "path": "model-ple-0058.safetensors", "bytes": 162517610}
{"verified": 69, "of": 139, "path": "model-ple-0059.safetensors", "bytes": 162517608}
{"verified": 70, "of": 139, "path": "model-ple-0060.safetensors", "bytes": 162517610}
{"verified": 71, "of": 139, "path": "model-ple-0061.safetensors", "bytes": 162517608}
{"verified": 72, "of": 139, "path": "model-ple-0062.safetensors", "bytes": 162517607}
{"verified": 73, "of": 139, "path": "model-ple-0063.safetensors", "bytes": 162517610}
{"verified": 74, "of": 139, "path": "model-ple-0064.safetensors", "bytes": 162517610}
{"verified": 75, "of": 139, "path": "model-ple-0065.safetensors", "bytes": 162517610}
{"verified": 76, "of": 139, "path": "model-ple-0066.safetensors", "bytes": 162517610}
{"verified": 77, "of": 139, "path": "model-ple-0067.safetensors", "bytes": 162517610}
{"verified": 78, "of": 139, "path": "model-ple-0068.safetensors", "bytes": 162517610}
{"verified": 79, "of": 139, "path": "model-ple-0069.safetensors", "bytes": 162517610}
{"verified": 80, "of": 139, "path": "model-ple-0070.safetensors", "bytes": 162517610}
{"verified": 81, "of": 139, "path": "model-ple-0071.safetensors", "bytes": 162517610}
{"verified": 82, "of": 139, "path": "model-ple-0072.safetensors", "bytes": 162517608}
{"verified": 83, "of": 139, "path": "model-ple-0073.safetensors", "bytes": 162517607}
{"verified": 84, "of": 139, "path": "model-ple-0074.safetensors", "bytes": 162517610}
{"verified": 85, "of": 139, "path": "model-ple-0075.safetensors", "bytes": 162517608}
{"verified": 86, "of": 139, "path": "model-ple-0076.safetensors", "bytes": 162517610}
{"verified": 87, "of": 139, "path": "model-ple-0077.safetensors", "bytes": 162517610}
{"verified": 88, "of": 139, "path": "model-ple-0078.safetensors", "bytes": 162517610}
{"verified": 89, "of": 139, "path": "model-ple-0079.safetensors", "bytes": 162517610}
{"verified": 90, "of": 139, "path": "model-ple-0080.safetensors", "bytes": 162517610}
{"verified": 91, "of": 139, "path": "model-ple-0081.safetensors", "bytes": 162517610}
{"verified": 92, "of": 139, "path": "model-ple-0082.safetensors", "bytes": 162517610}
{"verified": 93, "of": 139, "path": "model-ple-0083.safetensors", "bytes": 162517610}
{"verified": 94, "of": 139, "path": "model-ple-0084.safetensors", "bytes": 162517607}
{"verified": 95, "of": 139, "path": "model-ple-0085.safetensors", "bytes": 162517610}
{"verified": 96, "of": 139, "path": "model-ple-0086.safetensors", "bytes": 162517610}
{"verified": 97, "of": 139, "path": "model-ple-0087.safetensors", "bytes": 162517610}
{"verified": 98, "of": 139, "path": "model-ple-0088.safetensors", "bytes": 162517610}
{"verified": 99, "of": 139, "path": "model-ple-0089.safetensors", "bytes": 162517608}
{"verified": 100, "of": 139, "path": "model-ple-0090.safetensors", "bytes": 162517610}
{"verified": 101, "of": 139, "path": "model-ple-0091.safetensors", "bytes": 162517610}
{"verified": 102, "of": 139, "path": "model-ple-0092.safetensors", "bytes": 162517608}
{"verified": 103, "of": 139, "path": "model-ple-0093.safetensors", "bytes": 162517610}
{"verified": 104, "of": 139, "path": "model-ple-0094.safetensors", "bytes": 162517610}
{"verified": 105, "of": 139, "path": "model-ple-0095.safetensors", "bytes": 162517607}
{"verified": 106, "of": 139, "path": "model-ple-0096.safetensors", "bytes": 162517610}
{"verified": 107, "of": 139, "path": "model-ple-0097.safetensors", "bytes": 162517610}
{"verified": 108, "of": 139, "path": "model-ple-0098.safetensors", "bytes": 162517610}
{"verified": 109, "of": 139, "path": "model-ple-0099.safetensors", "bytes": 162517610}
{"verified": 110, "of": 139, "path": "model-ple-0100.safetensors", "bytes": 162517610}
{"verified": 111, "of": 139, "path": "model-ple-0101.safetensors", "bytes": 162517608}
{"verified": 112, "of": 139, "path": "model-ple-0102.safetensors", "bytes": 162517610}
{"verified": 113, "of": 139, "path": "model-ple-0103.safetensors", "bytes": 162517610}
{"verified": 114, "of": 139, "path": "model-ple-0104.safetensors", "bytes": 162517610}
{"verified": 115, "of": 139, "path": "model-ple-0105.safetensors", "bytes": 162517608}
{"verified": 116, "of": 139, "path": "model-ple-0106.safetensors", "bytes": 162517607}
{"verified": 117, "of": 139, "path": "model-ple-0107.safetensors", "bytes": 162517610}
{"verified": 118, "of": 139, "path": "model-ple-0108.safetensors", "bytes": 162517610}
{"verified": 119, "of": 139, "path": "model-ple-0109.safetensors", "bytes": 162517610}
{"verified": 120, "of": 139, "path": "model-ple-0110.safetensors", "bytes": 162517610}
{"verified": 121, "of": 139, "path": "model-ple-0111.safetensors", "bytes": 162517608}
{"verified": 122, "of": 139, "path": "model-ple-0112.safetensors", "bytes": 162517610}
{"verified": 123, "of": 139, "path": "model-ple-0113.safetensors", "bytes": 162517610}
{"verified": 124, "of": 139, "path": "model-ple-0114.safetensors", "bytes": 162517608}
{"verified": 125, "of": 139, "path": "model-ple-0115.safetensors", "bytes": 162517610}
{"verified": 126, "of": 139, "path": "model-ple-0116.safetensors", "bytes": 162517610}
{"verified": 127, "of": 139, "path": "model-ple-0117.safetensors", "bytes": 162517607}
{"verified": 128, "of": 139, "path": "model-ple-0118.safetensors", "bytes": 162517610}
{"verified": 129, "of": 139, "path": "model-ple-0119.safetensors", "bytes": 162517610}
{"verified": 130, "of": 139, "path": "model-ple-0120.safetensors", "bytes": 162517610}
{"verified": 131, "of": 139, "path": "model-ple-0121.safetensors", "bytes": 162517610}
{"verified": 132, "of": 139, "path": "model-ple-0122.safetensors", "bytes": 162517610}
{"verified": 133, "of": 139, "path": "model-ple-0123.safetensors", "bytes": 162517610}
{"verified": 134, "of": 139, "path": "model-ple-0124.safetensors", "bytes": 162517608}
{"verified": 135, "of": 139, "path": "model-ple-0125.safetensors", "bytes": 162517610}
{"verified": 136, "of": 139, "path": "model-ple-0126.safetensors", "bytes": 162517610}
{"verified": 137, "of": 139, "path": "model-ple-0127.safetensors", "bytes": 162517610}
{"verified": 138, "of": 139, "path": "model-vision-graft.safetensors", "bytes": 897899165}
{"verified": 139, "of": 139, "path": "mtp-head-q6.safetensors", "bytes": 2297560747}
complete
````

### vq-order-proof-3.2-v1.log

Original bytes: 7163; SHA-256: `47a99bb20eef724fdac62da25e79c5314b2ea000d312dd7ab1119f13ceb70f5c`.

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
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/prefill_bench.py", line 52, in preflight
    try: fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
BlockingIOError: [Errno 35] Resource temporarily unavailable

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/vq_model_reference.py", line 446, in <module>
    main()
  File "<HOME>/Projects/slotstream/Tools/vq_model_reference.py", line 370, in main
    quiet_preflight(13)  # Recheck after the potentially long file verification.
    ^^^^^^^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/Tools/context_qualification.py", line 58, in quiet_preflight
    return preflight(needed_gb)
           ^^^^^^^^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/Tools/prefill_bench.py", line 53, in preflight
    except BlockingIOError as e: raise RuntimeError("another model process holds the lock") from e
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
RuntimeError: another model process holds the lock
````

### vq-order-proof-3.2-v2.log

Original bytes: 7016; SHA-256: `f48868b3ef61395354c924ec7af7acb3b4fa2eb62550d501325a3480f1db5839`.

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
strict model loading complete
direct chunked traversal complete
{"layer": 0, "seconds": 0.05706150000332855, "memory": {"current_bytes": 5676094456, "lifetime_peak_bytes": 6392632600, "rss_peak_bytes": 5309693952}, "mlx_peak_bytes": 5922045834}
{"layer": 1, "seconds": 0.09671691700350493, "memory": {"current_bytes": 4272984144, "lifetime_peak_bytes": 6392632600, "rss_peak_bytes": 5309693952}, "mlx_peak_bytes": 5922045834}
{"layer": 2, "seconds": 0.047348291001981124, "memory": {"current_bytes": 2589297544, "lifetime_peak_bytes": 6392632600, "rss_peak_bytes": 5309693952}, "mlx_peak_bytes": 5922045834}
{"layer": 3, "seconds": 0.041769292001845315, "memory": {"current_bytes": 1569359960, "lifetime_peak_bytes": 6392632600, "rss_peak_bytes": 5309693952}, "mlx_peak_bytes": 5922045834}
{"layers": 4, "logits": {"traversal_equal_bits": true, "layers": 4, "tokens": 513, "output_sha256": "e4c2500aa9e8c9cb025b62d9680081076f961d15ba07711e83070a24f3ba86b8"}, "memory": {"current_bytes": 1138902864, "lifetime_peak_bytes": 6392632600, "rss_peak_bytes": 5309693952}}
````

### vq-order-proof-3.2-v2/receipt.json

Original bytes: 140852; SHA-256: `5b4ef4b85b18305386f65e2d8022e1475bcd41b8af2541ea3b3a4c93b4105d02`.

````text
{
  "schema": 1,
  "scope": "pilot feasibility, not native parity or quality qualification",
  "architecture_revision": "2097324ed04ff76078366c77148b88b9db612ba2",
  "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87",
  "runtime_sha256": "1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8",
  "mlx": "0.32.2",
  "mlx_lm": "0.31.3",
  "instrument": {
    "scripts": {
      "vq_model_reference.py": "a6e2a4a384b0b2bbc3551ec5fa6a0437c0b48699972c1fd3ef3b60068d7a36b2",
      "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
      "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
      "vq_kernel_sources.py": "00e931902b2c4f8b6f348897ca5c094f23747ea7d9260868d5440d791309a84c",
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
    "sha256": "45d0aa6658bfb05a0bd989bb51f4d3f3b77e65386dbbc5d185f9184eeeb03514"
  },
  "vq_decode_chunk": 32,
  "prompt_chunk": 512,
  "tokens": [
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    248044,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    248044,
    1246
  ],
  "positions": [
    497,
    498,
    499,
    500,
    501,
    502,
    503,
    504,
    505,
    506,
    507,
    508,
    509,
    510,
    511,
    512
  ],
  "tokens_sha256": "a9d0087a584fef727945b03897a57da9c5d720bd7e849b7a43744c70727b2e73",
  "layers": 4,
  "logits": null,
  "traversal_proof": {
    "traversal_equal_bits": true,
    "layers": 4,
    "tokens": 513,
    "output_sha256": "e4c2500aa9e8c9cb025b62d9680081076f961d15ba07711e83070a24f3ba86b8"
  },
  "order_proof_sha256": null,
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23297163264,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     4040.\nPages active:                                 957382.\nPages inactive:                              1279595.\nPages speculative:                              1868.\nPages throttled:                                   0.\nPages wired down:                             189975.\nPages purgeable:                                1053.\n\"Translation faults\":                      829332585.\nPages copy-on-write:                        50243549.\nPages zero filled:                        1678201448.\nPages reactivated:                          88793049.\nPages purged:                               10045492.\nFile-backed pages:                           1416853.\nAnonymous pages:                              821992.\nPages stored in compressor:                  1174329.\nPages occupied by compressor:                 652648.\nDecompressions:                             18689735.\nCompressions:                               26305774.\nPageins:                                   189844794.\nPageouts:                                     289832.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 128567.\nPages tagged resident:                         88199.\nPages tagged compressed:                       40368.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          126.\nPages tag-storage non-tag pageable:            92983.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5992128.\nTagged compressions:                          380611.\nTagged decompressions:                        311094.\n"
  },
  "allocation_before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23147216896,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     4165.\nPages active:                                 978947.\nPages inactive:                              1264250.\nPages speculative:                              2565.\nPages throttled:                                   0.\nPages wired down:                             182778.\nPages purgeable:                                4837.\n\"Translation faults\":                      829408266.\nPages copy-on-write:                        50243974.\nPages zero filled:                        1678292989.\nPages reactivated:                          88794831.\nPages purged:                               10048657.\nFile-backed pages:                           1403792.\nAnonymous pages:                              841970.\nPages stored in compressor:                  1174254.\nPages occupied by compressor:                 652635.\nDecompressions:                             18689810.\nCompressions:                               26305774.\nPageins:                                   194539004.\nPageouts:                                     289915.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 128645.\nPages tagged resident:                         88278.\nPages tagged compressed:                       40367.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5187.\nPages tag-storage free:                          216.\nPages tag-storage non-tag pageable:            92893.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5992128.\nTagged compressions:                          380611.\nTagged decompressions:                        311095.\n"
  },
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22816849920,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   322994.\nPages active:                                 919193.\nPages inactive:                               901675.\nPages speculative:                             16759.\nPages throttled:                                   0.\nPages wired down:                             233452.\nPages purgeable:                                3269.\n\"Translation faults\":                      829789097.\nPages copy-on-write:                        50245754.\nPages zero filled:                        1678828696.\nPages reactivated:                          88849634.\nPages purged:                               10048684.\nFile-backed pages:                           1066367.\nAnonymous pages:                              771260.\nPages stored in compressor:                  1234036.\nPages occupied by compressor:                 691347.\nDecompressions:                             18721210.\nCompressions:                               26396795.\nPageins:                                   194878633.\nPageouts:                                     289915.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 128973.\nPages tagged resident:                         88299.\nPages tagged compressed:                       40674.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5186.\nPages tag-storage free:                          339.\nPages tag-storage non-tag pageable:            92771.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6041920.\nTagged compressions:                          381280.\nTagged decompressions:                        311457.\n"
  },
  "process_memory": {
    "current_bytes": 1138902864,
    "lifetime_peak_bytes": 6392632600,
    "rss_peak_bytes": 5309693952
  },
  "peak_mlx_bytes": 5922045834,
  "artifact": {
    "verification_sha256": "ec76e8ddf0a7038ad51f3a08cabf12e2c22ca199b15d4b94c71688c1a73b8d7e",
    "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe"
  },
  "ple": {
    "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
    "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
    "scope": "pinned headers and selected bytes; full-payload provenance is a separate gate",
    "files": {
      "model-ple-0000.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1a77d6eb888fb7e24886450f4f7102323a371741ff4e51b50e87a740b1fad773"
      },
      "model-ple-0001.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f2f023233a5f21abb194ebb8c3c0b3253d564bade0fad04724d8b21a4cf17b76"
      },
      "model-ple-0002.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f28fc840c5f805d994cdd66c33173b07ffc94fb1990a51c6549aefb2f0ea85ea"
      },
      "model-ple-0003.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "7fd3ce750bfc99478fa7438529098fd99edeafc01d775c9ae51b407c0de61400"
      },
      "model-ple-0004.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "36110f9d39e25076a61050b2a74ece55f1b8400da53fa81145ac2d8cf321b50e"
      },
      "model-ple-0005.safetensors": {
        "bytes_read": 17034,
        "reads": 21,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ecf277ef69fb2144d26a3012956bca454fe326007c232a51eaac809a836c1d3c"
      },
      "model-ple-0006.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dcbe407dc06df2ebe6d33f02458ecd7a32769b27d36d013ac1542abcd98932f0"
      },
      "model-ple-0007.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5c8454df0757886dfdf0b6014d5fee650befc41bcd4a4b05c0d7f29f86b6a3d9"
      },
      "model-ple-0008.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ba87d2c5573729406bcca9d701b85ee2e2905b8690a34adedd9a772e09c0b8ca"
      },
      "model-ple-0009.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ef62f505ff8c7611be6a4fc1f27393fd1f45f2a28a6e8f6627e4e87cca6976fe"
      },
      "model-ple-0010.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dcd740909f3309926c445dc9aa8f7e7bcf0d688787b03d822686b1138a1c80fd"
      },
      "model-ple-0011.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "29f38b6959e7fcd2d5c66bcdb4693dde406636bc4986d20581d395944e2ecf5e"
      },
      "model-ple-0012.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "52b140cd4f0621f45110be8bec91492ee5fde9dbfd5742080600b986ce5bf1c9"
      },
      "model-ple-0013.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "31de4adaabecb9aa4888443d7a65ffda37101816dcf56d10cc56477afa71a95b"
      },
      "model-ple-0014.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "fc98c6e9120fd7c83b5ed83c1da6970e1c0b1eb480bcab90140fed855452f6be"
      },
      "model-ple-0015.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dda47c00ab437271bca5cfa9eddafc283db93497e0012cb41828c4151458ef90"
      },
      "model-ple-0016.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5394d1695b71450e5ca6aae866ad20564d413b275fba9b3b6bd2477df967e4f2"
      },
      "model-ple-0017.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ae1eef1dcf859b83ca63f3effc9fefb5335e88ec2f456feb054c8af0f8286914"
      },
      "model-ple-0018.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bd5b6773ca81e1a8ef400d8670f25554289e95a21a4a1550644687b66e0f9a01"
      },
      "model-ple-0019.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a8276e14d62881a67a1ad6d780fec3c2d6aa229559decaa47e755b59da2ffb17"
      },
      "model-ple-0020.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8152d94b31e15378ff7399cf836d1f9fa51a8fa669cec75b6db1f7a2fd67caa9"
      },
      "model-ple-0021.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b638b1dc38d9997d6d620d0e85e14fa16635a91ccda33c66fb26c68687f32f1c"
      },
      "model-ple-0022.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b85b4ae24c54c04dbcdc06f36a41189494ebe10256eadaae45fa877e69795c24"
      },
      "model-ple-0023.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e675c5bb6dcc51c02589821646858b4d3d220e60e00f70f6af4c2e648cfb8c20"
      },
      "model-ple-0024.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "fcf1bd5627bbc28ca62e60561ed079fc14c14e98e4acf267e5b16a804674aab7"
      },
      "model-ple-0025.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b8789679e2413423b139bae1102156c3292f705656f6de7bc739208ad642d826"
      },
      "model-ple-0026.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ecb91daecc103c6d887f949369e0507038df19c3bf9f410201771c288751e15"
      },
      "model-ple-0027.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "97f218d7a201225907b9c0800f4cd9c0eed7578d32e031f6b7c8f9a05fc61fee"
      },
      "model-ple-0028.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f72b0206ca34eac6bd71f7211033e79d14f63113bb2aba64123d8e257d70e048"
      },
      "model-ple-0029.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "373d7bddc9007c3f0bab2f4c2987fafb3e69806995e581a64c2378879ed4ff96"
      },
      "model-ple-0030.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "964de7e0c73056f4b6d9211e1df05fe5b95c06c46e5363f70e5fcb2091c6742f"
      },
      "model-ple-0031.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "92462f146bae77871a793f6b42d790948f0fdf2ca62b5ca8f25c5282e4be0b67"
      },
      "model-ple-0032.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3a13866cd08261ea003e939a9d4bffe69ac4445db668ea80ab5a14077ecd37b8"
      },
      "model-ple-0033.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ecd89f0454a931951af4e68f8f4776fa2f8cf9291835c5a7f240e976d3176946"
      },
      "model-ple-0034.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "75bfa391e25a7bd96465f456298fd5163dfb1cabaf91243c8e65438f991df650"
      },
      "model-ple-0035.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c3702646a2c998706341d8dc278f0bf426fdac347d51624b4521cff77e248bdc"
      },
      "model-ple-0036.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "78c746cbeb20c2afc31a1e3abdff0994cf500935cfe7f9d94f8081561b811edb"
      },
      "model-ple-0037.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "6cf1f353a7c903b16f4a805eca32a546e473d0c11c5d6ded8f225fd17a52ca3b"
      },
      "model-ple-0038.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "22c05adbab2fca388a871dbea75cb782c99bd2ac174cd31033c87146a504afeb"
      },
      "model-ple-0039.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4f9b4807fc8cd7fd9b3a38c526dd110a2581949f3209a201f24c6cf011b7d448"
      },
      "model-ple-0040.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "768193c02533c030677b18c52b972bb40351726b046b15d829a20115f27fb858"
      },
      "model-ple-0041.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f9c4a0f4773dce28d3e900d233087c6eb21ab6db8c964b25efa660c1ebe32ab9"
      },
      "model-ple-0042.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a7eacd86ce7760d259a0b2411706f836ff806bef17e71e0b9ec00ef662c78c8e"
      },
      "model-ple-0043.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "532f8e36dea0d5450130985fd86cd0d860fb234b49953f8f7f46907b4a9df671"
      },
      "model-ple-0044.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8905a009fcef95af5ac517f47a6247a5e80842dd68b28fcf1eb8680161177aeb"
      },
      "model-ple-0045.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3312ea3c6c3ee659b5ecff16d4e18e64514d9b308861ed552d6f9bb246720b90"
      },
      "model-ple-0046.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bf1187cbbc253ceb6312eb052643bee025136f6e863be379268982b9f602b913"
      },
      "model-ple-0047.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c3474245e81348915a3eea3b033c3c8f78296b1f7836fd7012a59142af135d49"
      },
      "model-ple-0048.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "49d0e4a2affd71c40af50a101f967a4ae4d26be21ca5639b97c1522f88d92921"
      },
      "model-ple-0049.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b621bdf2ac2bcb2da9403de0b028302b3cbac8e18e3a46396f0cf5a0038efb29"
      },
      "model-ple-0050.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "55d43c476938a9ba51bd775e69956ce1ddd69e5dfff0be9cc46d66ddd9fc742a"
      },
      "model-ple-0051.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b99d8086e2aa0009d4fadb21d4e7da6b7bcb82e4b6610d2ab5345445730f9150"
      },
      "model-ple-0052.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "11f43d44ff13f9542cf1496263ad57f51f2765eb23905afebc2e79c54a7bf3e1"
      },
      "model-ple-0053.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "288fe71606fd54fe4766be350ee0fa761a15e176c23eae99a1e457b7640c2b5a"
      },
      "model-ple-0054.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "cdda85af7c5f26cba6e15713398f8cbd713fd6b7b009792d49bc5cca6c32f0ef"
      },
      "model-ple-0055.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "02c19734b541ff11baafe90bd1f043351bc11553d8b90cca19ddcacf2e872cf4"
      },
      "model-ple-0056.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "de0ffa1631acadd04e5390ed5d5061ab241baa5276783eb43ac398fe9eb3f289"
      },
      "model-ple-0057.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0fb4b07fed1aac5094ca402e4a7eac341bd611b14c767d083b91eaa908ea8192"
      },
      "model-ple-0058.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "469b8bb94cad3f6f6e80f5b7d4cdbd73ecea41d99f1ff28edfc7126ccbb86ac4"
      },
      "model-ple-0059.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "89e5ac048329f69dffb2d2660c213004beded2ed9fd8b7da80d8524c514796f2"
      },
      "model-ple-0060.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c2fbac09b7ca7656897a9c15d96fcc0dbf5994f8ecc71a0efcbb9dcea51899a2"
      },
      "model-ple-0061.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "edb275ccfba5a84785202235f9047fba0964b674f7952e54d3ac1641b3522d84"
      },
      "model-ple-0062.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bf70928c5a17433118e2f4db2b8ea5780d18b615c126261dfd56e8993f4d7ca4"
      },
      "model-ple-0063.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4799ddde1618307c7b6ca56cc93192ccc5bc6cb32e5e550426fb866ab94e7d25"
      },
      "model-ple-0064.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a4453fcd18ae242d0d6f67a0f8209b0b0cfab3d3aa9791ad01bc904de1c02099"
      },
      "model-ple-0065.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ac31d394ecd8dea25bd1c2625a9e998ad67aa951cedd0aac48a31e47db78b81"
      },
      "model-ple-0066.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c16abafe35c3cd0f51bf18ebc25662655802f69a04c403cab34b2f1f79788d07"
      },
      "model-ple-0067.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "aa35e31d2d5111cd5bd3f4bcd7e5b62501ad03c079dd28b1177b7a17ceddba8b"
      },
      "model-ple-0068.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bd98a2e72df10bd2815be59878b26c5a7ea85040c3869b349c19489ea340cb2f"
      },
      "model-ple-0069.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1fa6ae26655070c074e968d0c5c8cabf05d2b814382c7b6fd626d9aeeecd8b8c"
      },
      "model-ple-0070.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a98f09cffc458ba3b06f0d4691166b3995ba244e3834a464918ad87c7e7440c3"
      },
      "model-ple-0071.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "912a2353655ca8c651fc5778748f06eba4a993449e48bb755457a97f4cc4a178"
      },
      "model-ple-0072.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "aad2f7fe78c8bd5364989956650ce03987f5589692463a1ebd38407120b2a44f"
      },
      "model-ple-0073.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "03ca33b11a000fe10458eafc4a4691d8830a9bf2d3a2605176ab824e3e5a5394"
      },
      "model-ple-0074.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a8c97f4735b7cbe0b5d4ed65ff1c1cded837e5e39df1ff14d24be87a7d3114b9"
      },
      "model-ple-0075.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f94d01c69433866f9b0736ed1b9d47316bb218f76114859adfe819e68e2f60fd"
      },
      "model-ple-0076.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b9093a80151735a124dbb58b0e66aaa5246ccb9ca8456da4544a62ff71ebc400"
      },
      "model-ple-0077.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "54cc70f3926c7d83e3fe983856ec245df11068aae2ccf0ec4654ad147e408b52"
      },
      "model-ple-0078.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ff2b2bdd002619eff9af6f611579e3cfa97b0ea7ecba1c1e2c0c7895e9c0adde"
      },
      "model-ple-0079.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "50698b2fa5b2c1cc224f65d568e74a9dccdcfe30b2c56a1a8c33230e85ff3761"
      },
      "model-ple-0080.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "23290be37802733804125dec069184bf2e940e6b62b9f4cd29279832874e341f"
      },
      "model-ple-0081.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a41c474a85d8814056cd62105df88417859d991efb7c4c75337c075dc5472923"
      },
      "model-ple-0082.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "66e199d9fe475202da2aeea1a3beaaa843d8833f8dbb8f0f8ebe8123528bb47b"
      },
      "model-ple-0083.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "af1c796203e4a1d9a5fa517068417f74cc1c8054a760df0d7280d524a79401f5"
      },
      "model-ple-0084.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "9d474c9eb7af61c83fc2c9fbb488940c421405d31fc67da7f04ef460a9a1d1ee"
      },
      "model-ple-0085.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bb9c554e63b2b004df529d7ceca9aa3f1f1bf685ac83d8c7deb3b300da1e8c0e"
      },
      "model-ple-0086.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "415548af2e2307aa329ae4bfbd70ce06a1a87098dc25afcad293447abd423ad3"
      },
      "model-ple-0087.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "858d3c6ef41eb7e817f89d823cdec6b6caea73c137288ad08e8eab08f119772d"
      },
      "model-ple-0088.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "15463319e21e61e39dc010000a0fdbdaa890156d5e2d144cf2fb01075820eaef"
      },
      "model-ple-0089.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "696ca36ea1ca83917d5bf1c625aef6348efa62b24d5146b06e44126b4bc0ec32"
      },
      "model-ple-0090.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "14c8dd9e7c44800316170713ddef753aac93ecae84d773e211e21a2ec9ac6f2d"
      },
      "model-ple-0091.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f8393d7c8c541c6c54ed5b45c4fdd0f5be2a99008cfbf41a495ca64e62c2435f"
      },
      "model-ple-0092.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "21842575e50065223db524da1c4900f6eb9f926f3554344608084a096ccfc437"
      },
      "model-ple-0093.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4b1fbe90a23014072ebc46ff0efaa0fcd7c1f9fc09014a6a56cde872dfb119d2"
      },
      "model-ple-0094.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "583157efb87d0a37df0ab520c6e27053986bc328540889b9c199273b94a64bf4"
      },
      "model-ple-0095.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a79812e4e60c09a1246e78502591403a413685baef4ac846e36fbb359d993afc"
      },
      "model-ple-0096.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8df14f8ba996c53f0417f734cf70a4f5fa9af63abe386ec9e6b15a1b13bd6918"
      },
      "model-ple-0097.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0f786045e8079d0fc2480ba3e0c18a3736335667838c8412cdf317503dcd0eb9"
      },
      "model-ple-0098.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1ca65f3c186a50a7237b7a3715d2ee67979f3e26fab4ca4bcde6e95371c7d76e"
      },
      "model-ple-0099.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "299f2064379bc7011e0b61f921e365b75040232c8090f28dc94682090cbb7058"
      },
      "model-ple-0100.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "95c8400bc37157c1c8e2639a528a87cb0e316e493e877cb5cce82451ae931cf8"
      },
      "model-ple-0101.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "aeef4e8f98cfe39ba4552d5a3066575f3b5cdaa8a084d9393a2b6ffab793a85f"
      },
      "model-ple-0102.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1b944bb1d709abc39fce5c4b215067359ea9d6c4c4ee2642e316f471b8f02b2f"
      },
      "model-ple-0103.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "afc49ca27e01d2737d381a0e028557c3645a8c9563f13808af037f30b4b46875"
      },
      "model-ple-0104.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "32baece43ac8eb73646bd0857ada9210588ec977d6cf68cded5d74e4698bf572"
      },
      "model-ple-0105.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b64ebcbe7001faeffc3dc87e2a759931ad089f051d47ed85cef5eaf0742ed00f"
      },
      "model-ple-0106.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "adc331094db3e3f69cc4d23873c1a5197e1cdb013e61e2abfc872c48cf9bf6cc"
      },
      "model-ple-0107.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8d2bd2097afc716035abc540e1afa50fabfb034b11bb7f5160ec209c96c9ef80"
      },
      "model-ple-0108.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dfd28d3b80f5ec901a604a5f5332139eb8261692efad7406659e6dacb9ef8d69"
      },
      "model-ple-0109.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e2fbc8c72a01788f02ca2e67b8c9e2b88095ddc459b7b004c53da7bbc4f893ba"
      },
      "model-ple-0110.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "6efa0063d0f40808c2770b93ce7c8e4ddb583e6657ddefe8ed89681c0940eea7"
      },
      "model-ple-0111.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "105db24f61d8054d45ca408cf6022d104847f54d4dba6750e2559df85bccb7d8"
      },
      "model-ple-0112.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "cc80a05bbe331f12a6014dbd1b154c139ec540158c9e5e58fd4b334973188c54"
      },
      "model-ple-0113.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ff2f6f0448180f7cca7ff8681d7d1a3dba0ff2e564288428690e2bf2749e400b"
      },
      "model-ple-0114.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "da4623bd09c4db7284e1f9699b4194bf807b0f8bb22878d31e1e1e8940bded64"
      },
      "model-ple-0115.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5cada7840d40160752fc660ba396f299e7c9ebfcdf50dd13043b80978178699d"
      },
      "model-ple-0116.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c4fa432470d92345e4e9e6e056a024a7abbbec272c1205d2bf85e48071dfe8e7"
      },
      "model-ple-0117.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "567f929791b3fc853ba116a60fa880f7d081de2a4b47041c2977323110892b6e"
      },
      "model-ple-0118.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5df70160db9a4e52e1c63b7cfdb8f12338d04cba4e45ec9b32dc9abf4a79bc4e"
      },
      "model-ple-0119.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e66d4681634b283eb2e3922e4509759f55e4f1e3fbbb7abb3bf8b198667d4b74"
      },
      "model-ple-0120.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a90805eca5e8020b3726af97ce3621e1e1bb5d7fecf007dab1bd87cf7c098cc0"
      },
      "model-ple-0121.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e943b951ed98e79c96138eedae6fba364f1d63a9453fda231543c6338a2e0254"
      },
      "model-ple-0122.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "94d9038384eb88d049e82a52b7da7cf0a16ee7059176f2d37d2137a347e68752"
      },
      "model-ple-0123.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5a8b624394d9ecb8098b710799fad55e701d6fe55cdf70e532c42eee47d934bf"
      },
      "model-ple-0124.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1f0a348da08475d259f1a50093e0a25371fd0dedb40e122690640a48714435bf"
      },
      "model-ple-0125.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "91c49a44b616996b3faf538752ca7a70ad28b82faf07bfcf88fe9e1e0fc6132b"
      },
      "model-ple-0126.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "2b96a6f05321da44315ff01193de77c16364a81a341bbb57cb66974e41c30956"
      },
      "model-ple-0127.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "72a412543c2a51f822d448102c918789d4fe1e1927a7a59ef1e267851f40d6e2"
      }
    },
    "tables": {
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_1": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_10": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_100": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_101": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_102": {
        "calls": 4,
        "rows_requested": 342,
        "unique_rows_read": 10,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_103": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_104": {
        "calls": 2,
        "rows_requested": 6,
        "unique_rows_read": 6,
        "max_rows": 3,
        "max_result_bytes": 195
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_105": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_106": {
        "calls": 2,
        "rows_requested": 336,
        "unique_rows_read": 4,
        "max_rows": 168,
        "max_result_bytes": 10920
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_107": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_108": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_109": {
        "calls": 2,
        "rows_requested": 338,
        "unique_rows_read": 6,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_11": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_110": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_111": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_112": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_113": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_114": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_115": {
        "calls": 2,
        "rows_requested": 342,
        "unique_rows_read": 8,
        "max_rows": 171,
        "max_result_bytes": 11115
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_116": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_117": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_118": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_119": {
        "calls": 2,
        "rows_requested": 506,
        "unique_rows_read": 6,
        "max_rows": 253,
        "max_result_bytes": 16445
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_12": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_120": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_121": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_122": {
        "calls": 4,
        "rows_requested": 172,
        "unique_rows_read": 6,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_123": {
        "calls": 2,
        "rows_requested": 508,
        "unique_rows_read": 8,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_124": {
        "calls": 2,
        "rows_requested": 338,
        "unique_rows_read": 4,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_125": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_126": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_127": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_13": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_14": {
        "calls": 2,
        "rows_requested": 342,
        "unique_rows_read": 6,
        "max_rows": 171,
        "max_result_bytes": 11115
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_15": {
        "calls": 4,
        "rows_requested": 6,
        "unique_rows_read": 6,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_16": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_17": {
        "calls": 2,
        "rows_requested": 512,
        "unique_rows_read": 8,
        "max_rows": 256,
        "max_result_bytes": 16640
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_18": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_19": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_2": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_20": {
        "calls": 4,
        "rows_requested": 174,
        "unique_rows_read": 8,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_21": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_22": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_23": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_24": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_25": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_26": {
        "calls": 2,
        "rows_requested": 338,
        "unique_rows_read": 4,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_27": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_28": {
        "calls": 4,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_29": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_3": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_30": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_31": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_32": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_33": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_34": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_35": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_36": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_37": {
        "calls": 4,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_38": {
        "calls": 2,
        "rows_requested": 508,
        "unique_rows_read": 6,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_39": {
        "calls": 2,
        "rows_requested": 340,
        "unique_rows_read": 4,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_4": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_40": {
        "calls": 4,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_41": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_42": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_43": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_44": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_45": {
        "calls": 2,
        "rows_requested": 340,
        "unique_rows_read": 4,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_46": {
        "calls": 2,
        "rows_requested": 508,
        "unique_rows_read": 8,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_47": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_48": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_49": {
        "calls": 2,
        "rows_requested": 340,
        "unique_rows_read": 4,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_5": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_50": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_51": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_52": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_53": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_54": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_55": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_56": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_57": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_58": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_59": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_6": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_60": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_61": {
        "calls": 4,
        "rows_requested": 176,
        "unique_rows_read": 8,
        "max_rows": 87,
        "max_result_bytes": 5655
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_62": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_63": {
        "calls": 2,
        "rows_requested": 342,
        "unique_rows_read": 6,
        "max_rows": 171,
        "max_result_bytes": 11115
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_64": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_65": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_66": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 6,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_67": {
        "calls": 2,
        "rows_requested": 174,
        "unique_rows_read": 8,
        "max_rows": 87,
        "max_result_bytes": 5655
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_68": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_69": {
        "calls": 4,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_7": {
        "calls": 2,
        "rows_requested": 508,
        "unique_rows_read": 6,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_70": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_71": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_72": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_73": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_74": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_75": {
        "calls": 4,
        "rows_requested": 340,
        "unique_rows_read": 6,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_76": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_77": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 6,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_78": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_79": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_8": {
        "calls": 2,
        "rows_requested": 508,
        "unique_rows_read": 6,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_80": {
        "calls": 2,
        "rows_requested": 340,
        "unique_rows_read": 8,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_81": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_82": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_83": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_84": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_85": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_86": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_87": {
        "calls": 4,
        "rows_requested": 6,
        "unique_rows_read": 6,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_88": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_89": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_9": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_90": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_91": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_92": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_93": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_94": {
        "calls": 4,
        "rows_requested": 176,
        "unique_rows_read": 8,
        "max_rows": 87,
        "max_result_bytes": 5655
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_95": {
        "calls": 2,
        "rows_requested": 340,
        "unique_rows_read": 8,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_96": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_97": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_98": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_99": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      }
    }
  }
}
````

### vq-order-proof-3.2-v3.log

Original bytes: 7015; SHA-256: `0f656baed0d6522d20c40da694fa132b3020d5056a53c44004acd764e59e5d45`.

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
strict model loading complete
direct chunked traversal complete
{"layer": 0, "seconds": 0.04169475001981482, "memory": {"current_bytes": 5674554264, "lifetime_peak_bytes": 6391125176, "rss_peak_bytes": 4887805952}, "mlx_peak_bytes": 5922081708}
{"layer": 1, "seconds": 0.09562645902042277, "memory": {"current_bytes": 4271411112, "lifetime_peak_bytes": 6391125176, "rss_peak_bytes": 4887805952}, "mlx_peak_bytes": 5922081708}
{"layer": 2, "seconds": 0.04522050000377931, "memory": {"current_bytes": 2587609824, "lifetime_peak_bytes": 6391125176, "rss_peak_bytes": 4887805952}, "mlx_peak_bytes": 5922081708}
{"layer": 3, "seconds": 0.042522458999883384, "memory": {"current_bytes": 1567541168, "lifetime_peak_bytes": 6391125176, "rss_peak_bytes": 4887805952}, "mlx_peak_bytes": 5922081708}
{"layers": 4, "logits": {"traversal_equal_bits": true, "layers": 4, "tokens": 513, "output_sha256": "e4c2500aa9e8c9cb025b62d9680081076f961d15ba07711e83070a24f3ba86b8"}, "memory": {"current_bytes": 1137067688, "lifetime_peak_bytes": 6391125176, "rss_peak_bytes": 4887805952}}
````

### vq-order-proof-3.2-v3/receipt.json

Original bytes: 140852; SHA-256: `bc8f8f3a121e2ebbffc964acddb3bc4826f238314961739b2eed4b36c7506df6`.

````text
{
  "schema": 1,
  "scope": "pilot feasibility, not native parity or quality qualification",
  "architecture_revision": "2097324ed04ff76078366c77148b88b9db612ba2",
  "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87",
  "runtime_sha256": "1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8",
  "mlx": "0.32.2",
  "mlx_lm": "0.31.3",
  "instrument": {
    "scripts": {
      "vq_model_reference.py": "3e478a72ce459c1a12de3449444568434e5142df1bb249457f13759c98299cf4",
      "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
      "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
      "vq_kernel_sources.py": "00e931902b2c4f8b6f348897ca5c094f23747ea7d9260868d5440d791309a84c",
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
    "sha256": "68f8eaa96cb204cc90ce6437e6e89971db3dea6a842ad7d852590313880cd473"
  },
  "vq_decode_chunk": 32,
  "prompt_chunk": 512,
  "tokens": [
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    248044,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    248044,
    1246
  ],
  "positions": [
    497,
    498,
    499,
    500,
    501,
    502,
    503,
    504,
    505,
    506,
    507,
    508,
    509,
    510,
    511,
    512
  ],
  "tokens_sha256": "a9d0087a584fef727945b03897a57da9c5d720bd7e849b7a43744c70727b2e73",
  "layers": 4,
  "logits": null,
  "traversal_proof": {
    "traversal_equal_bits": true,
    "layers": 4,
    "tokens": 513,
    "output_sha256": "e4c2500aa9e8c9cb025b62d9680081076f961d15ba07711e83070a24f3ba86b8"
  },
  "order_proof_sha256": null,
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22821847040,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   244950.\nPages active:                                 970507.\nPages inactive:                               939955.\nPages speculative:                             80752.\nPages throttled:                                   0.\nPages wired down:                             190286.\nPages purgeable:                                1569.\n\"Translation faults\":                      830202611.\nPages copy-on-write:                        50293135.\nPages zero filled:                        1679079699.\nPages reactivated:                          88850154.\nPages purged:                               10049747.\nFile-backed pages:                           1146416.\nAnonymous pages:                              844798.\nPages stored in compressor:                  1183018.\nPages occupied by compressor:                 658825.\nDecompressions:                             18751030.\nCompressions:                               26396795.\nPageins:                                   194892717.\nPageouts:                                     289915.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 130332.\nPages tagged resident:                         89828.\nPages tagged compressed:                       40504.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5186.\nPages tag-storage free:                          429.\nPages tag-storage non-tag pageable:            92681.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6013504.\nTagged compressions:                          381280.\nTagged decompressions:                        311516.\n"
  },
  "allocation_before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22537748480,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     3913.\nPages active:                                 997357.\nPages inactive:                              1223398.\nPages speculative:                             19485.\nPages throttled:                                   0.\nPages wired down:                             182996.\nPages purgeable:                                  76.\n\"Translation faults\":                      830406087.\nPages copy-on-write:                        50320768.\nPages zero filled:                        1679218232.\nPages reactivated:                          88853606.\nPages purged:                               10053050.\nFile-backed pages:                           1371606.\nAnonymous pages:                              868634.\nPages stored in compressor:                  1183667.\nPages occupied by compressor:                 658645.\nDecompressions:                             18751921.\nCompressions:                               26399071.\nPageins:                                   199245206.\nPageouts:                                     290059.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 129162.\nPages tagged resident:                         88472.\nPages tagged compressed:                       40690.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5186.\nPages tag-storage free:                          217.\nPages tag-storage non-tag pageable:            92893.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6051840.\nTagged compressions:                          381487.\nTagged decompressions:                        311537.\n"
  },
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22266298368,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   322724.\nPages active:                                 897907.\nPages inactive:                               869552.\nPages speculative:                             27411.\nPages throttled:                                   0.\nPages wired down:                             232548.\nPages purgeable:                                  27.\n\"Translation faults\":                      830793491.\nPages copy-on-write:                        50323934.\nPages zero filled:                        1679757487.\nPages reactivated:                          88901660.\nPages purged:                               10053096.\nFile-backed pages:                           1036276.\nAnonymous pages:                              758594.\nPages stored in compressor:                  1290247.\nPages occupied by compressor:                 735176.\nDecompressions:                             18814173.\nCompressions:                               26568329.\nPageins:                                   199585552.\nPageouts:                                     290059.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 128486.\nPages tagged resident:                         86310.\nPages tagged compressed:                       42176.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5186.\nPages tag-storage free:                          256.\nPages tag-storage non-tag pageable:            92854.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6325120.\nTagged compressions:                          382973.\nTagged decompressions:                        311537.\n"
  },
  "process_memory": {
    "current_bytes": 1137067688,
    "lifetime_peak_bytes": 6391125176,
    "rss_peak_bytes": 4887805952
  },
  "peak_mlx_bytes": 5922081708,
  "artifact": {
    "verification_sha256": "ec76e8ddf0a7038ad51f3a08cabf12e2c22ca199b15d4b94c71688c1a73b8d7e",
    "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe"
  },
  "ple": {
    "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
    "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
    "scope": "pinned headers and selected bytes; full-payload provenance is a separate gate",
    "files": {
      "model-ple-0000.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1a77d6eb888fb7e24886450f4f7102323a371741ff4e51b50e87a740b1fad773"
      },
      "model-ple-0001.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f2f023233a5f21abb194ebb8c3c0b3253d564bade0fad04724d8b21a4cf17b76"
      },
      "model-ple-0002.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f28fc840c5f805d994cdd66c33173b07ffc94fb1990a51c6549aefb2f0ea85ea"
      },
      "model-ple-0003.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "7fd3ce750bfc99478fa7438529098fd99edeafc01d775c9ae51b407c0de61400"
      },
      "model-ple-0004.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "36110f9d39e25076a61050b2a74ece55f1b8400da53fa81145ac2d8cf321b50e"
      },
      "model-ple-0005.safetensors": {
        "bytes_read": 17034,
        "reads": 21,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ecf277ef69fb2144d26a3012956bca454fe326007c232a51eaac809a836c1d3c"
      },
      "model-ple-0006.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dcbe407dc06df2ebe6d33f02458ecd7a32769b27d36d013ac1542abcd98932f0"
      },
      "model-ple-0007.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5c8454df0757886dfdf0b6014d5fee650befc41bcd4a4b05c0d7f29f86b6a3d9"
      },
      "model-ple-0008.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ba87d2c5573729406bcca9d701b85ee2e2905b8690a34adedd9a772e09c0b8ca"
      },
      "model-ple-0009.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ef62f505ff8c7611be6a4fc1f27393fd1f45f2a28a6e8f6627e4e87cca6976fe"
      },
      "model-ple-0010.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dcd740909f3309926c445dc9aa8f7e7bcf0d688787b03d822686b1138a1c80fd"
      },
      "model-ple-0011.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "29f38b6959e7fcd2d5c66bcdb4693dde406636bc4986d20581d395944e2ecf5e"
      },
      "model-ple-0012.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "52b140cd4f0621f45110be8bec91492ee5fde9dbfd5742080600b986ce5bf1c9"
      },
      "model-ple-0013.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "31de4adaabecb9aa4888443d7a65ffda37101816dcf56d10cc56477afa71a95b"
      },
      "model-ple-0014.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "fc98c6e9120fd7c83b5ed83c1da6970e1c0b1eb480bcab90140fed855452f6be"
      },
      "model-ple-0015.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dda47c00ab437271bca5cfa9eddafc283db93497e0012cb41828c4151458ef90"
      },
      "model-ple-0016.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5394d1695b71450e5ca6aae866ad20564d413b275fba9b3b6bd2477df967e4f2"
      },
      "model-ple-0017.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ae1eef1dcf859b83ca63f3effc9fefb5335e88ec2f456feb054c8af0f8286914"
      },
      "model-ple-0018.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bd5b6773ca81e1a8ef400d8670f25554289e95a21a4a1550644687b66e0f9a01"
      },
      "model-ple-0019.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a8276e14d62881a67a1ad6d780fec3c2d6aa229559decaa47e755b59da2ffb17"
      },
      "model-ple-0020.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8152d94b31e15378ff7399cf836d1f9fa51a8fa669cec75b6db1f7a2fd67caa9"
      },
      "model-ple-0021.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b638b1dc38d9997d6d620d0e85e14fa16635a91ccda33c66fb26c68687f32f1c"
      },
      "model-ple-0022.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b85b4ae24c54c04dbcdc06f36a41189494ebe10256eadaae45fa877e69795c24"
      },
      "model-ple-0023.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e675c5bb6dcc51c02589821646858b4d3d220e60e00f70f6af4c2e648cfb8c20"
      },
      "model-ple-0024.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "fcf1bd5627bbc28ca62e60561ed079fc14c14e98e4acf267e5b16a804674aab7"
      },
      "model-ple-0025.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b8789679e2413423b139bae1102156c3292f705656f6de7bc739208ad642d826"
      },
      "model-ple-0026.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ecb91daecc103c6d887f949369e0507038df19c3bf9f410201771c288751e15"
      },
      "model-ple-0027.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "97f218d7a201225907b9c0800f4cd9c0eed7578d32e031f6b7c8f9a05fc61fee"
      },
      "model-ple-0028.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f72b0206ca34eac6bd71f7211033e79d14f63113bb2aba64123d8e257d70e048"
      },
      "model-ple-0029.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "373d7bddc9007c3f0bab2f4c2987fafb3e69806995e581a64c2378879ed4ff96"
      },
      "model-ple-0030.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "964de7e0c73056f4b6d9211e1df05fe5b95c06c46e5363f70e5fcb2091c6742f"
      },
      "model-ple-0031.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "92462f146bae77871a793f6b42d790948f0fdf2ca62b5ca8f25c5282e4be0b67"
      },
      "model-ple-0032.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3a13866cd08261ea003e939a9d4bffe69ac4445db668ea80ab5a14077ecd37b8"
      },
      "model-ple-0033.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ecd89f0454a931951af4e68f8f4776fa2f8cf9291835c5a7f240e976d3176946"
      },
      "model-ple-0034.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "75bfa391e25a7bd96465f456298fd5163dfb1cabaf91243c8e65438f991df650"
      },
      "model-ple-0035.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c3702646a2c998706341d8dc278f0bf426fdac347d51624b4521cff77e248bdc"
      },
      "model-ple-0036.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "78c746cbeb20c2afc31a1e3abdff0994cf500935cfe7f9d94f8081561b811edb"
      },
      "model-ple-0037.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "6cf1f353a7c903b16f4a805eca32a546e473d0c11c5d6ded8f225fd17a52ca3b"
      },
      "model-ple-0038.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "22c05adbab2fca388a871dbea75cb782c99bd2ac174cd31033c87146a504afeb"
      },
      "model-ple-0039.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4f9b4807fc8cd7fd9b3a38c526dd110a2581949f3209a201f24c6cf011b7d448"
      },
      "model-ple-0040.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "768193c02533c030677b18c52b972bb40351726b046b15d829a20115f27fb858"
      },
      "model-ple-0041.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f9c4a0f4773dce28d3e900d233087c6eb21ab6db8c964b25efa660c1ebe32ab9"
      },
      "model-ple-0042.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a7eacd86ce7760d259a0b2411706f836ff806bef17e71e0b9ec00ef662c78c8e"
      },
      "model-ple-0043.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "532f8e36dea0d5450130985fd86cd0d860fb234b49953f8f7f46907b4a9df671"
      },
      "model-ple-0044.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8905a009fcef95af5ac517f47a6247a5e80842dd68b28fcf1eb8680161177aeb"
      },
      "model-ple-0045.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3312ea3c6c3ee659b5ecff16d4e18e64514d9b308861ed552d6f9bb246720b90"
      },
      "model-ple-0046.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bf1187cbbc253ceb6312eb052643bee025136f6e863be379268982b9f602b913"
      },
      "model-ple-0047.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c3474245e81348915a3eea3b033c3c8f78296b1f7836fd7012a59142af135d49"
      },
      "model-ple-0048.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "49d0e4a2affd71c40af50a101f967a4ae4d26be21ca5639b97c1522f88d92921"
      },
      "model-ple-0049.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b621bdf2ac2bcb2da9403de0b028302b3cbac8e18e3a46396f0cf5a0038efb29"
      },
      "model-ple-0050.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "55d43c476938a9ba51bd775e69956ce1ddd69e5dfff0be9cc46d66ddd9fc742a"
      },
      "model-ple-0051.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b99d8086e2aa0009d4fadb21d4e7da6b7bcb82e4b6610d2ab5345445730f9150"
      },
      "model-ple-0052.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "11f43d44ff13f9542cf1496263ad57f51f2765eb23905afebc2e79c54a7bf3e1"
      },
      "model-ple-0053.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "288fe71606fd54fe4766be350ee0fa761a15e176c23eae99a1e457b7640c2b5a"
      },
      "model-ple-0054.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "cdda85af7c5f26cba6e15713398f8cbd713fd6b7b009792d49bc5cca6c32f0ef"
      },
      "model-ple-0055.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "02c19734b541ff11baafe90bd1f043351bc11553d8b90cca19ddcacf2e872cf4"
      },
      "model-ple-0056.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "de0ffa1631acadd04e5390ed5d5061ab241baa5276783eb43ac398fe9eb3f289"
      },
      "model-ple-0057.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0fb4b07fed1aac5094ca402e4a7eac341bd611b14c767d083b91eaa908ea8192"
      },
      "model-ple-0058.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "469b8bb94cad3f6f6e80f5b7d4cdbd73ecea41d99f1ff28edfc7126ccbb86ac4"
      },
      "model-ple-0059.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "89e5ac048329f69dffb2d2660c213004beded2ed9fd8b7da80d8524c514796f2"
      },
      "model-ple-0060.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c2fbac09b7ca7656897a9c15d96fcc0dbf5994f8ecc71a0efcbb9dcea51899a2"
      },
      "model-ple-0061.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "edb275ccfba5a84785202235f9047fba0964b674f7952e54d3ac1641b3522d84"
      },
      "model-ple-0062.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bf70928c5a17433118e2f4db2b8ea5780d18b615c126261dfd56e8993f4d7ca4"
      },
      "model-ple-0063.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4799ddde1618307c7b6ca56cc93192ccc5bc6cb32e5e550426fb866ab94e7d25"
      },
      "model-ple-0064.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a4453fcd18ae242d0d6f67a0f8209b0b0cfab3d3aa9791ad01bc904de1c02099"
      },
      "model-ple-0065.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ac31d394ecd8dea25bd1c2625a9e998ad67aa951cedd0aac48a31e47db78b81"
      },
      "model-ple-0066.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c16abafe35c3cd0f51bf18ebc25662655802f69a04c403cab34b2f1f79788d07"
      },
      "model-ple-0067.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "aa35e31d2d5111cd5bd3f4bcd7e5b62501ad03c079dd28b1177b7a17ceddba8b"
      },
      "model-ple-0068.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bd98a2e72df10bd2815be59878b26c5a7ea85040c3869b349c19489ea340cb2f"
      },
      "model-ple-0069.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1fa6ae26655070c074e968d0c5c8cabf05d2b814382c7b6fd626d9aeeecd8b8c"
      },
      "model-ple-0070.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a98f09cffc458ba3b06f0d4691166b3995ba244e3834a464918ad87c7e7440c3"
      },
      "model-ple-0071.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "912a2353655ca8c651fc5778748f06eba4a993449e48bb755457a97f4cc4a178"
      },
      "model-ple-0072.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "aad2f7fe78c8bd5364989956650ce03987f5589692463a1ebd38407120b2a44f"
      },
      "model-ple-0073.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "03ca33b11a000fe10458eafc4a4691d8830a9bf2d3a2605176ab824e3e5a5394"
      },
      "model-ple-0074.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a8c97f4735b7cbe0b5d4ed65ff1c1cded837e5e39df1ff14d24be87a7d3114b9"
      },
      "model-ple-0075.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f94d01c69433866f9b0736ed1b9d47316bb218f76114859adfe819e68e2f60fd"
      },
      "model-ple-0076.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b9093a80151735a124dbb58b0e66aaa5246ccb9ca8456da4544a62ff71ebc400"
      },
      "model-ple-0077.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "54cc70f3926c7d83e3fe983856ec245df11068aae2ccf0ec4654ad147e408b52"
      },
      "model-ple-0078.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ff2b2bdd002619eff9af6f611579e3cfa97b0ea7ecba1c1e2c0c7895e9c0adde"
      },
      "model-ple-0079.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "50698b2fa5b2c1cc224f65d568e74a9dccdcfe30b2c56a1a8c33230e85ff3761"
      },
      "model-ple-0080.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "23290be37802733804125dec069184bf2e940e6b62b9f4cd29279832874e341f"
      },
      "model-ple-0081.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a41c474a85d8814056cd62105df88417859d991efb7c4c75337c075dc5472923"
      },
      "model-ple-0082.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "66e199d9fe475202da2aeea1a3beaaa843d8833f8dbb8f0f8ebe8123528bb47b"
      },
      "model-ple-0083.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "af1c796203e4a1d9a5fa517068417f74cc1c8054a760df0d7280d524a79401f5"
      },
      "model-ple-0084.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "9d474c9eb7af61c83fc2c9fbb488940c421405d31fc67da7f04ef460a9a1d1ee"
      },
      "model-ple-0085.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bb9c554e63b2b004df529d7ceca9aa3f1f1bf685ac83d8c7deb3b300da1e8c0e"
      },
      "model-ple-0086.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "415548af2e2307aa329ae4bfbd70ce06a1a87098dc25afcad293447abd423ad3"
      },
      "model-ple-0087.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "858d3c6ef41eb7e817f89d823cdec6b6caea73c137288ad08e8eab08f119772d"
      },
      "model-ple-0088.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "15463319e21e61e39dc010000a0fdbdaa890156d5e2d144cf2fb01075820eaef"
      },
      "model-ple-0089.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "696ca36ea1ca83917d5bf1c625aef6348efa62b24d5146b06e44126b4bc0ec32"
      },
      "model-ple-0090.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "14c8dd9e7c44800316170713ddef753aac93ecae84d773e211e21a2ec9ac6f2d"
      },
      "model-ple-0091.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f8393d7c8c541c6c54ed5b45c4fdd0f5be2a99008cfbf41a495ca64e62c2435f"
      },
      "model-ple-0092.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "21842575e50065223db524da1c4900f6eb9f926f3554344608084a096ccfc437"
      },
      "model-ple-0093.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4b1fbe90a23014072ebc46ff0efaa0fcd7c1f9fc09014a6a56cde872dfb119d2"
      },
      "model-ple-0094.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "583157efb87d0a37df0ab520c6e27053986bc328540889b9c199273b94a64bf4"
      },
      "model-ple-0095.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a79812e4e60c09a1246e78502591403a413685baef4ac846e36fbb359d993afc"
      },
      "model-ple-0096.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8df14f8ba996c53f0417f734cf70a4f5fa9af63abe386ec9e6b15a1b13bd6918"
      },
      "model-ple-0097.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0f786045e8079d0fc2480ba3e0c18a3736335667838c8412cdf317503dcd0eb9"
      },
      "model-ple-0098.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1ca65f3c186a50a7237b7a3715d2ee67979f3e26fab4ca4bcde6e95371c7d76e"
      },
      "model-ple-0099.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "299f2064379bc7011e0b61f921e365b75040232c8090f28dc94682090cbb7058"
      },
      "model-ple-0100.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "95c8400bc37157c1c8e2639a528a87cb0e316e493e877cb5cce82451ae931cf8"
      },
      "model-ple-0101.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "aeef4e8f98cfe39ba4552d5a3066575f3b5cdaa8a084d9393a2b6ffab793a85f"
      },
      "model-ple-0102.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1b944bb1d709abc39fce5c4b215067359ea9d6c4c4ee2642e316f471b8f02b2f"
      },
      "model-ple-0103.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "afc49ca27e01d2737d381a0e028557c3645a8c9563f13808af037f30b4b46875"
      },
      "model-ple-0104.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "32baece43ac8eb73646bd0857ada9210588ec977d6cf68cded5d74e4698bf572"
      },
      "model-ple-0105.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b64ebcbe7001faeffc3dc87e2a759931ad089f051d47ed85cef5eaf0742ed00f"
      },
      "model-ple-0106.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "adc331094db3e3f69cc4d23873c1a5197e1cdb013e61e2abfc872c48cf9bf6cc"
      },
      "model-ple-0107.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8d2bd2097afc716035abc540e1afa50fabfb034b11bb7f5160ec209c96c9ef80"
      },
      "model-ple-0108.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dfd28d3b80f5ec901a604a5f5332139eb8261692efad7406659e6dacb9ef8d69"
      },
      "model-ple-0109.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e2fbc8c72a01788f02ca2e67b8c9e2b88095ddc459b7b004c53da7bbc4f893ba"
      },
      "model-ple-0110.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "6efa0063d0f40808c2770b93ce7c8e4ddb583e6657ddefe8ed89681c0940eea7"
      },
      "model-ple-0111.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "105db24f61d8054d45ca408cf6022d104847f54d4dba6750e2559df85bccb7d8"
      },
      "model-ple-0112.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "cc80a05bbe331f12a6014dbd1b154c139ec540158c9e5e58fd4b334973188c54"
      },
      "model-ple-0113.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ff2f6f0448180f7cca7ff8681d7d1a3dba0ff2e564288428690e2bf2749e400b"
      },
      "model-ple-0114.safetensors": {
        "bytes_read": 16774,
        "reads": 13,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "da4623bd09c4db7284e1f9699b4194bf807b0f8bb22878d31e1e1e8940bded64"
      },
      "model-ple-0115.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5cada7840d40160752fc660ba396f299e7c9ebfcdf50dd13043b80978178699d"
      },
      "model-ple-0116.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c4fa432470d92345e4e9e6e056a024a7abbbec272c1205d2bf85e48071dfe8e7"
      },
      "model-ple-0117.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "567f929791b3fc853ba116a60fa880f7d081de2a4b47041c2977323110892b6e"
      },
      "model-ple-0118.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5df70160db9a4e52e1c63b7cfdb8f12338d04cba4e45ec9b32dc9abf4a79bc4e"
      },
      "model-ple-0119.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e66d4681634b283eb2e3922e4509759f55e4f1e3fbbb7abb3bf8b198667d4b74"
      },
      "model-ple-0120.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a90805eca5e8020b3726af97ce3621e1e1bb5d7fecf007dab1bd87cf7c098cc0"
      },
      "model-ple-0121.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e943b951ed98e79c96138eedae6fba364f1d63a9453fda231543c6338a2e0254"
      },
      "model-ple-0122.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "94d9038384eb88d049e82a52b7da7cf0a16ee7059176f2d37d2137a347e68752"
      },
      "model-ple-0123.safetensors": {
        "bytes_read": 16904,
        "reads": 17,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5a8b624394d9ecb8098b710799fad55e701d6fe55cdf70e532c42eee47d934bf"
      },
      "model-ple-0124.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1f0a348da08475d259f1a50093e0a25371fd0dedb40e122690640a48714435bf"
      },
      "model-ple-0125.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "91c49a44b616996b3faf538752ca7a70ad28b82faf07bfcf88fe9e1e0fc6132b"
      },
      "model-ple-0126.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "2b96a6f05321da44315ff01193de77c16364a81a341bbb57cb66974e41c30956"
      },
      "model-ple-0127.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "72a412543c2a51f822d448102c918789d4fe1e1927a7a59ef1e267851f40d6e2"
      }
    },
    "tables": {
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_1": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_10": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_100": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_101": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_102": {
        "calls": 4,
        "rows_requested": 342,
        "unique_rows_read": 10,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_103": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_104": {
        "calls": 2,
        "rows_requested": 6,
        "unique_rows_read": 6,
        "max_rows": 3,
        "max_result_bytes": 195
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_105": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_106": {
        "calls": 2,
        "rows_requested": 336,
        "unique_rows_read": 4,
        "max_rows": 168,
        "max_result_bytes": 10920
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_107": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_108": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_109": {
        "calls": 2,
        "rows_requested": 338,
        "unique_rows_read": 6,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_11": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_110": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_111": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_112": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_113": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_114": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_115": {
        "calls": 2,
        "rows_requested": 342,
        "unique_rows_read": 8,
        "max_rows": 171,
        "max_result_bytes": 11115
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_116": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_117": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_118": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_119": {
        "calls": 2,
        "rows_requested": 506,
        "unique_rows_read": 6,
        "max_rows": 253,
        "max_result_bytes": 16445
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_12": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_120": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_121": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_122": {
        "calls": 4,
        "rows_requested": 172,
        "unique_rows_read": 6,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_123": {
        "calls": 2,
        "rows_requested": 508,
        "unique_rows_read": 8,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_124": {
        "calls": 2,
        "rows_requested": 338,
        "unique_rows_read": 4,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_125": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_126": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_127": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_13": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_14": {
        "calls": 2,
        "rows_requested": 342,
        "unique_rows_read": 6,
        "max_rows": 171,
        "max_result_bytes": 11115
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_15": {
        "calls": 4,
        "rows_requested": 6,
        "unique_rows_read": 6,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_16": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_17": {
        "calls": 2,
        "rows_requested": 512,
        "unique_rows_read": 8,
        "max_rows": 256,
        "max_result_bytes": 16640
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_18": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_19": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_2": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_20": {
        "calls": 4,
        "rows_requested": 174,
        "unique_rows_read": 8,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_21": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_22": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_23": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_24": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_25": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_26": {
        "calls": 2,
        "rows_requested": 338,
        "unique_rows_read": 4,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_27": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_28": {
        "calls": 4,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_29": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_3": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_30": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_31": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_32": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_33": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_34": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_35": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_36": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_37": {
        "calls": 4,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_38": {
        "calls": 2,
        "rows_requested": 508,
        "unique_rows_read": 6,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_39": {
        "calls": 2,
        "rows_requested": 340,
        "unique_rows_read": 4,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_4": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_40": {
        "calls": 4,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_41": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_42": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_43": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_44": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_45": {
        "calls": 2,
        "rows_requested": 340,
        "unique_rows_read": 4,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_46": {
        "calls": 2,
        "rows_requested": 508,
        "unique_rows_read": 8,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_47": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_48": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_49": {
        "calls": 2,
        "rows_requested": 340,
        "unique_rows_read": 4,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_5": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_50": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_51": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_52": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_53": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_54": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_55": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_56": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_57": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_58": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_59": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_6": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_60": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_61": {
        "calls": 4,
        "rows_requested": 176,
        "unique_rows_read": 8,
        "max_rows": 87,
        "max_result_bytes": 5655
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_62": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_63": {
        "calls": 2,
        "rows_requested": 342,
        "unique_rows_read": 6,
        "max_rows": 171,
        "max_result_bytes": 11115
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_64": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_65": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_66": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 6,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_67": {
        "calls": 2,
        "rows_requested": 174,
        "unique_rows_read": 8,
        "max_rows": 87,
        "max_result_bytes": 5655
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_68": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_69": {
        "calls": 4,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_7": {
        "calls": 2,
        "rows_requested": 508,
        "unique_rows_read": 6,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_70": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_71": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_72": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_73": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_74": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_75": {
        "calls": 4,
        "rows_requested": 340,
        "unique_rows_read": 6,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_76": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_77": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 6,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_78": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_79": {
        "calls": 2,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_8": {
        "calls": 2,
        "rows_requested": 508,
        "unique_rows_read": 6,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_80": {
        "calls": 2,
        "rows_requested": 340,
        "unique_rows_read": 8,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_81": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_82": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_83": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_84": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_85": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_86": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_87": {
        "calls": 4,
        "rows_requested": 6,
        "unique_rows_read": 6,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_88": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_89": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_9": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_90": {
        "calls": 2,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_91": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_92": {
        "calls": 2,
        "rows_requested": 172,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_93": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_94": {
        "calls": 4,
        "rows_requested": 176,
        "unique_rows_read": 8,
        "max_rows": 87,
        "max_result_bytes": 5655
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_95": {
        "calls": 2,
        "rows_requested": 340,
        "unique_rows_read": 8,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_96": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_97": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_98": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_99": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      }
    }
  }
}
````

### vq-full-reference-3.2-v1.log

Original bytes: 14955; SHA-256: `a9e865f80e5b2f72fe50cadc91ceafcb4d4e3520b0066122a1d958c0d697cbee`.

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
strict model loading complete
{"layer": 0, "seconds": 0.19231929199304432, "memory": {"current_bytes": 2025097400, "lifetime_peak_bytes": 2516781528, "rss_peak_bytes": 2461171712}, "mlx_peak_bytes": 2112565872}
{"layer": 1, "seconds": 0.1979849580093287, "memory": {"current_bytes": 2080540952, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 2, "seconds": 0.10348374999011867, "memory": {"current_bytes": 1766950976, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 3, "seconds": 0.10442499999771826, "memory": {"current_bytes": 1752156224, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 4, "seconds": 0.10010650000185706, "memory": {"current_bytes": 1767180352, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 5, "seconds": 0.14124837500276044, "memory": {"current_bytes": 2055620888, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 6, "seconds": 0.10141245898557827, "memory": {"current_bytes": 1767180352, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 7, "seconds": 0.10445695900125429, "memory": {"current_bytes": 1778337808, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 8, "seconds": 0.10894924998865463, "memory": {"current_bytes": 1767114720, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 9, "seconds": 0.10509041702607647, "memory": {"current_bytes": 1767147536, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 10, "seconds": 0.10646704101236537, "memory": {"current_bytes": 1767163944, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 11, "seconds": 0.10198495900840499, "memory": {"current_bytes": 1752123408, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 12, "seconds": 0.1060214159952011, "memory": {"current_bytes": 1767180352, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 13, "seconds": 0.10690670800977387, "memory": {"current_bytes": 1793378344, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 14, "seconds": 0.10474604199407622, "memory": {"current_bytes": 1767213168, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 15, "seconds": 0.10381804200005718, "memory": {"current_bytes": 1778337808, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 16, "seconds": 0.10368349999771453, "memory": {"current_bytes": 1764460656, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 17, "seconds": 0.10254620801424608, "memory": {"current_bytes": 1764411432, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 18, "seconds": 0.11161383299622685, "memory": {"current_bytes": 1475954584, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 19, "seconds": 0.10188720899168402, "memory": {"current_bytes": 1749338080, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 20, "seconds": 0.10475279198726639, "memory": {"current_bytes": 1764444248, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 21, "seconds": 0.10723158399923705, "memory": {"current_bytes": 1764378616, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 22, "seconds": 0.10285754199139774, "memory": {"current_bytes": 1764444248, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 23, "seconds": 0.10046058299485594, "memory": {"current_bytes": 1749387304, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 24, "seconds": 0.10498562501743436, "memory": {"current_bytes": 1764427840, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 25, "seconds": 0.10060541599523276, "memory": {"current_bytes": 1764427840, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 26, "seconds": 0.10410270799184218, "memory": {"current_bytes": 1764427840, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 27, "seconds": 0.11121149998507462, "memory": {"current_bytes": 1749387304, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 28, "seconds": 0.10630279200267978, "memory": {"current_bytes": 1764427840, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 29, "seconds": 0.10953554199659266, "memory": {"current_bytes": 1764395024, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 30, "seconds": 0.10071766600594856, "memory": {"current_bytes": 1790675056, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 31, "seconds": 0.14049866699497215, "memory": {"current_bytes": 2037795024, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 32, "seconds": 0.10061662501539104, "memory": {"current_bytes": 1790609424, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 33, "seconds": 0.10363241599407047, "memory": {"current_bytes": 1790625832, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 34, "seconds": 0.1079826659988612, "memory": {"current_bytes": 1764378616, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 35, "seconds": 0.10251420899294317, "memory": {"current_bytes": 1749387304, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 36, "seconds": 0.10294854099629447, "memory": {"current_bytes": 1764378616, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 37, "seconds": 0.10410633299034089, "memory": {"current_bytes": 1764411432, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 38, "seconds": 0.10256670799572021, "memory": {"current_bytes": 1764378616, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 39, "seconds": 0.14160545900813304, "memory": {"current_bytes": 2037795024, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 40, "seconds": 0.10544200000003912, "memory": {"current_bytes": 1790609424, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 41, "seconds": 0.10365758300758898, "memory": {"current_bytes": 1790642240, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 42, "seconds": 0.10440999999991618, "memory": {"current_bytes": 1764362208, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 43, "seconds": 0.10305129102198407, "memory": {"current_bytes": 1749370896, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 44, "seconds": 0.10555679199751467, "memory": {"current_bytes": 1794132008, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 45, "seconds": 0.10426616598851979, "memory": {"current_bytes": 1764411432, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 46, "seconds": 0.10391599999275059, "memory": {"current_bytes": 1790609424, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layer": 47, "seconds": 0.13652283299597912, "memory": {"current_bytes": 2037795024, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}, "mlx_peak_bytes": 2149782967}
{"layers": 48, "logits": {"path": "logits.f32", "bytes": 5959680, "sha256": "fc89bd06be2e0d6a77136d4e1d482bc6ea527922ee857173b5f7fe8781afb748"}, "memory": {"current_bytes": 1785464824, "lifetime_peak_bytes": 3033779056, "rss_peak_bytes": 2983526400}}
````

### vq-full-reference-3.2-v1/receipt.json

Original bytes: 135784; SHA-256: `8c20d2aa2ad1b98e2d40ea6eb6e0d10322393563a8b44aa6599a55b6853824c6`.

````text
{
  "schema": 1,
  "scope": "pilot feasibility, not native parity or quality qualification",
  "architecture_revision": "2097324ed04ff76078366c77148b88b9db612ba2",
  "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87",
  "runtime_sha256": "1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8",
  "mlx": "0.32.2",
  "mlx_lm": "0.31.3",
  "instrument": {
    "scripts": {
      "vq_model_reference.py": "3e478a72ce459c1a12de3449444568434e5142df1bb249457f13759c98299cf4",
      "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
      "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
      "vq_kernel_sources.py": "00e931902b2c4f8b6f348897ca5c094f23747ea7d9260868d5440d791309a84c",
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
    "sha256": "68f8eaa96cb204cc90ce6437e6e89971db3dea6a842ad7d852590313880cd473"
  },
  "vq_decode_chunk": 32,
  "prompt_chunk": 512,
  "tokens": [
    9707,
    11,
    1246,
    525,
    498,
    30
  ],
  "positions": [
    0,
    1,
    2,
    3,
    4,
    5
  ],
  "tokens_sha256": "67557f1a8d27e83d8f43b72ca72904ae05a1cc46cd9bd9341a9cdedfa1f0ca0d",
  "layers": 48,
  "logits": {
    "path": "logits.f32",
    "bytes": 5959680,
    "sha256": "fc89bd06be2e0d6a77136d4e1d482bc6ea527922ee857173b5f7fe8781afb748"
  },
  "traversal_proof": null,
  "order_proof_sha256": "bc8f8f3a121e2ebbffc964acddb3bc4826f238314961739b2eed4b36c7506df6",
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23535812608,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   260865.\nPages active:                                 945575.\nPages inactive:                               893689.\nPages speculative:                            143026.\nPages throttled:                                   0.\nPages wired down:                             174302.\nPages purgeable:                                6072.\n\"Translation faults\":                      831195059.\nPages copy-on-write:                        50369296.\nPages zero filled:                        1679939313.\nPages reactivated:                          88901799.\nPages purged:                               10053366.\nFile-backed pages:                           1169575.\nAnonymous pages:                              812715.\nPages stored in compressor:                  1199741.\nPages occupied by compressor:                 667285.\nDecompressions:                             18847050.\nCompressions:                               26568329.\nPageins:                                   199599494.\nPageouts:                                     290059.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 128521.\nPages tagged resident:                         87581.\nPages tagged compressed:                       40940.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5186.\nPages tag-storage free:                          372.\nPages tag-storage non-tag pageable:            92738.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6082112.\nTagged compressions:                          382973.\nTagged decompressions:                        312270.\n"
  },
  "allocation_before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22994010112,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     3900.\nPages active:                                 969220.\nPages inactive:                              1251441.\nPages speculative:                             14111.\nPages throttled:                                   0.\nPages wired down:                             183860.\nPages purgeable:                                7002.\n\"Translation faults\":                      831305906.\nPages copy-on-write:                        50374126.\nPages zero filled:                        1680044093.\nPages reactivated:                          88904383.\nPages purged:                               10054727.\nFile-backed pages:                           1392541.\nAnonymous pages:                              842231.\nPages stored in compressor:                  1197845.\nPages occupied by compressor:                 662698.\nDecompressions:                             18848446.\nCompressions:                               26568330.\nPageins:                                   204195724.\nPageouts:                                     290230.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 128348.\nPages tagged resident:                         87413.\nPages tagged compressed:                       40935.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5186.\nPages tag-storage free:                          267.\nPages tag-storage non-tag pageable:            92843.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6081408.\nTagged compressions:                          382973.\nTagged decompressions:                        312275.\n"
  },
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 21237809152,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     9860.\nPages active:                                1027905.\nPages inactive:                              1091047.\nPages speculative:                             58473.\nPages throttled:                                   0.\nPages wired down:                             231850.\nPages purgeable:                                  38.\n\"Translation faults\":                      834603687.\nPages copy-on-write:                        50382940.\nPages zero filled:                        1683350100.\nPages reactivated:                          88907265.\nPages purged:                               10059130.\nFile-backed pages:                           1286355.\nAnonymous pages:                              891070.\nPages stored in compressor:                  1204543.\nPages occupied by compressor:                 666554.\nDecompressions:                             18848547.\nCompressions:                               26575242.\nPageins:                                   207387674.\nPageouts:                                     290404.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 129010.\nPages tagged resident:                         88068.\nPages tagged compressed:                       40942.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5186.\nPages tag-storage free:                          226.\nPages tag-storage non-tag pageable:            92884.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6082304.\nTagged compressions:                          382982.\nTagged decompressions:                        312277.\n"
  },
  "process_memory": {
    "current_bytes": 1785464824,
    "lifetime_peak_bytes": 3033779056,
    "rss_peak_bytes": 2983526400
  },
  "peak_mlx_bytes": 2149782967,
  "artifact": {
    "verification_sha256": "ec76e8ddf0a7038ad51f3a08cabf12e2c22ca199b15d4b94c71688c1a73b8d7e",
    "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe"
  },
  "ple": {
    "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
    "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
    "scope": "pinned headers and selected bytes; full-payload provenance is a separate gate",
    "files": {
      "model-ple-0000.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ff2bcc953512d8336f2dc872f62a8598c32e5b7e8f4ec0c71814330ce180c4f"
      },
      "model-ple-0001.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b8b365db2b4535f4959f2b46f930d1e301c1885a4af59041f1a37c9a86a6efdc"
      },
      "model-ple-0002.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f28fc840c5f805d994cdd66c33173b07ffc94fb1990a51c6549aefb2f0ea85ea"
      },
      "model-ple-0003.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "420206009b8f8cb94e075a81205fd4996901b7673a062dd21257303baf5dfb95"
      },
      "model-ple-0004.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "36110f9d39e25076a61050b2a74ece55f1b8400da53fa81145ac2d8cf321b50e"
      },
      "model-ple-0005.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "da7a3d5761b1bcc8affe1b1864bf9b62fdb394225d49752fbca2fcd6e9c5d0a5"
      },
      "model-ple-0006.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "6d530ac0fbea4b1d56c2c8a2b7b2278f718b72fd98f9ca74a495102de1621f0f"
      },
      "model-ple-0007.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "6946b377b892dc96967a64d8fce72ffa631686afd89c1f2ef836a5b6b7d06c21"
      },
      "model-ple-0008.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4fb98df5626db0bda1c7652e89835a40e952feaeeb94a621cbf3b828f252b84f"
      },
      "model-ple-0009.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ee7f4c5c89f06df8debd09ef6fc67c460dbea6be13c428445cb4a9522c16940c"
      },
      "model-ple-0010.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dcd740909f3309926c445dc9aa8f7e7bcf0d688787b03d822686b1138a1c80fd"
      },
      "model-ple-0011.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "55faacf97ad4f52e956d1527fcb20dd8c040c9e7e9b0b44927b5f4587f82c51b"
      },
      "model-ple-0012.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "9c02f4470c2f19be48f47a7b70f03fd972bd3411142fef1c127fed5bc5e59956"
      },
      "model-ple-0013.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "31de4adaabecb9aa4888443d7a65ffda37101816dcf56d10cc56477afa71a95b"
      },
      "model-ple-0014.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "86253fa2b1630ef0e84b5b2700ae7235ae194957dfc1a2d8173e1578eb71ebe6"
      },
      "model-ple-0015.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "67baeb2d9c3b6ea3fa852832ee8f5d5c8bb68ed7ab2529338dca465d92d91e0b"
      },
      "model-ple-0016.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "043fe5620893d60d0ef308184427f7079dbe462a76716064f8b97b44e726b9cb"
      },
      "model-ple-0017.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "626e0322f48155adfd5c8ccd57977f45d49aa759109b03ac77a44950d22f3582"
      },
      "model-ple-0018.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bd5b6773ca81e1a8ef400d8670f25554289e95a21a4a1550644687b66e0f9a01"
      },
      "model-ple-0019.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "384bb322096302a76c9270d7732f1dbfd72cad1a0d5cb1903324c1fed69dbff1"
      },
      "model-ple-0020.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c4364f07c3d428dc96495462dc56be53f1eb749ac522c2c658d1839b2a431862"
      },
      "model-ple-0021.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "db3012ebb328de19ee8bcefe20628fd8a7771ac23ab7f97251acc96da794e8bd"
      },
      "model-ple-0022.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b85b4ae24c54c04dbcdc06f36a41189494ebe10256eadaae45fa877e69795c24"
      },
      "model-ple-0023.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dad202bcdbc447ddb9176dc79e2e2d539cbcc343e58dd10e8a028d378281741a"
      },
      "model-ple-0024.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c01e2921aa894156a72286581dc116177384e4ae35b938381cbe3118734599a8"
      },
      "model-ple-0025.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b70b8ff63dac091337d9577d92c7b6344e58c16bf854c8f66e55adbadcae45c0"
      },
      "model-ple-0026.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ecb91daecc103c6d887f949369e0507038df19c3bf9f410201771c288751e15"
      },
      "model-ple-0027.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "645dcd44aca09e969033fadb6a89a662137fface4e357ad1218c2627f3b62a6f"
      },
      "model-ple-0028.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "92cf624fe7e8fd26cbf28692a60b81f880bbcd153dec21c968945625d99e0b55"
      },
      "model-ple-0029.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "046b9bb868ce76edf4a0e53689704e04ab992e130879a74f3a36ba5f553c8eb4"
      },
      "model-ple-0030.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "d5a8eb67216c72ce883d8ab7c0dd6268b6c6220351cc8e7fbd9640eea019ee7b"
      },
      "model-ple-0031.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "92462f146bae77871a793f6b42d790948f0fdf2ca62b5ca8f25c5282e4be0b67"
      },
      "model-ple-0032.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f40ba1225e8b780ac1d30cc87576aab7f434c62c309686f347e27d9c37662245"
      },
      "model-ple-0033.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f32b31355a5095e7cb130e4e4eb8fc0163a6ca7c02bfc0e076aa3177eedfe1c9"
      },
      "model-ple-0034.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "517f04c0a5158b3c41c7f8b63c5b18a343b517136e7f838ab9278c8f541d281a"
      },
      "model-ple-0035.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dbe9827a525dd5477c19456242b84acf6e85a0760150caea3b7bda9d247cfbd7"
      },
      "model-ple-0036.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "78c746cbeb20c2afc31a1e3abdff0994cf500935cfe7f9d94f8081561b811edb"
      },
      "model-ple-0037.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4c31179cc8f8bf46d07b6ab42f2092e1d9b388790e6539dd1182e07410b74a75"
      },
      "model-ple-0038.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "956baeab2b65701747420f763411bf4b8d0a9c06f0b4f3ee7de16e541127f4d3"
      },
      "model-ple-0039.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4f9b4807fc8cd7fd9b3a38c526dd110a2581949f3209a201f24c6cf011b7d448"
      },
      "model-ple-0040.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "44dd4cb3898ce0ae0de5000ef4cf2f961b6468ac51688ce9c963b791ff7e0c55"
      },
      "model-ple-0041.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "69d49a6747b6545c541f307d3b8412c043db541627ae4607b1d913458a8a4d41"
      },
      "model-ple-0042.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a7eacd86ce7760d259a0b2411706f836ff806bef17e71e0b9ec00ef662c78c8e"
      },
      "model-ple-0043.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0d0c0aea5628b7c4f76907543dcdc76a57998181c5bfd510be484966eb303235"
      },
      "model-ple-0044.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e24cfb4d47fc80b9a6b35551e3c16443900fc0262c2976667906c7e7d4adf05f"
      },
      "model-ple-0045.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "7d73ddda9924f169335b84c98bea40d08cd3607904222601f55f921a9f8b1196"
      },
      "model-ple-0046.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0092f8b3f80ac160dcb31bc37da4d32dabb0cf86d158beef7f3a3f4e257cc130"
      },
      "model-ple-0047.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "203eecd7ffb44d4abcaf06d3eabc68e3d394c2bdd4ad27ef7d99d50e81eae4b8"
      },
      "model-ple-0048.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "603dd86dcf1cbed09ba683ad11d792a471587a3fc33ced0cbe89c172fe449bf0"
      },
      "model-ple-0049.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "537850f45c02f10712a5c8d677577d9db53b5596ab956aee8fb66960f965e670"
      },
      "model-ple-0050.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b0cb3ff71dd8ea41dfb0f148c6378fa7b4a1608475fafba223edb4c71ff46993"
      },
      "model-ple-0051.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b99d8086e2aa0009d4fadb21d4e7da6b7bcb82e4b6610d2ab5345445730f9150"
      },
      "model-ple-0052.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "26cef3c42ebaaf92fa5b2dba738c5d512ec2f1539354fa271b08023fe728abb0"
      },
      "model-ple-0053.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "6fc86331ae221e5e425845ce335847abe3f29e79fc968923746113bdd93b06d8"
      },
      "model-ple-0054.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "cdda85af7c5f26cba6e15713398f8cbd713fd6b7b009792d49bc5cca6c32f0ef"
      },
      "model-ple-0055.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "02c19734b541ff11baafe90bd1f043351bc11553d8b90cca19ddcacf2e872cf4"
      },
      "model-ple-0056.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "9694751961ca48579276159965bb28004bc18ffcd3b43f4b4a41c50287050e1d"
      },
      "model-ple-0057.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ef95c6d82d8325ab36102c1bdfe8cc77e5389f37be4e48dd68ef40b4b51a1012"
      },
      "model-ple-0058.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8e5f7fd19102f05d5ff656b7451aafe79a8c459dd41fbc3ed81aea7a336705f8"
      },
      "model-ple-0059.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "52470fff54a7b8f399dffc240318456413f23f15d6d84ff238d92a552645c642"
      },
      "model-ple-0060.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "75f39be4f3c797251a171f8206ce1ecfa7f6aa22b82ff92d2c6ec94e314c8431"
      },
      "model-ple-0061.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a19e315e9cf41ad09a8a2597ae216aef778e61942c0cc17861ede8238d73d10d"
      },
      "model-ple-0062.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ea48c8a3345e8b7ed78cee64bded562173a068b6bc08ac939206532bec0b3a6d"
      },
      "model-ple-0063.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a2815386ead742d6189b4fe32050f3117753352f759b3f16ad731730590b3634"
      },
      "model-ple-0064.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a4453fcd18ae242d0d6f67a0f8209b0b0cfab3d3aa9791ad01bc904de1c02099"
      },
      "model-ple-0065.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ac31d394ecd8dea25bd1c2625a9e998ad67aa951cedd0aac48a31e47db78b81"
      },
      "model-ple-0066.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "734fd658c7bdc87207f5fa208dfea162edd9fc8a8752fed0b9add85c03a9a945"
      },
      "model-ple-0067.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "afa402cd16315cb538e61ebc6c53becd5e1dedb386d134d721cc8497c97b3e4e"
      },
      "model-ple-0068.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f092afee16b92fd629cd435754464bfb7399583361a2de6e28bc61c7bf3e03f0"
      },
      "model-ple-0069.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4484efbfc50c2da7239301b2a577ff01a9f2d57fe3eec19e5a84afb8fae0941c"
      },
      "model-ple-0070.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8c4ffd613daffb39a6d9dd419253e9ffe0546f60848be46e59801ad06f607f4a"
      },
      "model-ple-0071.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "94c27f8e2940e26ac94abae936d900f3dbddb9476dfa44e40949b1adf91c734b"
      },
      "model-ple-0072.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3ca0612f4b326b9189653ffea9d8d2002b807a7c5cd93838d869e31333c8bae7"
      },
      "model-ple-0073.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "39ce218b193a2482e2f767b3daecd8c3354261aa86052c5c7be454075301a6d4"
      },
      "model-ple-0074.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "538cd2468b9f17025b9294a9ebbb88f90c4057792788122d2b9729e4fbd51ac8"
      },
      "model-ple-0075.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3ef84840bcca54a540d0265a627da3c9b0b60e514a2be5797293ffe6995718b8"
      },
      "model-ple-0076.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "23613b738b8cc24070f126ab282ad09077db3139bf5ab9cb5d215c2b4dcf078a"
      },
      "model-ple-0077.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e8d0f73f0befe899016df4efc9bb1f926b2018a00d162f6838eb34d88fedbd70"
      },
      "model-ple-0078.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ff2b2bdd002619eff9af6f611579e3cfa97b0ea7ecba1c1e2c0c7895e9c0adde"
      },
      "model-ple-0079.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bd0e14dc8301d682307ef5ea5dad3903258237fba1c3bb7d5d5606926673ed4d"
      },
      "model-ple-0080.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "23290be37802733804125dec069184bf2e940e6b62b9f4cd29279832874e341f"
      },
      "model-ple-0081.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c47dbf757546b3f15d712994d4947668cb32f5551adcd51ed0e0e1e3c517290f"
      },
      "model-ple-0082.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1cd8678402df2aac6285484c77cce113b874342252d007b743a3f09266023231"
      },
      "model-ple-0083.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "aee1845ac5cea6d8a6ab442debf80a56efb9bf327ade9b9968a162e87a77f23a"
      },
      "model-ple-0084.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4f9dd53c589d6c9483504b04dd07895c76e41923680002bab40fdf78f40ae7ba"
      },
      "model-ple-0085.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bb9c554e63b2b004df529d7ceca9aa3f1f1bf685ac83d8c7deb3b300da1e8c0e"
      },
      "model-ple-0086.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ab8f69bdfb41a2c1d90e9239f837e3babfc71fa4d2a512c8130448857383bc2"
      },
      "model-ple-0087.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "151e4b0a54bb684eae785b5ef1b85f1d93145a09e978964e7796480b5a844710"
      },
      "model-ple-0088.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8da6a3c716a8b4bcde6477d32e46615fd8bf437cee36de9d034399ae93295c71"
      },
      "model-ple-0089.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "696ca36ea1ca83917d5bf1c625aef6348efa62b24d5146b06e44126b4bc0ec32"
      },
      "model-ple-0090.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "8b03ec434f10d46a2628ee47d0ebdda765d5265627b6908687796b99d043b36f"
      },
      "model-ple-0091.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "2d663bf299d1f799efc05210a645a94332d592cfce779f9184d3b61d4de12d1e"
      },
      "model-ple-0092.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0d6ba43b144ffbc7f9a41a82472dacfb2df512ad30059085514df4f709117c28"
      },
      "model-ple-0093.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "7156712e6c955f634c045c5b3fb7fc6620dc567a94488e8d878bd5f8b28d812e"
      },
      "model-ple-0094.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "966d40bc6a16085619441cde399f0864ef35149106d9bb2933274968543940b3"
      },
      "model-ple-0095.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "877a77e6f3aa918c6229860a1298823198e89dc170481d1bf0b8c396afe94eae"
      },
      "model-ple-0096.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a2389e0aa89d689387ea0fd929657c68ad8b8c0390e71e80b8f9722f13852d63"
      },
      "model-ple-0097.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0f786045e8079d0fc2480ba3e0c18a3736335667838c8412cdf317503dcd0eb9"
      },
      "model-ple-0098.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "787f3a8951041329e84042d74dfdaa8a491d01aa4a4c1694da784088370a74b4"
      },
      "model-ple-0099.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "7785e9cc773bb1d95f84293d8f1f83799917a7de1e60d438067db8c1c41439d2"
      },
      "model-ple-0100.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "95c8400bc37157c1c8e2639a528a87cb0e316e493e877cb5cce82451ae931cf8"
      },
      "model-ple-0101.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "49a0947a1ac00fcc7c2bc051784cb73b702cb1bab53746a5a02636829f11a2c2"
      },
      "model-ple-0102.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "33be4fcf6754b16837c1dd492b5b6f1bf66d493bbbcd99a65241da5d6a91b6e2"
      },
      "model-ple-0103.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e7784bc92f78a1bb996865ce4230ea1b7cda0f8071b1f1ed578fd5e597b0361d"
      },
      "model-ple-0104.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "36282e4e21fe2034ae8aa7ffe1fe679ff115ad9d28296dd1969edea62e2fa326"
      },
      "model-ple-0105.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "cc778325fac804bdb153716e51c3005f02a4fd4c0007bacaf3349e0c05582969"
      },
      "model-ple-0106.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1a67ddee64fedb15689b3d4c19b5fd101370f48e979b184dfc9edbc06035ae22"
      },
      "model-ple-0107.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1c7ab64b787ccedde70a849ae9cf062f13f5499798fd4a1e5f0f68d2eb13a7a8"
      },
      "model-ple-0108.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dfd28d3b80f5ec901a604a5f5332139eb8261692efad7406659e6dacb9ef8d69"
      },
      "model-ple-0109.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ae463e455446268ab0be5c29f1602b5e153e2f418d3f85b777add05c3f33f207"
      },
      "model-ple-0110.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3a22a08634df5526ccd9aea7d054e887a176a235221c42926b4be870af2ab7a6"
      },
      "model-ple-0111.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3f12014919bae64686bcfb2211b66d5afeed38a0ebf3bac18c750e42435c2594"
      },
      "model-ple-0112.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4376be1cb1d069cf704d91de3c242de4f29783402656f18b8c8b51ec6b678ee4"
      },
      "model-ple-0113.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "185ac9215f5b833892c48b0582e8486756db84a8b733ee9f02086e1a90d0c5e8"
      },
      "model-ple-0114.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "68522f07cd6360d128f75c41085521b2801ef59d15abf383172dbc653e4add91"
      },
      "model-ple-0115.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5cada7840d40160752fc660ba396f299e7c9ebfcdf50dd13043b80978178699d"
      },
      "model-ple-0116.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "54fd5f5f1bddadbe341ee8f872417958522366a651ba6eebda9524ee94b88974"
      },
      "model-ple-0117.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "567f929791b3fc853ba116a60fa880f7d081de2a4b47041c2977323110892b6e"
      },
      "model-ple-0118.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "21745ac65ad92b62ea98519d7c3aa94bf64dccbbaa6cb31a44caaa6e78d054c1"
      },
      "model-ple-0119.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e66d4681634b283eb2e3922e4509759f55e4f1e3fbbb7abb3bf8b198667d4b74"
      },
      "model-ple-0120.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1884d3a7fa13c0373e8627dcb0f1f08245ecff63189b0c29e28b7b4576772498"
      },
      "model-ple-0121.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "adffe43ded8fa2ccbd14d7e773fb02e875e7818a60656ac73c108babfc30c78e"
      },
      "model-ple-0122.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f30b9da87998f8f79bf2ed164af12c75acdbd212113af673bb951478dbb3da89"
      },
      "model-ple-0123.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0b01ceb3204e108ae75239693ea303d80917e01e09c6cd14ff5ada4d564ef627"
      },
      "model-ple-0124.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0889cadf6f7480d6336207524fc126bd316bba28063bf027f88385883727c29e"
      },
      "model-ple-0125.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5a59710707eddb4571db167dcc192dabaa65d4a1e708560301408655fd925992"
      },
      "model-ple-0126.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "cc6797e772430f98a8f23f229a23ccf36e0b493b5bf950b9eeb58da9c5306308"
      },
      "model-ple-0127.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "72a412543c2a51f822d448102c918789d4fe1e1927a7a59ef1e267851f40d6e2"
      }
    },
    "tables": {
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_1": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_10": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_100": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_101": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_102": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_103": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_104": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_105": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_106": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_107": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_108": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_109": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_11": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_110": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_111": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_112": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_113": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_114": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_115": {
        "calls": 1,
        "rows_requested": 3,
        "unique_rows_read": 3,
        "max_rows": 3,
        "max_result_bytes": 195
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_116": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_117": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_118": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_119": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_12": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_120": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_121": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_122": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_123": {
        "calls": 1,
        "rows_requested": 3,
        "unique_rows_read": 3,
        "max_rows": 3,
        "max_result_bytes": 195
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_124": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_125": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_126": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_127": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_13": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_14": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_15": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_16": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_17": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_18": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_19": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_2": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_20": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_21": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_22": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_23": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_24": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_25": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_26": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_27": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_28": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_29": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_3": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_30": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_31": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_32": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_33": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_34": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_35": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_36": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_37": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_38": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_39": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_4": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_40": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_41": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_42": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_43": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_44": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_45": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_46": {
        "calls": 1,
        "rows_requested": 4,
        "unique_rows_read": 4,
        "max_rows": 4,
        "max_result_bytes": 260
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_47": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_48": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_49": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_5": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_50": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_51": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_52": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_53": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_54": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_55": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_56": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_57": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_58": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_59": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_6": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_60": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_61": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_62": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_63": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_64": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_65": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_66": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_67": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_68": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_69": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_7": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_70": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_71": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_72": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_73": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_74": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_75": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_76": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_77": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_78": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_79": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_8": {
        "calls": 1,
        "rows_requested": 3,
        "unique_rows_read": 3,
        "max_rows": 3,
        "max_result_bytes": 195
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_80": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_81": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_82": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_83": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_84": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_85": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_86": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_87": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_88": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_89": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_9": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_90": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_91": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_92": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_93": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_94": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_95": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_96": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_97": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_98": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_99": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      }
    }
  }
}
````

### vq-full-reference-3.2-v2.log

Original bytes: 14943; SHA-256: `edb22a6db8132d1523b208528e579c77a3a58f5eed1203fb64ce10a2a314bf6d`.

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
strict model loading complete
{"layer": 0, "seconds": 0.2668213750002906, "memory": {"current_bytes": 2192230608, "lifetime_peak_bytes": 2842528264, "rss_peak_bytes": 2236989440}, "mlx_peak_bytes": 2367643474}
{"layer": 1, "seconds": 0.3326252499828115, "memory": {"current_bytes": 2262059360, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2236989440}, "mlx_peak_bytes": 2413312332}
{"layer": 2, "seconds": 0.13530524997622706, "memory": {"current_bytes": 1936591008, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2236989440}, "mlx_peak_bytes": 2413312332}
{"layer": 3, "seconds": 0.13353750001988374, "memory": {"current_bytes": 1922566328, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2236989440}, "mlx_peak_bytes": 2413312332}
{"layer": 4, "seconds": 0.13765795799554326, "memory": {"current_bytes": 1937033424, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2236989440}, "mlx_peak_bytes": 2413312332}
{"layer": 5, "seconds": 0.18096145798335783, "memory": {"current_bytes": 2222180776, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 6, "seconds": 0.13730929198209196, "memory": {"current_bytes": 1937148088, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 7, "seconds": 0.13588912499835715, "memory": {"current_bytes": 1933674704, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 8, "seconds": 0.1353511250053998, "memory": {"current_bytes": 1937164472, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 9, "seconds": 0.13604774998384528, "memory": {"current_bytes": 1937410280, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 10, "seconds": 0.13628733300720342, "memory": {"current_bytes": 1937000632, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 11, "seconds": 0.1351718750083819, "memory": {"current_bytes": 1922517224, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 12, "seconds": 0.13585445898934267, "memory": {"current_bytes": 1936820384, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 13, "seconds": 0.1494574999960605, "memory": {"current_bytes": 1648248848, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 14, "seconds": 0.1355746250192169, "memory": {"current_bytes": 1936787616, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 15, "seconds": 0.143087958014803, "memory": {"current_bytes": 1922549992, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 16, "seconds": 0.1379006249771919, "memory": {"current_bytes": 1936951480, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 17, "seconds": 0.1404463330109138, "memory": {"current_bytes": 1936804048, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 18, "seconds": 0.13968525000382215, "memory": {"current_bytes": 1936853200, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 19, "seconds": 0.13182712497655302, "memory": {"current_bytes": 1922681040, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 20, "seconds": 0.14252241599024273, "memory": {"current_bytes": 1648396328, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 21, "seconds": 0.13429433401324786, "memory": {"current_bytes": 1933134032, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 22, "seconds": 0.13601075002225116, "memory": {"current_bytes": 1936836840, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 23, "seconds": 0.1295839160156902, "memory": {"current_bytes": 1922484360, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 24, "seconds": 0.13569812499918044, "memory": {"current_bytes": 1936853200, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 25, "seconds": 0.13313425000524148, "memory": {"current_bytes": 1941162216, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 26, "seconds": 0.14363599999342114, "memory": {"current_bytes": 1936771328, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 27, "seconds": 0.14679604198317975, "memory": {"current_bytes": 1644840952, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 28, "seconds": 0.14598662502248771, "memory": {"current_bytes": 1648232416, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 29, "seconds": 0.13331387500511482, "memory": {"current_bytes": 1936771304, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 30, "seconds": 0.13955049999640323, "memory": {"current_bytes": 1936853224, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 31, "seconds": 0.18320404199766926, "memory": {"current_bytes": 2207713704, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 32, "seconds": 0.1343695829855278, "memory": {"current_bytes": 1936836840, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 33, "seconds": 0.13193495900486596, "memory": {"current_bytes": 1936967888, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 34, "seconds": 0.13270616601221263, "memory": {"current_bytes": 1936853200, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 35, "seconds": 0.14191320902318694, "memory": {"current_bytes": 1633961952, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 36, "seconds": 0.13330916699487716, "memory": {"current_bytes": 1941063864, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 37, "seconds": 0.14651016698917374, "memory": {"current_bytes": 1939081472, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 38, "seconds": 0.1349916250037495, "memory": {"current_bytes": 1941047480, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 39, "seconds": 0.17872550000902265, "memory": {"current_bytes": 2207648120, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 40, "seconds": 0.13967437500832602, "memory": {"current_bytes": 1934493904, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 41, "seconds": 0.13352808300987817, "memory": {"current_bytes": 1937000680, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 42, "seconds": 0.13853191700764, "memory": {"current_bytes": 1939458304, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 43, "seconds": 0.13618704097461887, "memory": {"current_bytes": 1930741968, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 44, "seconds": 0.13349079099134542, "memory": {"current_bytes": 1936853224, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 45, "seconds": 0.13256595897837542, "memory": {"current_bytes": 1936836816, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 46, "seconds": 0.13054962499882095, "memory": {"current_bytes": 1936918784, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layer": 47, "seconds": 0.16987954199430533, "memory": {"current_bytes": 2207713704, "lifetime_peak_bytes": 2877901440, "rss_peak_bytes": 2248163328}, "mlx_peak_bytes": 2413312332}
{"layers": 48, "logits": {"path": "logits.f32", "bytes": 15892480, "sha256": "dd6fb02c138980cc8c6ee35f7aadf91554215999890cfb44ba8767ea20e5d823"}, "memory": {"current_bytes": 1780500640, "lifetime_peak_bytes": 3231369376, "rss_peak_bytes": 2248163328}}
````

### vq-full-reference-3.2-v2/receipt.json

Original bytes: 140815; SHA-256: `37059379fe2aa1f768219eb36d537e6f387ee843e1981773ba9d1b4ab9c6bd28`.

````text
{
  "schema": 1,
  "scope": "pilot feasibility, not native parity or quality qualification",
  "architecture_revision": "2097324ed04ff76078366c77148b88b9db612ba2",
  "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87",
  "runtime_sha256": "1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8",
  "mlx": "0.32.2",
  "mlx_lm": "0.31.3",
  "instrument": {
    "scripts": {
      "vq_model_reference.py": "3e478a72ce459c1a12de3449444568434e5142df1bb249457f13759c98299cf4",
      "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
      "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
      "vq_kernel_sources.py": "00e931902b2c4f8b6f348897ca5c094f23747ea7d9260868d5440d791309a84c",
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
    "sha256": "68f8eaa96cb204cc90ce6437e6e89971db3dea6a842ad7d852590313880cd473"
  },
  "vq_decode_chunk": 32,
  "prompt_chunk": 512,
  "tokens": [
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    248044,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    248044,
    1246
  ],
  "positions": [
    497,
    498,
    499,
    500,
    501,
    502,
    503,
    504,
    505,
    506,
    507,
    508,
    509,
    510,
    511,
    512
  ],
  "tokens_sha256": "a9d0087a584fef727945b03897a57da9c5d720bd7e849b7a43744c70727b2e73",
  "layers": 48,
  "logits": {
    "path": "logits.f32",
    "bytes": 15892480,
    "sha256": "dd6fb02c138980cc8c6ee35f7aadf91554215999890cfb44ba8767ea20e5d823"
  },
  "traversal_proof": null,
  "order_proof_sha256": "bc8f8f3a121e2ebbffc964acddb3bc4826f238314961739b2eed4b36c7506df6",
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22323806208,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     4242.\nPages active:                                1018111.\nPages inactive:                              1206632.\nPages speculative:                             29723.\nPages throttled:                                   0.\nPages wired down:                             182878.\nPages purgeable:                                2951.\n\"Translation faults\":                      836610638.\nPages copy-on-write:                        50681848.\nPages zero filled:                        1684400746.\nPages reactivated:                          88908755.\nPages purged:                               10062415.\nFile-backed pages:                           1355344.\nAnonymous pages:                              899122.\nPages stored in compressor:                  1158407.\nPages occupied by compressor:                 643851.\nDecompressions:                             18891941.\nCompressions:                               26575242.\nPageins:                                   207922459.\nPageouts:                                     290675.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 130237.\nPages tagged resident:                         91463.\nPages tagged compressed:                       38774.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5185.\nPages tag-storage free:                          246.\nPages tag-storage non-tag pageable:            92865.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5675520.\nTagged compressions:                          382982.\nTagged decompressions:                        314443.\n"
  },
  "allocation_before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 21995225088,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     4172.\nPages active:                                1051234.\nPages inactive:                              1182599.\nPages speculative:                             20774.\nPages throttled:                                   0.\nPages wired down:                             182931.\nPages purgeable:                                4393.\n\"Translation faults\":                      836962130.\nPages copy-on-write:                        50733462.\nPages zero filled:                        1684583272.\nPages reactivated:                          88923615.\nPages purged:                               10068032.\nFile-backed pages:                           1333917.\nAnonymous pages:                              920690.\nPages stored in compressor:                  1157372.\nPages occupied by compressor:                 643630.\nDecompressions:                             18893287.\nCompressions:                               26575905.\nPageins:                                   212617353.\nPageouts:                                     290927.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 130222.\nPages tagged resident:                         91439.\nPages tagged compressed:                       38783.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5185.\nPages tag-storage free:                          237.\nPages tag-storage non-tag pageable:            92874.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5675008.\nTagged compressions:                          382998.\nTagged decompressions:                        314450.\n"
  },
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 20837564416,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    90830.\nPages active:                                1027354.\nPages inactive:                               977379.\nPages speculative:                             49874.\nPages throttled:                                   0.\nPages wired down:                             230684.\nPages purgeable:                                  55.\n\"Translation faults\":                      840370345.\nPages copy-on-write:                        50763856.\nPages zero filled:                        1689119290.\nPages reactivated:                          88986316.\nPages purged:                               10071242.\nFile-backed pages:                           1180939.\nAnonymous pages:                              873668.\nPages stored in compressor:                  1235598.\nPages occupied by compressor:                 709129.\nDecompressions:                             18933158.\nCompressions:                               26708627.\nPageins:                                   215809780.\nPageouts:                                     291128.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 129870.\nPages tagged resident:                         90706.\nPages tagged compressed:                       39164.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5185.\nPages tag-storage free:                          207.\nPages tag-storage non-tag pageable:            92904.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5740416.\nTagged compressions:                          383380.\nTagged decompressions:                        314451.\n"
  },
  "process_memory": {
    "current_bytes": 1780500640,
    "lifetime_peak_bytes": 3231369376,
    "rss_peak_bytes": 2248163328
  },
  "peak_mlx_bytes": 2664473932,
  "artifact": {
    "verification_sha256": "ec76e8ddf0a7038ad51f3a08cabf12e2c22ca199b15d4b94c71688c1a73b8d7e",
    "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe"
  },
  "ple": {
    "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
    "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
    "scope": "pinned headers and selected bytes; full-payload provenance is a separate gate",
    "files": {
      "model-ple-0000.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "293f43f210331d0f679b2d224afd473804d36e9191181811a7ae91cc60879711"
      },
      "model-ple-0001.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "de59a4827feffd4186141c0978ed7fdeedc86a1417937dee3ed9c72337033b37"
      },
      "model-ple-0002.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f28fc840c5f805d994cdd66c33173b07ffc94fb1990a51c6549aefb2f0ea85ea"
      },
      "model-ple-0003.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "420206009b8f8cb94e075a81205fd4996901b7673a062dd21257303baf5dfb95"
      },
      "model-ple-0004.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "36110f9d39e25076a61050b2a74ece55f1b8400da53fa81145ac2d8cf321b50e"
      },
      "model-ple-0005.safetensors": {
        "bytes_read": 16709,
        "reads": 11,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "967d9fa6a5a3c636aa40c6b5af03f2eef77149163a9ae3ce8d30819efe63091e"
      },
      "model-ple-0006.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "6c5c886bb91c706179f3fc606859db487d452b76d6498a224ef692af89b94db6"
      },
      "model-ple-0007.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c9cacaeafadd92c3315c7393d1682723e30985de518e3274943ad39c32622c16"
      },
      "model-ple-0008.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ad3d00fa5b138e840d3b877c6f06057895a813c581cb75e5f4652844c474e219"
      },
      "model-ple-0009.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ee7f4c5c89f06df8debd09ef6fc67c460dbea6be13c428445cb4a9522c16940c"
      },
      "model-ple-0010.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dcd740909f3309926c445dc9aa8f7e7bcf0d688787b03d822686b1138a1c80fd"
      },
      "model-ple-0011.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "55faacf97ad4f52e956d1527fcb20dd8c040c9e7e9b0b44927b5f4587f82c51b"
      },
      "model-ple-0012.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "62c641ae57e5da76d6e46561549132510090955bcf517b997f917b099c28cca6"
      },
      "model-ple-0013.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "31de4adaabecb9aa4888443d7a65ffda37101816dcf56d10cc56477afa71a95b"
      },
      "model-ple-0014.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "35170ec6a827a84ba4ff80ecd1b12e7e07eb02ac01da29e15d5a5d8b0f2886b6"
      },
      "model-ple-0015.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "48f76cf98c3f595f69eae86ab6b6c41b2bf5e02748100d19fa514335b8b947b1"
      },
      "model-ple-0016.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4e8015fb959e0a3372ee0c4f6f688ce5b8bdc41be32b1199700420c0bcf82402"
      },
      "model-ple-0017.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "963e0d57eb8d723b23dd98f0ff0b1a78983cd42f7c9fbe87cd454c578ffed603"
      },
      "model-ple-0018.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bd5b6773ca81e1a8ef400d8670f25554289e95a21a4a1550644687b66e0f9a01"
      },
      "model-ple-0019.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "93743332166ca65fceadf714bd333b5dfd000f3445af530339d3a891071bc984"
      },
      "model-ple-0020.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c4364f07c3d428dc96495462dc56be53f1eb749ac522c2c658d1839b2a431862"
      },
      "model-ple-0021.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "d5f755c73a00ac6264b4bf93893b753a60a349328ee07d29454b537e0f10022a"
      },
      "model-ple-0022.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b85b4ae24c54c04dbcdc06f36a41189494ebe10256eadaae45fa877e69795c24"
      },
      "model-ple-0023.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "9b77495dd2e6a0e10c61377cd85db80b8b52e479384ff9cbe8c9b4cd4416857c"
      },
      "model-ple-0024.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c01e2921aa894156a72286581dc116177384e4ae35b938381cbe3118734599a8"
      },
      "model-ple-0025.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b70b8ff63dac091337d9577d92c7b6344e58c16bf854c8f66e55adbadcae45c0"
      },
      "model-ple-0026.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ecb91daecc103c6d887f949369e0507038df19c3bf9f410201771c288751e15"
      },
      "model-ple-0027.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b9e6b2f022bfde829adeee03748cc50859d36b018528207aa1c8757da8fd1bf9"
      },
      "model-ple-0028.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "68b17609608c833deb79569fb939b164c42a32a2d7452146bd7e2061aa84bd72"
      },
      "model-ple-0029.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0423edf304e473a51a5d4e0e6058869b60c70e7741af4ecc97a7728389dfdd7b"
      },
      "model-ple-0030.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "af302636b7b3709842b87bba0170323f6dc05b001908d9fe6586560142fc1d85"
      },
      "model-ple-0031.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "92462f146bae77871a793f6b42d790948f0fdf2ca62b5ca8f25c5282e4be0b67"
      },
      "model-ple-0032.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "d37c32d1d94c40175c7c075be751c5719796e44e02eff7d0ae5939c2ccfd15f9"
      },
      "model-ple-0033.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f2ebb230a812645327868b640a59b29b905701625682faaa40a4ef1ae2105491"
      },
      "model-ple-0034.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "613694c058452783b7500ed6e61fb094fa4f97f4e22d652892345609f85dad67"
      },
      "model-ple-0035.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "2bad566effc25273a1d435c90bd72675132c32eec0dd4c849fb720bcb21b21ae"
      },
      "model-ple-0036.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "78c746cbeb20c2afc31a1e3abdff0994cf500935cfe7f9d94f8081561b811edb"
      },
      "model-ple-0037.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ad0330321a785aa00f9a3acadf9b20c28b15180b584f85b098779945e1a2b852"
      },
      "model-ple-0038.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "956baeab2b65701747420f763411bf4b8d0a9c06f0b4f3ee7de16e541127f4d3"
      },
      "model-ple-0039.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4f9b4807fc8cd7fd9b3a38c526dd110a2581949f3209a201f24c6cf011b7d448"
      },
      "model-ple-0040.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ba6b8e4382af0c5c995889583826812e1bb89f7331441c8cd4a03c0bcd47e18"
      },
      "model-ple-0041.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "2000f6857791d2d1f493efdcb8436edf185a0389af5cc5be9f8af9cd8da90430"
      },
      "model-ple-0042.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a7eacd86ce7760d259a0b2411706f836ff806bef17e71e0b9ec00ef662c78c8e"
      },
      "model-ple-0043.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0d0c0aea5628b7c4f76907543dcdc76a57998181c5bfd510be484966eb303235"
      },
      "model-ple-0044.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e24cfb4d47fc80b9a6b35551e3c16443900fc0262c2976667906c7e7d4adf05f"
      },
      "model-ple-0045.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "7d73ddda9924f169335b84c98bea40d08cd3607904222601f55f921a9f8b1196"
      },
      "model-ple-0046.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0092f8b3f80ac160dcb31bc37da4d32dabb0cf86d158beef7f3a3f4e257cc130"
      },
      "model-ple-0047.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "203eecd7ffb44d4abcaf06d3eabc68e3d394c2bdd4ad27ef7d99d50e81eae4b8"
      },
      "model-ple-0048.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dfd40fc7d3e628a9507bd29bbef4c35015c4b95b7a3dcace8a2ac918046da646"
      },
      "model-ple-0049.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bc6068539635053cd5769ad7fbfaac1b601d47806efcd42302976d4ded851f81"
      },
      "model-ple-0050.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "00395b2ea3748560e95044c1bfdaea9459ab5251b116776271be5413d7a6e6bb"
      },
      "model-ple-0051.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b99d8086e2aa0009d4fadb21d4e7da6b7bcb82e4b6610d2ab5345445730f9150"
      },
      "model-ple-0052.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3c5fd243d1df82e45b781d37ce6fff3bd0273c0fa8a2213156cc577d22a9d181"
      },
      "model-ple-0053.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "6fc86331ae221e5e425845ce335847abe3f29e79fc968923746113bdd93b06d8"
      },
      "model-ple-0054.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "cdda85af7c5f26cba6e15713398f8cbd713fd6b7b009792d49bc5cca6c32f0ef"
      },
      "model-ple-0055.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "02c19734b541ff11baafe90bd1f043351bc11553d8b90cca19ddcacf2e872cf4"
      },
      "model-ple-0056.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "9694751961ca48579276159965bb28004bc18ffcd3b43f4b4a41c50287050e1d"
      },
      "model-ple-0057.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "2cc7094e9c3c5e8cadda4bbe3d070f4ac7690d92a554ad9556f0180a4faa3a2f"
      },
      "model-ple-0058.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ec72915d85e22b4f45ef9a1a203a3a20489c9a397a8c321b811e6398e4ef8cf5"
      },
      "model-ple-0059.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "30601bca7681b684446b3fe082d6f602834334906f0da324a06240ced9c7258c"
      },
      "model-ple-0060.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "2c1ec0601f6a3da886786722af262e7c0eda49a5beb7a853ca759ebf4f72bf94"
      },
      "model-ple-0061.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a19e315e9cf41ad09a8a2597ae216aef778e61942c0cc17861ede8238d73d10d"
      },
      "model-ple-0062.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ea48c8a3345e8b7ed78cee64bded562173a068b6bc08ac939206532bec0b3a6d"
      },
      "model-ple-0063.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "92a2e6d248948dd8f1bc8a2da4f0556f6c9d3cd3c77bd7ddc7894afa416d546f"
      },
      "model-ple-0064.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a4453fcd18ae242d0d6f67a0f8209b0b0cfab3d3aa9791ad01bc904de1c02099"
      },
      "model-ple-0065.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4ac31d394ecd8dea25bd1c2625a9e998ad67aa951cedd0aac48a31e47db78b81"
      },
      "model-ple-0066.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "7aa2c47b472750b09dcd5c3429537cefb29a67e2c7e6ed3ecc45921e5ede4d9d"
      },
      "model-ple-0067.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "9e3eb5c65624e68c9aa2c03630d637240b84639a148986b68c54d0586002bfcc"
      },
      "model-ple-0068.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f092afee16b92fd629cd435754464bfb7399583361a2de6e28bc61c7bf3e03f0"
      },
      "model-ple-0069.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4484efbfc50c2da7239301b2a577ff01a9f2d57fe3eec19e5a84afb8fae0941c"
      },
      "model-ple-0070.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "7d702b9ac67ddb93cc79468f15efd544f8cf00fc8ee24a4592343ac57f540230"
      },
      "model-ple-0071.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "94c27f8e2940e26ac94abae936d900f3dbddb9476dfa44e40949b1adf91c734b"
      },
      "model-ple-0072.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "50351633564ce5d634d2e607760cd2dc69a752b9a8eba816e21c7bffb83a912b"
      },
      "model-ple-0073.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "b0094898fec024d9cc3eb89141c2a0088890c107e711007dba12860bcd161c92"
      },
      "model-ple-0074.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "538cd2468b9f17025b9294a9ebbb88f90c4057792788122d2b9729e4fbd51ac8"
      },
      "model-ple-0075.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "090fb3f4e51c571ec21945dcdae60e781a63da68ac6eba625f30405c6283502f"
      },
      "model-ple-0076.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c37ee3bbdf001e656363ba7a17b720782e3efa0c9a3e093b98bb1c3a8fa3ada8"
      },
      "model-ple-0077.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1afb6f34ba39c829e0f01f74b215f961ada3af85ee74c32e9119bf110c4589a7"
      },
      "model-ple-0078.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ff2b2bdd002619eff9af6f611579e3cfa97b0ea7ecba1c1e2c0c7895e9c0adde"
      },
      "model-ple-0079.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "f8c8bab2959d95dae50e5d6bd3ef51485192e4fb60697ffc30c8af7d14f1bc46"
      },
      "model-ple-0080.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "23290be37802733804125dec069184bf2e940e6b62b9f4cd29279832874e341f"
      },
      "model-ple-0081.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "c47dbf757546b3f15d712994d4947668cb32f5551adcd51ed0e0e1e3c517290f"
      },
      "model-ple-0082.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1cd8678402df2aac6285484c77cce113b874342252d007b743a3f09266023231"
      },
      "model-ple-0083.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "16d3aeb9b4b880357eb8056c933e75d9234e1e15f007915be2e2230cb8bda62f"
      },
      "model-ple-0084.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4f9dd53c589d6c9483504b04dd07895c76e41923680002bab40fdf78f40ae7ba"
      },
      "model-ple-0085.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bb9c554e63b2b004df529d7ceca9aa3f1f1bf685ac83d8c7deb3b300da1e8c0e"
      },
      "model-ple-0086.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e38428660160bf6430e8130799f98c3ebfc7a07f501d89ff059d058872cbcf54"
      },
      "model-ple-0087.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "36e3a70566f3482cd342030f7e71c619e2aa065541c054234625575848ce712a"
      },
      "model-ple-0088.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "2b3ab2a5354a6f5ce3efaa1a7f9e94437829a57061a832b8c3657dc7009bb703"
      },
      "model-ple-0089.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "696ca36ea1ca83917d5bf1c625aef6348efa62b24d5146b06e44126b4bc0ec32"
      },
      "model-ple-0090.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "bb5879c8a679dd3dcae435794196f5441b1a63dc66ca6fee4564271e564a36a3"
      },
      "model-ple-0091.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "52da2b6ccdd2b4641bb3977eba258ff1916c1563ffe2192bba9adc8efaaf3ef9"
      },
      "model-ple-0092.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "7b3956fa3b84865bb42c1b5c6bd8c864c5a502f5749812251dc29a3f901638c5"
      },
      "model-ple-0093.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "7156712e6c955f634c045c5b3fb7fc6620dc567a94488e8d878bd5f8b28d812e"
      },
      "model-ple-0094.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a8eddd4d9c273e6913b23897d219e7e6fe7476e7f7583cf4db92cb34a82d4ce0"
      },
      "model-ple-0095.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "34403637131b56b64707a27dc7ccfd8377d7ec327a8096cc8867f4b81efa9efe"
      },
      "model-ple-0096.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "a2389e0aa89d689387ea0fd929657c68ad8b8c0390e71e80b8f9722f13852d63"
      },
      "model-ple-0097.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "0f786045e8079d0fc2480ba3e0c18a3736335667838c8412cdf317503dcd0eb9"
      },
      "model-ple-0098.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "df2b0a3e023d4ebe018fce7024a4a6d7a851f11374dd233ac7ad8cecbb32d839"
      },
      "model-ple-0099.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dd017a3698656f1f5c9d0117f7473363b60c6bbeadb1644e2a0f783474a22013"
      },
      "model-ple-0100.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "95c8400bc37157c1c8e2639a528a87cb0e316e493e877cb5cce82451ae931cf8"
      },
      "model-ple-0101.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "600801c60229f1e5de116250174d381cf4ee750ab05b20c9f60c9d50c5482685"
      },
      "model-ple-0102.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "33be4fcf6754b16837c1dd492b5b6f1bf66d493bbbcd99a65241da5d6a91b6e2"
      },
      "model-ple-0103.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "9b64e839cb13dbbaa6f1e91b5fd0e87dd11d93d107dbf4f923bec0408ddf7b85"
      },
      "model-ple-0104.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "36282e4e21fe2034ae8aa7ffe1fe679ff115ad9d28296dd1969edea62e2fa326"
      },
      "model-ple-0105.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e0d77508d10660e5b158d7062f23ef314a0b1978016dd4a5e03ade161d6cec3b"
      },
      "model-ple-0106.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "1a67ddee64fedb15689b3d4c19b5fd101370f48e979b184dfc9edbc06035ae22"
      },
      "model-ple-0107.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "63f2c5c4e2caac15d7e5bf6d61f0d66536f72f23008dad05eba9d4025f1b6359"
      },
      "model-ple-0108.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "dfd28d3b80f5ec901a604a5f5332139eb8261692efad7406659e6dacb9ef8d69"
      },
      "model-ple-0109.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "ae463e455446268ab0be5c29f1602b5e153e2f418d3f85b777add05c3f33f207"
      },
      "model-ple-0110.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "74466a2e8c0c33a5f576ad7ba3837cb4ce7fe083db95d73b3ac07452c8bb3257"
      },
      "model-ple-0111.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "9ae1b22f8c8a050917a4c13154351f3902771c6cf527bdabc68d2cc3905fc5ce"
      },
      "model-ple-0112.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "4376be1cb1d069cf704d91de3c242de4f29783402656f18b8c8b51ec6b678ee4"
      },
      "model-ple-0113.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "185ac9215f5b833892c48b0582e8486756db84a8b733ee9f02086e1a90d0c5e8"
      },
      "model-ple-0114.safetensors": {
        "bytes_read": 16579,
        "reads": 7,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "422fdea678719d7d5dedeb9218b1e65959d4b4bb84c1d3ddee71b51db07852d9"
      },
      "model-ple-0115.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "5cada7840d40160752fc660ba396f299e7c9ebfcdf50dd13043b80978178699d"
      },
      "model-ple-0116.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "54fd5f5f1bddadbe341ee8f872417958522366a651ba6eebda9524ee94b88974"
      },
      "model-ple-0117.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "567f929791b3fc853ba116a60fa880f7d081de2a4b47041c2977323110892b6e"
      },
      "model-ple-0118.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "21745ac65ad92b62ea98519d7c3aa94bf64dccbbaa6cb31a44caaa6e78d054c1"
      },
      "model-ple-0119.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "e66d4681634b283eb2e3922e4509759f55e4f1e3fbbb7abb3bf8b198667d4b74"
      },
      "model-ple-0120.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "517443da11d1cea3460f311c11b8ff76ff80e94c9570cb054feaf3a05df8de9c"
      },
      "model-ple-0121.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3e52c5dbe95caad4715c479c98fde0df8a667d11e7f62d25507ba267779bf465"
      },
      "model-ple-0122.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "77463a083b2105300112b8fddcd0cb961d52c0213511478c4593d11bf9d9adb4"
      },
      "model-ple-0123.safetensors": {
        "bytes_read": 16644,
        "reads": 9,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "d085f466af53d040ebfb094ea0b272e3606dc7c7dcaf464f3bfaedfc398bbae0"
      },
      "model-ple-0124.safetensors": {
        "bytes_read": 16449,
        "reads": 3,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "eed5ee70be17ae996c9a4828a5f69cfa0d307aff371502067a1d927a82ff75b9"
      },
      "model-ple-0125.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "439e9d0939aed0f98721e76fbd4f145f2808836f1c33bc039da5228bee24e59f"
      },
      "model-ple-0126.safetensors": {
        "bytes_read": 16514,
        "reads": 5,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "3da86fc3fdeb940efa19ae71cde1ca80d3ed46b3930f0f9cce7194ab5a099430"
      },
      "model-ple-0127.safetensors": {
        "bytes_read": 16384,
        "reads": 1,
        "max_read_bytes": 16384,
        "ordered_ranges_sha256": "72a412543c2a51f822d448102c918789d4fe1e1927a7a59ef1e267851f40d6e2"
      }
    },
    "tables": {
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_1": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_10": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_100": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_101": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_102": {
        "calls": 2,
        "rows_requested": 171,
        "unique_rows_read": 5,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_103": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_104": {
        "calls": 1,
        "rows_requested": 3,
        "unique_rows_read": 3,
        "max_rows": 3,
        "max_result_bytes": 195
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_105": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_106": {
        "calls": 1,
        "rows_requested": 168,
        "unique_rows_read": 2,
        "max_rows": 168,
        "max_result_bytes": 10920
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_107": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_108": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_109": {
        "calls": 1,
        "rows_requested": 169,
        "unique_rows_read": 3,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_11": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_110": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_111": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_112": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_113": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_114": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_115": {
        "calls": 1,
        "rows_requested": 171,
        "unique_rows_read": 4,
        "max_rows": 171,
        "max_result_bytes": 11115
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_116": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_117": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_118": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_119": {
        "calls": 1,
        "rows_requested": 253,
        "unique_rows_read": 3,
        "max_rows": 253,
        "max_result_bytes": 16445
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_12": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_120": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_121": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_122": {
        "calls": 2,
        "rows_requested": 86,
        "unique_rows_read": 3,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_123": {
        "calls": 1,
        "rows_requested": 254,
        "unique_rows_read": 4,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_124": {
        "calls": 1,
        "rows_requested": 169,
        "unique_rows_read": 2,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_125": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_126": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_127": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_13": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_14": {
        "calls": 1,
        "rows_requested": 171,
        "unique_rows_read": 3,
        "max_rows": 171,
        "max_result_bytes": 11115
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_15": {
        "calls": 2,
        "rows_requested": 3,
        "unique_rows_read": 3,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_16": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_17": {
        "calls": 1,
        "rows_requested": 256,
        "unique_rows_read": 4,
        "max_rows": 256,
        "max_result_bytes": 16640
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_18": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_19": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_2": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_20": {
        "calls": 2,
        "rows_requested": 87,
        "unique_rows_read": 4,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_21": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_22": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_23": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_24": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_25": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_26": {
        "calls": 1,
        "rows_requested": 169,
        "unique_rows_read": 2,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_27": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_28": {
        "calls": 2,
        "rows_requested": 86,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_29": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_3": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_30": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_31": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_32": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_33": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_34": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_35": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_36": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_37": {
        "calls": 2,
        "rows_requested": 85,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_38": {
        "calls": 1,
        "rows_requested": 254,
        "unique_rows_read": 3,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_39": {
        "calls": 1,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_4": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_40": {
        "calls": 2,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_41": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_42": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_43": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_44": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_45": {
        "calls": 1,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_46": {
        "calls": 1,
        "rows_requested": 254,
        "unique_rows_read": 4,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_47": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_48": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_49": {
        "calls": 1,
        "rows_requested": 170,
        "unique_rows_read": 2,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_5": {
        "calls": 1,
        "rows_requested": 86,
        "unique_rows_read": 2,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_50": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_51": {
        "calls": 1,
        "rows_requested": 86,
        "unique_rows_read": 2,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_52": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_53": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_54": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_55": {
        "calls": 1,
        "rows_requested": 86,
        "unique_rows_read": 2,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_56": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_57": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_58": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_59": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_6": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_60": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_61": {
        "calls": 2,
        "rows_requested": 88,
        "unique_rows_read": 4,
        "max_rows": 87,
        "max_result_bytes": 5655
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_62": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_63": {
        "calls": 1,
        "rows_requested": 171,
        "unique_rows_read": 3,
        "max_rows": 171,
        "max_result_bytes": 11115
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_64": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_65": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_66": {
        "calls": 1,
        "rows_requested": 86,
        "unique_rows_read": 3,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_67": {
        "calls": 1,
        "rows_requested": 87,
        "unique_rows_read": 4,
        "max_rows": 87,
        "max_result_bytes": 5655
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_68": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_69": {
        "calls": 2,
        "rows_requested": 85,
        "unique_rows_read": 2,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_7": {
        "calls": 1,
        "rows_requested": 254,
        "unique_rows_read": 3,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_70": {
        "calls": 1,
        "rows_requested": 86,
        "unique_rows_read": 2,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_71": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_72": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_73": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_74": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_75": {
        "calls": 2,
        "rows_requested": 170,
        "unique_rows_read": 3,
        "max_rows": 169,
        "max_result_bytes": 10985
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_76": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_77": {
        "calls": 1,
        "rows_requested": 86,
        "unique_rows_read": 3,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_78": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_79": {
        "calls": 1,
        "rows_requested": 2,
        "unique_rows_read": 2,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_8": {
        "calls": 1,
        "rows_requested": 254,
        "unique_rows_read": 3,
        "max_rows": 254,
        "max_result_bytes": 16510
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_80": {
        "calls": 1,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_81": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_82": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_83": {
        "calls": 1,
        "rows_requested": 86,
        "unique_rows_read": 2,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_84": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_85": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_86": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_87": {
        "calls": 2,
        "rows_requested": 3,
        "unique_rows_read": 3,
        "max_rows": 2,
        "max_result_bytes": 130
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_88": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_89": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_9": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_90": {
        "calls": 1,
        "rows_requested": 84,
        "unique_rows_read": 1,
        "max_rows": 84,
        "max_result_bytes": 5460
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_91": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_92": {
        "calls": 1,
        "rows_requested": 86,
        "unique_rows_read": 2,
        "max_rows": 86,
        "max_result_bytes": 5590
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_93": {
        "calls": 1,
        "rows_requested": 1,
        "unique_rows_read": 1,
        "max_rows": 1,
        "max_result_bytes": 65
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_94": {
        "calls": 2,
        "rows_requested": 88,
        "unique_rows_read": 4,
        "max_rows": 87,
        "max_result_bytes": 5655
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_95": {
        "calls": 1,
        "rows_requested": 170,
        "unique_rows_read": 4,
        "max_rows": 170,
        "max_result_bytes": 11050
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_96": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 1,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_97": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_98": {
        "calls": 1,
        "rows_requested": 85,
        "unique_rows_read": 2,
        "max_rows": 85,
        "max_result_bytes": 5525
      },
      "model.layers.1.ple.ple_embedding.ngram_embedding.shard_99": {
        "calls": 0,
        "rows_requested": 0,
        "unique_rows_read": 0,
        "max_rows": 0,
        "max_result_bytes": 0
      }
    }
  }
}
````

### vq-feasibility-tokens.json

Original bytes: 31; SHA-256: `67557f1a8d27e83d8f43b72ca72904ae05a1cc46cd9bd9341a9cdedfa1f0ca0d`.

````text
[9707, 11, 1246, 525, 498, 30]
````

### vq-order-tokens.json

Original bytes: 2574; SHA-256: `a9d0087a584fef727945b03897a57da9c5d720bd7e849b7a43744c70727b2e73`.

````text
[9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 248044, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 11, 1246, 525, 498, 30, 9707, 248044, 1246]
````

### frozen-logits-v1/build-identity.json

Original bytes: 27677; SHA-256: `c24b302090eeb5a42993856fe7cb92fccd24efc0a669827935ea6ffa905d3c56`.

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
    "Sources/Slotstream/Checkpoint.swift": "1d978203cdceea932a94e83b0967adf01e0c80bee4c70e0f818ca34cd235fe2d",
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
    "Sources/Slotstream/Layers.swift": "3d84885d4452d14845271fc6deb2d9146d1b0d00ae78ab3fbcf98528e95560c9",
    "Sources/Slotstream/MTP.swift": "973fded18e26361262bb635a3e9dbfa1b8e3f8281dfda8682904638096c8fca2",
    "Sources/Slotstream/MTPExpertStream.swift": "391b13fed457ba61a7cb4e107472a699ba87adc9a57cfd14580faa2dfbe50fd7",
    "Sources/Slotstream/Machine.swift": "34bffbaad9bd1a80f8d8aacc6b1abbbfa2d616690546a2a709363c4fb44033f6",
    "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
    "Sources/Slotstream/Model.swift": "1048ad7bcd1c9f93f5316465ed38d7bd93046fe4bfbd0fc138d972e646ee12ab",
    "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
    "Sources/Slotstream/NgramStore.swift": "f9f0cf609ac1bec2c7abb645b365fcb174dd4b5ec812b602985bacab847cdfbf",
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
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQExpert.swift": "c505139817de503604c337e08b104d7567fef80ec36522eb5ac68f6ac9206b3c",
    "Sources/Slotstream/VQKernelSources.swift": "ea98803b719f0916e7c2ba6ce53f9d85c624d72a691959cb843fb3abf50653d9",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "ac0a81ccd99ebb59a52ad0728221f34c59d2402d255b4e6a9cbb583b7d42dd6f",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+Quantization.swift": "ec074376677b6deb0e03eefc28f9269815265a82325e2fcb89df08e75bf3e619",
    "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationBench.swift": "7037fa0693746e35b91d146180e74883ccdbfabcbe54df8e970948c177f54ad1",
    "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationFixtures.swift": "9abb390231b4a1162df9605ccd4ab0b8840a474f7925f9acae2f70c79d27ae47",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VerifyPass.swift": "37baddc192c0f9083bef740f897d16cda315b82017349b122807bfbfcc77400e",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "7779c1339db28cce006d300d6bdd41e3e9a27c55314153aa12659c3e11d575b3",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
    "Sources/SlotstreamTestKit/AnthropicChecks.swift": "a15f7854d8f2da41184d30fac17f94f1e6e1cb68fd4236eb3c63f60e12714648",
    "Sources/SlotstreamTestKit/AnthropicTurnChecks.swift": "4d585e3ddb8692c1668d065a99c6ff1a56109f6da33328600f646bdc16f43aa5",
    "Sources/SlotstreamTestKit/Catalogue.swift": "bdfef7fffc2bbd801fc1880f9d9134783134a0e36e2424c3eb419b2767fe62a7",
    "Sources/SlotstreamTestKit/CodexFixture.swift": "23839d1d776252c1c5cec6a3acaf6c08c1e89bc7def714f7b5f3180fae57aac0",
    "Sources/SlotstreamTestKit/GatewayChecks.swift": "a9e798d056582f4d97554b9131b3f8c7220a37a314312bb3c0e590883c7c8ad4",
    "Sources/SlotstreamTestKit/LaunchChecks.swift": "8fd6f5920b219d68f0ea69295810a0a6b34effdee69ac855b04212399379e54d",
    "Sources/SlotstreamTestKit/OpenAIChecks.swift": "cb813af4c908567161db660aa8c6b78710be6a2b80a97a6e6d90e995ecd8806f",
    "Sources/SlotstreamTestKit/PersistentPrefixChecks.swift": "2a5cc8ffaf4befb90a732f350f84c34f162ad7ca67b0fb50eae3060fdeb0b0b3",
    "Sources/SlotstreamTestKit/PersistentPrefixIOChecks.swift": "c16d39aaf50f66ffa0f4f5fef02937dd141d5ba2ad7f42bcc9f387416d503f2c",
    "Sources/SlotstreamTestKit/PersistentPrefixMetadataChecks.swift": "65b5a45b3954c98517b777039373030f309e0271a6343037c6a452b4e03a82e8",
    "Sources/SlotstreamTestKit/PersistentPrefixRemovalChecks.swift": "a910392fe22933480cba14e3c604933066ba9178b670db4442e8c53b1c79a459",
    "Sources/SlotstreamTestKit/ResponsesChecks.swift": "6f692f86a68f6bbd1f62b6bdc544fdebaba1196e902b58a59313755af68be130",
    "Sources/SlotstreamTestKit/T0Checks.swift": "0cc6543c5f9210c500373aa8c316b2634ae5612f2336f158a2629355eb699321",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "26e617adc59b71650f0d8dcecc64f3fc5f541931e081e44658b231870a9df93e",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "d5acd22c67996527b1dbd6bfa81b487cdce963411d111a0dad5cb3dbbbc6a559",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "83c4569983bd96d16821ee87857c2015e975da387adf3573dd1e4660095e87fd",
  "binary_sha256": "8aaeebafb0fb6f3d05f44af518f8fa94d4d49eb97ec256e00fbf5e0cbf3feb16",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````

### run-baseline-logits.py

Original bytes: 2357; SHA-256: `15b4c32ba41f83c473c9ad432b4d99619a39ec7fb66dfdf8050a5cabd48237ea`.

````text
from pathlib import Path
import ctypes,ctypes.util,hashlib,json,os,subprocess,sys,time
sys.path.insert(0,'Tools')
from context_qualification import quiet_preflight
from prefill_bench import terminate_child_tree,vm_snapshot
root=Path('.build/quantization-research');out=root/'baseline-logits-supervision-v1';out.mkdir()
before=quiet_preflight(13)
binary=Path('.build/release/slotstream').resolve()
cmd=[str(binary),'quantization-logits','--model',str(Path.home()/'.slotstream/models/qwen38-flash-next-mlx-4bit'),'--tokens',str(root/'vq-feasibility-tokens.json'),'--output',str(root/'baseline-logits-v1')]
env={k:v for k,v in os.environ.items() if not k.startswith(('SLOTSTREAM_','SS_DEBUG'))}
identity={'command':cmd,'binary_sha256':hashlib.sha256(binary.read_bytes()).hexdigest(),'metallib_sha256':hashlib.sha256((binary.parent/'mlx.metallib').read_bytes()).hexdigest(),'before':before,'removed_override_names':sorted(set(os.environ)-set(env))}
(out/'identity.json').write_text(json.dumps(identity,indent=2)+'\n')
lib=ctypes.CDLL(ctypes.util.find_library('proc')); peak=0;samples=0;last_pressure=0
with (out/'stdout.txt').open('w') as stdout,(out/'stderr.txt').open('w') as stderr:
 child=subprocess.Popen(cmd,env=env,stdout=stdout,stderr=stderr,start_new_session=True)
 started=time.monotonic()
 try:
  while child.poll() is None:
   data=ctypes.create_string_buffer(296)
   if lib.proc_pid_rusage(child.pid,4,data)==0:
    footprint=max(int.from_bytes(data.raw[72:80],'little'),int.from_bytes(data.raw[240:248],'little'))
    peak=max(peak,footprint);samples+=1
    if footprint>10_000_000_000:raise RuntimeError('native baseline exceeded 10 GB')
   if time.monotonic()-last_pressure>1:
    if subprocess.check_output(['sysctl','-n','kern.memorystatus_vm_pressure_level'],text=True).strip()!='1':raise RuntimeError('OS memory pressure')
    last_pressure=time.monotonic()
   if time.monotonic()-started>600:raise RuntimeError('native baseline timed out')
   time.sleep(.05)
 finally:
  if child.poll() is None:terminate_child_tree(child)
 receipt={'exit_code':child.returncode,'sampled_peak_bytes':peak,'samples':samples,'after':vm_snapshot(),'scope':'functional native logit export while candidate transfer runs; no timing claim'}
 (out/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps(receipt))
 assert child.returncode==0
````

### run-baseline-logits-boundary.py

Original bytes: 2351; SHA-256: `2df8cb47b345c04dd980f08db91156c632b77fa1ce20c39ad4e456eaed0f9774`.

````text
from pathlib import Path
import ctypes,ctypes.util,hashlib,json,os,subprocess,sys,time
sys.path.insert(0,'Tools')
from context_qualification import quiet_preflight
from prefill_bench import terminate_child_tree,vm_snapshot
root=Path('.build/quantization-research');out=root/'baseline-logits-supervision-v2';out.mkdir()
before=quiet_preflight(13)
binary=Path('.build/release/slotstream').resolve()
cmd=[str(binary),'quantization-logits','--model',str(Path.home()/'.slotstream/models/qwen38-flash-next-mlx-4bit'),'--tokens',str(root/'vq-order-tokens.json'),'--output',str(root/'baseline-logits-v2')]
env={k:v for k,v in os.environ.items() if not k.startswith(('SLOTSTREAM_','SS_DEBUG'))}
identity={'command':cmd,'binary_sha256':hashlib.sha256(binary.read_bytes()).hexdigest(),'metallib_sha256':hashlib.sha256((binary.parent/'mlx.metallib').read_bytes()).hexdigest(),'before':before,'removed_override_names':sorted(set(os.environ)-set(env))}
(out/'identity.json').write_text(json.dumps(identity,indent=2)+'\n')
lib=ctypes.CDLL(ctypes.util.find_library('proc')); peak=0;samples=0;last_pressure=0
with (out/'stdout.txt').open('w') as stdout,(out/'stderr.txt').open('w') as stderr:
 child=subprocess.Popen(cmd,env=env,stdout=stdout,stderr=stderr,start_new_session=True)
 started=time.monotonic()
 try:
  while child.poll() is None:
   data=ctypes.create_string_buffer(296)
   if lib.proc_pid_rusage(child.pid,4,data)==0:
    footprint=max(int.from_bytes(data.raw[72:80],'little'),int.from_bytes(data.raw[240:248],'little'))
    peak=max(peak,footprint);samples+=1
    if footprint>10_000_000_000:raise RuntimeError('native baseline exceeded 10 GB')
   if time.monotonic()-last_pressure>1:
    if subprocess.check_output(['sysctl','-n','kern.memorystatus_vm_pressure_level'],text=True).strip()!='1':raise RuntimeError('OS memory pressure')
    last_pressure=time.monotonic()
   if time.monotonic()-started>600:raise RuntimeError('native baseline timed out')
   time.sleep(.05)
 finally:
  if child.poll() is None:terminate_child_tree(child)
 receipt={'exit_code':child.returncode,'sampled_peak_bytes':peak,'samples':samples,'after':vm_snapshot(),'scope':'functional native logit export while candidate transfer runs; no timing claim'}
 (out/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps(receipt))
 assert child.returncode==0
````

### baseline-logits-v1/receipt.json

Original bytes: 3231; SHA-256: `b44eb806ecb178b36b48fe7c568d63f3a509914d50ba9aa4a3a9cb85117d1b00`.

````text
{
  "after" : {
    "reclaimableBytes" : 16551755776,
    "swapins" : 0,
    "swapouts" : 0
  },
  "arithmetic" : "native deployed defaults, teacher-forced chunks, complete head before row selection",
  "before" : {
    "reclaimableBytes" : 20918272000,
    "swapins" : 0,
    "swapouts" : 0
  },
  "logits" : {
    "bytes" : 5959680,
    "path" : "logits.f32",
    "sha256" : "39ef706d3404731aaf6a2da0a1762c581a5bc719cee55da7a6526daa74e9f8f6"
  },
  "mtp" : false,
  "optimizations" : {
    "adaptiveSpeculation" : false,
    "alignedPrefixResume" : true,
    "automaticReadScope" : true,
    "boundedDraftTail" : false,
    "boundedIndexer" : false,
    "boundedOutputQueue" : true,
    "boundedPLE" : false,
    "boundedSweepRows" : false,
    "cachedRouterWeights" : false,
    "compactIndexerRaw" : false,
    "compactMTPRow" : true,
    "compactNgramRows" : true,
    "compactScopeFrontier" : false,
    "compactStateWindows" : true,
    "compiledNormFinish" : false,
    "completePromptCheckpoint" : true,
    "contiguousSlotWrites" : false,
    "cpuSlotWrites" : false,
    "deduplicateImages" : false,
    "demandedPrefillOutput" : false,
    "denseExpertLookup" : false,
    "denseIndexerBypass" : false,
    "deviceSamplerDraw" : true,
    "directDemandReads" : true,
    "directReadHandles" : false,
    "disjointSweepOutput" : false,
    "fusedGDNProjection" : false,
    "fusedGDNRecording" : false,
    "fusedPrefillAttention" : true,
    "fusedPrefillWorkspace" : true,
    "fusedRoPE" : true,
    "incrementalIndexer" : false,
    "indexerBlockTopK" : false,
    "layerExpertWorkspace" : false,
    "layerLocalFloorCache" : false,
    "ngramLookahead" : false,
    "ngramRingOrder" : false,
    "overlapResidentExperts" : false,
    "overlapSharedExpert" : false,
    "prefixCheckpointTokens" : 256,
    "readScopeTokens" : 0,
    "resolvedRuntimeBudget" : false,
    "responsiveGovernor" : true,
    "reuseFirstMTPEntry" : false,
    "routerTopK" : false,
    "selectedTextAttention" : false,
    "sharedRoPE" : true,
    "skipUnusedFinalForward" : true,
    "sparsePoolPins" : false,
    "tailAwarePrefill" : false,
    "terminalLastQuery" : false,
    "terminalPrefillPruning" : false,
    "valueOnlySamplerThreshold" : true,
    "verifySplitAttention" : true,
    "visionAttentionPadding" : 0,
    "visionQueryTile" : 256,
    "wordSlotWrites" : false,
    "workspacePiecewiseWrites" : false,
    "workspaceTokenTile" : 256
  },
  "pack_repo" : "pipenetwork\/Qwen3.8-Flash-Next-MLX-4bit",
  "pack_revision" : "aa7c790e804bbf9d491ddb109c3d61bc4a555f7c",
  "peak_mlx_bytes" : 4501476668,
  "peak_process_bytes" : 4643262304,
  "pinned_manifest_sha256" : "4bfc1c7a674d69a33b4058c8aa0e7de174f7e118f57360d695d7ce732bf05351",
  "pool_slots" : 640,
  "positions" : [
    0,
    1,
    2,
    3,
    4,
    5
  ],
  "prompt_chunk" : 512,
  "schema" : 1,
  "scope" : "native baseline pilot; not candidate quality or speed qualification",
  "tokens" : [
    9707,
    11,
    1246,
    525,
    498,
    30
  ],
  "tokens_sha256" : "67557f1a8d27e83d8f43b72ca72904ae05a1cc46cd9bd9341a9cdedfa1f0ca0d",
  "vision" : false,
  "weight_provenance" : "run pull --verify separately; this command validates checkpoint metadata"
}
````

### baseline-logits-supervision-v1/identity.json

Original bytes: 2585; SHA-256: `d76e2193a7d062c80bd6aaf18965e2e07c99cae7a8a2f59a0ea5ebd2774cf7cc`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/arm64-apple-macosx/release/slotstream",
    "quantization-logits",
    "--model",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--tokens",
    ".build/quantization-research/vq-feasibility-tokens.json",
    "--output",
    ".build/quantization-research/baseline-logits-v1"
  ],
  "binary_sha256": "8aaeebafb0fb6f3d05f44af518f8fa94d4d49eb97ec256e00fbf5e0cbf3feb16",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed",
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 20514471936,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     4221.\nPages active:                                 710564.\nPages inactive:                              1533569.\nPages speculative:                             38434.\nPages throttled:                                   0.\nPages wired down:                             183893.\nPages purgeable:                               15804.\n\"Translation faults\":                      826245876.\nPages copy-on-write:                        49638702.\nPages zero filled:                        1674968483.\nPages reactivated:                          87984319.\nPages purged:                               10026639.\nFile-backed pages:                           1232079.\nAnonymous pages:                             1050488.\nPages stored in compressor:                  1086699.\nPages occupied by compressor:                 614749.\nDecompressions:                             18675950.\nCompressions:                               26201708.\nPageins:                                   184432683.\nPageouts:                                     289126.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 132671.\nPages tagged resident:                         92851.\nPages tagged compressed:                       39820.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5197.\nPages tag-storage free:                          164.\nPages tag-storage non-tag pageable:            92935.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5895168.\nTagged compressions:                          379783.\nTagged decompressions:                        310815.\n"
  },
  "removed_override_names": []
}
````

### baseline-logits-supervision-v1/receipt.json

Original bytes: 2175; SHA-256: `b2190f4b5f8f17536da262a7396e598699a78fcd3bb7c5c4922174d552f0d7cc`.

````text
{
  "exit_code": 0,
  "sampled_peak_bytes": 4643311456,
  "samples": 24,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 20280623104,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   289347.\nPages active:                                 726093.\nPages inactive:                              1214294.\nPages speculative:                             57971.\nPages throttled:                                   0.\nPages wired down:                             182947.\nPages purgeable:                               15803.\n\"Translation faults\":                      826546567.\nPages copy-on-write:                        49642450.\nPages zero filled:                        1675270035.\nPages reactivated:                          87984319.\nPages purged:                               10026649.\nFile-backed pages:                            932681.\nAnonymous pages:                             1065677.\nPages stored in compressor:                  1086687.\nPages occupied by compressor:                 614746.\nDecompressions:                             18675962.\nCompressions:                               26201708.\nPageins:                                   184571656.\nPageouts:                                     289126.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 132878.\nPages tagged resident:                         93058.\nPages tagged compressed:                       39820.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5197.\nPages tag-storage free:                          168.\nPages tag-storage non-tag pageable:            92931.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5895168.\nTagged compressions:                          379783.\nTagged decompressions:                        310815.\n"
  },
  "scope": "functional native logit export while candidate transfer runs; no timing claim"
}
````

### baseline-logits-v2/receipt.json

Original bytes: 7905; SHA-256: `af178f805770e05b0b14c849ef02b76d6c6a8999a4473f0ba3f0d04782c1fbdf`.

````text
{
  "after" : {
    "reclaimableBytes" : 17580867584,
    "swapins" : 0,
    "swapouts" : 0
  },
  "arithmetic" : "native deployed defaults, teacher-forced chunks, complete head before row selection",
  "before" : {
    "reclaimableBytes" : 21108228096,
    "swapins" : 0,
    "swapouts" : 0
  },
  "logits" : {
    "bytes" : 15892480,
    "path" : "logits.f32",
    "sha256" : "32d8470fb7a6fad30e7a62f86e9d15f73555659eb8a4113596670eefb434b8c0"
  },
  "mtp" : false,
  "optimizations" : {
    "adaptiveSpeculation" : false,
    "alignedPrefixResume" : true,
    "automaticReadScope" : true,
    "boundedDraftTail" : false,
    "boundedIndexer" : false,
    "boundedOutputQueue" : true,
    "boundedPLE" : false,
    "boundedSweepRows" : false,
    "cachedRouterWeights" : false,
    "compactIndexerRaw" : false,
    "compactMTPRow" : true,
    "compactNgramRows" : true,
    "compactScopeFrontier" : false,
    "compactStateWindows" : true,
    "compiledNormFinish" : false,
    "completePromptCheckpoint" : true,
    "contiguousSlotWrites" : false,
    "cpuSlotWrites" : false,
    "deduplicateImages" : false,
    "demandedPrefillOutput" : false,
    "denseExpertLookup" : false,
    "denseIndexerBypass" : false,
    "deviceSamplerDraw" : true,
    "directDemandReads" : true,
    "directReadHandles" : false,
    "disjointSweepOutput" : false,
    "fusedGDNProjection" : false,
    "fusedGDNRecording" : false,
    "fusedPrefillAttention" : true,
    "fusedPrefillWorkspace" : true,
    "fusedRoPE" : true,
    "incrementalIndexer" : false,
    "indexerBlockTopK" : false,
    "layerExpertWorkspace" : false,
    "layerLocalFloorCache" : false,
    "ngramLookahead" : false,
    "ngramRingOrder" : false,
    "overlapResidentExperts" : false,
    "overlapSharedExpert" : false,
    "prefixCheckpointTokens" : 256,
    "readScopeTokens" : 0,
    "resolvedRuntimeBudget" : false,
    "responsiveGovernor" : true,
    "reuseFirstMTPEntry" : false,
    "routerTopK" : false,
    "selectedTextAttention" : false,
    "sharedRoPE" : true,
    "skipUnusedFinalForward" : true,
    "sparsePoolPins" : false,
    "tailAwarePrefill" : false,
    "terminalLastQuery" : false,
    "terminalPrefillPruning" : false,
    "valueOnlySamplerThreshold" : true,
    "verifySplitAttention" : true,
    "visionAttentionPadding" : 0,
    "visionQueryTile" : 256,
    "wordSlotWrites" : false,
    "workspacePiecewiseWrites" : false,
    "workspaceTokenTile" : 256
  },
  "pack_repo" : "pipenetwork\/Qwen3.8-Flash-Next-MLX-4bit",
  "pack_revision" : "aa7c790e804bbf9d491ddb109c3d61bc4a555f7c",
  "peak_mlx_bytes" : 5673917868,
  "peak_process_bytes" : 6183357608,
  "pinned_manifest_sha256" : "4bfc1c7a674d69a33b4058c8aa0e7de174f7e118f57360d695d7ce732bf05351",
  "pool_slots" : 640,
  "positions" : [
    497,
    498,
    499,
    500,
    501,
    502,
    503,
    504,
    505,
    506,
    507,
    508,
    509,
    510,
    511,
    512
  ],
  "prompt_chunk" : 512,
  "schema" : 1,
  "scope" : "native baseline pilot; not candidate quality or speed qualification",
  "tokens" : [
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    248044,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    11,
    1246,
    525,
    498,
    30,
    9707,
    248044,
    1246
  ],
  "tokens_sha256" : "a9d0087a584fef727945b03897a57da9c5d720bd7e849b7a43744c70727b2e73",
  "vision" : false,
  "weight_provenance" : "run pull --verify separately; this command validates checkpoint metadata"
}
````

### baseline-logits-supervision-v2/identity.json

Original bytes: 2579; SHA-256: `d081539f83c3c8792450ad2155e8fc1a54f53de3d858ba4e015cea0e3060ec15`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/arm64-apple-macosx/release/slotstream",
    "quantization-logits",
    "--model",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--tokens",
    ".build/quantization-research/vq-order-tokens.json",
    "--output",
    ".build/quantization-research/baseline-logits-v2"
  ],
  "binary_sha256": "8aaeebafb0fb6f3d05f44af518f8fa94d4d49eb97ec256e00fbf5e0cbf3feb16",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed",
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 20449296384,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   140425.\nPages active:                                 724934.\nPages inactive:                              1368448.\nPages speculative:                             53939.\nPages throttled:                                   0.\nPages wired down:                             182855.\nPages purgeable:                               24573.\n\"Translation faults\":                      827074553.\nPages copy-on-write:                        49773194.\nPages zero filled:                        1675502877.\nPages reactivated:                          87984623.\nPages purged:                               10027195.\nFile-backed pages:                           1083128.\nAnonymous pages:                             1064193.\nPages stored in compressor:                  1086293.\nPages occupied by compressor:                 614650.\nDecompressions:                             18676356.\nCompressions:                               26201708.\nPageins:                                   184574091.\nPageouts:                                     289126.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 133448.\nPages tagged resident:                         93741.\nPages tagged compressed:                       39707.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5197.\nPages tag-storage free:                          202.\nPages tag-storage non-tag pageable:            92897.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5872064.\nTagged compressions:                          379783.\nTagged decompressions:                        310928.\n"
  },
  "removed_override_names": []
}
````

### baseline-logits-supervision-v2/receipt.json

Original bytes: 2175; SHA-256: `e46b430deca4ff1930f7d4fc835b56b576de29a67f7d2ebcea404eb3b4c4e7fd`.

````text
{
  "exit_code": 0,
  "sampled_peak_bytes": 6183357608,
  "samples": 73,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 20991754240,
    "swapins": 0,
    "swapouts": 0,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   382457.\nPages active:                                 949983.\nPages inactive:                               856834.\nPages speculative:                             92115.\nPages throttled:                                   0.\nPages wired down:                             184067.\nPages purgeable:                               13073.\n\"Translation faults\":                      827392913.\nPages copy-on-write:                        49779871.\nPages zero filled:                        1677304846.\nPages reactivated:                          88479957.\nPages purged:                               10037966.\nFile-backed pages:                            885705.\nAnonymous pages:                             1013227.\nPages stored in compressor:                  1113216.\nPages occupied by compressor:                 619583.\nDecompressions:                             18683207.\nCompressions:                               26235467.\nPageins:                                   184990030.\nPageouts:                                     289643.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 131826.\nPages tagged resident:                         92080.\nPages tagged compressed:                       39746.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5197.\nPages tag-storage free:                          489.\nPages tag-storage non-tag pageable:            92610.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5881344.\nTagged compressions:                          379894.\nTagged decompressions:                        311000.\n"
  },
  "scope": "functional native logit export while candidate transfer runs; no timing claim"
}
````

### frozen-ple-native-v1/build-identity.json

Original bytes: 27916; SHA-256: `3404fbd9d8974713a5742cd7ed1c0d83e25f1ab6a0b99c5f1917e7f54c2d09e8`.

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
    "Sources/Slotstream/Checkpoint.swift": "1d978203cdceea932a94e83b0967adf01e0c80bee4c70e0f818ca34cd235fe2d",
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
    "Sources/Slotstream/Layers.swift": "3d84885d4452d14845271fc6deb2d9146d1b0d00ae78ab3fbcf98528e95560c9",
    "Sources/Slotstream/MTP.swift": "973fded18e26361262bb635a3e9dbfa1b8e3f8281dfda8682904638096c8fca2",
    "Sources/Slotstream/MTPExpertStream.swift": "391b13fed457ba61a7cb4e107472a699ba87adc9a57cfd14580faa2dfbe50fd7",
    "Sources/Slotstream/Machine.swift": "34bffbaad9bd1a80f8d8aacc6b1abbbfa2d616690546a2a709363c4fb44033f6",
    "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
    "Sources/Slotstream/Model.swift": "1048ad7bcd1c9f93f5316465ed38d7bd93046fe4bfbd0fc138d972e646ee12ab",
    "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
    "Sources/Slotstream/NgramStore.swift": "f9f0cf609ac1bec2c7abb645b365fcb174dd4b5ec812b602985bacab847cdfbf",
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
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQExpert.swift": "c505139817de503604c337e08b104d7567fef80ec36522eb5ac68f6ac9206b3c",
    "Sources/Slotstream/VQKernelSources.swift": "ea98803b719f0916e7c2ba6ce53f9d85c624d72a691959cb843fb3abf50653d9",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "ac0a81ccd99ebb59a52ad0728221f34c59d2402d255b4e6a9cbb583b7d42dd6f",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+Quantization.swift": "ec074376677b6deb0e03eefc28f9269815265a82325e2fcb89df08e75bf3e619",
    "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationBench.swift": "7037fa0693746e35b91d146180e74883ccdbfabcbe54df8e970948c177f54ad1",
    "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationFixtures.swift": "9e6ac546d6373e10b3e0c6a001017f2f948a4c6a1f039db0e376b33fb64bad21",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VerifyPass.swift": "37baddc192c0f9083bef740f897d16cda315b82017349b122807bfbfcc77400e",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "7779c1339db28cce006d300d6bdd41e3e9a27c55314153aa12659c3e11d575b3",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
    "Sources/SlotstreamTestKit/AnthropicChecks.swift": "a15f7854d8f2da41184d30fac17f94f1e6e1cb68fd4236eb3c63f60e12714648",
    "Sources/SlotstreamTestKit/AnthropicTurnChecks.swift": "4d585e3ddb8692c1668d065a99c6ff1a56109f6da33328600f646bdc16f43aa5",
    "Sources/SlotstreamTestKit/Catalogue.swift": "bdfef7fffc2bbd801fc1880f9d9134783134a0e36e2424c3eb419b2767fe62a7",
    "Sources/SlotstreamTestKit/CodexFixture.swift": "23839d1d776252c1c5cec6a3acaf6c08c1e89bc7def714f7b5f3180fae57aac0",
    "Sources/SlotstreamTestKit/GatewayChecks.swift": "a9e798d056582f4d97554b9131b3f8c7220a37a314312bb3c0e590883c7c8ad4",
    "Sources/SlotstreamTestKit/LaunchChecks.swift": "8fd6f5920b219d68f0ea69295810a0a6b34effdee69ac855b04212399379e54d",
    "Sources/SlotstreamTestKit/OpenAIChecks.swift": "cb813af4c908567161db660aa8c6b78710be6a2b80a97a6e6d90e995ecd8806f",
    "Sources/SlotstreamTestKit/PersistentPrefixChecks.swift": "2a5cc8ffaf4befb90a732f350f84c34f162ad7ca67b0fb50eae3060fdeb0b0b3",
    "Sources/SlotstreamTestKit/PersistentPrefixIOChecks.swift": "c16d39aaf50f66ffa0f4f5fef02937dd141d5ba2ad7f42bcc9f387416d503f2c",
    "Sources/SlotstreamTestKit/PersistentPrefixMetadataChecks.swift": "65b5a45b3954c98517b777039373030f309e0271a6343037c6a452b4e03a82e8",
    "Sources/SlotstreamTestKit/PersistentPrefixRemovalChecks.swift": "a910392fe22933480cba14e3c604933066ba9178b670db4442e8c53b1c79a459",
    "Sources/SlotstreamTestKit/ResponsesChecks.swift": "6f692f86a68f6bbd1f62b6bdc544fdebaba1196e902b58a59313755af68be130",
    "Sources/SlotstreamTestKit/T0Checks.swift": "0cb44dca1a1023a9644bfa8413577a47d44082a10132c5bb508ec6296a98dcef",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "6f4a0be7f454693db7b8b7739bbb8215f7edd9f233628248cf2b3cd930d2fd8a",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "d5acd22c67996527b1dbd6bfa81b487cdce963411d111a0dad5cb3dbbbc6a559",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "fba9c21781ef14d9121d8cf4f1b546e2609698d30db7c4eede1f93deb43c3478",
  "binary_sha256": "405087b112d8981fde68bece9dc18b2a2f4fea2ae3f84ed92d936cdddd2d4127",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````

### ple-native-2.1-v1.json

Original bytes: 9484; SHA-256: `8d36b929d463f9dc6621421726738e7f94f351c0ba7dc917c22bac4663163692`.

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
        "name" : "fixture-0.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-1.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-2.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-3.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-5.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-5.safetensors native CPU disk PLE 1 exact BF16 bits",
        "passed" : true
      },
      {
        "name" : "fixture-5.safetensors native CPU disk PLE 6 exact BF16 bits",
        "passed" : true
      },
      {
        "name" : "fixture-5.safetensors native CPU disk PLE 512 exact BF16 bits",
        "passed" : true
      },
      {
        "name" : "fixture-5.safetensors native CPU disk PLE 8192 exact BF16 bits",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-fixtures",
    "passed" : true
  }
]
````

### ple-native-3.2-v1.json

Original bytes: 9371; SHA-256: `9b3d18e7f501f23f32ee3c0f5f9c3a5cb6650548018e7c1b5cf4afac1d750db4`.

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
        "name" : "fixture-0.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-1.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-2.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-3.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors native CPU disk PLE 1 exact BF16 bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors native CPU disk PLE 6 exact BF16 bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors native CPU disk PLE 512 exact BF16 bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors native CPU disk PLE 8192 exact BF16 bits",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-fixtures",
    "passed" : true
  }
]
````

### ple-native-4.4-v1.json

Original bytes: 9371; SHA-256: `9b3d18e7f501f23f32ee3c0f5f9c3a5cb6650548018e7c1b5cf4afac1d750db4`.

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
        "name" : "fixture-0.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-1.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-2.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-3.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors native CPU disk PLE 1 exact BF16 bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors native CPU disk PLE 6 exact BF16 bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors native CPU disk PLE 512 exact BF16 bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors native CPU disk PLE 8192 exact BF16 bits",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-fixtures",
    "passed" : true
  }
]
````
