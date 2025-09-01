import * as S from "./styles";
import * as GS from "../../styles";
import { useContext, useState } from "react";
import { ModalContext, ModalType } from "../../contexts/ModalContext";
import api from "../../services/api";
import { UserContext } from "../../contexts/UserContext";
import { toast } from "react-toastify";

const MensagemGeral = () => {
  const { setModal } = useContext(ModalContext);
  const [message, setMessage] = useState("");
  const { user } = useContext(UserContext);

  const handleSendMessage = async () => {
    const response = (
      await api.post(
        "sendMessage",
        JSON.stringify({
          message: `<b>${user.fac}:</b> ${message}`,
          fac: user.fac,
        })
      )
    ).data;

    if (response.result === "success") {
      toast.success(response.message);
    }
    if (response.result === "error") toast.error(response.message);
  };

  const closeModal = () => {
    setModal({} as ModalType);
    setMessage("");
  };

  return (
    <S.Container>
      <GS.Textarea
        value={message}
        onChange={(e) => setMessage(e.target.value)}
        rows={4}
      ></GS.Textarea>
      <GS.BtnInLine>
        <GS.ActionButton onClick={handleSendMessage} className="success">
          Enviar
        </GS.ActionButton>
        <GS.ActionButton onClick={closeModal} className="error">
          Cancelar
        </GS.ActionButton>
      </GS.BtnInLine>
    </S.Container>
  );
};

export default MensagemGeral;
