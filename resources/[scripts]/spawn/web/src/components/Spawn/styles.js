import styled, { css, keyframes } from "styled-components";

const bounceAnimation = keyframes`
  0%   { transform: translateY(0); }
  50%  { transform: translateY(-10px); }
  100% { transform: translateY(0); }
`;

export const Wrap = styled.div`
  ${({ theme }) => css`
    width: 100%;
    height: 100%;

    background-image: url("http://189.127.164.170/capital/wallpaper.png");
    background-size: cover;

    position: absolute;

    display: flex;
    justify-content: flex-start;
  `}
`;

export const Filter = styled.div`
  ${({ theme }) => css`
    width: 100%;
    height: 100%;

    background-color: ${theme.colors.dark(0.3)};
    backdrop-filter: blur(3px);

    position: absolute;
    z-index: 1;

    display: flex;
    justify-content: flex-start;
  `}
`;

export const Left = styled.div`
  ${({ theme }) => css`
    width: 35rem;
    height: 100%;

    display: flex;
    justify-content: flex-start;
    align-items: center;

    background-image: linear-gradient(
      to right,
      ${theme.colors.dark(0.95)},
      ${theme.colors.dark(0.8)},
      ${theme.colors.dark(0.7)},
      ${theme.colors.dark(0.6)},
      ${theme.colors.dark(0.4)},
      transparent
    );

    z-index: 2;

    @media (max-width: 1700px) {
      width: 30rem;
    }

    @media (max-width: 1280px) {
      width: 25rem;
    }

    @media (max-width: 1000px) {
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

  @media (max-width: 1700px) {
    padding: 10rem 3.5rem;
  }

  @media (max-width: 1280px) {
    padding: 10rem 3rem;
  }

  @media (max-width: 1100px) {
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
      font-size: 4rem;
      font-weight: 700;
      line-height: 4.5rem;
      text-transform: uppercase;

      color: ${theme.colors.shape()};
    }

    & > span {
      font-size: 1.15rem;
      font-weight: 300;

      color: ${theme.colors.shape(0.5)};
    }

    @media (max-width: 1700px) {
      & > h1 {
        font-size: 3.4rem;
        line-height: 4rem;
      }

      & > span {
        font-size: 0.975rem;
      }
    }

    @media (max-width: 1280px) {
      & > h1 {
        font-size: 3rem;
        line-height: 3.5rem;
      }

      & > span {
        font-size: 0.87rem;
      }
    }

    @media (max-width: 1100px) {
      & > h1 {
        font-size: 3.2rem;
        line-height: 3.5rem;
      }

      & > span {
        font-size: 0.93rem;
      }
    }

    @media (max-width: 1000px) {
      & > h1 {
        font-size: 2.6rem;
        line-height: 3rem;
      }

      & > span {
        font-size: 0.748rem;
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

export const OthersSpawnWrap = styled.ul`
  width: 100%;
  height: 100%;

  display: flex;
  justify-content: flex-start;
  flex-direction: column;
  gap: 1rem;

  list-style: none;
`;

export const OthersSpawn = styled.li`
  ${({ theme }) => css`
    width: 23rem;
    min-height: 4.5rem;

    display: flex;
    align-items: center;

    padding: 0 1.5rem 0 1rem;

    background-color: ${theme.colors.dark(0.5)};
    border-radius: 10px;
    border: 2px solid ${theme.colors.shape(0.1)};

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

    @media (max-width: 1700px) {
      width: 20rem;
    }

    @media (max-width: 1280px) {
      width: 17.5rem;
    }

    @media (max-width: 1100px) {
      width: 19rem;
    }

    @media (max-width: 1000px) {
      width: 15rem;
    }
  `}
`;

export const Home = styled.div`
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
  `}
`;

export const Center = styled.div`
  width: calc(100% - 35rem);
  height: 100%;

  display: flex;
  justify-content: center;
  align-items: center;

  padding: 7rem 3rem;

  z-index: 3;

  @media (max-width: 1700px) {
    width: calc(100% - 30rem);
  }

  @media (max-width: 1280px) {
    width: calc(100% - 25rem);
  }

  @media (max-width: 1100px) {
    padding: 7rem 2rem;
  }

  @media (max-width: 1000px) {
    width: calc(100% - 20rem);
  }
`;

export const ResponsiveCenter = styled.div`
  width: 100%;
  height: 100%;

  display: flex;
  justify-content: center;
  align-items: center;

  position: relative;
`;

export const Wallpaper = styled.img`
  ${({ theme }) => css`
    width: 100%;
    height: 100%;

    border-radius: 10px;
    border: 2px solid ${theme.colors.shape(0.1)};

    box-shadow: 0 2px 10px ${theme.colors.dark(0.5)};
  `}
`;

export const Location = styled.div`
  display: flex;
  align-items: center;
  flex-direction: column;

  gap: 0.5rem;

  position: absolute;

  &.LosSantos {
    right: 18.8%;
    bottom: 43.5%;

    @media (max-width: 1700px) {
      right: 17.5%;
    }

    @media (max-width: 1550px) {
      right: 16.5%;
    }

    @media (max-width: 1440px) {
      right: 15.5%;
    }

    @media (max-width: 1366px) {
      right: 17%;
    }

    @media (max-width: 1100px) {
      right: 16%;
    }

    @media (max-width: 800px) {
      right: 13%;
    }
  }

  &.SandyShores {
    right: 46%;
    bottom: 47.5%;

    @media (max-width: 1700px) {
      right: 45%;
    }

    @media (max-width: 1550px) {
      right: 44%;
    }

    @media (max-width: 1440px) {
      right: 43%;
    }

    @media (max-width: 1366px) {
      right: 44%;
    }

    @media (max-width: 1100px) {
      right: 43%;
    }

    @media (max-width: 800px) {
      right: 40%;
    }
  }

  &.PaletoBay {
    left: 12%;
    bottom: 37%;

    @media (max-width: 1700px) {
      left: 11%;
    }

    @media (max-width: 1550px) {
      left: 10%;
    }

    @media (max-width: 1440px) {
      left: 9%;
    }

    @media (max-width: 1366px) {
      left: 10%;
    }

    @media (max-width: 1100px) {
      left: 9%;
    }

    @media (max-width: 800px) {
      left: 6%;
    }
  }

  &:hover {
    animation-duration: 1s;
    animation-iteration-count: infinite;
    transform-origin: bottom;
    animation-name: ${bounceAnimation};
    animation-timing-function: ease;
  }

  @media (max-width: 1366px) {
    zoom: 0.8;
  }

  @media (max-width: 1100px) {
    zoom: 0.7;
  }

  @media (max-width: 800px) {
    zoom: 0.6;
  }
`;

export const ButtonLocation = styled.button`
  ${({ theme }) => css`
    height: 2rem;

    padding: 0 2rem;

    text-transform: uppercase;
    font-weight: 700;
    font-size: 1rem;

    border-radius: 10px;
    border: 0;
    outline: 0;

    background-color: transparent;
    background-image: linear-gradient(
      to left,
      ${theme.colors.shape(0.8)},
      ${theme.colors.shape(1)},
      ${theme.colors.shape(0.8)}
    );

    box-shadow: 0 2px 10px ${theme.colors.dark(0.5)};

    cursor: pointer;
    transition: background-image 0.3s;

    &:hover {
      background-color: ${theme.colors.shape(0.7)};
    }

    color: ${theme.colors.primary(0.9)};
  `}
`;

export const LocationPointer = styled.div`
  ${({ theme }) => css`
    width: 0.8rem;
    height: 0.8rem;

    background-color: transparent;
    background-image: linear-gradient(
      to left,
      ${theme.colors.shape(0.8)},
      ${theme.colors.shape(1)},
      ${theme.colors.shape(0.8)}
    );

    box-shadow: 0 2px 10px ${theme.colors.dark(0.5)};

    border-radius: 50%;
  `}
`;

export const LastLocation = styled.button`
  ${({ theme }) => css`
    width: 13rem;
    height: 2.5rem;

    position: absolute;
    bottom: 2%;

    text-transform: uppercase;
    font-weight: 700;
    font-size: 1rem;

    border-radius: 10px;
    border: 0;
    outline: 0;

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

    color: ${theme.colors.shape(0.9)};

    @media (max-width: 1366px) {
      zoom: 0.8;
    }

    @media (max-width: 1100px) {
      zoom: 0.7;
    }

    @media (max-width: 800px) {
      zoom: 0.6;
    }
  `}
`;
