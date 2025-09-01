import styled, { css } from "styled-components";

export const Container = styled.div`
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
`;

export const Label = styled.label`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    font-size: 0.8rem;
  `}
`;

export const Input = styled.input`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.1)};
    border: 1px solid ${theme.colors.shape(0.1)};
    border-radius: 5px;
    outline: 0;
    height: 35px;
    transition: border-color 0.2s;
    padding: 0 0.5rem;
    color: ${theme.colors.shape()};

    &[disabled] {
      background-color: ${theme.colors.dark(0.1)};
      cursor: not-allowed;
    }

    &:focus {
      border-color: ${theme.colors.shape(0.2)};
    }
  `}
`;
