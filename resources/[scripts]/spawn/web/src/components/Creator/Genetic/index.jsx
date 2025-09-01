import * as S from "./styles";

import { Title } from "../../Title";
import { Input } from "../../Input";
import { Gender } from "./Gender";
import { Parents } from "./Parents";
import { Slider } from "../../Slider";
import { Footer } from "../../Footer";

import { motion } from "framer-motion";
import { useContext, useEffect, useState } from "react";

import CamContext from "../../../contexts/CamContext";
import CharacterContext from "../../../contexts/CharacterContext";
import FocusContext from "../../../contexts/FocusContext";

export function Genetic({ theme }) {
  const { character, setCharacter } = useContext(CharacterContext);
  const { setCam, setHandle } = useContext(CamContext);
  const { setFocus } = useContext(FocusContext);

  useEffect(() => {
    setHandle("next");
    setCam(0);
  }, []);

  const formatInput = (e, pattern, field) => {
    const sanitizedValue = e.target.value.replace(pattern, "");
    setCharacter((old) => ({ ...old, [field]: sanitizedValue }));
  };

  const handleFocus = (bool) => {
    setFocus(bool);
  };

  return (
    <motion.div
      initial={{ y: 0, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      exit={{ y: 0, opacity: 0 }}
      transition={{ duration: 0.3 }}
      layout
    >
      <S.Container>
        <Title title="Genética" />
        <S.Wrap>
          <Input
            label="nome:"
            placeHolder="Nome..."
            onFocus={() => handleFocus(true)}
            onBlur={() => handleFocus(false)}
            value={character.firstname}
            onChange={(e) => formatInput(e, /[^A-Za-z]/g, "firstname")}
          />
          <Input
            label="sobrenome:"
            placeHolder="Sobrenome..."
            onFocus={() => handleFocus(true)}
            onBlur={() => handleFocus(false)}
            value={character.lastname}
            onChange={(e) => formatInput(e, /[^A-Za-z]/g, "lastname")}
          />
          <Input
            label="sua idade:"
            placeHolder="18"
            onFocus={() => handleFocus(true)}
            onBlur={() => handleFocus(false)}
            value={character.age}
            onChange={(e) => formatInput(e, /[^0-9]/g, "age")}
          />
          <Gender />
          <Parents />
          <Slider
            label="semelhança pai/mãe"
            value={character.shapeMix}
            setValue={(val) =>
              setCharacter((old) => ({ ...old, shapeMix: val }))
            }
            min={0}
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
