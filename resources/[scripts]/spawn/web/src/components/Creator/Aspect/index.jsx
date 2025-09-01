import * as S from "./styles";

import { Title } from "../../Title";
import { Slider } from "../../Slider";
import { Footer } from "../../Footer";

import { motion } from "framer-motion";
import { useContext, useEffect } from "react";

import CamContext from "../../../contexts/CamContext";
import CharacterContext from "../../../contexts/CharacterContext";

export function Aspect({ theme }) {
  const { character, setCharacter, drawables } = useContext(CharacterContext);
  const { setCam, setHandle } = useContext(CamContext);

  useEffect(() => {
    setHandle("next");
    setCam(1);
  }, []);

  return (
    <motion.div
      initial={{ y: 0, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      exit={{ y: 0, opacity: 0 }}
      transition={{ duration: 0.3 }}
      layout
    >
      <S.Container>
        <Title title="Aspecto" />
        <S.Wrap>
          <Slider
            label="aspecto"
            value={character.complexionModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, complexionModel: val }))
            }
            min={-1}
            max={drawables.complexion}
            ruler={true}
          />
          <Slider
            label="opacidade do aspecto"
            value={character.complexionOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, complexionOpacity: val }))
            }
            ruler={true}
            min={0}
            max={1}
            step={0.01}
          />
          <Slider
            label="danos solares"
            value={character.sundamageModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, sundamageModel: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.sundamage}
          />
          <Slider
            label="opacidade dos danos solares"
            value={character.sundamageOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, sundamageOpacity: val }))
            }
            ruler={true}
            min={0}
            max={1}
            step={0.01}
          />
          <Slider
            label="sardas"
            value={character.frecklesModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, frecklesModel: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.freckles}
          />
          <Slider
            label="opacidade das sardas"
            value={character.frecklesOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, frecklesOpacity: val }))
            }
            ruler={true}
            min={0}
            max={1}
            step={0.01}
          />
          <Slider
            label="rugas"
            value={character.ageingModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, ageingModel: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.ageing}
          />
          <Slider
            label="opacidade das rugas"
            value={character.ageingOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, ageingOpacity: val }))
            }
            ruler={true}
            min={0}
            max={1}
            step={0.01}
          />
          <Slider
            label="manchas no rosto"
            value={character.blemishesModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, blemishesModel: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.blemishes}
          />
          <Slider
            label="opacidade das manchas"
            value={character.blemishesOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, blemishesOpacity: val }))
            }
            ruler={true}
            min={0}
            max={1}
            step={0.01}
          />
        </S.Wrap>
        <Footer theme={theme} />
      </S.Container>
    </motion.div>
  );
}
