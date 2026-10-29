#!/usr/bin/env bash
# Render a Remotion composition. Reuses HyperFrames' Chrome so Remotion does not
# need to download its own (its download host may be blocked in sandboxes).
set -euo pipefail
cd "$(dirname "$0")/.."
comp="${1:-Intro}"
out="${2:-remotion/out/${comp}.mp4}"
shift $(( $# > 2 ? 2 : $# ))
args=()
chrome="$(scripts/chrome-path.sh)"
[ -n "$chrome" ] && args+=(--browser-executable="$chrome")
npx remotion render remotion/src/index.ts "$comp" "$out" "${args[@]}" "$@"
