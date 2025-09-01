import * as S from "./styles";

import { Title } from "../../Title";
import { Slider } from "../../Slider";
import { Footer } from "../../Footer";
import { ColorPicker } from "../../ColorPicker";

import { motion } from "framer-motion";
import { useContext, useEffect } from "react";

import CamContext from "../../../contexts/CamContext";
import CharacterContext from "../../../contexts/CharacterContext";

export function Eyes({ theme }) {
  const { character, setCharacter, drawables } = useContext(CharacterContext);
  const { setCam, setHandle } = useContext(CamContext);

  useEffect(() => {
    setHandle("next");
    setCam(2);
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
        <Title title="Olhos" />
        <S.Wrap>
          <Slider
            label="cor dos olhos"
            value={character.eyesColor}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, eyesColor: val }))
            }
            ruler={true}
            min={0}
            max={drawables.eyes}
          />
          <Slider
            label="abertura dos olhos"
            value={character.eyesOpening}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, eyesOpening: val }))
            }
            min={-1}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="estilo das Sobrancelhas"
            value={character.eyebrowsModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, eyebrowsModel: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.eyebrows}
          />
          <ColorPicker
            label="Cor das Sobrancelhas"
            value={character.eyebrowsColor}
            colorPicker="colors_type_1"
            description="Escolha uma cor para a sua sobrancelha"
            setValue={(val) =>
              setCharacter((old) => ({ ...old, eyebrowsColor: val }))
            }
            id={1}
          />
          <Slider
            label="opacidade das sobrancelhas"
            value={character.eyebrowsOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, eyebrowsOpacity: val }))
            }
            ruler={true}
            min={0}
            max={1}
            step={0.01}
          />
          <Slider
            label="Altura das Sobrancelhas"
            value={character.eyebrowsHeight}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, eyebrowsHeight: val }))
            }
            ruler={true}
            min={-1}
            max={1}
            step={0.01}
          />
          <Slider
            label="Largura das Sobrancelhas"
            value={character.eyebrowsWidth}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, eyebrowsWidth: val }))
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
