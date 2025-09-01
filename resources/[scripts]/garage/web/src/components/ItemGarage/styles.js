import styled, { css } from "styled-components";

export const CarItem = styled.li`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.25)};
    border: 1px solid ${theme.colors.shape(0.1)};
    min-width: calc(30% - 3rem);
    height: 150px;
    border-radius: 5px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    transition: all 0.2s;
    position: relative;

    & > svg {
      font-size: 2.5rem;
      margin-bottom: 1rem;
      color: ${theme.colors.shape()};
    }

    &:hover {
      background-color: ${theme.colors.shape(0.05)};
    }
  `}
`;

export const CarItemImage = styled.img`
  /* width: 80px; */
  height: 50px;
  margin-bottom: 0.5rem;
  object-fit: cover;
  object-position: center;
`;

export const CarItemTitle = styled.strong`
  ${({ theme }) => css`
    font-size: 0.875rem;
    text-transform: uppercase;
    color: ${theme.colors.shape()};
    margin-bottom: 0.2rem;
  `}
`;

export const CarItemSubtitle = styled.span`
  ${({ theme }) => css`
    text-transform: uppercase;
    font-size: 0.6rem;
    color: ${theme.colors.primary()};
  `}
`;

export const CategoryItem = styled.div`
  ${({ theme }) => css`
    width: 1.5rem;
    height: 1.5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: ${theme.colors.primary()};
    color: ${theme.colors.shape()};
    position: absolute;
    top: 0;
    left: 0;
    border-radius: 5px 0 5px 0;
  `}
`;
