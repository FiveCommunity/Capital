import styled from "styled-components";
import { theme } from "../../styles";

export const Wrap = styled.div`
  position: absolute;
  width: 100%;
  height: 100%;
`;

export const Backdrop = styled.div`
  background-color: rgba(0, 0, 0, 0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
`;

export const Container = styled.div`
  background-color: ${theme.colors.secondary};
  width: 400px;
  padding: 20px;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  gap: 20px;
`;

export const Title = styled.h1`
  font-size: 18px;
  font-weight: normal;
  color: white;
  display: flex;
  align-items: center;
  gap: 10px;

  text-align: center;

  & > svg {
    color: ${theme.colors.primary};
  }
`;

export const Actions = styled.div`
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
`;
