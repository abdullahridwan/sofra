#!/bin/bash
# Renders the Instagram post HTML templates in this folder to
# 1080x1080 PNGs in ../../Instagram/feed-1080.
# Usage: ./render.sh
set -e
cd "$(dirname "$0")"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
OUT="../../Instagram/feed-1080"
mkdir -p "$OUT"

PAIRS="0-cover:01-carousel-cover 1-map:02-carousel-map 2-borough:03-carousel-borough 3-pin:04-carousel-pin 4-lookaround:05-carousel-lookaround stat-post:06-coverage-stat spot-of-week:07-spot-of-week-namkeen"

for pair in $PAIRS; do
  f="${pair%%:*}"
  out_name="${pair##*:}"
  "$CHROME" --headless --disable-gpu --force-device-scale-factor=1 --hide-scrollbars \
    --window-size=1080,1080 --screenshot="$(pwd)/$OUT/$out_name.png" "file://$(pwd)/$f.html" \
    2>&1 | grep -v "task_policy_set\|allocator\|os_integration\|externally_managed" || true
  echo "rendered $out_name.png"
done
