import styled from "styled-components";
import { theme } from "../../styles";

export const Container = styled.div`
  background-color: ${theme.colors.secondary};
  width: 900px;
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

export const Subtitle = styled.h2`
  color: white;
  font-size: 18px;
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 25px;

  svg {
    color: ${theme.colors.primary};
  }
`;

export const Description = styled.p`
  color: #999;
  font-size: 16px;
  margin-bottom: 25px;
`;

export const Content = styled.div`
  flex: 1;
  display: flex;
  gap: 20px;
`;

export const Wrap = styled.div`
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
`;

export const ProductList = styled.ul`
  list-style: none;
  padding: 0;
  display: flex;
  flex-direction: column;
  margin: 0;
  width: 100%;
  margin-bottom: 25px;
  gap: 10px;
  height: 300px;
  max-height: 300px;
  overflow-x: hidden;
  overflow-y: auto;
  padding-right: 10px;
`;

export const ItemProductList = styled.li`
  background-color: rgba(255, 255, 255, 0.03);
  border-radius: 10px;
  width: 100%;
  display: flex;
  gap: 10px;
  color: white;
  padding: 10px;
  cursor: pointer;
  border: 2px solid ${theme.colors.secondary};
  align-items: center;

  &.active {
    border-color: rgba(255, 255, 255, 0.1);
  }

  img {
    width: 75px;
    height: 75px;
  }
`;

export const ImageProductWrap = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 5px;
  width: 40%;
`;

export const ItemProductListInfo = styled.div`
  flex: 1px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 5px;

  & > b {
    font-size: 14px;
  }
`;

export const Materials = styled.div`
  display: flex;
  gap: 10px;
  flex-direction: column;
  flex-wrap: wrap;
  flex: 1;
`;

export const ItemMaterials = styled.div`
  color: #999;
  font-size: 12px;
  width: 100%;
  background-color: rgba(0, 0, 0, 0.2);
  border-radius: 5px;
  padding: 10px;

  & > b {
    color: ${theme.colors.primary};
    font-size: 14px;
  }
`;

export const Storage = styled.div`
  width: 100%;
  background-color: rgba(0, 0, 0, 0.2);
  border-radius: 10px;
  padding: 20px;
`;

export const Label = styled.label`
  width: 100%;
  font-size: 12px;
  color: white;
`;
