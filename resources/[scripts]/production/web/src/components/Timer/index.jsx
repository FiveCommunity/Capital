import { useCallback, useContext, useEffect, useState } from "react";
import * as S from "./styles";

import useRequest from "../../hooks/useRequest";
import ProductionContext from "../../contexts/ProductionContext";
import { motion } from "framer-motion";

import { FaClock } from "react-icons/fa";

export function Timer() {
  return (
    <motion.div
      initial={{ y: 0, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      exit={{ y: 0, opacity: 0 }}
      transition={{ duration: 0.3 }}
      layout
    >
      <S.Container>
        <S.HeaderProduction>
          <S.ProductionImage
            src={`http://189.127.164.125/babilonia/gb_inventory/nitro.png`}
          />
          <S.Description>
            <S.ProductionTitle>Nitro</S.ProductionTitle>
            <S.QtdPerProduction>1 unidade(s)</S.QtdPerProduction>
          </S.Description>
        </S.HeaderProduction>
        <S.Timer>
          <FaClock />
          05:00:00
        </S.Timer>
      </S.Container>
    </motion.div>
  );
}
