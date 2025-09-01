import { useCallback, useContext, useEffect } from "react";
import Production from "./components/Production";
import * as S from "./styles";
import useRequest from "./hooks/useRequest";
import ProductionContext from "./contexts/ProductionContext";
// import { Timer } from "./components/Timer";

function App() {
  const { production, setProduction } = useContext(ProductionContext);
  const { request } = useRequest();

  const nuiMessage = useCallback(
    (event) => {
      const { action, products, title, org } = event.data;
      if (action === "open") {
        setProduction({
          title,
          products,
          org,
        });
      }
    },
    [setProduction]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        setProduction({});
        request("close");
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request, setProduction]);

  return (
    <>
      <S.GlobalStyle />
      {production.title && (
        <S.Wrap>
          <Production data={production} />
          {/* <Timer />  */}
        </S.Wrap>
      )}
    </>
  );
}

export default App;
