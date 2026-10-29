#!/usr/bin/env bash
# Install everything needed to build videos with HyperFrames, Remotion and FFmpeg.
set -euo pipefail
cd "$(dirname "$0")/.."

if ! command -v ffmpeg >/dev/null || ! command -v ffprobe >/dev/null; then
  echo "Installing FFmpeg..."
  if command -v apt-get >/dev/null; then
    sudo apt-get update && sudo apt-get install -y ffmpeg
  elif command -v brew >/dev/null; then
    brew install ffmpeg
  else
    echo "Install FFmpeg manually: https://ffmpeg.org/download.html" >&2
    exit 1
  fi
fi

npm ci
# Chrome Headless Shell used by HyperFrames (and by Remotion, see scripts/chrome-path.sh).
npx hyperframes browser ensure
