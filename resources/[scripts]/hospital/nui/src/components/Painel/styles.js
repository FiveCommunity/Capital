import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark()};
    background-image: linear-gradient(
      to bottom right,
      ${theme.colors.primary(0.2)},
      ${theme.colors.dark(0.2)}
    );
    width: 62.5rem;
    height: 55vh;
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    box-shadow: 5px 5px 5px ${theme.colors.dark(0.3)};
  `}
`;

export const BackgroundImage = styled.img`
  width: 31.25rem;
  opacity: 0.05;
`;

export const Content = styled.div`
  ${({ theme }) => css`
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
    position: absolute;
    border-radius: 10px;
    border: 5px solid ${theme.colors.dark(0.8)};
  `}
`;

export const Body = styled.div`
  width: 100%;
  height: calc(100% - 4.6rem);
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1rem;
`;
