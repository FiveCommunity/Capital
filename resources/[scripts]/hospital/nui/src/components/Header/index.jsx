import { useCallback, useContext, useState } from "react";
import Input from "../Input";
import NotifyButton from "../NotifyButton";
import * as S from "./styles";
import PainelContext from "../../contexts/PainelContext";
import FilterContext from "../../contexts/FilterContext";
import { AiOutlineSearch } from "react-icons/ai";
import useRequest from "../../hooks/useRequest";

function Header() {
  const { request } = useRequest();
  const { painel } = useContext(PainelContext);
  const [search, setSearch] = useState("");
  const [typeSearch, setTypeSearch] = useState("patient_id");
  const { filter } = useContext(FilterContext);

  const handleChangeFilter = useCallback(() => {
    request("changeFilter", {
      page: filter.page,
      search,
      typeSearch,
    });
  }, [filter, search, typeSearch]);

  return (
    <S.Header>
      <S.Title>
        Centro <span>Médico</span>
      </S.Title>
      <S.Right>
        <S.Form>
          <S.SearchType
            value={typeSearch}
            onChange={(e) => setTypeSearch(e.target.value)}
          >
            <option value="patient_id">ID Paciente</option>
            <option value="doctor_id">ID Médico</option>
          </S.SearchType>
          <Input
            placeholder="Colaborador ou paciente"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
          <S.BtnSearch onClick={handleChangeFilter}>
            <AiOutlineSearch />
          </S.BtnSearch>
        </S.Form>
        <NotifyButton notifies={painel.pendingServicesAmount} />
      </S.Right>
    </S.Header>
  );
}

export default Header;
