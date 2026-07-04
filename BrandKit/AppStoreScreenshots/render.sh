#!/bin/bash
# Renders the App Store screenshot HTML templates in this folder to
# 1320x2868 PNGs (Apple's required 6.9" iPhone size) in ../../AppStore/screenshots-6.9in.
# Usage: ./render.sh
set -e
cd "$(dirname "$0")"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
OUT="../../AppStore/screenshots-6.9in"
mkdir -p "$OUT"

PAIRS="0-splash-intro:01-splash-intro 1-map-overview:02-map-overview 2-borough-coverage:03-borough-coverage 3-pin-details:04-pin-details 4-look-around:05-look-around"

for pair in $PAIRS; do
  f="${pair%%:*}"
  out_name="${pair##*:}"
  "$CHROME" --headless --disable-gpu --force-device-scale-factor=1 --hide-scrollbars \
    --window-size=1320,2868 --screenshot="$(pwd)/$OUT/$out_name.png" "file://$(pwd)/$f.html" \
    2>&1 | grep -v "task_policy_set\|allocator\|os_integration\|externally_managed" || true
  echo "rendered $out_name.png"
done
