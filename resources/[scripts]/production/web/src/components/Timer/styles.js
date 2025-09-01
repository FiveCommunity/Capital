import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    width: 20rem;

    background-color: ${theme.colors.dark(0.8)};
    background-image: linear-gradient(
      to right top,
      ${theme.colors.primary(0.2)},
      ${theme.colors.dark(0.5)}
    );

    border-radius: 10px;

    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    gap: 0.5rem;

    padding: 1rem;
  `}
`;

export const HeaderProduction = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.3)};
    border: 1px solid ${theme.colors.shape(0.1)};
    padding: 0.5rem;
    border-radius: 5px;
    width: 100%;
    height: 6rem;
    gap: 1rem;
    display: flex;
    align-items: center;

    &.p-item {
      background-color: ${theme.colors.shape(0.05)};
      & > img {
        background-color: ${theme.colors.shape(0.05)};
      }
    }
  `}
`;

export const ProductionImage = styled.img`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.03)};
    border: 1px solid ${theme.colors.shape(0.1)};
    border-radius: 5px;
    width: 75px;
    height: 75px;
    padding: 0.5rem;
  `}
`;

export const ProductionTitle = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
  `}
`;

export const Description = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
`;

export const QtdPerProduction = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.shape(0.5)};
    font-size: 0.9rem;
    font-weight: 300;
  `}
`;

export const Timer = styled.div`
  ${({ theme }) => css`
    display: flex;
    justify-content: center;
    align-items: center;

    color: ${theme.colors.shape()};
    font-size: 0.9rem;
    font-weight: 300;

    & > svg {
      margin-right: 0.5rem;
    }
  `}
`;
