# Video toolchain

HyperFrames (HTML + GSAP → video), Remotion (React → video) and FFmpeg (editing/encoding).

```bash
cd video
npm run setup     # FFmpeg (if missing), npm deps, Chrome Headless Shell
npm run verify    # renders both demos, then crossfades them with audio via FFmpeg → out/
```

| Task | Command |
| --- | --- |
| Preview HyperFrames | `npm run hf:preview` |
| Render HyperFrames | `npm run hf:render` |
| Remotion Studio | `npm run remotion:studio` |
| Render Remotion | `npm run remotion:render -- Intro out/intro.mp4` |

- `demo-hyperframes/` — HyperFrames project (`index.html`). GSAP is vendored in `assets/`
  because headless Chrome can't always reach CDNs.
- `remotion/src/` — Remotion compositions (`Root.tsx` registers them).
- `scripts/remotion-render.sh` reuses HyperFrames' Chrome so Remotion doesn't need its own download.

Optional extras reported by `npx hyperframes doctor` (not installed): whisper-cpp
(transcription), Kokoro (local TTS: `pip install kokoro-onnx soundfile`),
MusicGen (local music).
