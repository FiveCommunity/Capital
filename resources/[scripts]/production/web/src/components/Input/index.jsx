import * as S from "./styles";

function Input({ label, ...rest }) {
  return (
    <S.Container>
      <S.Label>{label}</S.Label>
      <S.Input {...rest} />
    </S.Container>
  );
}

export default Input;
