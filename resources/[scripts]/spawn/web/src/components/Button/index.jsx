import * as S from "./styles";

export function Button({ svg, onClick, active }) {
  return (
    <S.Button active={active} onClick={onClick}>
      {svg}
    </S.Button>
  );
}
