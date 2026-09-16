#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
# Native development regressions use scripted inference and disposable Homes.
# This never starts a model or qualifies a signed/installed public release.
for product in Sevra sevra-local sevra-composer-checks sevra-presentation-checks sevra-mac-checks; do
  swift build --package-path apps/macos -c release --product "$product" -j 2
done
OUT=$(swift build --package-path apps/macos -c release --show-bin-path)
"$OUT/sevra-composer-checks"
"$OUT/sevra-presentation-checks"
bash Tools/check_sevra_scroll.sh
"$OUT/sevra-mac-checks"
