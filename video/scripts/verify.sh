#!/usr/bin/env bash
# End-to-end check: render with HyperFrames and Remotion, then edit both with FFmpeg.
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p out

probe() { ffprobe -v error -show_entries format=duration:stream=codec_name,width,height -of compact "$1"; }

echo "== FFmpeg"
ffmpeg -hide_banner -version | sed -n 1p
encoders="$(ffmpeg -hide_banner -encoders 2>/dev/null)"
for enc in libx264 libx265 libvpx-vp9 libsvtav1 prores_ks aac libopus libmp3lame; do
  grep -q " $enc " <<<"$encoders" || { echo "missing encoder: $enc" >&2; exit 1; }
done
echo "encoders OK"

echo "== HyperFrames"
(cd demo-hyperframes && npx hyperframes check && npx hyperframes render -o ../out/hyperframes.mp4 --quality draft)
probe out/hyperframes.mp4

echo "== Remotion"
npx tsc -p remotion/tsconfig.json
scripts/remotion-render.sh Intro out/remotion.mp4
probe out/remotion.mp4

echo "== FFmpeg edit (crossfade + audio)"
ffmpeg -hide_banner -loglevel error -y -i out/hyperframes.mp4 -i out/remotion.mp4 \
  -f lavfi -i "sine=frequency=440:duration=7" \
  -filter_complex "[0:v]settb=AVTB,fps=30[a0];[1:v]settb=AVTB,fps=30[b0];[a0][b0]xfade=transition=fade:duration=1:offset=3,format=yuv420p[v];[2:a]afade=t=out:st=6:d=1,volume=0.2[a]" \
  -map "[v]" -map "[a]" -c:v libx264 -crf 18 -c:a aac -movflags +faststart out/edit.mp4
probe out/edit.mp4

echo "All checks passed."
