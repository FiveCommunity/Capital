import useRequest from "./hooks/useRequest";
import { ThemeProvider } from "styled-components";
import { useCallback, useContext, useEffect } from "react";
import * as GS from "./styles";
import Painel from "./components/Painel";
import PainelContext from "./contexts/PainelContext";
import DetailsContext from "./contexts/DetailsContext";
import FilterContext from "./contexts/FilterContext";

function App() {
  const { painel, setPainel } = useContext(PainelContext);
  const { setFilter } = useContext(FilterContext);
  const { setDetails } = useContext(DetailsContext);
  const { request } = useRequest();

  const nuiMessage = useCallback(
    (event) => {
      const {
        action,
        pendingServicesAmount,
        services,
        currentService,
        prices,
        servicesAmount,
        currentPage,
        filter,
      } = event.data;
      if (action === "open") {
        setPainel({
          open: true,
          pendingServicesAmount,
          services,
          currentService,
          prices,
          servicesAmount,
          filter,
        });
        setFilter(filter);
      }
    },
    [setPainel]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        request("close");
        setPainel({});
        setDetails({});
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request, setPainel]);

  return (
    <ThemeProvider theme={GS.theme}>
      <GS.GlobalStyle />
      <GS.Wrap>{painel.open && <Painel />}</GS.Wrap>
    </ThemeProvider>
  );
}

export default App;
