# Native Q2 component reference fixtures

`formats.json` contains bounded blocks from the pinned GSQ-RCO target, decoded
independently with gguf 0.17.1. Q2_0, which that release does not implement,
uses NumPy FP16 scales and the published `scale * (code - 1)` formula. Inputs
and dot products are independent CPU references. Run:

```
.build/release/slotstream q2-format-check --fixtures bench/q2/formats.json --policy-fixtures bench/q2/verify-budget.json
```

The command also checks routed batches and rejects corrupted, truncated,
mutated, symbolic-link and cancelled GGUF inputs with tiny synthetic files.

`verify-budget.json` was produced by Splash's `VerifyBudget.cpp` at
1482f6bbc2abf12375332725302019594150b6cb, with single-lane confidence selection.
It exercises exploration and online refitting. The native adaptation retains
one proposal until the existing whole-cycle policy can decide to stop drafting;
unverified proposals are never training labels. Upstream observations use NaN
for these unverified positions to make the reference contract match.

These are component checks, not whole-model quality or speed qualification.
The source generators and complete native-run evidence belong in the linked
engineering measurement's immutable archive.
