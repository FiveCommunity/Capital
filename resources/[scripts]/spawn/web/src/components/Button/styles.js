import styled, { css } from "styled-components";

export const Button = styled.button`
  ${({ active, theme }) => css`
    width: 3rem;
    height: 3rem;

    display: flex;
    justify-content: center;
    align-items: center;

    background-color: ${active
      ? theme.colors.primary()
      : theme.colors.shape(0.08)};

    border: 2px solid ${theme.colors.shape(0.1)};
    border-radius: 10px;

    cursor: pointer;
    transition: all 0.3s;

    & > svg {
      color: ${theme.colors.shape()};
      font-size: 1.5rem;
    }

    &:hover {
      background-color: ${theme.colors.primary()};
    }

    &:focus {
      outline: 0;
      border-color: ${theme.colors.shape(0.2)};
    }
  `}
`;
