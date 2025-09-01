import * as S from "./styles";

import { motion } from "framer-motion";

export function Radar({ data }) {
  const formatVelocity = (value) => {
    if (value < 10) value = "00" + value;
    if (value >= 10 && value < 100) value = "0" + value;
    return value;
  };

  return (
    <S.Wrap>
      {data.radar.show && (
        <motion.div
          initial={{ x: 0, opacity: 0 }}
          animate={{ x: 0, opacity: 1 }}
          exit={{ x: 0, opacity: 0 }}
          layout
        >
          <S.Content>
            <S.Camera>
              <S.Header>Dianteiro</S.Header>
              <S.Velocity>
                <strong>{formatVelocity(data.radar.frontal.speed)}</strong>
                <p>velocidade</p>
              </S.Velocity>
              <S.CamList>
                <S.CamOption>
                  <S.Option>Placa:</S.Option>
                  <span>{data.radar.frontal.plate}</span>
                </S.CamOption>
                <S.CamOption>
                  <S.Option>Modelo:</S.Option>
                  <span>{data.radar.frontal.model}</span>
                </S.CamOption>
              </S.CamList>
            </S.Camera>
            <S.Camera>
              <S.Header>Traseiro</S.Header>
              <S.Velocity>
                <strong>{formatVelocity(data.radar.rear.speed)}</strong>
                <p>velocidade</p>
              </S.Velocity>
              <S.CamList>
                <S.CamOption>
                  <S.Option>Placa:</S.Option>
                  <span>{data.radar.rear.plate}</span>
                </S.CamOption>
                <S.CamOption>
                  <S.Option>Modelo:</S.Option>
                  <span>{data.radar.rear.model}</span>
                </S.CamOption>
              </S.CamList>
            </S.Camera>
          </S.Content>
        </motion.div>
      )}
    </S.Wrap>
  );
}
