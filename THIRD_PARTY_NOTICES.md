# Third-party notices

`Sources/Slotstream/VQKernelSources.swift` contains Metal kernel strings from
[VQLab](https://github.com/noahzelezny/VQLab), by Noah Zelezny and contributors,
under the [Apache License 2.0](Licenses/VQLab-Apache-2.0.txt).

The strings were extracted from the pinned Flash Next VQ runtime whose digest
is recorded in `Tools/vq_kernel_sources.py`. Their bytes also match
`src/vqlab/runtime/vq_switch.py` at VQLab commit
`97b4380c60f5faf55bdc777102d042468c4644ca`. The modification is packaging those
constants in Swift; runtime wrappers and bounded diagnostics are Slotstream
code. No upstream Python is executed by the native runtime.

This code license does not license the separately distributed model weights.
Each model artifact retains its own license and provenance requirements.

`Sources/Slotstream/DFlashDraft.swift` implements the DFlash 2 draft network
in native Swift/MLX, following [Z Lab DFlash](https://github.com/z-lab/dflash)
(`model_mlx.py` at commit `07ebd93db9f472af339b644bb70221ad8428328a`). Its grouped dynamic
convolution and candidate selection are adapted under the
[MIT license](Licenses/DFlash-MIT.txt), Copyright 2026 Z Lab.
The bounded context, target verification and app integration are Slotstream code.
The separately downloaded Fast draft includes its own Apache 2.0 license.
The pinned Smart draft declares Apache 2.0 in its
[model card](https://huggingface.co/incoai/Qwen3.8-Flash-Next-DFlash2/tree/a22a1744e85c17364dcc54a6a420af7135d4c7f6);
that revision has no separate LICENSE file. Both retain their original model
cards and pinned provenance alongside the downloaded weights.

The target architecture was checked against Apple's
[mlx-swift-lm](https://github.com/ml-explore/mlx-swift-lm) Qwen35 and Qwen35MoE
implementations at `bb0d5b048f02e14dbf8f2d7bb1a20911a295470a`.
[Splash](https://github.com/incoai/splash) at
`1482f6bbc2abf12375332725302019594150b6cb` was also reviewed as an
implementation reference. Slotstream does not run Splash or its host-step
GPU scheduling mechanism.

The native GSQ-RCO Q2 checkpoint decoder and single-request DFlash verification
budget adapt Splash's GGUF format readers and `VerifyBudget` at the revision
above, under [Apache-2.0](Licenses/splash-Apache-2.0.txt). The original notices
and a description of the adaptations are retained in
[the Splash notice](Licenses/splash-NOTICE.txt). Exact packed model bytes remain
separately downloaded artifacts; this source license is not their license.
