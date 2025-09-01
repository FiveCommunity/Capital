import { useMemo, useContext } from "react";
import * as S from "./styles";
import Form from "./Form";
import { AiOutlineClose } from "react-icons/ai";
import PainelContext from "../../contexts/PainelContext";
import DetailsContext from "../../contexts/DetailsContext";
import useRequest from "../../hooks/useRequest";

function Details() {
  const { request } = useRequest();
  const { painel, setPainel } = useContext(PainelContext);
  const { details, setDetails } = useContext(DetailsContext);

  const renderDetailsPopup = useMemo(() => {
    if (painel.currentService.patient_id) {
      return painel.currentService;
    }
    if (details.patient_id) {
      return details;
    }
    return {};
  }, [painel, details]);

  const handleCancelService = () => {
    if (details.patient_id) {
      setDetails({});
    } else {
      request("cancelService");
      setPainel({});
    }
  };

  return (
    <>
      {renderDetailsPopup.patient_id && (
        <S.Details>
          <S.BackImage src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=810&height=282" />
          <S.Content>
            <S.CloseButton onClick={handleCancelService}>
              <AiOutlineClose />
            </S.CloseButton>
            <Form
              isDetails={details.patient_id ?? false}
              data={renderDetailsPopup}
            />
          </S.Content>
        </S.Details>
      )}
    </>
  );
}

export default Details;
