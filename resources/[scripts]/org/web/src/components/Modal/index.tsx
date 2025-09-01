import React, { useContext } from "react";
import * as S from "./styles";
import * as GS from "../../styles";
import { ModalContext, ModalType } from "../../contexts/ModalContext";

const Modal = () => {
  const { modal, setModal } = useContext(ModalContext);

  const confirm = () => {
    if (modal.actionConfirm) modal.actionConfirm();
    setModal({} as ModalType);
  };

  const close = () => {
    if (modal.actionCancel) modal.actionCancel();
    setModal({} as ModalType);
  };

  return (
    <>
      {modal.text && (
        <S.Wrap>
          <S.Backdrop>
            <S.Container>
              <S.Title>{modal.text}</S.Title>
              {modal.content && modal.content}
              {modal.actionConfirm && (
                <S.Actions>
                  <GS.ActionButton className="success full-w" onClick={confirm}>
                    Confirmar
                  </GS.ActionButton>
                  <GS.ActionButton className="error full-w" onClick={close}>
                    Cancelar
                  </GS.ActionButton>
                </S.Actions>
              )}
            </S.Container>
          </S.Backdrop>
        </S.Wrap>
      )}
    </>
  );
};

export default Modal;
