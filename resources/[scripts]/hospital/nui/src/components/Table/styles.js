import styled, { css } from "styled-components";

export const WrapTable = styled.div`
  flex: 1;
  height: 100%;
  max-height: 100%;
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
`;

export const Table = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.dark(0.2)};
    overflow-y: auto;
    overflow-x: none;
    flex: 1;
    width: 100%;
    border-radius: 5px;
    box-shadow: 5px 5px 3px ${theme.colors.dark(0.1)};
    padding-top: 3.1rem;
  `}
`;

export const Row = styled.div`
  ${({ theme }) => css`
    width: 100%;
    height: 3.1rem;
    display: flex;
    align-items: center;
    border-bottom: 1px solid ${theme.colors.primary(0.1)};

    &:nth-child(even) {
      background-color: ${theme.colors.shape(0.02)};
    }

    &.head {
      position: absolute;
      top: 0;
      left: 0;
      background-color: ${theme.colors.dark()};
      border-radius: 5px 0 0 0;
      background-image: linear-gradient(
        to bottom right,
        ${theme.colors.primary(0.1)},
        ${theme.colors.primary(0.1)}
      );
      & > div {
        font-weight: 400;
      }
    }
  `}
`;

export const Td = styled.div`
  ${({ theme }) => css`
    flex: 1;
    width: 100px;
    height: 100%;
    color: ${theme.colors.shape()};
    padding: 0 1rem;
    font-weight: 100;
    font-size: 0.85rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;

    &.detail {
      flex: none;
      width: 2rem;
      justify-content: center;
    }

    & > svg {
      color: ${theme.colors.primary()};
      font-size: 1.2rem;
    }
  `}
`;

export const EmptyFeedback = styled.h1`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: 400;
  `}
`;

export const ButtonAction = styled.button`
  ${({ theme }) => css`
    color: ${theme.colors.primary()};
    background-color: transparent;
    border: 0;
    display: flex;
    justify-content: center;
    font-size: 1.3rem;
    align-items: center;
    cursor: pointer;
  `}
`;

export const Pagination = styled.div`
  display: flex;
  justify-content: flex-end;
  height: 3.1rem;
  align-items: center;
  gap: 0.5rem;
`;

export const IndicatorPagination = styled.div`
  ${({ theme }) => css`
    width: 2.7rem;
    height: 2.7rem;
    border-radius: 5px;
    color: ${theme.colors.shape()};
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 0.8rem;
  `}
`;

export const ButtonPagination = styled.button`
  ${({ theme }) => css`
    background-color: transparent;
    border: 1px solid ${theme.colors.primary()};
    color: ${theme.colors.shape()};
    width: 2rem;
    height: 2rem;
    border-radius: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: background-color 0.5s;
    cursor: pointer;

    &:hover {
      background-color: ${theme.colors.primary(0.2)};
    }
  `}
`;
