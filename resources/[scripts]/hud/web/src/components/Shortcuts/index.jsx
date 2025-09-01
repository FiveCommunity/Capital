import * as S from "./styles";

import { motion } from "framer-motion";

export function Shortcuts({ shortcuts }) {
  return (
    <motion.div
      initial={{ x: 0, opacity: 0 }}
      animate={{ x: 0, opacity: 1 }}
      exit={{ x: 0, opacity: 0 }}
      layout
    >
      <S.Container>
        <S.Wrap>
          <S.Content>
            <S.ItemsWrap>
              <S.Items>
                <S.Header>
                  <S.Sinal>1</S.Sinal>
                </S.Header>
                <S.Center>
                  {shortcuts.hotbar["1"].item !== "" && (
                    <img
                      src={`http://189.127.164.125/babilonia/gb_inventory/${shortcuts.hotbar["1"].item}.png`}
                    />
                  )}
                </S.Center>
                {shortcuts.hotbar["1"].amount > 0 && (
                  <S.Quantity>
                    <span>{shortcuts.hotbar["1"].amount}x</span>
                  </S.Quantity>
                )}
              </S.Items>
              <S.Items>
                <S.Header>
                  <S.Sinal>2</S.Sinal>
                </S.Header>
                <S.Center>
                  {shortcuts.hotbar["2"].item !== "" && (
                    <img
                      src={`http://189.127.164.125/babilonia/gb_inventory/${shortcuts.hotbar["2"].item}.png`}
                    />
                  )}
                </S.Center>
                {shortcuts.hotbar["2"].amount > 0 && (
                  <S.Quantity>
                    <span>{shortcuts.hotbar["2"].amount}x</span>
                  </S.Quantity>
                )}
              </S.Items>
              <S.Items>
                <S.Header>
                  <S.Sinal>3</S.Sinal>
                </S.Header>
                <S.Center>
                  {shortcuts.hotbar["3"].item !== "" && (
                    <img
                      src={`http://189.127.164.125/babilonia/gb_inventory/${shortcuts.hotbar["3"].item}.png`}
                    />
                  )}
                </S.Center>
                {shortcuts.hotbar["3"].amount > 0 && (
                  <S.Quantity>
                    <span>{shortcuts.hotbar["3"].amount}x</span>
                  </S.Quantity>
                )}
              </S.Items>
              <S.Items>
                <S.Header>
                  <S.Sinal>4</S.Sinal>
                </S.Header>
                <S.Center>
                  {shortcuts.hotbar["4"].item !== "" && (
                    <img
                      src={`http://189.127.164.125/babilonia/gb_inventory/${shortcuts.hotbar["4"].item}.png`}
                    />
                  )}
                </S.Center>
                {shortcuts.hotbar["4"].amount > 0 && (
                  <S.Quantity>
                    <span>{shortcuts.hotbar["4"].amount}x</span>
                  </S.Quantity>
                )}
              </S.Items>
              <S.Items>
                <S.Header>
                  <S.Sinal>5</S.Sinal>
                </S.Header>
                <S.Center>
                  {shortcuts.hotbar["5"].item !== "" && (
                    <img
                      src={`http://189.127.164.125/babilonia/gb_inventory/${shortcuts.hotbar["5"].item}.png`}
                    />
                  )}
                </S.Center>
                {shortcuts.hotbar["5"].amount > 0 && (
                  <S.Quantity>
                    <span>{shortcuts.hotbar["5"].amount}x</span>
                  </S.Quantity>
                )}
              </S.Items>
            </S.ItemsWrap>
          </S.Content>
        </S.Wrap>
      </S.Container>
    </motion.div>
  );
}
