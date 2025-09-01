import styled, { css } from "styled-components";

export const Container = styled.div`
  position: absolute;
  width: 100%;
  height: 100vh;
  z-index: 3;
`;

export const Wrap = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: left;
  align-items: center;

  padding: 2rem;
`;

export const Content = styled.div`
  ${({ theme }) => css`
    display: flex;
    flex-direction: column;
    gap: 1rem;

    padding: 0.8rem;

    background-color: ${theme.colors.dark(0.5)};

    border-radius: 10px;
    border: 2px ridge ${theme.colors.shape(0.1)};
  `}
`;

export const Frequency = styled.div`
  width: 100%;

  display: flex;
  flex-direction: column;
  gap: 0.5rem;
`;

export const Header = styled.header`
  ${({ theme }) => css`
    width: 100%;

    display: flex;
    justify-content: space-between;
    align-items: center;

    & > svg {
      color: ${theme.colors.shape()};
      cursor: pointer;
      transition: color 0.2s;

      &:hover {
        color: ${theme.colors.primary()};
      }
    }
  `}
`;

export const Title = styled.div`
  ${({ theme }) => css`
    display: flex;
    align-items: center;
    gap: 0.5rem;

    & > svg {
      color: ${theme.colors.shape()};
    }

    & > span {
      color: ${theme.colors.shape()};
      font-weight: 500;
      letter-spacing: 0.01rem;
      font-size: 0.875rem;
    }
  `}
`;

export const Input = styled.input`
  ${({ theme }) => css`
    width: 100%;
    height: 2.5rem;

    background-color: ${theme.colors.shape(0.02)};
    border: 0.5px ridge ${theme.colors.shape(0.1)};
    border-radius: 5px;

    padding: 0 0.5rem;

    color: ${theme.colors.shape(0.8)};

    &:focus {
      outline: 0;
      border: 0.5px ridge ${theme.colors.shape(0.2)};
    }

    &:hover {
      border: 0.5px ridge ${theme.colors.shape(0.2)};
    }

    &::placeholder {
      color: ${theme.colors.shape(0.5)};
      font-size: 0.8rem;
    }
  `}
`;

export const Buttons = styled.div`
  width: 100%;

  display: flex;
  gap: 0.5rem;
`;

export const Button = styled.button`
  width: 50%;
  height: 1.5rem;

  border-radius: 5px;
  border: 0;

  text-transform: uppercase;
  font-size: 0.7rem;
  letter-spacing: 0.01rem;
  font-weight: 600;

  cursor: pointer;
  transition: all 0.2s;

  &:hover {
    transform: scale(0.98);
  }

  &:focus {
    outline: 0;
    border: 0;
  }
`;
