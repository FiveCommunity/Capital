import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import { PainelProvider } from "./contexts/PainelContext.jsx";
import { DetailsProvider } from "./contexts/DetailsContext.jsx";
import { FilterProvider } from "./contexts/FilterContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <PainelProvider>
    <DetailsProvider>
      <FilterProvider>
        <App />
      </FilterProvider>
    </DetailsProvider>
  </PainelProvider>
);
