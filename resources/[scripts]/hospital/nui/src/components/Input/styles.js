import styled, { css } from "styled-components";

export const WrapInput = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.1)};
    border: 1px solid ${theme.colors.primary(0.2)};
    display: flex;
    align-items: center;
    height: 2rem;
    border-radius: 15px;
    width: 13.6rem;
    padding-left: 0.5rem;

    & > svg {
      color: ${theme.colors.shape()};
    }
  `}
`;

export const Input = styled.input`
  ${({ theme }) => css`
    border-radius: 15px;
    padding: 0.5rem;
    color: ${theme.colors.shape()};
    outline: none;
    font-weight: 100;
    height: 100%;
    flex: 1;
    border: 0;
    background-color: ${theme.colors.dark(0)};
  `}
`;
