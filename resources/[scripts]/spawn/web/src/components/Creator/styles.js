import styled, { css } from "styled-components";

export const WrapLeft = styled.div`
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

    @media (max-width: 1399px) {
      width: 30rem;
    }

    @media (max-width: 1100px) {
      width: 25rem;
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

  padding: 5rem 0;
`;

export const MainRight = styled.main`
  width: 100%;
  height: 100%;

  display: flex;
  flex-direction: column;
  align-items: flex-end;

  gap: 1rem;

  padding: 5rem 5rem;

  @media (max-width: 1399px) {
    padding: 5rem 4rem;
  }

  @media (max-width: 1100px) {
    padding: 5rem 3.5rem;
  }

  @media (max-width: 800px) {
    padding: 5rem 2.5rem;
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

    @media (max-width: 1399px) {
      & > h1 {
        font-size: 2.7rem;
      }
    }

    @media (max-width: 1199px) {
      & > h1 {
        line-height: 2.2rem;
        font-size: 2rem;
      }
    }

    @media (max-width: 800px) {
      & > span {
        font-size: 0.775rem;
      }
    }
  `}
`;

export const Side = styled.aside`
  width: 20%;
  height: 100%;
`;

export const Line = styled.li`
  ${({ theme }) => css`
    height: 2.2rem;
    border: 0.5px dashed ${theme.colors.shape(0.3)};

    @media (max-height: 900px) {
      height: 2.2rem;
    }

    @media (max-height: 850px) {
      height: 2.2rem;
    }

    @media (max-height: 750px) {
      height: 2.2rem;
    }

    @media (max-height: 700px) {
      height: 2.2rem;
    }

    @media (max-height: 650px) {
      height: 0.8rem;
    }
  `}
`;

export const CategoryList = styled.ul`
  width: 100%;
  height: 100%;

  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  list-style: none;

  @media (min-width: 1440px) {
    padding: 15rem 0;
    justify-content: flex-start;
  }
`;

export const CategoryButton = styled.li`
  ${({ active, theme }) => css`
    transition: background-color 0.3s;

    width: 2rem;
    height: 2rem;
    border-radius: 50%;

    border: 1px solid rgba(255, 255, 255, 0.3);
    background-color: ${active
      ? theme.colors.primary()
      : theme.colors.dark(0.5)};

    display: flex;
    align-items: center;
    justify-content: center;

    & > svg {
      font-size: 0.875rem;
      color: ${theme.colors.shape()};
    }

    @media (max-width: 800px) {
      width: 1.5rem;
      height: 1.5rem;

      & > svg {
        font-size: 0.8rem;
      }
    }

    @media (max-height: 900px) {
      width: 1.5rem;
      height: 1.5rem;

      & > svg {
        font-size: 0.8rem;
      }
    }
  `}
`;

export const CategoryWrap = styled.ul`
  width: 100%;
  height: 100%;
`;

export const Center = styled.div`
  width: calc(100% - 76rem);
  height: 100%;

  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;

  padding: 2rem;

  @media (max-width: 1399px) {
    width: calc(100% - 60rem);
  }

  @media (max-width: 1100px) {
    width: calc(100% - 50rem);
  }
`;

export const WrapRight = styled.div`
  ${({ theme }) => css`
    width: 38rem;
    height: 100%;

    background-image: linear-gradient(
      to left,
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

    @media (max-width: 1399px) {
      width: 30rem;
    }

    @media (max-width: 1100px) {
      width: 25rem;
    }
  `}
`;

export const Notify = styled.div`
  width: 100%;
  height: 100%;

  position: absolute;

  z-index: 999;

  display: flex;
  justify-content: center;
  align-items: center;
`;

export const WrapColor = styled.div`
  width: 23rem;

  display: flex;
  align-items: flex-end;
  flex-direction: column;
`;

export const Colors = styled.ul`
  width: 100%;

  margin: 2rem 0;
  list-style: none;

  display: flex;
  justify-content: flex-end;
  flex-wrap: wrap;
  gap: 0.7rem;

  @media (max-width: 1199px) {
    width: 80%;
  }

  @media (max-width: 1100px) {
    width: 72%;
  }

  @media (max-height: 700px) {
    height: 18rem;

    border-radius: 10px;
    padding-right: 1rem;

    overflow-y: scroll;
    overflow-x: visible;
  }

  @media (max-height: 600px) {
    height: 17 rem;
    margin: 2rem 0 1rem 0;
  }
`;

export const Option = styled.div`
  ${({ bgColor, active, theme }) => css`
    background-color: ${bgColor};

    width: 2rem;
    height: 2rem;

    display: flex;
    align-items: center;
    justify-content: center;

    border-radius: 10px;
    cursor: pointer;

    transition: opacity 0.3s;

    &:hover {
      opacity: 0.7;
    }

    & > svg {
      font-size: 1.3rem;
      color: ${theme.colors.shape()};
    }

    ${active && `border: 1px solid ${theme.colors.shape()}`}
  `}
`;

export const ConfirmButton = styled.div`
  width: 100%;

  display: flex;
  justify-content: center;
  align-items: center;

  @media (max-width: 1199px) {
    width: 80%;
  }

  @media (max-width: 1100px) {
    width: 72%;
  }
`;

export const Button = styled.button`
  ${({ theme }) => css`
    width: 2rem;
    height: 2rem;

    display: flex;
    justify-content: center;
    align-items: center;

    border-radius: 50%;
    outline: 0;
    border: 0;

    cursor: pointer;
    transition: background-color 0.3s;
    background-color: ${theme.colors.shape(0.8)};

    & > svg {
      font-size: 1.2rem;
    }

    &:hover {
      background-color: ${theme.colors.shape(0.6)};
    }
  `}
`;
