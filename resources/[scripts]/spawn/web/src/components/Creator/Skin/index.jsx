import * as S from "./styles";

import { Title } from "../../Title";
import { Slider } from "../../Slider";
import { Footer } from "../../Footer";

import { motion } from "framer-motion";
import { useContext, useEffect } from "react";

import CamContext from "../../../contexts/CamContext";
import CharacterContext from "../../../contexts/CharacterContext";

export function Skin({ theme }) {
  const { character, setCharacter, drawables } = useContext(CharacterContext);
  const { setCam, setHandle } = useContext(CamContext);

  useEffect(() => {
    setHandle("next");
    setCam(0);
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
        <Title title="Pele" />

        <S.Wrap>
          <Slider
            label="cor da mãe"
            value={character.colorMother}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, colorMother: val }))
            }
            ruler={true}
            min={0}
            max={45}
          />
          <Slider
            label="cor do pai"
            value={character.colorFather}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, colorFather: val }))
            }
            ruler={true}
            min={0}
            max={45}
          />
          <Slider
            label="tom de pele"
            value={character.skinMix}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, skinMix: val }))
            }
            min={0}
            max={1}
            step={0.01}
            ruler={true}
          />
          <Slider
            label="manchas no corpo"
            value={character.addBodyBlemishes}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, addBodyBlemishes: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.addBodyBlemishes}
          />
          <Slider
            label=""
            value={character.bodyBlemishes}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, bodyBlemishes: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.bodyBlemishes}
          />
          <Slider
            label="opacidade das manchas"
            value={character.bodyBlemishesOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, bodyBlemishesOpacity: val }))
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
