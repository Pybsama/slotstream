---
type: run
id: 01m5vr250vvww51v66atf0yvzg
created: 2026-10-26T09:18:30.427136+00:00
updated: 2026-10-26T09:18:31.644908+00:00
summary: Q2 allocator probes, failed sensitivity controls and read-latency localization
binary: Explicitly identity-bound MLX allocator diagnostic source, restored v68 artifacts; all build identities archived
captured_at: 2026-10-26
command: Archived prepare/build/selftest/run/analyze/compare_arms scripts for all recorder revisions
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 allocator probes, failed sensitivity controls and read-latency localization
tool: Bounded MLX allocator scopes and existing read/GPU observers
---
[Raw part 1](q2-allocator-waits-2026-10-26-part01.tar.xz): 53 members, 26598952 bytes, SHA-256 `8c90d469373d18ad1e017b9a968bc362f0dc8c0b66d2a8bbba0372bcf86477e1`.

[Raw part 2](q2-allocator-waits-2026-10-26-part02.tar.xz): 13 members, 19077812 bytes, SHA-256 `9e89798f3b00328718c61271087e3fab4df869f639144b391a87d8556447733d`.

[Raw part 3](q2-allocator-waits-2026-10-26-part03.tar.xz): 10 members, 20631868 bytes, SHA-256 `ac2cb34a9c4ba0fd2c52b374c7b7d34d89340341d976c7c47bb48604aec18bb2`.

[Raw part 4](q2-allocator-waits-2026-10-26-part04.tar.xz): 21 members, 16773936 bytes, SHA-256 `12f9e6a178fcdc5a79c83947be47723c01433b9f13747329d611ad855f7adf3a`.

[Raw part 5](q2-allocator-waits-2026-10-26-part05.tar.xz): 88 members, 17966688 bytes, SHA-256 `10d6220019cbc0e69b13917017536a6cd410825cf408ee73ecad83bab1be32d4`.

[Raw part 6](q2-allocator-waits-2026-10-26-part06.tar.xz): 17 members, 23714684 bytes, SHA-256 `1a42f52e804852d98162c40c60900453c54a3e0a99f9068f3994adad0359f049`.

[Raw part 7](q2-allocator-waits-2026-10-26-part07.tar.xz): 17 members, 22152560 bytes, SHA-256 `f15d2ebdc8df41215c5028f148e8f253bfde6f09574fd665e4e1b3789a98ea69`.

[Raw part 8](q2-allocator-waits-2026-10-26-part08.tar.xz): 25 members, 22158132 bytes, SHA-256 `0a7a42fd90e1b3c6fd489391fe2b92eaccda2a0d0bf63d3a4408c47db97ddf8d`.

[Raw part 9](q2-allocator-waits-2026-10-26-part09.tar.xz): 16 members, 5593532 bytes, SHA-256 `eda4ffc6861160c82e20b2744008c4a14ae3830f71372b01fc91c538f95a7912`.

All 260 members survive across nine size-bounded shards. Every member is read back and SHA-256 checked; credential-pattern matches are zero. The first recorder failure, both later controls, exact-output results, sources, self-tests, build identities and offline analysis are preserved. Executables, libraries, model weights, duplicate source archives and active archive-driver output are excluded. Reused GPU/read observer sources remain in the earlier registered diagnostic archives.

The initial recorder's validation exits with an undifferentiated diagnostic error and is not a passing validation. Its bounded capacity is 1,048,576 rows. A revision adds explicit counters/error codes and a 4,194,304-row ceiling, recording 1,635,211 rows during the same validation workload. This establishes that the original capacity is too small for that workload; the first failure did not preserve its exact return code. The revised all-thread instrument and the subsequent owner-only instrument each match all 111 full-logit hashes, draft proposals and selected IDs under Metal validation. Their small two-thread mutex tests check parent/child intervals, unlock/relock, recording scope and drained writes.

Both fixed off/on/on/off controls preserve one warmup and one measured round per process, 15 GB physical ceilings, 4,067 cache slots, 8,192 native context and BF16/FP32 precision. Every environmental guard passes. Both fail the predeclared two-percent instrumentation-sensitivity gate. Keep every arm, including the slow first owner-only off arm; neither control qualifies representative timing attribution or a performance gain.

Offline localization uses the already-captured owner-only control without another model run. The slow off arm has the same 45,109 required cache misses as the later off arm but fewer ready forecasts, longer read service and a longer tail. Preserve sums of concurrent worker service separately from wall-time coverage and retain all warmup rows. The initial localization mistakenly inserted zeros for two absent counter fields; the initial script/result remain, and the corrected analysis requires every requested counter to exist. The actual read/GPU timing fields are unchanged.

All 509 runtime source inputs and five default artifacts match v68, and the MLX dependency checkout is restored clean with its original file modes. No production allocator, cache, scheduler, Fast or app change follows.
