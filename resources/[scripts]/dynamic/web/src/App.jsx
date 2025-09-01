import { useCallback, useContext, useEffect } from "react";
import Dynamic from "./components/Dynamic";
import * as GS from "./styles";
import useRequest from "./hooks/useRequest";
import DynamicContext from "./contexts/DynamicContext";

function App() {
  const { dynamic, setDynamic } = useContext(DynamicContext);

  const { request } = useRequest();

  const nuiMessage = useCallback(
    (event) => {
      const { action, favorites, clothes, animations, permissions } =
        event.data;
      if (action === "open") {
        setDynamic({
          favorites,
          clothes,
          animations,
          permissions,
        });
      }
    },
    [setDynamic]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        setDynamic({});
        request("close");
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request, setDynamic]);

  return (
    <>
      {dynamic.favorites && (
        <>
          <GS.GlobalStyle />
          <GS.Wrap>
            <Dynamic />
          </GS.Wrap>
        </>
      )}
    </>
  );
}

export default App;
