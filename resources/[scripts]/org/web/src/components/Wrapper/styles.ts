import styled, { css } from "styled-components";
import { VisibleType } from "../../contexts/NuiContext";

type ContainerProps = {
  type: VisibleType;
};

export const Container = styled.section<ContainerProps>`
  ${({ type }) => css`
    background-color: ${type !== "goalsSender"
      ? "background-color: rgba(0, 0, 0, 0.5)"
      : "transparent"};
    width: 100vw;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
  `}
`;
