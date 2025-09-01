import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";

import { ThemeProvider } from "styled-components";
import { theme } from "./styles.js";

import { CreationProvider } from "./contexts/CreationContext.jsx";
import { CharacterProvider } from "./contexts/CharacterContext.jsx";
import { SelectionProvider } from "./contexts/SelectionContext.jsx";
import { SpawnProvider } from "./contexts/SpawnContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <SelectionProvider>
      <CreationProvider>
        <SpawnProvider>
          <CharacterProvider>
            <ThemeProvider theme={theme}>
              <App />
            </ThemeProvider>
          </CharacterProvider>
        </SpawnProvider>
      </CreationProvider>
    </SelectionProvider>
  </React.StrictMode>
);
