import * as S from "./styles";

import { motion } from "framer-motion";

export function NotifyItems({ items }) {
  return (
    <S.Container>
      <S.Wrap>
        <S.Content>
          <S.ItemsWrap>
            {items.map((data, index) => (
              <motion.div
                key={index}
                initial={{ x: 0, opacity: 0 }}
                animate={{ x: 0, opacity: 1 }}
                exit={{ x: 0, opacity: 0 }}
                layout
              >
                <S.Items key={index}>
                  <S.Header>
                    <S.Sinal>{data.type === "retired" ? "-" : "+"}</S.Sinal>
                    <S.Quantity>
                      <span>{data.amount}x</span>
                    </S.Quantity>
                  </S.Header>
                  <S.Center>
                    <img
                      src={`http://189.127.164.125/babilonia/gb_inventory/${data.index}.png`}
                    />
                  </S.Center>
                  <S.Name>
                    <strong>{data.item}</strong>
                  </S.Name>
                </S.Items>
              </motion.div>
            ))}
          </S.ItemsWrap>
        </S.Content>
      </S.Wrap>
    </S.Container>
  );
}
