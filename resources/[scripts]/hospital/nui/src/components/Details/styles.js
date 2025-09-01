import styled, { css } from "styled-components";

export const Details = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark()};
    position: absolute;
    z-index: 3;
    border-radius: 5px;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
  `}
`;

export const BackImage = styled.img`
  width: 25rem;
  opacity: 0.02;
`;

export const Content = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.primary(0.1)};
    width: 100%;
    height: 100%;
    position: absolute;
    border-radius: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
  `}
`;

export const Form = styled.div`
  width: 80%;
  height: 90%;
  padding: 2rem 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  gap: 0.5rem;
  overflow-x: hidden;
  overflow-y: auto;
`;

export const Group = styled.div`
  display: flex;
  align-items: center;
  width: 100%;
  gap: 2rem;
`;

export const Input = styled.div`
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 1rem;
`;

export const Title = styled.h2`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    margin-bottom: 2rem;
    font-weight: 400;
    font-size: 1.2rem;

    & > span {
      color: ${theme.colors.primary()};
    }
  `}
`;

export const InputField = styled.input`
  ${({ theme }) => css`
    height: 2.5rem;
    border-radius: 5px;
    border: 1px solid ${theme.colors.primary(0.2)};
    color: ${theme.colors.shape(0.8)};
    background-color: ${theme.colors.dark(0.3)};
    padding: 0 0.5rem;
    font-size: 0.8rem;
    margin-bottom: 1rem;
    outline: none;

    &[disabled] {
      background-color: ${theme.colors.shape(0.05)};
    }
  `}
`;

export const Select = styled.select`
  ${({ theme }) => css`
    height: 2.5rem;
    border-radius: 5px;
    border: 1px solid ${theme.colors.primary(0.2)};
    color: ${theme.colors.shape(0.8)};
    background-color: ${theme.colors.dark(0.3)};
    padding: 0 0.5rem;
    font-weight: bold;
    font-size: 0.8rem;
    outline: none;
    margin-bottom: 1rem;

    &[disabled] {
      background-color: ${theme.colors.shape(0.05)};
    }
  `}
`;

export const Label = styled.label`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    font-size: 0.8rem;
  `}
`;

export const Textarea = styled.textarea`
  ${({ theme }) => css`
    width: 100%;
    border: 1px solid ${theme.colors.primary(0.2)};
    color: ${theme.colors.shape(0.8)};
    background-color: ${theme.colors.dark(0.3)};
    border-radius: 5px;
    padding: 0.5rem;
    outline: none;
    margin-bottom: 1rem;
    resize: none;

    &[disabled] {
      background-color: ${theme.colors.shape(0.05)};
    }
  `}
`;

export const Button = styled.button`
  ${({ theme }) => css`
    width: auto;
    height: 2.2rem;
    background-color: ${theme.colors.dark(0.5)};
    border-radius: 5px;
    border: 1px solid ${theme.colors.primary()};
    color: ${theme.colors.shape()};
    box-shadow: 3px 3px 3px ${theme.colors.dark(0.2)};
    padding: 0 1.5rem;
    cursor: pointer;
    transition: all 0.3s;

    &:hover {
      background-color: ${theme.colors.primary(0.05)};
    }
  `}
`;

export const Datetime = styled.small`
  ${({ theme }) => css`
    color: ${theme.colors.primary()};
  `}
`;

export const CloseButton = styled.button`
  ${({ theme }) => css`
    position: absolute;
    top: 1rem;
    right: 1rem;
    font-size: 1.5rem;
    width: 2.5rem;
    height: 2.5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    border: 0;
    color: ${theme.colors.shape()};
    background-color: ${theme.colors.shape(0.05)};
    cursor: pointer;
    box-shadow: 3px 3px 3px ${theme.colors.dark()};
  `}
`;
