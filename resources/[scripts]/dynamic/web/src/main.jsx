import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import { ThemeProvider } from "styled-components";
import { theme } from "./styles.js";
import { DynamicProvider } from "./contexts/DynamicContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <DynamicProvider>
      <ThemeProvider theme={theme}>
        <App />
      </ThemeProvider>
    </DynamicProvider>
  </React.StrictMode>
);
