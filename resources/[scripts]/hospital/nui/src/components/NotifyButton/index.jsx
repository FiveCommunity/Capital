import { useCallback, useState } from "react";
import * as S from "./styles";
import { FaBell } from "react-icons/fa";
import { FiCheck } from "react-icons/fi";
import useRequest from "../../hooks/useRequest";

function NotifyButton({ notifies }) {
  const { request } = useRequest();
  const [showModal, setShowModal] = useState(false);

  const handleOpenModal = useCallback(() => {
    if (showModal) {
      setShowModal(false);
    } else {
      setShowModal(true);
    }
  }, [showModal, setShowModal]);

  const handleAcceptService = () => {
    request("acceptService");
    setShowModal(false);
  };

  return (
    <S.WrapButton>
      <S.Button onClick={handleOpenModal}>
        {notifies > 0 && <S.WrapNotifies>{notifies}</S.WrapNotifies>}
        <FaBell />
      </S.Button>
      {showModal && notifies > 0 && (
        <>
          <S.BackModal onClick={() => setShowModal(false)} />
          <S.ConfirmModal>
            <S.Description>Quer assumir um chamado?</S.Description>
            <S.Actions>
              <S.ResponseButton
                className="accept"
                onClick={handleAcceptService}
              >
                <FiCheck /> Aceitar solicitação
              </S.ResponseButton>
            </S.Actions>
          </S.ConfirmModal>
        </>
      )}
    </S.WrapButton>
  );
}

export default NotifyButton;
