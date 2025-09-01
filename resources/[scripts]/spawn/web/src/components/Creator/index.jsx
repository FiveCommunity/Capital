import * as S from "./styles";

import { FaDna } from "react-icons/fa";
import { FaPerson } from "react-icons/fa6";
import { IoEyeSharp } from "react-icons/io5";
import { GiNoseFront } from "react-icons/gi";
import { MdFaceRetouchingNatural } from "react-icons/md";
import { FaRegFaceKissBeam } from "react-icons/fa6";
import { TbFaceId } from "react-icons/tb";
import { IoCheckmarkOutline } from "react-icons/io5";
import { IoIosCheckmarkCircle } from "react-icons/io";
import { GiComb } from "react-icons/gi";

import { Genetic } from "./Genetic";
import { Skin } from "./Skin";
import { Eyes } from "./Eyes";
import { Nose } from "./Nose";
import { Chin } from "./Chin";
import { Cheek } from "./Cheek";
import { Barber } from "./Barber";
import { Aspect } from "./Aspect";
import { Cam } from "./Cam";
import { Rotation } from "./Rotation";
import { Alert } from "./Alert";

import { motion } from "framer-motion";

import CategoryContext from "../../contexts/CategoryContext";
import ColorPickerContext from "../../contexts/ColorPickerContext";
import AlertContext from "../../contexts/AlertContext";

import { useContext } from "react";

export function Creator({ theme }) {
  const { alert } = useContext(AlertContext);
  const { category } = useContext(CategoryContext);
  const {
    colorDiv,
    colorDescription,
    colors,
    handleColor,
    colorSelected,
    setColorSelected,
    colorActual,
    colorActualId,
  } = useContext(ColorPickerContext);

  return (
    <>
      {/* NOTIFICAÇÃO */}

      {alert && (
        <S.Notify>
          <Alert />
        </S.Notify>
      )}

      {/* CONTEÚDO ESQUERDA */}
      <S.WrapLeft style={{ opacity: !alert ? `1` : `0.5` }}>
        <S.Side>
          <S.CategoryList>
            <S.CategoryButton active={category.name === "genetic"}>
              <FaDna />
            </S.CategoryButton>
            <S.Line />
            <S.CategoryButton active={category.name === "skin"}>
              <FaPerson />
            </S.CategoryButton>
            <S.Line />
            <S.CategoryButton active={category.name === "eyes"}>
              <IoEyeSharp />
            </S.CategoryButton>
            <S.Line />
            <S.CategoryButton active={category.name === "nose"}>
              <GiNoseFront />
            </S.CategoryButton>
            <S.Line />
            <S.CategoryButton active={category.name === "chin"}>
              <MdFaceRetouchingNatural />
            </S.CategoryButton>
            <S.Line />
            <S.CategoryButton active={category.name === "cheek"}>
              <FaRegFaceKissBeam />
            </S.CategoryButton>
            <S.Line />
            <S.CategoryButton active={category.name === "aspect"}>
              <TbFaceId />
            </S.CategoryButton>
            <S.Line />
            <S.CategoryButton active={category.name === "barber"}>
              <GiComb />
            </S.CategoryButton>
          </S.CategoryList>
        </S.Side>
        <S.Main>
          <S.Header>
            <h1>
              Criação de <br /> Personagem
            </h1>
            <span>Bem-vindo, reserve um tempo para criar!</span>
          </S.Header>

          <S.CategoryWrap>
            {category.name === "genetic" && <Genetic theme={theme} />}
            {category.name === "skin" && <Skin theme={theme} />}
            {category.name === "eyes" && <Eyes theme={theme} />}
            {category.name === "nose" && <Nose theme={theme} />}
            {category.name === "chin" && <Chin theme={theme} />}
            {category.name === "cheek" && <Cheek theme={theme} />}
            {category.name === "aspect" && <Aspect theme={theme} />}
            {category.name === "barber" && <Barber theme={theme} />}
          </S.CategoryWrap>
        </S.Main>
      </S.WrapLeft>
      {/* CONTEÚDO MEIO */}
      <S.Center style={{ opacity: !alert ? `1` : `0.5` }}>
        <Cam />
        <Rotation theme={theme} />
      </S.Center>
      {/* CONTEÚDO DIREITA */}
      <S.WrapRight style={{ opacity: !alert ? `1` : `0.5` }}>
        {colorDiv === true && (
          <S.MainRight>
            <motion.div
              initial={{ y: 0, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              exit={{ y: 0, opacity: 0 }}
              transition={{ duration: 0.3 }}
              layout
            >
              <S.Header style={{ direction: "rtl" }}>
                <h1>
                  Selecione <br /> uma Cor
                </h1>
                <span>{colorDescription}</span>
              </S.Header>
              <S.WrapColor>
                <S.Colors>
                  {colors.map((option, index) => (
                    <S.Option
                      key={index}
                      onClick={() =>
                        setColorSelected((old) => ({
                          ...old,
                          [colorActualId]: {
                            0: index,
                            1: option.index,
                            2: option.color_type,
                          },
                        }))
                      }
                      bgColor={option.hex}
                      active={
                        index ===
                        (colorSelected[colorActualId] &&
                        colorSelected[colorActualId][0] >= 0
                          ? colorSelected[colorActualId][0]
                          : colorActual)
                      }
                    >
                      {index ===
                        (colorSelected[colorActualId] &&
                        colorSelected[colorActualId][0] >= 0
                          ? colorSelected[colorActualId][0]
                          : colorActual) && <IoIosCheckmarkCircle />}
                    </S.Option>
                  ))}
                </S.Colors>
                <S.ConfirmButton>
                  <S.Button onClick={handleColor}>
                    <IoCheckmarkOutline />
                  </S.Button>
                </S.ConfirmButton>
              </S.WrapColor>
            </motion.div>
          </S.MainRight>
        )}
      </S.WrapRight>
    </>
  );
}
