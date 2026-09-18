#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
# Native development regressions use scripted inference and disposable Homes.
# This never starts a model or qualifies a signed/installed public release.
for product in Sevra sevra-local sevra-composer-checks sevra-presentation-checks sevra-mac-checks sevra-extract; do
  swift build --package-path apps/macos -c release --product "$product" -j 2
done
OUT=$(swift build --package-path apps/macos -c release --show-bin-path)
"$OUT/sevra-composer-checks"
"$OUT/sevra-presentation-checks"
bash Tools/check_sevra_scroll.sh
bash Tools/check_sevra_thinking_ui.sh
bash Tools/check_sevra_apps_ui.sh
# The runtime finds the helper beside the check binary; name it explicitly.
SEVRA_EXTRACT="$OUT/sevra-extract" "$OUT/sevra-mac-checks"
