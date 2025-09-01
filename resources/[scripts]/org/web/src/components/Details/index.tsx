import React, { useContext, useEffect, useState } from "react";
import * as S from "./styles";
import * as GS from "../../styles";
import { DetailsContext, DetailsType } from "../../contexts/DetailsContext";
import api from "../../services/api";
import { UserDetailsDTO } from "../../DTOS/Members";

const DetailsModal = () => {
  const { details, setDetails } = useContext(DetailsContext);
  const [user, setUser] = useState<UserDetailsDTO>({} as UserDetailsDTO);

  const close = () => {
    setDetails({} as DetailsType);
  };

  const handleGetUserDetails = async () => {
    const member = (
      await api.post(
        "/detailsUser",
        JSON.stringify({
          user_id: details.user,
          fac: details.fac,
        })
      )
    ).data;

    setUser(JSON.parse(member));
  };

  useEffect(() => {
    if (details.show) handleGetUserDetails();
  }, [details.show]);

  return (
    <>
      {details.show && user.last_seen && (
        <S.Wrap>
          <S.Backdrop>
            <S.Container>
              <S.Title>Detalhes</S.Title>
              <S.List>
                <S.Item>
                  {details.isJob ? "Último ponto" : "Último visto"}:{" "}
                  <span>{user.last_seen}</span>
                </S.Item>
                {details.isJob && (
                  <>
                    <S.Item>
                      Total de horas (Semana):{" "}
                      <span>{user.hours_worked_week}</span>
                    </S.Item>
                    <S.Item>
                      Total de horas registradas:{" "}
                      <span>{user.hours_worked}</span>
                    </S.Item>
                  </>
                )}
              </S.List>
              <S.Actions>
                <GS.ActionButton className="error full-w" onClick={close}>
                  Fechar
                </GS.ActionButton>
              </S.Actions>
            </S.Container>
          </S.Backdrop>
        </S.Wrap>
      )}
    </>
  );
};

export default DetailsModal;
