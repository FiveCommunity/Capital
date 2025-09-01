import styled, { css } from "styled-components";

export const Wrap = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;

  position: absolute;

  bottom: 0.8rem;
  left: 23rem;

  zoom: 0.9;

  @media (max-width: 1680px) {
    left: 20.5rem;
  }

  @media (max-width: 1600px) {
    left: 19.5rem;
  }

  @media (max-width: 1440px) {
    left: 17.5rem;
  }

  @media (max-width: 1366px) {
    left: 16.5rem;
  }

  @media (max-width: 1280px) {
    left: 15.5rem;
  }

  @media (max-width: 1024px) {
    left: 12rem;
  }

  @media (max-width: 800px) {
    left: 9rem;
    bottom: 0.5rem;
  }
`;

export const Content = styled.div`
  height: 13.5rem;
  display: flex;
  justify-content: space-between;
  flex-direction: column;
  gap: 0.3rem;

  @media (max-height: 1050px) {
    height: 12.8rem;
  }

  @media (max-height: 900px) {
    height: 10rem;
  }

  @media (max-height: 800px) {
    zoom: 0.85;
  }

  @media (max-height: 664px) {
    zoom: 0.7;
  }

  @media (max-height: 600px) {
    zoom: 0.65;
  }
`;

export const Camera = styled.div`
  ${({ theme }) => css`
    width: 29rem;
    height: 7rem;

    display: flex;
    align-items: center;
    gap: 0.2rem;

    background-image: linear-gradient(
      to right,
      ${theme.colors.dark(0.5)},
      transparent
    );

    @media (max-height: 900px) {
      height: 5.6rem;
    }
  `}
`;

export const Header = styled.header`
  ${({ theme }) => css`
    width: 1.5rem;
    height: 100%;

    writing-mode: vertical-lr;
    transform: rotate(180deg);

    display: flex;
    justify-content: center;
    align-items: center;

    color: ${theme.colors.shape()};
    text-transform: uppercase;
    font-size: 0.775rem;
    font-weight: 600;
    letter-spacing: 0.01rem;

    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
  `}
`;

export const Velocity = styled.div`
  ${({ theme }) => css`
    width: 8rem;
    height: 100%;

    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;

    color: ${theme.colors.shape()};
    text-transform: uppercase;

    & > strong {
      font-size: 2.5rem;
    }

    & > p {
      font-size: 0.7rem;
      font-weight: 300;
    }
  `}
`;

export const CamList = styled.ul`
  width: 20rem;
  height: 100%;

  display: flex;
  flex-direction: column;
  align-items: flex-start;
  justify-content: center;
  gap: 0.5rem;

  list-style: none;
`;

export const CamOption = styled.li`
  ${({ theme }) => css`
    width: 80%;
    height: 1.5rem;

    display: flex;
    align-items: center;
    gap: 0.3rem;

    background-image: linear-gradient(
      to right,
      ${theme.colors.dark(0.2)},
      transparent
    );
    border-left: 2px ridge ${theme.colors.primary()};
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;

    padding: 0.5rem;

    & > span {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;

      font-size: 0.7rem;
      text-transform: uppercase;
      letter-spacing: 0.03rem;
      color: ${theme.colors.shape()};
    }
  `}
`;

export const Option = styled.div`
  ${({ theme }) => css`
    text-transform: uppercase;
    font-size: 0.675rem;
    font-weight: 600;
    letter-spacing: 0.03rem;
    color: ${theme.colors.shape()};
  `}
`;
