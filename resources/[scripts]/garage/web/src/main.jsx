import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import { ThemeProvider } from "styled-components";
import { theme } from "./styles.js";
import { GarageProvider } from "./contexts/GarageContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <GarageProvider>
    <ThemeProvider theme={theme}>
      <App />
    </ThemeProvider>
  </GarageProvider>
);
