
export function NotifyContainerLeft() {
  return (
    <svg
      style={{
        width: 0,
        height: 0,
        position: "absolute",
      }}
    >
      <clipPath id="notifyleft" clipPathUnits="objectBoundingBox">
        <path d="M0.999,0.075 C1,0.042,0.997,0.005,0.988,0.005 H0.013 C0.006,0.005,0.001,0.027,0.001,0.054 V0.955 C0.001,0.982,0.006,1,0.013,1 H0.56 H0.784 H0.887 C0.892,1,0.897,0.993,0.899,0.975 L0.999,0.075" />
      </clipPath>
    </svg>
  );
}
