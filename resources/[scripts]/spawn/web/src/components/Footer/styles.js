import styled, { css } from "styled-components";

export const Container = styled.div`
  width: 23rem;

  display: flex;
  justify-content: space-between;

  @media (max-width: 1399px) {
    width: 20rem;
  }

  @media (max-width: 1199px) {
    width: 18rem;
  }
`;

export const Previous = styled.button`
  ${({ dontHover, theme }) => css`
    width: 4.5rem;

    font-size: 0.6rem;
    text-transform: uppercase;

    border-radius: 5px;
    background: transparent;
    color: ${theme.colors.shape()};
    padding: 0.4rem 0;

    transition: background-color 0.3s;

    ${(!dontHover &&
      css`
        &:hover {
          cursor: pointer;
          background-color: ${theme.colors.shape(0.3)};
        }
      `) ||
    css`
      opacity: 0.5;
    `}
  `}
`;

export const Next = styled.button`
  ${({ theme }) => css`
    width: 4.5rem;

    font-size: 0.6rem;
    text-transform: uppercase;

    border-radius: 5px;
    background: transparent;
    color: ${theme.colors.shape()};
    padding: 0.4rem 0;

    transition: background-color 0.3s;

    &:hover {
      cursor: pointer;
      background-color: ${theme.colors.primary(0.3)};
    }
  `}
`;

export const Step = styled.span`
  color: ${({ theme }) => theme.colors.shape()};
`;
