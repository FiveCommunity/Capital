import * as S from "./styles";

import { BsFillPlayFill } from "react-icons/bs";
import { BsPersonArmsUp } from "react-icons/bs";
import { FaFaceSmile } from "react-icons/fa6";
import { IoEyeSharp } from "react-icons/io5";
import { GiLips } from "react-icons/gi";

import { useContext, useCallback, useEffect } from "react";
import { motion } from "framer-motion";

import CamContext from "../../../contexts/CamContext";
import { useRequest } from "../../../hooks/useRequest";

const cams = [
  {
    cam: "body",
    svg: <BsPersonArmsUp />,
  },
  {
    cam: "head",
    svg: <FaFaceSmile />,
  },
  {
    cam: "eyes",
    svg: <IoEyeSharp />,
  },
  {
    cam: "mouth",
    svg: <GiLips />,
  },
];

export function Cam() {
  const { request } = useRequest();
  const { cam, setCam, handle, setHandle } = useContext(CamContext);

  const anim = {
    ["prev"]: {
      initial: 5,
      exit: -5,
    },
    ["next"]: {
      initial: -5,
      exit: 5,
    },
  };

  const handleChangeCam = useCallback(async () => {
    await request("Cam", cams[cam].cam);
  }, [cam, request]);

  useEffect(() => {
    handleChangeCam();
  }, [cam, handleChangeCam]);

  const handlePrev = () => {
    setCam((old) => {
      setHandle("prev");
      const newValue = old - 1;
      return newValue < 0 ? cams.length - 1 : newValue;
    });
  };

  const handleNext = () => {
    setCam((old) => {
      setHandle("next");
      const newValue = old + 1;
      return newValue === cams.length ? 0 : newValue;
    });
  };

  return (
    <S.Cam>
      <S.Previous onClick={handlePrev}>
        <BsFillPlayFill />
      </S.Previous>

      <S.Circle>
        <motion.div
          key={cams[cam].cam}
          initial={{ x: anim[handle].initial, opacity: 0 }}
          animate={{ x: 0, opacity: 1 }}
          exit={{ x: anim[handle].exit, opacity: 0 }}
          transition={{ duration: 0.2 }}
        >
          <S.SVG>{cams[cam].svg}</S.SVG>
        </motion.div>
      </S.Circle>
      <S.Next onClick={handleNext}>
        <BsFillPlayFill />
      </S.Next>
    </S.Cam>
  );
}
