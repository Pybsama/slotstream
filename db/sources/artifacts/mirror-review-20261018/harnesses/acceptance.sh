#!/bin/bash
set -euo pipefail
ROOT=/Volumes/external/slotstream
OUT=/Volumes/external/review-evidence
export PATH=/Volumes/external/dbmd/bin:/Volumes/external/toolchains/swift-6.3/swift-6.3-RELEASE-osx-package.pkg/Payload/usr/bin:/opt/homebrew/bin:$PATH
export SDKROOT=$(xcrun --show-sdk-path)
export TMPDIR="$OUT/tmp"
export PYTHON=/opt/homebrew/Cellar/omlx/0.7.0rc1/libexec/bin/python3.11
export SLOTSTREAM_REFERENCE_PYTHON="$PYTHON"
export SLOTSTREAM_TEST_BINARY="$ROOT/.build/release/slotstream"
export SLOTSTREAM_BUILD_JOBS=2
export SLOTSTREAM_VERIFY_OUT="$OUT/full-acceptance"
exec > "$OUT/acceptance-controller.log" 2>&1
trap 'code=$?; echo "$code" > "$OUT/acceptance-controller.exit"' EXIT
cd "$ROOT"
for n in $(seq 1 450); do if [ -f "$OUT/build.exit" ]; then break; fi; sleep 2; done
test "$(cat "$OUT/build.exit")" = 0
git diff HEAD -- Tools/checkpoint_mirror_cli.py Tools/static_gates_binary_test.py > "$OUT/transferred-test-script.diff"
git restore --worktree -- Tools/checkpoint_mirror_cli.py Tools/static_gates_binary_test.py
git fetch /Volumes/external/slotstream-pr57-final-source-20261018.bundle mirror-reads-core
git checkout --detach FETCH_HEAD
test "$(git rev-parse HEAD)" = bccd78e0a1100247f14091cc0ae59ba4f306175f
git rev-parse HEAD > "$OUT/validated-commit.txt"
make build > "$OUT/final-rebuild.log" 2>&1
cp .build/release/build-identity.json "$OUT/final-build-identity.json"
shasum -a 256 .build/release/slotstream .build/release/slotstream-checks .build/release/mlx.metallib > "$OUT/final-build-sha256.txt"
.build/release/slotstream-checks --tier t0 --tier t1 > "$OUT/final-catalogue.log" 2>&1
python3 Tools/checkpoint_mirror_cli.py --binary .build/release/slotstream > "$OUT/final-mirror-cli.log" 2>&1
python3 - <<'PY'
import hashlib,json,sys
from pathlib import Path
sys.path.insert(0,'Tools')
from build_identity import source_files,sha
from serve_bench import verified_build
result=verified_build('.build/release/slotstream')
root=Path.cwd()
actual={str(p.relative_to(root)):sha(p) for p in source_files(root)}
assert actual==result['identity']['source'], 'final source differs from compiled source'
print('FINAL_COMPILED_SOURCE_IDENTITY_PASS',len(actual))
PY
if [ ! -e .venv31 ]; then ln -s /Volumes/external/slotstream-pr24-followup/.venv31 .venv31; printf '\n/.venv31\n' >> .git/info/exclude; fi
run_gate() {
 local name=$1
 shift
 echo "START $name $(date -u)"
 set +e
 "$@" > "$OUT/$name.log" 2>&1
 local code=$?
 set -e
 echo "$code" > "$OUT/$name.exit"
 tail -n 7 "$OUT/$name.log"
 echo "END $name exit=$code $(date -u)"
 return "$code"
}
DBMD_INSTALL_DIR="$OUT/tools/bin" bash Tools/dbmd_install.sh > "$OUT/dbmd-install.log" 2>&1
export PATH="$OUT/tools/bin:$PATH"
dbmd() { /Volumes/external/review-evidence/tools/bin/dbmd "$@"; }
export -f dbmd
run_gate router-regression python3 /Volumes/external/slotstream-pr57-router-regression.py
run_gate static bash Tools/static_gates.sh
run_gate sampler bash Tools/sampler_gates.sh
run_gate mirror-runtime python3 /Volumes/external/slotstream-pr57-runtime.py
run_gate full-acceptance bash Tools/verify.sh
run_gate benchmark python3 /Volumes/external/slotstream-pr57-benchmark.py
run_gate benchmark-audit python3 /Volumes/external/slotstream-pr57-benchmark-audit.py "$OUT/benchmark"
run_gate consumer bash Tools/consumer_smoke.sh
run_gate coverage bash Tools/coverage.sh t0 t1 --lcov "$OUT/coverage.info"
run_gate coverage-ratchet python3 Tools/coverage_ratchet.py "$OUT/coverage.info"
git status --short > "$OUT/final-worktree.txt"
shasum -a 256 .build/release/slotstream > "$OUT/final-binary-sha256.txt"
echo FINAL_ACCEPTANCE_AND_BENCHMARK_PASS
