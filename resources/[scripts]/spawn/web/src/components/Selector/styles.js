import styled, { css } from "styled-components";

export const Left = styled.div`
  ${({ theme }) => css`
    width: 38rem;
    height: 100%;

    background-image: linear-gradient(
      to right,
      ${theme.colors.dark(0.95)},
      ${theme.colors.dark(0.8)},
      ${theme.colors.dark(0.7)},
      ${theme.colors.dark(0.6)},
      ${theme.colors.dark(0.4)},
      transparent
    );

    display: flex;
    justify-content: flex-start;
    align-items: center;

    @media (max-width: 1700px) {
      width: 35rem;
    }

    @media (max-width: 1500px) {
      width: 30rem;
    }

    @media (max-width: 1050px) {
      width: 25rem;
    }

    @media (max-width: 950px) {
      width: 20rem;
    }
  `}
`;

export const Main = styled.main`
  width: 100%;
  height: 100%;

  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 1rem;

  padding: 10rem 5rem;

  @media (max-width: 1500px) {
    padding: 10rem 3rem;
  }

  @media (max-width: 950px) {
    padding: 10rem 2rem;
  }
`;

export const Header = styled.header`
  ${({ theme }) => css`
    display: flex;
    flex-direction: column;

    gap: 0.2rem;
    letter-spacing: 0.02rem;

    & > h1 {
      font-size: 3rem;
      font-weight: 700;
      line-height: 3.5rem;
      text-transform: uppercase;

      color: ${theme.colors.shape()};
    }

    & > span {
      font-size: 0.875rem;
      font-weight: 300;

      color: ${theme.colors.shape(0.5)};
    }

    @media (max-width: 1500px) {
      & > h1 {
        font-size: 2.7rem;
      }

      & > span {
        font-size: 0.75rem;
      }
    }

    @media (max-width: 1050px) {
      & > h1 {
        font-size: 2rem;
        line-height: 2.5rem;
      }

      & > span {
        font-size: 0.58rem;
      }
    }

    @media (max-width: 950px) {
      & > h1 {
        font-size: 1.85rem;
      }

      & > span {
        font-size: 0.54rem;
      }
    }
  `}
`;

export const Content = styled.div`
  width: 100%;
  height: 27rem;

  overflow-y: scroll;
  overflow-x: hidden;
`;

export const CharactersWrap = styled.ul`
  width: 100%;
  height: 100%;

  display: flex;
  justify-content: flex-start;
  flex-direction: column;
  gap: 1rem;

  list-style: none;
`;

export const Characters = styled.li`
  ${({ theme, selected }) => css`
    width: 23rem;
    min-height: 4.5rem;

    display: flex;
    align-items: center;

    padding: 0 1.5rem 0 1rem;

    background-color: ${theme.colors.dark(0.5)};
    border-radius: 10px;
    border: 2px solid
      ${selected ? theme.colors.primary() : theme.colors.shape(0.1)};

    cursor: pointer;
    transition: border-color 0.3s;

    &:hover {
      border-color: ${theme.colors.primary()};
    }

    & > strong {
      font-size: 0.9rem;
      color: ${theme.colors.shape()};
    }

    & > svg {
      font-size: 1.2rem;
      color: ${theme.colors.shape()};
    }

    @media (max-width: 1500px) {
      width: 20rem;
    }

    @media (max-width: 1050px) {
      width: 16rem;
    }

    @media (max-width: 950px) {
      width: 14rem;
    }
  `}
`;

export const User = styled.div`
  ${({ theme }) => css`
    width: 100%;
    height: 100%;

    display: flex;
    justify-content: center;
    flex-direction: column;
    gap: 0.2rem;

    letter-spacing: 0.01rem;

    & > span {
      color: ${theme.colors.shape(0.5)};
      font-size: 0.7rem;
    }

    & > strong {
      color: ${theme.colors.shape()};
      font-size: 0.875rem;
    }

    @media (max-width: 1050px) {
      & > span {
        font-size: 0.6rem;
      }

      & > strong {
        font-size: 0.7rem;
      }
    }
  `}
`;

export const Center = styled.div`
  width: calc(100% - 76rem);
  height: 100%;

  display: flex;
  align-items: flex-end;
  justify-content: center;

  padding: 2rem 0;

  @media (max-width: 1700px) {
    width: calc(100% - 70rem);
  }

  @media (max-width: 1500px) {
    width: calc(100% - 60rem);
  }

  @media (max-width: 1050px) {
    width: calc(100% - 50rem);
  }

  @media (max-width: 950px) {
    width: calc(100% - 40rem);
  }
`;

export const ButtonPlay = styled.button`
  ${({ theme }) => css`
    width: 12rem;
    height: 3.5rem;

    border: 0;
    border-radius: 10px;

    color: ${theme.colors.shape(0.9)};
    font-weight: 700;
    font-size: 1.5rem;

    background-image: linear-gradient(
      to left,
      ${theme.colors.primary(0.9)},
      ${theme.colors.primary(1)},
      ${theme.colors.primary(0.9)}
    );

    box-shadow: 0 2px 10px ${theme.colors.dark(0.5)};

    cursor: pointer;
    transition: background-image 0.3s;

    &:hover {
      background-color: ${theme.colors.primary(1)};
    }

    @media (max-width: 1200px) {
      width: 8rem;
      height: 3rem;

      font-size: 1.2rem;
    }

    @media (max-width: 950px) {
      width: 6rem;
      font-size: 1rem;
    }
  `}
`;
