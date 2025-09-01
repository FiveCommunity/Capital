import styled, { css } from "styled-components";

export const Header = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.primary(0.05)};
    width: 100%;
    height: 4.6rem;
    border-radius: 5px 5px 0 0;
    box-shadow: 0px 3px 5px ${theme.colors.dark(0.3)};
    border-top: 3px solid ${theme.colors.primary()};
    padding: 0 1rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
  `}
`;

export const Title = styled.h1`
  ${({ theme }) => css`
    text-transform: uppercase;
    font-weight: 100;
    color: ${theme.colors.shape(0.8)};

    span {
      color: ${theme.colors.primary()};
    }
  `}
`;

export const Right = styled.div`
  display: flex;
  align-items: center;
  gap: 1rem;
`;

export const Form = styled.div`
  ${({ theme }) => css`
    padding: 0.5rem 1rem;
    display: flex;
    border-radius: 50px;
    gap: 1rem;
  `}
`;

export const SearchType = styled.select`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.1)};
    border: 1px solid ${theme.colors.primary(0.2)};
    height: 2rem;
    width: 10rem;
    border-radius: 15px;
    color: ${theme.colors.shape()};
    outline: none;
    padding: 0 0.5rem;

    & > option {
      background-color: ${theme.colors.dark()};
      height: 2rem;
    }
  `}
`;

export const BtnSearch = styled.button`
  ${({ theme }) => css`
    width: 1.8rem;
    height: 1.8rem;
    background-color: ${theme.colors.dark(0.2)};
    color: ${theme.colors.primary()};
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 5px;
    font-size: 1.1rem;
    border: 0;
    cursor: pointer;
  `}
`;
