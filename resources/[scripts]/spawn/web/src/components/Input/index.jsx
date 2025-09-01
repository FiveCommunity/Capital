import * as S from "./styles";

import { Label } from "../Label";

export function Input({ label, ...rest }) {
  return (
    <S.Container>
      <Label label={label} />
      <S.Input {...rest} />
    </S.Container>
  );
}
