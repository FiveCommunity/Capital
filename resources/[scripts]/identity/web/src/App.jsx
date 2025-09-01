import { ThemeProvider } from "styled-components";
import useRequest from "./hooks/useRequest";
import * as S from "./styles";
import { useCallback, useEffect, useState } from "react";
import { AiFillCamera, AiOutlineClose, AiOutlineCheck } from "react-icons/ai";
import { RiCoinsLine } from "react-icons/ri";
import { currencyFormat } from "./utils/formats";

function App() {
  const { request } = useRequest();
  const [user, setUser] = useState({});
  const [showModal, setShowModal] = useState(false);
  const [userImage, setUserImage] = useState("");

  const nuiMessage = useCallback((event) => {
    const { action, userInfo } = event.data;
    if (action === "open" || action === "update") {
      setUser(userInfo);
      setUserImage(userInfo.image);
    }
  }, []);

  const handleChangeImage = useCallback(() => {
    request("changeImage", {
      image: userImage,
    });
    setShowModal(false);
  }, [userImage, request]);

  const handleClearInput = useCallback(() => {
    setUserImage("");
    request("changeImage", {
      image: null,
    });
  }, [setUserImage, request]);

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        request("close");
        setUser({});
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request]);

  return (
    <ThemeProvider theme={S.theme}>
      <S.GlobalStyle />
      {user.id && (
        <S.Wrap>
          {showModal && (
            <S.ModalImage>
              <S.TitleForm>Link da imagem:</S.TitleForm>
              <S.Form>
                <S.Input
                  value={userImage}
                  placeholder="Cole o link da imagem aqui..."
                  onChange={(e) => setUserImage(e.target.value)}
                />
                {userImage !== "" && (
                  <S.CancelImageButton onClick={handleClearInput}>
                    <AiOutlineClose />
                  </S.CancelImageButton>
                )}
                <S.SubmitImageButton onClick={handleChangeImage}>
                  <AiOutlineCheck />
                </S.SubmitImageButton>
              </S.Form>
              <S.ButtonCloseImage onClick={() => setShowModal(false)}>
                <AiOutlineClose />
              </S.ButtonCloseImage>
            </S.ModalImage>
          )}
          <S.Identify>
            <S.Left>
              {/* <S.WrapLogo>
                <S.Logo src="https://media.discordapp.net/attachments/1059878373737893918/1125947172165255178/zero_small.png?width=988&height=346" />
              </S.WrapLogo> */}
              <S.WrapImage>
                <S.Image src={user.image} />
                <S.BtnImage onClick={() => setShowModal(true)}>
                  <AiFillCamera />
                </S.BtnImage>
              </S.WrapImage>
            </S.Left>
            <S.WrapInfos>
              <S.Header>
                <S.LeftHeader>
                  <S.IdNumber>#{user.id}</S.IdNumber>
                  <S.WrapName>
                    <S.Name>{user.fullname}</S.Name>
                    <S.Job>{user.job ? user.job : "Desempregado"}</S.Job>
                  </S.WrapName>
                </S.LeftHeader>
                {user.rg && <S.IdNumber>{user.rg}</S.IdNumber>}
              </S.Header>
              <S.InfoList>
                <S.Info className="highlight">
                  <S.InfoLabel>Carteira</S.InfoLabel>
                  <S.InfoContent>
                    {currencyFormat(user.wallet ?? 0)}
                  </S.InfoContent>
                </S.Info>
                <S.Info className="highlight">
                  <S.InfoLabel>Banco</S.InfoLabel>
                  <S.InfoContent>
                    {currencyFormat(user.bank ?? 0)}
                  </S.InfoContent>
                </S.Info>
                {user.staff && (
                  <S.Info>
                    <S.InfoLabel>Staff</S.InfoLabel>
                    <S.InfoContent>{user.staff}</S.InfoContent>
                  </S.Info>
                )}
                <S.Info>
                  <S.InfoLabel>Fator Sanguíneo</S.InfoLabel>
                  <S.InfoContent>
                    {user.rh ? user.rh : "Desconhecido"}
                  </S.InfoContent>
                </S.Info>
                <S.Info>
                  <S.InfoLabel>Idade</S.InfoLabel>
                  <S.InfoContent>{user.age}</S.InfoContent>
                </S.Info>
                <S.Info>
                  <S.InfoLabel>Telefone</S.InfoLabel>
                  <S.InfoContent>{user.phone}</S.InfoContent>
                </S.Info>
                {user.relationship && (
                  <S.Info>
                    <S.InfoLabel>Estado Civil</S.InfoLabel>
                    <S.InfoContent>{user.relationship}</S.InfoContent>
                  </S.Info>
                )}
                {user.vip && (
                  <S.Info>
                    <S.InfoLabel>VIP</S.InfoLabel>
                    <S.InfoContent>{user.vip}</S.InfoContent>
                  </S.Info>
                )}

                {user.coins > 0 && (
                  <S.Info>
                    <S.InfoLabel>Coins</S.InfoLabel>
                    <S.InfoContent>
                      <RiCoinsLine />
                      {user.coins}
                    </S.InfoContent>
                  </S.Info>
                )}

                {user.fines > 0 && (
                  <S.Info>
                    <S.InfoLabel>Valor em Multa(s)</S.InfoLabel>
                    <S.InfoContent>
                      {currencyFormat(user.fines ?? 0)}
                    </S.InfoContent>
                  </S.Info>
                )}
                <S.Info>
                  <S.InfoLabel>Habilitação</S.InfoLabel>
                  <S.InfoContent>
                    {user.driveLicense ? user.driveLicense : "Não possui"}
                  </S.InfoContent>
                </S.Info>
                {user.oac && (
                  <S.Info>
                    <S.InfoLabel>OAC</S.InfoLabel>
                    <S.InfoContent>
                      {user.oac ? "Possui" : "Não possui"}
                    </S.InfoContent>
                  </S.Info>
                )}
                {user.gunLicense && (
                  <S.Info>
                    <S.InfoLabel>Porte de armas</S.InfoLabel>
                    <S.InfoContent>
                      {user.gunLicense ? "Possui" : "Não possui"}
                    </S.InfoContent>
                  </S.Info>
                )}
                {user.hunter && (
                  <S.Info>
                    <S.InfoLabel>Licença de Caça</S.InfoLabel>
                    <S.InfoContent>
                      {user.hunter ? "Possui" : "Não possui"}
                    </S.InfoContent>
                  </S.Info>
                )}
              </S.InfoList>
            </S.WrapInfos>
          </S.Identify>
        </S.Wrap>
      )}
    </ThemeProvider>
  );
}

export default App;
