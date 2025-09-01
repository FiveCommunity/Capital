import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    position: absolute;
    background-color: ${theme.colors.dark(0.8)};
    width: 100%;
    height: 100vh;
    z-index: 2;
    background-image: linear-gradient(
      ${theme.colors.primary(0.1)},
      ${theme.colors.dark(0.8)}
    );
  `}
`;

export const Wrap = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
`;

export const Form = styled.div`
  width: 600px;
  display: flex;
  flex-direction: column;
`;

export const Header = styled.div`
  display: flex;
  justify-content: space-between;
  align-content: center;
  margin-bottom: 1rem;
`;

export const Title = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    font-weight: 400;
    font-size: 1.5rem;
  `}
`;

export const IconCopy = styled.span`
  ${({ theme }) => css`
    font-size: 1.2rem;
    width: 40px;
    height: 40px;
    border: 2px ridge ${theme.colors.shape(0.1)};
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    color: ${theme.colors.shape()};
    letter-spacing: 1px;
  `}
`;

export const Textarea = styled.textarea`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.05)};
    border: 0;
    outline: none;
    border-radius: 5px;
    padding: 1rem;
    font-weight: 300;
    color: ${theme.colors.shape()};
  `}
`;

export const Footer = styled.div`
  ${({ theme }) => css`
    display: flex;
    justify-content: flex-end;
    align-items: center;
    font-size: 0.8rem;
    letter-spacing: 1px;
    color: ${theme.colors.shape(0.7)};
    padding: 1rem 0;
  `}
`;
