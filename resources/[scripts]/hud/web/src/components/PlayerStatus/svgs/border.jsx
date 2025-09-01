export function Border({ color }) {
  return (
    <svg
      class="triangle-border"
      width="42"
      height="48"
      viewBox="0 0 42 48"
      fill="none"
    >
      <path
        d="M2.39135 26.682C0.507467 25.584 0.507467 22.8623 2.39135 21.7643L37.2913 1.42344C39.1886 0.317621 41.5704 1.68625 41.5704 3.88232L41.5704 44.564C41.5704 46.76 39.1886 48.1287 37.2913 47.0229L2.39135 26.682Z"
        stroke={color}
        stroke-width="0.854323"
      />
    </svg>
  );
}
