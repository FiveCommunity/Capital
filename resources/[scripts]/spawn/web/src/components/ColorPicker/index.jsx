import * as S from "./styles";
import Colors from "./colors.json";
import ColorPickerContext from "../../contexts/ColorPickerContext";

import { useContext, useEffect } from "react";
import { Label } from "../Label";

export function ColorPicker({
  label,
  value,
  colorPicker,
  setValue,
  description,
  id,
}) {
  const { handleColor, colorSelected } = useContext(ColorPickerContext);

  useEffect(() => {
    if (colorSelected[id] && colorSelected[id][1] >= 0) {
      setValue(colorSelected[id][1], colorSelected[id][2]);
    }
  }, [colorSelected]);

  return (
    <S.Container>
      <Label label={label} />
      <S.Picker>
        <S.Placeholder
          onClick={() =>
            handleColor(description, Colors[colorPicker], value, id)
          }
          bgColor={Colors[colorPicker][value].hex}
        />
      </S.Picker>
    </S.Container>
  );
}
