---
type: reference
id: 01m40yaspx1s603rqzqjhbfc14
created: 2026-10-03T13:12:53.725685+00:00
updated: 2026-10-03T13:13:57.389690+00:00
summary: Pinned vLLM draft input normalization uses full hidden-stream width
captured_at: 2026-10-03
title: Qwen4Exp draft hidden-input normalization source pin
url: https://github.com/vllm-project/vllm/blob/e3cae8d2ac6be8dfd319f3bb8061a1ba4d19bf52/vllm/models/qwen4_exp/nvidia/mtp.py
---
The [official vLLM implementation](https://github.com/vllm-project/vllm/blob/e3cae8d2ac6be8dfd319f3bb8061a1ba4d19bf52/vllm/models/qwen4_exp/nvidia/mtp.py#L227) constructs the draft's hidden-input RMS normalization across all hidden streams. Forward flattens the stream and channel dimensions before that normalization and reshapes afterward. This supports Slotstream's existing full-width statistic; it differs from the inspected VQLab loader's per-stream statistic. No external code was executed.

Pinned file: `vllm/models/qwen4_exp/nvidia/mtp.py` at revision `e3cae8d2ac6be8dfd319f3bb8061a1ba4d19bf52`, source commit dated October 2, 2026. Retrieved October 3. File size: 17,682 bytes. SHA-256: `7a425801657c071f3cfa3930f952fccc8ab58a88bf4d7f68335fe6d46aae6437`. The local research copy is bound by this hash.

This is architecture evidence. It does not qualify the q6 sidecar, settle normalization multiplication dtype, prove numerical parity or measure draft acceptance. Keep the existing native draft arithmetic. A new sidecar reference must independently replay the exact representation and arithmetic before integration.
