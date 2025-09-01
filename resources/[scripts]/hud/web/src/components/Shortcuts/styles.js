import styled, { css } from "styled-components";

export const Container = styled.div`
  position: absolute;
  top: 0;
  left: 0;
  height: 100vh;
  width: auto;
  z-index: 4;

  display: flex;
  align-items: center;
  padding: 1rem;
`;

export const Wrap = styled.div`
  display: flex;
  flex-direction: column; /* Vertical */
  align-items: center;
  justify-content: center;
  gap: 0.5rem;

  @media (max-height: 600px) {
    zoom: 0.7;
  }
`;

export const Content = styled.div`
  width: 6.5rem; /* mesma largura dos itens */
`;

export const ItemsWrap = styled.ul`
  display: flex;
  flex-direction: column; /* Em pé */
  gap: 0.5rem;

  overflow: hidden;
  list-style: none;
  padding: 0;
  margin: 0;
`;

export const Items = styled.li`
  ${({ theme }) => css`
    width: 5.5rem;  /* antes 6.5rem */
    height: 6rem;   /* antes 7rem */

    position: relative;

    border-radius: 5px;
    background-color: ${theme.colors.dark(0.4)};
  `}
`;

export const Header = styled.header`
  width: 100%;

  position: absolute;
  top: 0;

  display: flex;
  align-items: flex-start;
  justify-content: space-between;
`;

export const Sinal = styled.div`
  ${({ theme }) => css`
    width: 1.2rem;
    height: 1.2rem;

    display: flex;
    justify-content: center;
    align-items: center;

    border-top-left-radius: 5px;
    border-bottom-right-radius: 3px;
    box-shadow: rgba(0, 0, 0, 0.25) 0px 54px 55px,
      rgba(0, 0, 0, 0.12) 0px -12px 30px,
      rgba(0, 0, 0, 0.12) 0px 4px 6px,
      rgba(0, 0, 0, 0.17) 0px 12px 13px,
      rgba(0, 0, 0, 0.09) 0px -3px 5px;

    color: ${theme.colors.dark()};
    font-size: 0.7rem;
    font-weight: 700;
    background-color: ${theme.colors.primary(1)};
  `}
`;

export const Name = styled.div`
  ${({ theme }) => css`
    width: 100%;
    height: 1.2rem;

    position: absolute;
    bottom: 0;

    display: flex;
    justify-content: center;
    align-items: center;

    padding: 0 0.2rem;

    & > strong {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;

      font-size: 0.6rem;
      font-weight: 400;
      text-transform: uppercase;

      color: ${theme.colors.shape()};
    }
  `}
`;

export const Center = styled.main`
  width: 100%;
  height: 100%;

  position: relative;

  display: flex;
  justify-content: center;
  align-items: center;

  & > img {
    max-width: 60%;
  }
`;

export const Quantity = styled.div`
  ${({ theme }) => css`
    width: 100%;
    height: 1.2rem;

    position: absolute;
    bottom: 0;

    display: flex;
    align-items: center;
    justify-content: flex-end;

    padding: 0.2rem 0.2rem;

    & > span {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;

      font-size: 0.7rem;
      color: ${theme.colors.shape(1)};
    }
  `}
`;
