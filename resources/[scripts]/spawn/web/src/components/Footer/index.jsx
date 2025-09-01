import * as S from "./styles";

import CategoryContext from "../../contexts/CategoryContext";
import ColorPickerContext from "../../contexts/ColorPickerContext";
import CharacterContext from "../../contexts/CharacterContext";
import AlertContext from "../../contexts/AlertContext";
import namesBlacklisted from "./namesBlacklisted.json";

import { useContext } from "react";

export function Footer({ theme }) {
  const { setAlert } = useContext(AlertContext);
  const { character, setCharacter } = useContext(CharacterContext);
  const { handleColor } = useContext(ColorPickerContext);
  const { category, handleNext, handlePrev, Categories } =
    useContext(CategoryContext);

  const TextButton = {
    nextButton:
      (category.index == Categories.length - 1 && "Finalizar") || "Próximo",
    previousButton: (category.index === 0 && "--") || "Voltar",
  };

  const formatCategoryNumber = (number) => {
    if (number < 10) number = "0" + number;
    return number;
  };

  const Finish = () => {
    const firstNameValid =
      character.firstname.length >= 3 && character.firstname.length <= 16;
    const lastNameValid =
      character.lastname.length >= 3 && character.lastname.length <= 16;
    const isFirstNameBlacklisted = namesBlacklisted.includes(
      character.firstname.toLowerCase()
    );
    const isLastNameBlacklisted = namesBlacklisted.includes(
      character.lastname.toLowerCase()
    );

    if (isFirstNameBlacklisted || isLastNameBlacklisted) {
      setAlert({
        title: "ATENÇÃO",
        description: (
          <span>
            O seu <b>{isFirstNameBlacklisted ? "nome" : "sobrenome"}</b> não é
            permitido
          </span>
        ),
        type: "error",
      });
      return;
    }

    if (!firstNameValid || !lastNameValid) {
      const fieldName = !firstNameValid ? "nome" : "sobrenome";
      const lengthQualifier =
        character.firstname.length <= 3 || character.lastname.length <= 3
          ? "mínimo 3"
          : "máximo 16";

      setAlert({
        title: "ATENÇÃO",
        description: (
          <span>
            O seu <b>{fieldName}</b> deve conter no{" "}
            <b>{lengthQualifier} caracteres</b>
          </span>
        ),
        type: "error",
      });
      return;
    }

    if (character.age < 18 || character.age > 99) {
      setAlert({
        title: "ATENÇÃO",
        description: (
          <span>
            A sua <b>idade</b> deve ser entre <b>18 e 99 anos</b>
          </span>
        ),
        type: "error",
      });
      return;
    }

    setAlert({
      title: "ATENÇÃO",
      description: (
        <span>
          você tem certeza que deseja criar esse personagem? "
          <b>
            {character.firstname} {character.lastname}
          </b>
          " ({character.age} anos)
        </span>
      ),
      type: "ok",
    });
  };

  return (
    <S.Container>
      <S.Previous
        dontHover={TextButton.previousButton === "--"}
        style={{
          border: `2px solid ${theme.colors.shape(0.3)}`,
          opacity: TextButton.previousButton === "--" ? 0.5 : 1.0,
        }}
        onClick={
          TextButton.previousButton === "Voltar"
            ? () => {
                handlePrev();
                handleColor();
              }
            : () => {}
        }
      >
        Voltar
      </S.Previous>
      <S.Step>
        {formatCategoryNumber(category.number)}/
        {formatCategoryNumber(Categories.length)}
      </S.Step>
      <S.Next
        style={{ border: `2px solid ${theme.colors.primary(0.3)}` }}
        onClick={
          TextButton.nextButton === "Próximo"
            ? () => {
                handleNext();
                handleColor();
              }
            : Finish
        }
      >
        {TextButton.nextButton}
      </S.Next>
    </S.Container>
  );
}
