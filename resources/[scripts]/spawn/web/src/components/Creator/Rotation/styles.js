import styled, { css } from "styled-components";

export const Rotation = styled.div`
  ${({ theme }) => css`
    width: 7rem;
    height: 2.5rem;

    display: flex;
    justify-content: center;
    align-items: center;

    border-radius: 10px;
    gap: 0.9rem;

    background-color: ${theme.colors.shape(0.08)};
    border: 2px solid ${theme.colors.shape(0.1)};

    & > img {
      opacity: 0.3;
    }

    & > span {
      font-weight: 700;
      transition: color 0.3s;
    }

    @media (max-width: 800px) {
      width: 5rem;
      height: 2rem;

      gap: 0.4rem;

      & > img {
        width: 2rem;
      }

      & > span {
        font-size: 0.7rem;
      }
    }
  `}
`;
