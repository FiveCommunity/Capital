import * as S from "./styles";

import { Button } from "../../../Button";
import { FaFemale, FaMale } from "react-icons/fa";
import { useState, useEffect, useContext } from "react";
import { Label } from "../../../Label";

import CharacterContext from "../../../../contexts/CharacterContext";

export function Gender() {
  const { character, setCharacter } = useContext(CharacterContext);
  const [gender, setGender] = useState(character.gender);

  useEffect(() => {
    setCharacter((old) => ({ ...old, gender: gender }));
  }, [gender]);

  return (
    <S.Container>
      <Label label="genêro:" />
      <S.OptionsList>
        <S.OptionsButton>
          <Button
            active={gender === "male"}
            svg={<FaMale />}
            onClick={() => setGender("male")}
          />
          <span>Homem</span>
        </S.OptionsButton>
        <S.Line />
        <S.OptionsButton>
          <Button
            active={gender === "female"}
            svg={<FaFemale />}
            onClick={() => setGender("female")}
          />
          <span>Mulher</span>
        </S.OptionsButton>
      </S.OptionsList>
    </S.Container>
  );
}
