import * as S from "./styles";
import ParentsJson from "./parents.json";

import { BsFillPlayFill } from "react-icons/bs";
import { useState, useContext, useEffect } from "react";
import { Label } from "../../../Label";

import CharacterContext from "../../../../contexts/CharacterContext";

export function Parents() {
  const { character, setCharacter } = useContext(CharacterContext);
  const [father, setFather] = useState(character.fatherId);
  const [mother, setMother] = useState(character.motherId);

  const handlePrev = (type) => {
    if (type == "mom") {
      setMother((old) => {
        const newValue = old - 1;
        return newValue < 0 ? ParentsJson.length - 1 : newValue;
      });
    } else {
      setFather((old) => {
        const newValue = old - 1;
        return newValue < 0 ? ParentsJson.length - 1 : newValue;
      });
    }
  };

  const handleNext = (type) => {
    if (type == "mom") {
      setMother((old) => {
        const newValue = old + 1;
        return newValue === ParentsJson.length ? 0 : newValue;
      });
    } else {
      setFather((old) => {
        const newValue = old + 1;
        return newValue === ParentsJson.length ? 0 : newValue;
      });
    }
  };

  useEffect(() => {
    setCharacter((old) => ({ ...old, fatherId: father, motherId: mother }));
  }, [father, mother]);

  return (
    <S.Container>
      <Label label="parentes" />
      <S.ParentsList>
        <S.ParentsButton>
          <S.Avatar>
            <img
              src={`http://189.127.164.125/babilonia/gb_creation/${father}.png`}
            />
          </S.Avatar>
          <S.Information>
            <span>Seu Pai</span>
            <S.Option>
              <S.Previous onClick={handlePrev}>
                <BsFillPlayFill />
              </S.Previous>
              <strong>{ParentsJson[father].name}</strong>
              <S.Next onClick={handleNext}>
                <BsFillPlayFill />
              </S.Next>
            </S.Option>
          </S.Information>
        </S.ParentsButton>
        <S.ParentsButton>
          <S.Avatar>
            <img
              src={`http://189.127.164.125/babilonia/gb_creation/${mother}.png`}
            />
          </S.Avatar>
          <S.Information>
            <span>Sua Mãe</span>
            <S.Option>
              <S.Previous onClick={() => handlePrev("mom")}>
                <BsFillPlayFill />
              </S.Previous>
              <strong>{ParentsJson[mother].name}</strong>
              <S.Next onClick={() => handleNext("mom")}>
                <BsFillPlayFill />
              </S.Next>
            </S.Option>
          </S.Information>
        </S.ParentsButton>
      </S.ParentsList>
    </S.Container>
  );
}
