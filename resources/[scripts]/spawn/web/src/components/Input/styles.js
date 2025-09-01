import styled, { css } from "styled-components";

export const Container = styled.div`
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
`;

export const Input = styled.input`
  ${({ theme }) => css`
    width: 23rem;
    height: 2.4rem;

    background-color: ${theme.colors.shape(0.08)};
    border: 2px solid ${theme.colors.shape(0.1)};
    border-radius: 10px;
    outline: 0;

    transition: border-color 0.2s;
    padding: 0 0.8rem;
    color: ${theme.colors.shape()};

    &:focus {
      border-color: ${theme.colors.shape(0.2)};
    }

    &:hover {
      border-color: ${theme.colors.shape(0.2)};
    }

    @media (max-width: 1399px) {
      width: 18rem;
    }

    @media (max-width: 1199px) {
      width: 16rem;
    }
  `}
`;
