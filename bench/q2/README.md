# Native Q2 component reference fixtures

`formats.json` contains bounded blocks from the pinned GSQ-RCO target, decoded
independently with gguf 0.17.1. Q2_0, which that release does not implement,
uses NumPy FP16 scales and the published `scale * (code - 1)` formula. Inputs
and dot products are independent CPU references. Run:

```
.build/release/slotstream q2-format-check --fixtures bench/q2/formats.json --policy-fixtures bench/q2/verify-budget.json --policy-fixtures bench/q2/verify-budget-complete.json --mix-fixtures bench/q2/mix-quantization.json
.build/release/slotstream q2-experts-check
```

The command also checks routed batches and rejects corrupted, truncated,
mutated, symbolic-link and cancelled GGUF inputs with tiny synthetic files.

`verify-budget.json` preserves the original truncated-observation fixture from
Splash's `VerifyBudget.cpp` at
1482f6bbc2abf12375332725302019594150b6cb. Its driver forced at least one draft
and replaced later confidences with NaN. It checks that narrower API and
online refitting, but does not test anchor-only selection or the runtime's
complete observations.

`verify-budget-complete.json` adds an independent driver around the same
unmodified upstream implementation. It retains all confidences, permits
anchor-only passes, and checks selected depths and retained label counts
through exploration, refitting and replacement of the bounded label history.
`Tools/reference/q2_verify_budget.cpp` is the driver; the measurement archive
preserves the upstream sources and build command.

A target pass also evaluates the final bonus prediction. Comparing it with
the corresponding draft guess supplies a label without consuming additional
model state or accepting an unverified output token. Production checks also
verify calibration reuse between requests and reset at the embedding owner's
privacy boundary. Kernel and policy fixtures alone cannot prove that wiring.

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
