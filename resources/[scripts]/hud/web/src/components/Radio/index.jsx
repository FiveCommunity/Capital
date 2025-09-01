import * as S from "./styles";

import { useState, useCallback, useEffect, useRef } from "react";
import { useRequest } from "../../hooks/useRequest";

import { Slider } from "../Slider";
import { LuRadioTower } from "react-icons/lu";
import { IoIosClose } from "react-icons/io";

import { motion } from "framer-motion";

export function Radio({ theme, setRadio, volume, setVolume }) {
  const textareaRef = useRef();
  const { request } = useRequest();
  const [mhz, setMhz] = useState("");

  useEffect(() => {
    if (textareaRef.current) {
      textareaRef.current.focus();
    }
  });

  const formatInput = (e, pattern) => {
    const sanitizedValue = e.target.value.replace(pattern, "");
    setMhz(sanitizedValue);
  };

  const handleFrequency = useCallback(
    async (join) => {
      await request("Frequency", { join: join, mhz: mhz });
    },
    [request]
  );

  const handleClose = useCallback(async () => {
    setRadio(false);
    await request("Close");
  }, [request]);

  const handleKeyDown = (e) => {
    if (e.keyCode === 27) handleClose();
  };

  const handleVolume = useCallback(async () => {
    await request("Volume", volume);
  }, [request]);

  useEffect(() => {
    handleVolume();
  }, [volume]);

  return (
    <motion.div
      initial={{ x: 0, opacity: 0 }}
      animate={{ x: 0, opacity: 1 }}
      exit={{ x: 0, opacity: 0 }}
      layout
    >
      <S.Container onKeyDown={handleKeyDown}>
        <S.Wrap>
          <S.Content>
            <S.Header>
              <S.Title>
                <LuRadioTower />
                <span>Rádio</span>
              </S.Title>
              <IoIosClose onClick={() => handleClose()} />
            </S.Header>
            <S.Frequency>
              <S.Input
                ref={textareaRef}
                placeholder="Insira a frequência..."
                value={mhz}
                onChange={(e) => formatInput(e, /[^0-9]/g)}
              />
            </S.Frequency>
            <Slider
              value={volume}
              setValue={(val) => setVolume(val)}
              min={0}
              max={100}
              step={1}
              ruler={false}
            />
            <S.Buttons>
              <S.Button onClick={() => handleFrequency(false)}>
                desconectar
              </S.Button>
              <S.Button
                style={{
                  opacity: mhz !== "" ? "1.0" : "0.5",
                  color: theme.colors.shape(),
                  backgroundColor: theme.colors.primary(),
                  pointerEvents: mhz !== "" ? "" : "none",
                }}
                onClick={() => handleFrequency(true)}
              >
                conectar
              </S.Button>
            </S.Buttons>
          </S.Content>
        </S.Wrap>
      </S.Container>
    </motion.div>
  );
}
