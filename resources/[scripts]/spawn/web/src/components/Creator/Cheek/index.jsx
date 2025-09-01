import * as S from "./styles";

import { Title } from "../../Title";
import { Slider } from "../../Slider";
import { Footer } from "../../Footer";

import { motion } from "framer-motion";
import { useContext, useEffect } from "react";

import CamContext from "../../../contexts/CamContext";
import CharacterContext from "../../../contexts/CharacterContext";

export function Cheek({ theme }) {
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
        <Title title="Bochecha" />
        <S.Wrap>
          <Slider
            label="Altura dos ossos da bochecha"
            value={character.cheekboneHeight}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, cheekboneHeight: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="Largura dos ossos da bochecha"
            value={character.cheekboneWidth}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, cheekboneWidth: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="Largura da bochecha"
            value={character.cheeksWidth}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, cheeksWidth: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="tamanho do pescoço"
            value={character.neckWidth}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, neckWidth: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="lábios"
            value={character.lips}
            setValue={(val) => setCharacter((old) => ({ ...old, lips: val }))}
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
