#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
python3 Tools/check_mac_package_products.py
# Native development regressions use scripted inference and disposable Homes.
# This never starts a model or qualifies a signed/installed public release.
python3 Tools/test_prepare_slotstream_build.py
python3 Tools/prepare_slotstream_build.py --configuration release
for product in SlotstreamDesktop slotstream-home slotstream-local slotstream-composer-checks slotstream-presentation-checks slotstream-mac-checks slotstream-extract; do
  swift build --disable-build-manifest-caching --package-path apps/macos -c release --product "$product" -j "${SLOTSTREAM_BUILD_JOBS:-2}"
done
OUT=$(swift build --disable-build-manifest-caching --package-path apps/macos -c release --show-bin-path)
# Run every suite even after one fails, so a slow run reports all its failures
# at once. The script still fails if any suite did.
failed=()
suite() { "$@" || failed+=("$*"); }
suite "$OUT/slotstream-composer-checks"
suite "$OUT/slotstream-presentation-checks"
suite bash Tools/check_slotstream_scroll.sh
suite bash Tools/check_slotstream_thinking_ui.sh
suite bash Tools/check_slotstream_apps_ui.sh
suite bash Tools/check_slotstream_memory_ui.sh
suite bash Tools/check_slotstream_home_ui.sh
suite python3 Tools/check_home_integration.py --bin-dir "$OUT"
# The runtime finds the helper beside the check binary; name it explicitly.
suite env SLOTSTREAM_EXTRACT="$OUT/slotstream-extract" "$OUT/slotstream-mac-checks"
# Settings and unloading an unused engine must not initialize the GPU. Copy
# only the check executable so a developer's adjacent metallib cannot hide a
# regression that fails on a clean CI machine.
EMPTY=$(mktemp -d "${TMPDIR:-/tmp}/slotstream-settings-no-metal-XXXXXX")
trap 'rm -rf "$EMPTY"' EXIT
cp "$OUT/slotstream-mac-checks" "$EMPTY/checks"
settings_without_metal() { (cd "$EMPTY" && ./checks --performance); }
suite settings_without_metal
suite python3 Tools/prepare_slotstream_build.py --configuration release --check
if [ ${#failed[@]} -gt 0 ]; then
  printf 'FAILED SUITE: %s\n' "${failed[@]}" >&2
  exit 1
fi
