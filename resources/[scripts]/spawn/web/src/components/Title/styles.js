import styled, { css } from "styled-components";

export const Container = styled.div`
  display: flex;
  align-items: center;
`;

export const Title = styled.h2`
  ${({ theme }) => css`
    color: ${theme.colors.primary()};
    font-weight: 700;
    font-size: 1.25rem;
    letter-spacing: 0.1rem;
  `}
`;
