import styled, { css } from "styled-components";

export const Container = styled.div`
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 0.7rem;
`;

export const ParentsList = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
`;

export const ParentsButton = styled.div`
  ${({ theme }) => css`
    width: 23rem;
    height: 4rem;

    display: flex;
    align-items: center;
    padding: 0.5rem;

    background-color: ${theme.colors.shape(0.08)};
    border: 2px solid ${theme.colors.shape(0.1)};
    border-radius: 10px;

    @media (max-width: 1399px) {
      width: 18rem;
    }

    @media (max-width: 1199px) {
      width: 16rem;
    }
  `}
`;

export const Avatar = styled.div`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.2)};
    border: 0.5px solid ${theme.colors.shape(0.1)};

    width: 3rem;
    height: 3rem;

    border-radius: 50%;

    & > img {
      width: 100%;
      height: 100%;
      border-radius: 50%;
    }
  `}
`;

export const Information = styled.div`
  ${({ theme }) => css`
    width: 75%;
    height: 100%;

    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    gap: 0.5rem;

    & > span {
      color: ${theme.colors.shape(0.55)};
      font-size: 0.8rem;
    }
  `}
`;

export const Option = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};

    display: flex;
    gap: 0.8rem;

    & > strong {
      font-size: 0.875rem;
      font-weight: 400;
    }
  `}
`;

export const Previous = styled.button`
  ${({ theme }) => css`
    cursor: pointer;
    transition: color 0.3s;

    background: transparent;
    border: 0;

    &:focus {
      border: 0;
      outline: 0;
    }

    & > svg {
      transform: rotate(-180deg);
      color: ${theme.colors.shape()};
      font-size: 1.2rem;

      &:hover {
        color: ${theme.colors.shape(0.5)};
      }
    }
  `}
`;

export const Next = styled.button`
  ${({ theme }) => css`
    cursor: pointer;
    transition: color 0.3s;
    background: transparent;
    border: 0;

    &:focus {
      border: 0;
      outline: 0;
    }

    & > svg {
      color: ${theme.colors.shape()};
      font-size: 1.2rem;

      &:hover {
        color: ${theme.colors.shape(0.5)};
      }
    }
  `}
`;
