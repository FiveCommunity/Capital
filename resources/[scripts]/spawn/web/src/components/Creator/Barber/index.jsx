import * as S from "./styles";

import { Title } from "../../Title";
import { Slider } from "../../Slider";
import { Footer } from "../../Footer";
import { ColorPicker } from "../../ColorPicker";

import { motion } from "framer-motion";
import { useContext, useEffect } from "react";

import CamContext from "../../../contexts/CamContext";
import CharacterContext from "../../../contexts/CharacterContext";

export function Barber({ theme }) {
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
        <Title title="Barbearia" />
        <S.Wrap>
          <Slider
            label="corte de cabelo"
            value={character.hairModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, hairModel: val }))
            }
            ruler={true}
            min={0}
            max={drawables.hair}
          />
          <ColorPicker
            label="Cor do cabelo"
            value={character.firstHairColor}
            colorPicker="colors_type_1"
            description="Escolha uma cor para o seu cabelo"
            setValue={(val) =>
              setCharacter((old) => ({ ...old, firstHairColor: val }))
            }
            id={2}
          />
          <ColorPicker
            label="Cor das mechas"
            value={character.secondHairColor}
            colorPicker="colors_type_1"
            description="Escolha uma cor para as mechas do seu cabelo"
            setValue={(val) =>
              setCharacter((old) => ({ ...old, secondHairColor: val }))
            }
            id={3}
          />

          <Slider
            label="estilo da barba"
            value={character.beardModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, beardModel: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.beard}
          />
          <ColorPicker
            label="Cor da barba"
            value={character.beardColor}
            colorPicker="colors_type_1"
            description="Escolha uma cor para a sua barba"
            setValue={(val) =>
              setCharacter((old) => ({ ...old, beardColor: val }))
            }
            id={4}
          />
          <Slider
            label="opacidade da barba"
            value={character.beardOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, beardOpacity: val }))
            }
            ruler={true}
            min={0}
            max={1}
            step={0.01}
          />
          <Slider
            label="estilo do pelo corporal"
            value={character.chestModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, chestModel: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.chestModel}
          />
          <ColorPicker
            label="Cor do pelo corporal"
            value={character.chestColor}
            colorPicker="colors_type_1"
            description="Escolha uma cor para a sua barba"
            setValue={(val) =>
              setCharacter((old) => ({ ...old, chestColor: val }))
            }
            id={5}
          />
          <Slider
            label="opacidade dos pelos"
            value={character.chestOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, chestOpacity: val }))
            }
            ruler={true}
            min={0}
            max={1}
            step={0.01}
          />
          <Slider
            label="estilo do blush"
            value={character.blushModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, blushModel: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.blush}
          />
          <ColorPicker
            label="Cor do blush"
            value={character.blushColor}
            colorPicker="colors_type_2"
            description="Escolha uma cor para o seu blush"
            setValue={(val) =>
              setCharacter((old) => ({ ...old, blushColor: val }))
            }
            id={6}
          />
          <Slider
            label="opacidade do blush"
            value={character.blushOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, blushOpacity: val }))
            }
            ruler={true}
            min={0}
            max={1}
            step={0.01}
          />
          <Slider
            label="estilo do batom"
            value={character.lipstickModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, lipstickModel: val }))
            }
            ruler={true}
            min={-1}
            max={drawables.lipstick}
          />
          <ColorPicker
            label="Cor do batom"
            value={character.lipstickColor}
            colorPicker="colors_type_2"
            description="Escolha uma cor para o seu batom"
            setValue={(val) =>
              setCharacter((old) => ({ ...old, lipstickColor: val }))
            }
            id={7}
          />
          <Slider
            label="opacidade do batom"
            value={character.lipstickOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, lipstickOpacity: val }))
            }
            ruler={true}
            min={0}
            max={1}
            step={0.01}
          />
          <Slider
            label="estilo da maquiagem"
            value={character.makeupModel}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, makeupModel: val }))
            }
            rule
            ruler={true}
            min={-1}
            max={drawables.makeup}
          />
          <ColorPicker
            label="Cor da maquiagem"
            value={character.makeupColor}
            colorPicker="colors_type_3"
            description="Escolha uma cor para a sua maquiagem"
            setValue={(val, val2) =>
              setCharacter((old) => ({
                ...old,
                makeupColor: val,
                makeupColorType: val2,
              }))
            }
            id={8}
          />
          <Slider
            label="opacidade da maquiagem"
            value={character.makeupOpacity}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, makeupOpacity: val }))
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
