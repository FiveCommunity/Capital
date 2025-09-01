export function NotifyContainer() {
  return (
    <svg
      style={{
        width: 0,
        height: 0,
        position: "absolute",
      }}
    >
      <clipPath id="notify" clipPathUnits="objectBoundingBox">
        <path d="M0.002,0.07 C-0.002,0.037,0.004,0,0.013,0 H0.988 C0.995,0,1,0.022,1,0.05 V0.95 C1,0.978,0.995,1,0.988,1 H0.441 H0.217 H0.114 C0.109,1,0.104,0.988,0.102,0.97 L0.002,0.07" />
      </clipPath>
    </svg>
  );
}
