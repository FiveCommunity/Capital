import * as S from "./styles";

import { useState, useEffect, useContext, useCallback } from "react";

import FocusContext from "../../../contexts/FocusContext";
import { useRequest } from "../../../hooks/useRequest";

import RotationPNG from "../../../assets/images/rotate.png"

export function Rotation({ theme }) {
  const { request } = useRequest();
  const { focus } = useContext(FocusContext);
  const [leftColor, setLeftColor] = useState(theme.colors.shape(0.5));
  const [rightColor, setRightColor] = useState(theme.colors.shape(0.5));

  useEffect(() => {
    window.addEventListener("keydown", handleKey, false);
    window.addEventListener("keyup", endKey, false);
    return () => {
      window.removeEventListener("keydown", handleKey, false);
      window.removeEventListener("keyup", endKey, false);
    };
  });

  const handleRotation = useCallback(
    async (link, data) => {
      await request(link, data);
    },
    [request]
  );

  const handleKey = (event) => {
    if (!focus) {
      if (event.key == "x") {
        handleRotation("Rotation", "up");
      }
      if (event.key == "a") {
        handleRotation("Rotation", "left");
        setLeftColor(theme.colors.primary());
      }
      if (event.key == "d") {
        handleRotation("Rotation", "right");
        setRightColor(theme.colors.primary());
      }
    }
  };

  const endKey = (event) => {
    if (event.key == "a") {
      setLeftColor(theme.colors.shape(0.5));
    }
    if (event.key == "d") {
      setRightColor(theme.colors.shape(0.5));
    }
  };

  return (
    <S.Rotation>
      <span style={{ color: leftColor }}>A</span>
      <img src={RotationPNG} />
      <span style={{ color: rightColor }}>D</span>
    </S.Rotation>
  );
}
