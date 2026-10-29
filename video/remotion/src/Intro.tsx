import { AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig } from "remotion";

export const Intro: React.FC<{ title: string }> = ({ title }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const enter = spring({ frame: frame - 6, fps, config: { damping: 200 } });
  const scale = interpolate(frame, [0, 120], [1, 1.06]);

  return (
    <AbsoluteFill
      style={{
        backgroundColor: "#14301f",
        color: "#f6efe2",
        justifyContent: "center",
        alignItems: "center",
        fontFamily: "sans-serif",
      }}
    >
      <h1
        style={{
          fontSize: 72,
          fontWeight: 600,
          letterSpacing: "-0.03em",
          opacity: enter,
          transform: `translateY(${(1 - enter) * 40}px) scale(${scale})`,
        }}
      >
        {title}
      </h1>
    </AbsoluteFill>
  );
};
