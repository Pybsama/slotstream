---
type: run
id: 01m5jhh35kb4w92zxf6hpbaaxb
created: 2026-10-22T19:31:10.130892+00:00
updated: 2026-10-22T19:31:11.306086+00:00
summary: Full static suite and catalogue pass on frozen native Q2 v17; initial static fixture failure preserved
binary: f6c979e088384622291bd9b3c277b2d9f4ba014bbebf1caa85e12bfb984808e3
captured_at: 2026-10-22
command: Commands and complete stdout in the immutable validation archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Native Q2 v17 validation receipts
tool: Native static suite, catalogue, source identity and brain gates
---
# Native Q2 v17 validation receipts

The immutable [validation archive](native-q2-execution-validation-2026-10-22.tar.gz) has SHA-256 `d3dcfb789e6c48f381b9354b5bd275937c5906306889e77e2326ff09512d996e`. All 12 payloads were read back against their manifest. It supplements [[sources/runs/2026/10/2026-10-22-native-q2-execution]].

The full static suite exits zero with `STATIC GATES PASS` against the frozen v17 binary. The first attempt caught outdated static-entry test expectations after adding the mix-quantization fixture and expert checks. The corrected expectations and a new fail-closed expert-check case pass; both attempts are preserved. The engine catalogue separately passes all 89 T0 and 18 T1 checks. The brain gates pass with zero errors and warnings and current projections and claims.

The receipt verifies that all compiled CLI and app source inputs still matched their build identities at the time of this validation, and the MLX dependency checkout was clean. Subsequent experimental source changes require separate qualification or restoration to these hashes. No release or performance parity is claimed.
