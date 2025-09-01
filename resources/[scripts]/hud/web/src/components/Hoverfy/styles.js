import styled, { css } from "styled-components";

export const Wrap = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
`;

export const Content = styled.div`
  height: 2rem;

  display: flex;
  align-items: center;
  gap: 0.5rem;
`;

export const Key = styled.strong`
  ${({ theme }) => css`
    width: 1.5rem;
    height: 1.5rem;

    display: flex;
    justify-content: center;
    align-items: center;

    color: ${theme.colors.shape()};

    background-color: ${theme.colors.dark(0.3)};

    border-radius: 5px;
    border: 2px ridge ${theme.colors.shape(0.1)};

    font-size: 0.8rem;
  `}
`;

export const Text = styled.p`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};

    text-shadow: 2px 2px 5px ${theme.colors.dark(0.5)};
  `}
`;
