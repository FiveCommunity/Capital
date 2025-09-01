import styled, { createGlobalStyle, css } from "styled-components";
import { theme } from "./theme";

export const GlobalStyle = createGlobalStyle`
    * {
        margin: 0;
        padding: 0;
        outline: 0;
        box-sizing: border-box;
        user-select: none;

        font-synthesis: none;
        text-rendering: optimizeLegibility;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        -webkit-text-size-adjust: 100%;
    }

    body {
        margin: 0;
        padding: 0;
        background-size: cover;
    }

    body, input, textarea, button, select {
        font-family: ${theme.fontFamily};
        outline: 0;
    }

    *::-webkit-scrollbar {
      width: 3px;
      background-color: rgba(0, 0, 0, 0.5);
    }

    *::-webkit-scrollbar-track {
      box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
    }

    *::-webkit-scrollbar-thumb {
      background-color: ${theme.colors.primary};
    }
`;

export const Page = styled.section`
  background-color: ${theme.colors.secondary};
  width: 100%;
  height: 100%;
`;

export const Card = styled.div`
  background-color: rgba(0, 0, 0, 0.3);
  width: 100%;
  padding: 15px;
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
  border-radius: 10px;
  display: flex;
`;

export const Input = styled.input`
  background-color: rgba(255, 255, 255, 0.03);
  width: 100%;
  height: 35px;
  border-radius: 5px;
  border: 0;
  padding: 0 10px;
  color: white;
`;

export const Textarea = styled.textarea`
  background-color: rgba(255, 255, 255, 0.03);
  width: 100%;
  border-radius: 5px;
  border: 0;
  padding: 10px;
  color: white;
  resize: none;
`;

export const Select = styled.select`
  background-color: rgba(255, 255, 255, 0.03);
  width: 100%;
  height: 35px;
  border-radius: 5px;
  border: 0;
  padding: 0 10px;
  color: white;

  & > option {
    background-color: ${theme.colors.secondary};
    color: white;
    height: 30px;
  }
`;

export const ActionButton = styled.button`
  background-color: rgba(0, 0, 0, 0.3);
  height: 30px;
  width: 100%;
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
  color: white;
  font-size: 14px;
  font-weight: normal;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 10px;
  justify-content: center;
  border: 0;
  transition: all 0.2s;
  border-radius: 5px;

  &.small-rounded {
    font-size: 15px;
    height: 25px;
    width: 25px;
    border-radius: 50%;
  }

  &.full-w {
    flex: 1;
  }

  &:hover {
    background-color: ${theme.colors.primary};
  }

  &:disabled {
    cursor: not-allowed;
  }

  &:disabled:hover {
    background-color: rgba(0, 0, 0, 0.3);
  }
`;

export const Title = styled.h2`
  color: white;
  font-size: 14px;
  display: flex;
  align-items: center;
  gap: 5px;

  & > svg {
    color: ${theme.colors.primary};
    font-size: 16px;
  }
`;

export const Table = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  gap: 10px;
  max-height: 500px;
  overflow-x: hidden;
  overflow-y: auto;
  padding-right: 10px;

  &::-webkit-scrollbar {
    width: 3px;
    background-color: rgba(0, 0, 0, 0.5);
  }

  &::-webkit-scrollbar-track {
    box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
  }

  &::-webkit-scrollbar-thumb {
    background-color: ${theme.colors.primary};
  }
`;

export const Row = styled.div`
  background-color: rgba(0, 0, 0, 0.3);
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
  width: 100%;
  height: 50px;
  min-height: 50px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-radius: 10px;
  padding: 0 20px;
  gap: 20px;
  cursor: pointer;
  transition: all 0.2s;

  &.headRow {
    pointer-events: none;
    background-color: transparent;
    box-shadow: none;
    border-bottom: 1px solid #333;
    border-radius: 0;
    color: white;
  }

  &:hover {
    background-color: rgba(0, 0, 0, 0.1);
  }
`;

type ColumnProp = {
  flex?: number;
};

export const Column = styled.div<ColumnProp>`
  ${({ flex }) => css`
    ${flex ? `flex: ${flex};` : `flex: 1;`}
  `}
  color: white;
  font-size: 12px;
  display: flex;
  align-items: center;
  gap: 5px;
  color: #ddd;
  border-right: 1px solid #222;

  &:last-child {
    border: 0;
  }

  & > svg {
    font-size: 16px;
    color: ${theme.colors.primary};
  }
`;

export const Divider = styled.hr`
  border: 0;
  border-bottom: 1px solid #333;
`;

export const Side = styled.div`
  width: 30%;
  display: flex;
  flex-direction: column;
  gap: 10px;
`;

export const BtnInLine = styled.div`
  display: flex;
  width: 100%;
  justify-content: space-between;
  gap: 10px;
  align-items: center;
`;

export * from "./theme";
