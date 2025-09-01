import styled, { css } from "styled-components";

export const WrapButton = styled.div`
  position: relative;
`;

export const Button = styled.button`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.2)};
    border: 1px solid ${theme.colors.primary(0.2)};
    color: ${theme.colors.shape()};
    border-radius: 5px;
    width: 2rem;
    height: 2rem;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    transition: background-color 0.5s;
    position: relative;

    &:hover {
      background-color: ${theme.colors.primary()};
    }
  `}
`;

export const BackModal = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  z-index: 1;
`;

export const WrapNotifies = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape()};
    color: ${theme.colors.primary()};
    border-radius: 50%;
    position: absolute;
    width: 1.2rem;
    height: 1.2rem;
    display: flex;
    justify-content: center;
    align-items: center;
    right: -0.6rem;
    bottom: -0.6rem;
    z-index: 2;
  `}
`;

export const ConfirmModal = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark()};
    background-image: linear-gradient(
      to bottom right,
      ${theme.colors.primary(0.15)},
      ${theme.colors.primary(0.15)}
    );
    border-radius: 5px;
    position: absolute;
    top: 2.5rem;
    right: 0;
    width: 18.75rem;
    z-index: 2;
    padding: 1rem;
    box-shadow: 2px 2px 3px ${theme.colors.dark()};
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem;
  `}
`;

export const Description = styled.p`
  ${({ theme }) => css`
    font-size: 1rem;
    color: ${theme.colors.shape()};
  `}
`;

export const Actions = styled.div`
  display: flex;
  align-items: center;
  gap: 1rem;
`;

export const ResponseButton = styled.button`
  ${({ theme }) => css`
    height: 2.1rem;
    border: 0;
    color: ${theme.colors.shape()};
    font-size: 0.8rem;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 5px;
    box-shadow: 3px 3px 3px ${theme.colors.dark(0.5)};
    cursor: pointer;
    padding: 0 1rem;

    & > svg {
      font-size: 1.2rem;
    }

    &.accept {
      background-color: ${theme.colors.accept()};
    }
  `}
`;
