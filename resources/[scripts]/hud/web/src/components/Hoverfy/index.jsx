import * as S from "./styles";

import { motion } from "framer-motion";

export function Hoverfy({ hoverfy }) {
  return (
    <motion.div
      initial={{ x: 0, opacity: 0 }}
      animate={{ x: 0, opacity: 1 }}
      exit={{ x: 0, opacity: 0 }}
      layout
    >
      <S.Wrap>
        <S.Content>
          <S.Key>{hoverfy.key}</S.Key>
          <S.Text>{hoverfy.text}</S.Text>
        </S.Content>
      </S.Wrap>
    </motion.div>
  );
}
