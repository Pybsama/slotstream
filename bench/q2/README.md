# Native Q2 component reference fixtures

`formats.json` contains bounded blocks from the pinned GSQ-RCO target, decoded
independently with gguf 0.17.1. Q2_0, which that release does not implement,
uses NumPy FP16 scales and the published `scale * (code - 1)` formula. Inputs
and dot products are independent CPU references. Run:

```
.build/release/slotstream q2-format-check --fixtures bench/q2/formats.json --policy-fixtures bench/q2/verify-budget.json --mix-fixtures bench/q2/mix-quantization.json
.build/release/slotstream q2-experts-check
```

The command also checks routed batches and rejects corrupted, truncated,
mutated, symbolic-link and cancelled GGUF inputs with tiny synthetic files.

`verify-budget.json` was produced by Splash's `VerifyBudget.cpp` at
1482f6bbc2abf12375332725302019594150b6cb, with single-lane confidence selection.
It exercises anchor-only verification, exploration and online refitting. This
controller alone chooses Q2's verification length, so another policy cannot
permanently truncate its exploration. Unverified proposals are never training
labels. Upstream observations use NaN
for these unverified positions to make the reference contract match.

`mix-quantization.json` uses a separate C++ reference for upstream Q8_0
preparation of BF16 and F16 mixing matrices. It includes zeros, signed ties and
different magnitudes. The check requires exact output bytes and separately
refuses nonfinite values and scale overflow. macOS 26.1 also checks lossless
resident planes against the decoded-weight oracle across partial and complete
tiles, BF16 hidden outputs and FP32 vocabulary outputs. The expert check covers
every code/scale byte, CPU/GPU layout equality, duplicate routes and inverse
permutation. Older OS versions retain the raw path.

The expert command also checks the native floating-point projections against
CPU FP64 dots, deterministic routing ties, single-round mixtures, the fused
hyper-connection and PLE arithmetic, attention normalization/rotary rounding,
and recurrent state recovery at every recorded position. Multirow checks
compare the same rows with their one-token executions. These preserve the
arithmetic contract while reducing dispatches and temporary state storage.

Do not infer deployment parity from the checkpoint filename. The maintained
recipe includes floating-point weight preparation, activation precision,
target verification, recurrent rollback, cache layout and scheduling. Match
actual expert slots and KV precision as well as requested memory. Keep process
footprint, continuous-session behavior and global paging separate. The
[execution comparison](../../db/records/measurements/native-q2-splash-execution-comparison.md)
preserves the successful changes, rejected experiments and remaining gap.

These are component checks, not whole-model quality or speed qualification.
The source generators and complete native-run evidence belong in the linked
engineering measurement's immutable archive.
