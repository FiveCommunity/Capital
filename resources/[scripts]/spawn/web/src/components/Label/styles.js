import styled, { css } from "styled-components";

export const Container = styled.div`
  display: flex;
  align-items: center;
`;

export const Label = styled.label`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    text-transform: uppercase;
    font-size: 0.7rem;
    font-weight: 300;
  `}
`;
