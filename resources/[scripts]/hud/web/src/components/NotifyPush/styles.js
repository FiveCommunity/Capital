import styled, { css } from "styled-components";

export const Container = styled.div`
  position: absolute;
  width: 100%;
  height: 100vh;
  z-index: 4;
`;

export const Wrap = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: left;
  align-items: center;

  padding: 2rem;

  @media (max-height: 768px) {
    zoom: 0.8;
  }
`;

export const Content = styled.div`
  width: 21rem;
  height: 20rem;

  display: flex;
  flex-direction: column;
  gap: 0.5rem;
`;

export const NotifysWrap = styled.ul`
  width: 100%;
  height: 100%;

  display: flex;
  flex-direction: column;
  gap: 0.5rem;

  overflow-y: scroll;
  overflow-x: hidden;

  list-style: none;
`;

export const Notifys = styled.li`
  ${({ theme }) => css`
    min-height: 80.299px;

    font-family: ${theme.fonts.family.primary};

    background-image: linear-gradient(270deg, rgba(0, 0, 0, 0.80) 0%, rgba(0, 115, 52, 0.80) 100%);
    border-left: 4px ridge #12AC5A;

    position: relative;

    clip-path: url(#notifyleft);
  `}
`;

export const CleanNotifys = styled.button`
  ${({ theme }) => css`
    width: 283.563px;
    height: 33.701px;

    border: 0;

    text-transform: uppercase;
    leading-trim: both;
    font-size: 10.878px;
    font-style: normal;
    font-weight: 800;
    line-height: normal;

    cursor: pointer;
    transition: all 0.2s;

    background-color: #12AC5A;
    color: ${theme.colors.shape()};

    clip-path: url(#notifyleft);

    &:hover {
      background-color: rgba(46, 206, 107, 0.8);
    }

    &:focus {
      outline: 0;
      border: 0;
    }
  `}
`;

export const IconPush = styled.div`
  ${({ theme }) => css`
    display: flex;
    justify-content: center;
    align-items: center;

    padding: 0 0.5rem;

    & > svg {
      font-size: 1.3rem;
      color: ${theme.colors.primary()};
    }
  `}
`;

export const HeaderPush = styled.div`
  width: 100%;

  display: flex;
  justify-content: space-between;
  align-items: center;
`;

export const InfosPush = styled.div`
  ${({ theme }) => css`
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;

    & > span {
      color: ${theme.colors.shape(0.8)};
      font-size: 0.65rem;
    }

    & > svg.close {
      position: absolute;

      top: 3%;
      right: 3%;

      font-size: 0.9rem;

      color: #2266A6;
    }

    & > svg {
      cursor: pointer;

      color: #12AC5A;

      font-size: 0.5rem;
    }
  `}
`;

export const ContentNotifyLeft = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  gap: 0.3rem;
`

export const ContentNotify = styled.div`
  flex: 1;
  display: flex;
  align-items: flex-start;
  justify-content: center;
  flex-direction: column;

  & > strong {
    margin-top: 0.6rem;
    
    color: #12AC5A;
    font-size: 14px;
    font-weight: 600;
    line-height: normal;
    letter-spacing: -0.84px;
  }

  & > p {
    color: #fff;
    font-size: 12px;
    font-weight: 400;
    line-height: normal;
    letter-spacing: -0.48px;
  }
`;

export const ContainerNotify = styled.div`
  width: 100%;

  display: flex;
  justify-content: space-around;
  align-items: flex-start;
  gap: 1rem;

  padding: 1rem;

  & > span {
    position: absolute;

    right: 0.5rem;
    top: 0.5rem;

    font-size: 0.5rem
  }
`;
