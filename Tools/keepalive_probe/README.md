# GPU keepalive diagnostic

Run from a checkout on a Mac with Command Line Tools installed:

```sh
bash Tools/keepalive_probe/run.sh > keepalive-probe.jsonl
```

This loads no model. It compiles the checkout's actual `GPUKeepAlive.swift`
with a small Metal workload. Run it without other GPU benchmarks. It exits
after the probes finish; keepalive does not remain running. No elevated
permissions or changes to system settings are needed.

The output records the GPU, macOS, thermal policy state, correctness checks,
GPU timestamps and CPU wait duration. `work` rows compare the actual
production keepalive on and off in alternating order. `bounded_spin` rows
measure the polling kernel itself. `scheduling` rows use a separate,
bounded copy of that kernel with different iteration counts and queue depths.

In `independent` mode, the work and polling buffers have no resource
dependency. In `dependency` mode, a shared event deliberately forces the work
to wait for polling to finish. The latter is a positive control demonstrating
the cost of serialization. It is **not** a reproduction of an independent
queue becoming blocked on a particular GPU.

Command-buffer GPU intervals can include internal waits; they are not
individual kernel instruction timelines. `exact` compares the entire result
buffer against a baseline. Every bounded command buffer must complete
successfully. The production class exposes submission counts, so its own
buffer completion status is not inspected by this probe.

This is a diagnostic, not a device qualification or an end-to-end inference
benchmark. A fast synthetic work row does not prove that every MLX kernel
can overlap. The polling counts are experimental controls, not new defaults.
See issue [#55](https://github.com/carloslfu/slotstream/issues/55).
