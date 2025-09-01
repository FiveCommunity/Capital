import { useCallback, useContext, useEffect } from "react";
import Garage from "./components/Garage";
import * as S from "./styles";
import useRequest from "./hook/useRequest";
import GarageContext from "./contexts/GarageContext";

function App() {
  const { garage, setGarage } = useContext(GarageContext);
  const { request } = useRequest();

  const nuiMessage = useCallback(
    (event) => {
      const { action, cars, myVehicles } = event.data;
      if (action === "open") {
        setGarage({ cars, dealership: false });
      } else if (action === "dealership") {
        setGarage({ myVehicles, cars, dealership: true });
      } else if (action === "close") {
        setGarage({});
        request("close");
      }
    },
    [setGarage, request]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        setGarage({});
        request("close");
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request, setGarage]);

  return (
    <>
      {garage.cars && (
        <>
          <S.GlobalStyle />
          <S.Wrap>
            <Garage />
          </S.Wrap>
        </>
      )}
    </>
  );
}

export default App;
