import * as S from "./styles";
import { BiSearch } from "react-icons/bi";

function Input({ ...rest }) {
  return (
    <S.WrapInput>
      <BiSearch />
      <S.Input {...rest} />
    </S.WrapInput>
  );
}

export default Input;
