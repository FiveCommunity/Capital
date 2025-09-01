import styled from "styled-components";
import { Card, Input, theme } from "../../styles";

export const Container = styled.div`
  padding: 20px;
  width: 100%;
  height: 100%;
  display: flex;
  gap: 20px;
`;

export const FormCard = styled(Card)``;
export const Form = styled.form`
  display: flex;
  flex-direction: column;
  width: 100%;
  gap: 20px;
`;

export const FormInput = styled(Input)`
  appearance: textfield;
`;

export const InfoUser = styled.ul`
  width: 100%;
  padding: 0;
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 10px;
`;

export const ItemInfoUser = styled.li`
  color: #ddd;
  letter-spacing: 1px;
  font-size: 12px;

  & > b {
    color: white;
  }
`;
