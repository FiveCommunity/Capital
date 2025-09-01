import * as S from "./styles";

import { IoLockClosed } from "react-icons/io5";
import { IoMdAddCircle } from "react-icons/io";

import { useEffect, useState, useContext, useCallback } from "react";

import SelectionContext from "../../contexts/SelectionContext";
import { useRequest } from "../../hooks/useRequest";

export function Selector({ theme }) {
  const { request } = useRequest();
  const { characters, chars, setSelection } = useContext(SelectionContext);
  const [selected, setSelected] = useState({
    index: 0,
    user_id: characters[0].user_id,
  });

  const formatPassport = (id) => {
    if (id < 10) id = "#00" + id;
    if (id >= 10 && id < 100) id = "#0" + id;
    if (id > 100) id = "#" + id;
    return id;
  };

  const handleRequest = useCallback(
    async (link, data) => {
      await request(link, data);
    },
    [request]
  );

  useEffect(() => {
    handleRequest("SwitchCharacter", selected.index + 1);
  }, [selected]);

  return (
    <>
      <S.Left>
        <S.Main>
          <S.Header>
            <h1>
              Seletor de <br /> Personagem
            </h1>
            <span>Escolha qual personagem você deseja interpretar!</span>
          </S.Header>

          <S.Content>
            <S.CharactersWrap>
              {characters.map((option, index) => (
                <S.Characters
                  key={index}
                  selected={selected.index === index}
                  onClick={() =>
                    setSelected({ index: index, user_id: option.user_id })
                  }
                >
                  <S.User>
                    <span>{option.group}</span>
                    <strong>{option.name}</strong>
                  </S.User>
                  <strong>{formatPassport(option.user_id)}</strong>
                </S.Characters>
              ))}
              {Array.from({ length: chars }).map((_, index) => (
                <S.Characters
                  key={index}
                  onClick={() => {
                    handleRequest("NewCharacter");
                    setSelection(false);
                  }}
                >
                  <S.User>
                    <span style={{ color: theme.colors.primary() }}>
                      Slot comprado
                    </span>
                    <strong>Crie o seu personagem</strong>
                  </S.User>
                  <IoMdAddCircle style={{ color: theme.colors.primary() }} />
                </S.Characters>
              ))}
              <S.Characters style={{ opacity: 0.5, pointerEvents: "none" }}>
                <S.User>
                  <span>Bloqueado</span>
                  <strong>Compre um slot</strong>
                </S.User>
                <IoLockClosed />
              </S.Characters>
              <S.Characters style={{ opacity: 0.5, pointerEvents: "none" }}>
                <S.User>
                  <span>Bloqueado</span>
                  <strong>Compre um slot</strong>
                </S.User>
                <IoLockClosed />
              </S.Characters>
            </S.CharactersWrap>
          </S.Content>
        </S.Main>
      </S.Left>
      <S.Center>
        <S.ButtonPlay
          onClick={() => {
            handleRequest("Play", selected.user_id);
            setSelection(false);
          }}
        >
          JOGAR
        </S.ButtonPlay>
      </S.Center>
    </>
  );
}
