import * as S from "./styles";

import { TbAlertTriangleFilled } from "react-icons/tb";
import { motion } from "framer-motion";
import { useContext, useCallback } from "react";

import AlertContext from "../../../contexts/AlertContext";
import CreationContext from "../../../contexts/CreationContext";
import { useRequest } from "../../../hooks/useRequest";

export function Alert() {
  const { request } = useRequest();
  const { setCreation } = useContext(CreationContext);
  const { alert, setAlert } = useContext(AlertContext);

  const handleFinish = useCallback(async () => {
    await request("Finish");
  }, [request]);

  return (
    <motion.div
      initial={{ y: 0, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      exit={{ y: 0, opacity: 0 }}
      transition={{ duration: 0.3 }}
      layout
    >
      <S.Alert>
        <S.Header>
          <TbAlertTriangleFilled />
          <h2>{alert.title}</h2>
          <TbAlertTriangleFilled />
        </S.Header>
        <S.Text>{alert.description}</S.Text>
        <S.Footer>
          {(alert.type === "error" && (
            <S.Button onClick={() => setAlert(false)}>Fechar</S.Button>
          )) || (
            <>
              <S.Button
                onClick={() => {
                  setAlert(false);
                  setCreation(false);
                  handleFinish();
                }}
              >
                Sim
              </S.Button>
              <S.Button onClick={() => setAlert(false)}>Não</S.Button>
            </>
          )}
        </S.Footer>
      </S.Alert>
    </motion.div>
  );
}
