import * as S from "./styles";

import { Title } from "../../Title";
import { Slider } from "../../Slider";
import { Footer } from "../../Footer";

import { motion } from "framer-motion";
import { useContext, useEffect } from "react";

import CamContext from "../../../contexts/CamContext";
import CharacterContext from "../../../contexts/CharacterContext";

export function Nose({ theme }) {
  const { character, setCharacter } = useContext(CharacterContext);
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
        <Title title="Nariz" />
        <S.Wrap>
          <Slider
            label="largura do nariz"
            value={character.noseWidth}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, noseWidth: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="altura do nariz"
            value={character.noseHeight}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, noseHeight: val }))
            }
            ruler={true}
            min={-1}
            max={1}
            step={0.01}
          />
          <Slider
            label="comprimento do nariz"
            value={character.noseLength}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, noseLength: val }))
            }
            ruler={true}
            min={-1}
            max={1}
            step={0.01}
          />
          <Slider
            label="ponta do nariz"
            value={character.noseTip}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, noseTip: val }))
            }
            ruler={true}
            min={-1}
            max={1}
            step={0.01}
          />
          <Slider
            label="ponte nasal"
            value={character.noseBridge}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, noseBridge: val }))
            }
            ruler={true}
            min={-1}
            max={1}
            step={0.01}
          />
          <Slider
            label="curvatura do nariz"
            value={character.noseShift}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, noseShift: val }))
            }
            ruler={true}
            min={-1}
            max={1}
            step={0.01}
          />
        </S.Wrap>

        <Footer theme={theme} />
      </S.Container>
    </motion.div>
  );
}
