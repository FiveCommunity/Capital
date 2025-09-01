import styled, { css } from "styled-components";

export const Alert = styled.div`
  ${({ theme }) => css`
    width: 20rem;

    padding: 1rem 2rem;

    background-color: ${theme.colors.dark(0.7)};
    border: 2px solid ${theme.colors.shape(0.1)};
    border-radius: 10px;

    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.7rem;

    @media (max-width: 1199px) {
      width: 18rem;
    }

    @media (max-width: 1100px) {
      width: 15rem;
    }

    @media (max-width: 800px) {
      width: 12rem;
    }
  `}
`;

export const Header = styled.header`
  ${({ theme }) => css`
    width: 100%;

    display: flex;
    justify-content: space-between;
    align-items: center;

    color: ${theme.colors.shape()};

    & > svg {
      font-size: 0.875rem;
    }

    & > h2 {
      font-size: 1.5rem;
    }

    @media (max-width: 800px) {
      & > h2 {
        font-size: 1rem;
      }

      & > svg {
        font-size: 0.775rem;
      }
    }
  `}
`;

export const Text = styled.p`
  ${({ theme }) => css`
    width: 100%;

    text-align: center;
    font-weight: 300;
    font-size: 0.8rem;
    line-height: 1.3rem;
    color: ${theme.colors.shape(0.7)};
    text-transform: uppercase;

    overflow: hidden;
    word-wrap: break-word;

    & > span > b {
      color: ${theme.colors.shape(0.8)};
    }

    @media (max-width: 800px) {
      font-size: 0.7rem;
    }
  `}
`;

export const Footer = styled.footer`
  width: 100%;
  display: flex;

  justify-content: center;
  align-items: center;
  gap: 0.5rem;
`;

export const Button = styled.button`
  ${({ theme }) => css`
    background: transparent;
    text-transform: uppercase;
    color: ${theme.colors.shape()};
    border: 2px solid ${theme.colors.shape(0.2)};
    border-radius: 10px;
    padding: 0.1rem 1rem;
    font-size: 0.7rem;
    font-weight: 700;
    cursor: pointer;
    transition: background-color 0.3s;

    &:hover {
      background-color: ${theme.colors.primary()};
    }
  `}
`;
