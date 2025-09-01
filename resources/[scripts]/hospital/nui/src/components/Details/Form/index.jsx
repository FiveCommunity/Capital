import { useCallback, useContext, useEffect, useState } from "react";
import * as S from "../styles";
import useRequest from "../../../hooks/useRequest";
import PainelContext from "../../../contexts/PainelContext";
import { formatDate } from "../../../utils";

function Form({ data, isDetails }) {
  const { request } = useRequest();
  const { painel } = useContext(PainelContext);
  const [price, setPrice] = useState("");
  const [description, setDescription] = useState("");

  useEffect(() => {
    if (data.total_price) {
      setPrice(data.total_price);
    }
    setDescription(data?.description ?? "");
  }, [setPrice, painel, data]);

  const handleRegisterService = useCallback(() => {
    request("registerService", {
      patient_id: data.patient_id,
      total_price: price,
      request: data.request,
      description,
    });
  }, [price, request, description, data]);

  return (
    <S.Form>
      <S.Title>
        <span>#{data.patient_id}</span> - {data.patient_name}
      </S.Title>
      <S.Group>
        <S.Input>
          <S.Label>Data do serviço:</S.Label>
          <S.InputField
            value={data?.service_date ?? formatDate(new Date())}
            disabled={true}
          />
        </S.Input>
        <S.Input>
          <S.Label>Valor do atendimento:</S.Label>
          <S.InputField
            value={price}
            disabled={isDetails}
            type={data.total_price ? "text" : "number"}
            onChange={(e) => setPrice(e.target.value)}
            placeholder="Valor"
          />
        </S.Input>
      </S.Group>
      <S.Group>
        <S.Input>
          <S.Label>Detalhes de atendimento:</S.Label>
          <S.Textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            disabled={isDetails}
            rows={5}
          ></S.Textarea>
        </S.Input>
      </S.Group>
      <S.Group>
        <S.Input>
          <S.Label>Solicitação do paciente:</S.Label>
          <S.InputField value={data?.request ?? ""} disabled={true} />
        </S.Input>
      </S.Group>
      <S.Group>
        {!isDetails && (
          <S.Button onClick={handleRegisterService}>
            Registrar Atendimento
          </S.Button>
        )}
        <S.Datetime></S.Datetime>
      </S.Group>
    </S.Form>
  );
}

export default Form;
