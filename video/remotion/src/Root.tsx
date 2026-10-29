import { Composition } from "remotion";
import { Intro } from "./Intro";

export const RemotionRoot: React.FC = () => (
  <Composition
    id="Intro"
    component={Intro}
    durationInFrames={120}
    fps={30}
    width={1920}
    height={1080}
    defaultProps={{ title: "Jamie's Meal Planner" }}
  />
);
