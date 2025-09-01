import * as S from "./styles";

function Input({ label, className, ...rest }) {
  return (
    <S.Container className={className}>
      {label && <S.Label>{label}</S.Label>}
      <S.Input {...rest} />
    </S.Container>
  );
}

export default Input;
