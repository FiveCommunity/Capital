import * as S from "./styles";

import { useCallback, useEffect, useRef } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { useRequest } from "../../hooks/useRequest";
import { AiOutlineCopy } from "react-icons/ai";

function Clipboard({ clipboard, setClipboard }) {
  const textareaRef = useRef();
  const { request } = useRequest();

  useEffect(() => {
    if (textareaRef.current) {
      textareaRef.current.focus();
      textareaRef.current.select();
    }
  });

  const handleCloseClipboard = useCallback(() => {
    request("Close");
    setClipboard([]);
  }, [request, setClipboard]);

  const handleKeyDown = (e) => {
    if (e.keyCode === 27) handleCloseClipboard();
  };

  return (
    <>
      {clipboard.title && (
        <AnimatePresence>
          <motion.div
            key="clipboard"
            initial={{ x: 0, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            exit={{ x: 0, opacity: 0 }}
            layout
          >
            <S.Container onKeyDown={handleKeyDown}>
              <S.Wrap>
                <S.Form>
                  <S.Header>
                    <S.Title>{clipboard.title}</S.Title>
                    <S.IconCopy>
                      <AiOutlineCopy />
                    </S.IconCopy>
                  </S.Header>
                  <S.Textarea
                    ref={textareaRef}
                    rows={7}
                    value={clipboard.value}
                  ></S.Textarea>
                  <S.Footer>Utilze [Esc] para cancelar.</S.Footer>
                </S.Form>
              </S.Wrap>
            </S.Container>
          </motion.div>
        </AnimatePresence>
      )}
    </>
  );
}

export default Clipboard;
