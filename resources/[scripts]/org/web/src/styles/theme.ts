export const theme = {
  fontFamily: "'Montserrat', sans-serif",
  colors: {
    primary: "rgba(3, 187, 232)",
    primary_opacity: (opacity: number = 1) => `rgba(3, 187, 232, ${opacity})`,
    secondary: "#111",
    dark: (opacity: number = 1) => `rgba(0, 0, 0, ${opacity})`,
    tablet: {},
  },
};
