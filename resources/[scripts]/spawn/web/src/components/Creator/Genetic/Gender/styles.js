import styled, { css } from "styled-components";

export const Container = styled.div`
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 0.7rem;
`;

export const OptionsList = styled.div`
  display: flex;
  justify-content: flex-start;
  gap: 1rem;
  align-items: center;

  width: 23rem;

  @media (max-width: 1399px) {
    width: 18rem;
  }

  @media (max-width: 1199px) {
    width: 16rem;
  }
`;

export const OptionsButton = styled.div`
  ${({ theme }) => css`
    width: 100%;
    display: flex;
    align-items: center;
    gap: 0.5rem;

    & > span {
      color: ${theme.colors.shape()};
      font-size: 0.8rem;
      font-weight: 300;
    }
  `}
`;

export const Line = styled.div`
  ${({ theme }) => css`
    width: 0.2rem;
    height: 2.8rem;

    background-color: ${theme.colors.shape(0.3)};
  `}
`;
