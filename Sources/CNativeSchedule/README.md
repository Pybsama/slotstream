# Native MLX execution adapters

Swift owns the model, expert cache, file reads and request lifecycle. This
module adds prepared Metal sections as MLX primitives on the existing MLX
stream. It uses MLX's allocator and dependency tracking. It does not create a
second inference engine or a separate Metal command queue.

`NativeSchedule.cpp` groups expert gathering, projections and scattering.
Missing weights are gated by a reusable host-ready event. The host publishes
success only after complete reads. Cancellation publishes an aborted state
and drains submitted work before cache slots can be reused. Forecast leases
remain alive through the Metal completion callback. Forecasts can prepare
bytes but never choose cache victims.

`NativeProgram.cpp` prepares finite lists of projection dispatches. Plans own
pipelines and geometry; each invocation supplies its own weights and arrays.
Scratch and outputs remain MLX allocations with normal GPU completion
ownership. Shared pipelines and plans have separate finite capacity limits;
full-model checks must assert that no capacity or compilation fallback occurred.
Batch sizes and reduction extents are copied into bounded inline dispatch
parameters. Different widths can share a pipeline while retaining exact buffer
shapes and arithmetic tile choices. Parameters belong to the immutable plan,
so their original host array may be released before GPU evaluation.

Reuse applies to immutable dispatch descriptions, not pre-encoded command
buffers. Splash also encodes fresh Metal commands each cycle. Eligible
routed work is submitted before the host constructs the following resident
block. Slot pins and event leases are retired only when the actual readers
have completed; the final drain remains part of cancellation and cleanup.

Narrow recurrent passes fold the retained speculative tape into their next
state update. Full-state checkpoint, persistence and fallback callers still
receive materialized state. Prepared residual combination owns a fresh output
so it cannot mutate a retained checkpoint, and preserves separate multiply
and add rounding.

`AdaptiveReplacement.cpp` adapts the unmodified Splash cache recycler to
Slotstream's physical slots and pins. Logical expert order is part of the
adapter contract. A failed read invalidates speculative metadata, and cache
resize or sweep admission reconstructs it from actual resident bytes.

mlx-swift exports its C API but not the C++ custom-primitive headers. This
bridge follows the pinned `mlx-c` array and stream context adapters. The
unmodified MLX and metal-cpp headers under `vendor/` match the exact
mlx-swift revision pinned in `Package.swift`. `vendor-manifest.json` records
their hashes and the C context adapters this bridge depends on.
`Tools/native_schedule_headers_gate.py` refuses a dependency or header change
without explicit requalification. Do not regenerate the manifest merely to
silence a mismatch.

The independent kernel, event, failed-read, pool-layout and cache-order checks
are wired through the CLI's `q2-format-check` and `q2-experts-check` commands.
Real-model and app tests additionally inspect executed-path counters, process
memory, cancellation, model switching and complete-request quality. A passing
component check alone does not qualify a performance default.

Splash attribution is in `Licenses/splash-NOTICE.txt`; its recycler sources
retain Apache-2.0 terms. MLX retains its MIT license and metal-cpp its Apache-2.0 license in the
repository's `Licenses/` directory.
