import styled, { css } from "styled-components";

export const Container = styled.div`
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
`;

export const Picker = styled.div`
  ${({ theme }) => css`
    display: flex;
    justify-content: center;
    align-items: center;
    width: 23rem;
    height: 2.4rem;
    position: relative;
    border-radius: 10px;

    cursor: pointer;
    padding: 0.3rem;

    background-color: ${theme.colors.shape(0.08)};
    border: 2px solid ${theme.colors.shape(0.1)};

    transition: background-color 0.3s;

    &:hover {
      background-color: ${theme.colors.shape(0.12)};
    }

    @media (max-width: 1399px) {
      width: 18rem;
    }

    @media (max-width: 1199px) {
      width: 16rem;
    }
  `}
`;

export const Placeholder = styled.div`
  ${({ bgColor, theme }) => css`
    background-color: ${bgColor};
    color: ${theme.colors.shape()};
    width: 100%;
    height: 100%;
    border-radius: 5px;
  `}
`;
