import * as S from "./styles";

import { Title } from "../../Title";
import { Slider } from "../../Slider";
import { Footer } from "../../Footer";

import { motion } from "framer-motion";
import { useContext, useEffect } from "react";

import CamContext from "../../../contexts/CamContext";
import CharacterContext from "../../../contexts/CharacterContext";

export function Chin({ theme }) {
  const { character, setCharacter } = useContext(CharacterContext);
  const { setCam, setHandle } = useContext(CamContext);

  useEffect(() => {
    setHandle("next");
    setCam(3);
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
        <Title title="Queixo" />
        <S.Wrap>
          <Slider
            label="comprimento do queixo"
            value={character.chinLength}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, chinLength: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="posição do queixo"
            value={character.chinPosition}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, chinPosition: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="largura do queixo"
            value={character.chinWidth}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, chinWidth: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="forma do queixo"
            value={character.chinShape}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, chinShape: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="largura da mandibula"
            value={character.jawWidth}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, jawWidth: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="altura da mandibula"
            value={character.jawHeight}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, jawHeight: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
        </S.Wrap>

        <Footer theme={theme} />
      </S.Container>
    </motion.div>
  );
}
