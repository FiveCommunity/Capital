import * as S from "./styles";

import { Creator } from "./components/Creator";
import { Selector } from "./components/Selector";
import { Spawn } from "./components/Spawn";
import { CategoryProvider } from "./contexts/CategoryContext";
import { ColorPickerProvider } from "./contexts/ColorPickerContext";
import { CamProvider } from "./contexts/CamContext";
import { AlertProvider } from "./contexts/AlertContext";
import { FocusProvider } from "./contexts/FocusContext";
import { useRequest } from "./hooks/useRequest";

import CreationContext from "./contexts/CreationContext";
import CharacterContext from "./contexts/CharacterContext";
import SelectionContext from "./contexts/SelectionContext";
import SpawnContext from "./contexts/SpawnContext";

import { useCallback, useContext, useEffect } from "react";

function App() {
  const { request } = useRequest();
  const { creation, setCreation } = useContext(CreationContext);
  const { spawn, setSpawn, setHomes } = useContext(SpawnContext);
  const { setDrawables } = useContext(CharacterContext);
  const { selection, setSelection, setCharacters, setChars } =
    useContext(SelectionContext);

  const actions = {
    creator: ({ data }) => {
      setCreation(data.show);
      if (data.show) setDrawables(data.drawables);
    },
    selector: ({ data }) => {
      setSelection(data.show);
      if (data.show) {
        setCharacters(data.characters);
        setChars(data.maxChars);
      }
    },
    spawn: ({ data }) => {
      setSpawn(data.show);
      if (data.show) setHomes(data.userHomes);
    },
  };

  const nuiMessage = useCallback((event) => {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);
  });

  const handleReady = useCallback(async () => {
    await request("NuiReady");
  }, [request]);

  useEffect(() => {
    handleReady();
    window.addEventListener("message", nuiMessage);

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage]);

  return (
    <>
      <S.GlobalStyle />
      <S.Wrap>
        {creation && (
          <>
            <CategoryProvider>
              <ColorPickerProvider>
                <CamProvider>
                  <AlertProvider>
                    <FocusProvider>
                      <Creator theme={S.theme} />
                    </FocusProvider>
                  </AlertProvider>
                </CamProvider>
              </ColorPickerProvider>
            </CategoryProvider>
          </>
        )}
        {selection && <Selector theme={S.theme} />}
        {spawn && <Spawn theme={S.theme} />}
      </S.Wrap>
    </>
  );
}

export default App;
