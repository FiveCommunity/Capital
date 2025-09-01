import styled from "styled-components";
import { theme } from "../../styles";

export const Progress = styled.div`
  background-color: rgba(0, 0, 0, 0.5);
  width: 150px;
  height: 10px;
  border-radius: 5px;
  padding: 2px;
  border: 1px solid ${theme.colors.primary};
  position: relative;
`;

type ProgressIndicatorProps = {
  percentWidth: string;
};

export const ProgressIndicator = styled.div<ProgressIndicatorProps>`
  background-color: ${theme.colors.primary};
  width: ${({ percentWidth }) => percentWidth};
  height: 100%;
  border-radius: 5px;
`;

export const ProgressLabel = styled.span`
  color: white;
  position: absolute;
  top: -15px;
  right: 0;
`;

export const ProgressDetails = styled.div`
  background-color: ${theme.colors.secondary};
  position: absolute;
  top: 20px;
  width: 100%;
  padding: 10px;
  border-radius: 10px;
  display: flex;
  box-shadow: 3px 3px 5px 0px rgba(0, 0, 0, 0.5);
  flex-direction: column;
  z-index: 1;
  gap: 10px;
`;

export const ProgressDetailsItem = styled.div`
  display: flex;
  justify-content: space-between;

  & > small {
    color: ${theme.colors.primary};
  }
`;
