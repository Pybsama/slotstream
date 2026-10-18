---
type: run
id: 01m572bxzpy0wfxt58qfpkxbq2
created: 2026-10-18T08:34:33.590870412+00:00
updated: 2026-10-18T10:19:17.805222175+00:00
summary: Final integrated mirror review acceptance and three-arm performance capture
binary: slotstream source bccd78e0a1100247f14091cc0ae59ba4f306175f; SHA-256 04090257eb4a009790f867ed02c919a3cbd2fff026f87cd759c05105ede77567
captured_at: 2026-10-18
command: bash /Volumes/external/slotstream-pr57-acceptance.sh
discarded: 'false'
machines: '[[records/machines/mac-mini-m4-32gb-mirror-review]]'
title: Final integrated mirror review acceptance and three-arm performance capture
tool: Tools/verify.sh and frozen mirror-review harnesses
---
The complete capture is preserved on the fork's
[pr57-validation-evidence-20261018 branch](https://github.com/spikezz/slotstream/tree/pr57-validation-evidence-20261018).
The immutable links below retain the exact output without adding the raw
archive to the implementation PR's file diff.

- [Protocol, commands, all runs and summary](https://github.com/spikezz/slotstream/tree/9df0b1ad04669e7ceda2a2f75a0c237fe83fb9bd/db/sources/artifacts/mirror-review-20261018/benchmark)
- [Source and executable identities, manifests, raw acceptance logs](https://github.com/spikezz/slotstream/tree/9df0b1ad04669e7ceda2a2f75a0c237fe83fb9bd/db/sources/artifacts/mirror-review-20261018)
- [Independent benchmark audit](https://github.com/spikezz/slotstream/blob/9df0b1ad04669e7ceda2a2f75a0c237fe83fb9bd/db/sources/artifacts/mirror-review-20261018/benchmark/independent-audit.json)
- [Controller transcript](https://github.com/spikezz/slotstream/blob/9df0b1ad04669e7ceda2a2f75a0c237fe83fb9bd/db/sources/artifacts/mirror-review-20261018/acceptance-controller.log)
- [CLI fixture diagnosis and follow-up receipts](https://github.com/spikezz/slotstream/tree/536f064b8c3c60ef8e42c9af172eb076de9d60af/db/sources/artifacts/mirror-review-ci-fixture-20261018)

The capture relabels local filesystem paths; its manifests retain original
and published digests. Model payloads, tensor binaries and executables are
excluded. All 299 compiled-source inputs remain identical in the later test
harness/documentation commits.

Exact build hashes from `final-build-sha256.txt`:

```text
04090257eb4a009790f867ed02c919a3cbd2fff026f87cd759c05105ede77567  .build/release/slotstream
b68c3042760c335d48554a579c1f8776f1e9e1d39ee89cf1383dd631531a56ea  .build/release/slotstream-checks
2d2e729831a995a39778164c93ea1b2e8d87f7d8b1e717386d3d816f46f416b2  .build/release/mlx.metallib
```

Exact independent-audit output:

```json
{
  "passed": true,
  "runs": 84,
  "measured_runs": 72,
  "measured_triplets": 24,
  "warmups": 12,
  "process_peak_bytes": 8092080440,
  "source_commit": "bccd78e0a1100247f14091cc0ae59ba4f306175f",
  "binary_sha256": "04090257eb4a009790f867ed02c919a3cbd2fff026f87cd759c05105ede77567",
  "all_run_swap_unchanged": true
}
```
