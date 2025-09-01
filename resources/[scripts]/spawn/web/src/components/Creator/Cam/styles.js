import styled, { css } from "styled-components";

export const Cam = styled.div`
  width: 7rem;
  height: 3rem;

  display: flex;
  justify-content: center;
  align-items: center;

  gap: 0.7rem;
`;

export const Previous = styled.button`
  ${({ theme }) => css`
    cursor: pointer;
    transition: color 0.3s;

    background: transparent;
    border: 0;

    &:focus {
      border: 0;
      outline: 0;
    }

    & > svg {
      transform: rotate(-180deg);
      color: ${theme.colors.shape(0.8)};
      font-size: 1.2rem;

      &:hover {
        color: ${theme.colors.shape(0.5)};
      }
    }
  `}
`;

export const Next = styled.button`
  ${({ theme }) => css`
    cursor: pointer;
    transition: color 0.3s;
    background: transparent;
    border: 0;

    &:focus {
      border: 0;
      outline: 0;
    }

    & > svg {
      color: ${theme.colors.shape(0.8)};
      font-size: 1.2rem;

      &:hover {
        color: ${theme.colors.shape(0.5)};
      }
    }
  `}
`;

export const Circle = styled.div`
  ${({ theme }) => css`
    width: 3rem;
    height: 3rem;

    display: flex;
    justify-content: center;
    align-items: center;

    border-radius: 50%;

    background-color: ${theme.colors.shape(0.08)};
    border: 2px solid ${theme.colors.shape(0.1)};

    @media (max-width: 800px) {
      width: 2.5rem;
      height: 2.5rem;
    }
  `}
`;

export const SVG = styled.div`
  ${({ theme }) => css`
    width: 100%;
    height: 100%;

    display: flex;
    justify-content: center;
    align-items: center;

    & > svg {
      color: ${theme.colors.shape(0.8)};
      font-size: 1.5rem;
    }

    @media (max-width: 800px) {
      & > svg {
        font-size: 1.2rem;
      }
    }
  `}
`;
