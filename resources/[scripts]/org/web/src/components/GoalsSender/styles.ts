import styled from "styled-components";
import { theme } from "../../styles";

export const Container = styled.div`
  background-color: ${theme.colors.secondary};
  width: 400px;
  padding: 20px 20px 40px;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  gap: 20px;
`;

export const Title = styled.h2`
  color: white;
  font-size: 25px;
  display: flex;
  align-items: center;
  gap: 10px;

  svg {
    color: ${theme.colors.primary};
  }
`;

export const Description = styled.p`
  color: #999;
  font-size: 16px;
`;
