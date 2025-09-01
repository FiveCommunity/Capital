import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import { ThemeProvider } from "styled-components";
import { theme } from "./styles.js";
import { ProductionProvider } from "./contexts/ProductionContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <ThemeProvider theme={theme}>
    <ProductionProvider>
      <App />
    </ProductionProvider>
  </ThemeProvider>
);
