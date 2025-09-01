import styled, { css } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.9)};
    background-image: linear-gradient(
      to bottom right,
      ${theme.colors.primary(0.3)},
      ${theme.colors.dark(0.3)}
    );

    width: 50.6rem;
    height: 35rem;
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
  `}
`;

export const Logo = styled.img`
  opacity: 0.05;
`;

export const Content = styled.div`
  position: absolute;
  top: 0;
  left: 0;
  border-radius: 10px;
  width: 100%;
  height: 100%;
  padding: 1rem;
  display: flex;
  align-items: center;
  gap: 1rem;
`;

export const ProductList = styled.ul`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.5)};
    border: 1px solid ${theme.colors.shape(0.1)};
    border-radius: 5px;
    width: 35%;
    height: 100%;
    padding: 0.5rem;
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    overflow-x: hidden;
    overflow-y: auto;
  `}
`;

export const Product = styled.li`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.05)};
    border: 1px solid ${theme.colors.shape(0.1)};
    display: flex;
    padding: 0.5rem;
    border-radius: 5px;
    justify-content: flex-start;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
    transition: background-color 0.2s;

    &:hover {
      background-color: ${theme.colors.shape(0.1)};
    }
  `}
`;

export const ProductImage = styled.img`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.05)};
    border: 1px solid ${theme.colors.shape(0.1)};
    border-radius: 5px;
    width: 60px;
    height: 60px;
    padding: 0.5rem;
  `}
`;

export const ProductTitle = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
  `}
`;

export const ProductMaterials = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.5)};
    border: 1px solid ${theme.colors.shape(0.1)};
    height: 100%;
    flex: 1;
    border-radius: 5px;
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items: center;
  `}
`;

export const Form = styled.div`
  width: 80%;
  display: flex;
  align-items: center;
  flex-direction: column;
  gap: 1rem;
`;

export const Title = styled.h1`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    font-weight: 300;
    margin-bottom: 1rem;

    & > span {
      color: ${theme.colors.primary()};
    }
  `}
`;

export const Materials = styled.div`
  width: 100%;
  height: 10rem;

  gap: 1rem;
  display: flex;
  justify-content: center;
  flex-wrap: wrap;

  overflow-y: scroll;
  overflow-x: hidden;
`;

export const EmptyProduct = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    font-size: 1.2rem;
    width: 80%;

    letter-spacing: 1px;
    text-align: center;
    text-transform: uppercase;
  `}
`;

export const HeaderProduction = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.3)};
    border: 1px solid ${theme.colors.shape(0.1)};
    padding: 0.5rem;
    border-radius: 5px;
    width: 100%;
    height: 6rem;
    gap: 1rem;
    display: flex;
    align-items: center;

    &.p-item {
      background-color: ${theme.colors.shape(0.05)};
      & > img {
        background-color: ${theme.colors.shape(0.05)};
      }
    }
  `}
`;

export const ProductionImage = styled.img`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.03)};
    border: 1px solid ${theme.colors.shape(0.1)};
    border-radius: 5px;
    width: 75px;
    height: 75px;
    padding: 0.5rem;
  `}
`;

export const ProductionTitle = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
  `}
`;

export const Description = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
`;

export const QtdPerProduction = styled.span`
  ${({ theme }) => css`
    color: ${theme.colors.shape(0.5)};
    font-size: 0.9rem;
    font-weight: 300;
  `}
`;

export const Actions = styled.div`
  display: flex;
  width: 100%;
  gap: 1rem;
  justify-content: center;
  align-items: flex-end;
`;

export const Button = styled.button`
  ${({ theme }) => css`
    background-color: ${theme.colors.primary()};
    border: 0;
    border-radius: 5px;
    height: 35px;
    flex: 1;
    transition: all 0.2s;
    color: ${theme.colors.shape()};
    text-transform: uppercase;
    font-weight: 600;
    cursor: pointer;

    &[disabled] {
      opacity: 0.5;
      cursor: not-allowed;
    }

    &:not([disabled]):hover {
      background-color: ${theme.colors.primary(0.8)};
    }
  `}
`;
