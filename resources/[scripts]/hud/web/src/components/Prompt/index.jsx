import { useCallback, useEffect, useRef, useState } from "react";
import * as S from "./styles";
import { useRequest } from "../../hooks/useRequest";
import { motion, AnimatePresence } from "framer-motion";

function Prompt({ questions = [], setQuestions }) {
  const [step, setStep] = useState(0);
  const responses = useRef([]);
  const [response, setResponse] = useState("");
  const textareaRef = useRef();
  const { request } = useRequest();

  useEffect(() => {
    if (textareaRef.current) {
      textareaRef.current.focus();
    }
  });

  const handleClosePrompt = useCallback(() => {
    responses.current = [];
    setStep(0);
    setResponse("");
    request("closePrompt");
    setQuestions([]);
  }, [setResponse, setQuestions, setStep, request]);

  const handleSendPrompt = useCallback(() => {
    request("promptResult", {
      responses: responses.current,
    });
    handleClosePrompt();
  }, [request, responses, handleClosePrompt]);

  const handleChangeQuestion = useCallback(() => {
    if (step < questions.length) {
      responses.current = [...responses.current, response];
      if (step + 1 == questions.length) {
        handleSendPrompt();
      } else {
        setStep((old) => old + 1);
      }
    }
    setResponse("");
  }, [step, response, questions, handleSendPrompt]);

  const handleKeyDown = (e) => {
    if (e.keyCode === 9) handleChangeQuestion();
    if (e.keyCode === 27) handleClosePrompt();
  };

  return (
    <>
      {questions.length > 0 && (
        <AnimatePresence>
          <motion.div
            key="prompt"
            initial={{ x: 0, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            exit={{ x: 0, opacity: 0 }}
            layout
          >
            <S.Container onKeyDown={handleKeyDown}>
              <S.Wrap>
                <S.Form>
                  <S.Header>
                    <S.Title>{questions[step]}</S.Title>
                    {questions.length > 1 && (
                      <S.Steps>
                        {step + 1}/{questions.length}
                      </S.Steps>
                    )}
                  </S.Header>
                  <S.Textarea
                    ref={textareaRef}
                    rows={7}
                    value={response}
                    onChange={(e) => setResponse(e.target.value)}
                  ></S.Textarea>
                  <S.Footer>
                    Utilze [Esc] para cancelar e [Tab] para continuar.
                  </S.Footer>
                </S.Form>
              </S.Wrap>
            </S.Container>
          </motion.div>
        </AnimatePresence>
      )}
    </>
  );
}

export default Prompt;
