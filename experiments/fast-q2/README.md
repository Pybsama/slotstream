# Fast and Q2 experiments

Archived on October 26, 2026. Slotstream now maintains one model:
**Qwen3.8-Flash-Next 4-bit**. Maintaining a separate Fast tier and compressed
candidate added more runtime, setup and qualification work than we want to carry.
This is a scope decision, not a claim that every experiment failed.

The native Mac app was also [archived](../mac-app/README.md) later the same day.
Current maintenance covers the engine, CLI, serving APIs and Swift library.

## Preserved source

The complete implementation, tests, fixtures, dependencies and license notices
are preserved at commit
[`df208489af2ef5378444727172b6dfcf8ee1ed10`](https://github.com/carloslfu/slotstream/tree/df208489af2ef5378444727172b6dfcf8ee1ed10),
also named by the Git tag `archive-fast-q2-2026-10-26`. This is an archive tag,
not a product release. The source remains in Git history; it is not compiled
or maintained as a second runtime on `main`.

To inspect it in a separate checkout:

```sh
git worktree add --detach ../slotstream-fast-q2-experiment df208489af2ef5378444727172b6dfcf8ee1ed10
```

The archived tree includes:

- Fast: Qwen3.6-35B-A3B 4-bit, its DFlash 2 integration, setup and app switching.
- The exact Qwen3.8-Flash-Next GSQ-RCO Q2 target, packed kernels and bounded streaming.
- Smart DFlash comparisons on the original target.
- Prepared Metal execution, native cache replacement, read-ahead and compiler experiments.
- The matching CLI diagnostics, app checks, reference fixtures and third-party notices.

No downloaded model or Home files are removed by this archival change. Old
experimental binaries remain experimental; inspecting or building that tree
does not make them supported. Follow its memory and single-process safeguards
if reproducing a run.

## Evidence and lessons

The public engineering records and raw captures remain at their original paths.
Their dates and build identities matter: they describe those experiments,
not the current runtime or a new release.

- [Fast integration and app checks](../../db/records/decisions/fast-and-smart.md)
- [Draft acceleration and target quantization](../../db/records/decisions/smart-dflash-and-target-quantization.md)
- [Exact Q2 qualification](../../db/records/measurements/native-exact-q2-qualification.md)
- [Fast comparison with Splash](../../db/records/measurements/fast-splash-execution-comparison.md)
- [Q2 comparison with Splash](../../db/records/measurements/native-q2-splash-execution-comparison.md)
- [Native kernels](../../db/records/measurements/native-fast-q2-execution-kernels.md), [read scheduling](../../db/records/measurements/native-fast-q2-scheduling.md), [prepared execution](../../db/records/measurements/native-prepared-execution.md)
- [Compiler investigation](../../db/records/measurements/q2-compiler-identity-and-precompiled-shaders.md)

Keep the useful lessons: compare complete tasks, include startup and cold
compilation, match actual cache capacity, preserve quality failures, and test
through the app's tools and review controls. Smaller weights, passing kernels
and an upstream throughput number do not establish a better user experience.

[Current maintenance decision](../../db/records/decisions/one-maintained-model.md).
