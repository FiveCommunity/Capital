import styled from "styled-components";
import * as GS from "../../styles";
import { theme } from "../../styles";

export const Container = styled.div`
  padding: 20px;
  width: 100%;
  height: 100%;
  display: flex;
  gap: 20px;
`;

export const Card = styled(GS.Card)`
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 15px;
`;

export const GoalsList = styled.ul`
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  max-height: 200px;
  overflow-x: hidden;
  overflow-y: auto;
  padding-right: 20px;
`;

export const GoalItem = styled.li`
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
  width: 100%;
  min-height: 50px;
  color: #fff;
  display: flex;
  font-size: 13px;
  justify-content: space-between;
  align-items: center;
  padding: 0 5px;

  &:last-child {
    border: none;
  }
`;


