import styled, { css, keyframes } from "styled-components";

export const Container = styled.div`
  ${({ theme }) => css`
    width: 300px;
    margin-left: 20%;
    background-color: ${theme.colors.dark(0.8)};
    background-image: linear-gradient(
      to bottom right,
      ${theme.colors.primary(0.3)},
      ${theme.colors.dark(0.2)}
    );
    padding: 1rem;
    border-radius: 5px;
    box-shadow: rgba(0, 0, 0, 0.25) 0px 14px 28px,
      rgba(0, 0, 0, 0.22) 0px 10px 10px;
  `}
`;

export const Title = styled.h1`
  ${({ theme }) => css`
    font-size: 0.8rem;
    font-weight: normal;
    color: ${theme.colors.shape()};
    margin-bottom: 1rem;

    & > span {
      color: ${theme.colors.primary()};
    }
  `}
`;

export const Header = styled.div`
  width: 100%;
  display: flex;
  gap: 1rem;
  align-items: center;
  margin-bottom: 1rem;
`;

export const BackButton = styled.button`
  ${({ theme }) => css`
    width: 2rem;
    height: 2rem;
    font-size: 1.5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: ${theme.colors.shape(0.1)};
    border: 1px solid ${theme.colors.shape(0.15)};
    border-radius: 3px;
    color: ${theme.colors.shape()};
    cursor: pointer;
  `}
`;

export const Search = styled.input`
  ${({ theme }) => css`
    height: 2rem;
    flex: 1;
    background-color: ${theme.colors.shape(0.1)};
    border: 1px solid ${theme.colors.shape(0.15)};
    border-radius: 3px;
    padding: 0 0.5rem;
    outline: none;
    color: ${theme.colors.shape()};
    font-size: 0.75rem;

    &::placeholder {
      color: ${theme.colors.shape(0.3)};
    }

    &:focus {
      border-color: ${theme.colors.shape(0.5)};
    }
  `}
`;

export const ActionList = styled.ul`
  padding: 0;
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  max-height: 12.5rem;
  overflow-x: hidden;
  overflow-y: auto;
  padding-right: 0.5rem;
`;

export const Item = styled.li`
  ${({ theme }) => css`
    border: 1px solid ${theme.colors.shape(0.15)};
    background: ${theme.colors.shape(0.05)};
    min-height: 2rem;
    height: 2rem;
    border-radius: 3px;
    font-size: 0.7rem;
    text-transform: uppercase;
    color: ${theme.colors.shape()};
    display: flex;
    align-items: center;
    cursor: pointer;
    padding: 0;
    transition: background-color 0.5s;
    justify-content: space-between;

    &:hover {
      background-color: ${theme.colors.shape(0.2)};
    }
  `}
`;

export const EmptyFeedback = styled.strong`
  ${({ theme }) => css`
    height: 2rem;
    display: flex;
    justify-content: center;
    align-items: center;
    color: ${theme.colors.shape()};

    & > strong {
      color: ${theme.colors.primary()};
    }
  `}
`;

export const ItemDescription = styled.div`
  ${({ theme }) => css`
    display: flex;
    align-items: center;
    gap: 0.5rem;
    height: 100%;
    flex: 1;
    padding: 0 0.5rem;

    & > svg {
      font-size: 1rem;
      color: ${theme.colors.primary()};
    }
  `}
`;

export const FavButton = styled.button`
  ${({ theme }) => css`
    color: ${theme.colors.primary(0.6)};
    background-color: ${theme.colors.primary(0)};
    border: 0;
    width: 2.1rem;
    height: 100%;
    font-size: 1.2rem;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    z-index: 1;

    &:hover {
      color: ${theme.colors.primary()};
    }
  `}
`;

const rotateAnimation = keyframes`
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
    }
`;

export const Loading = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    font-size: 1rem;
    height: 10rem;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0.8rem;
    margin-bottom: 1rem;

    & > svg {
      animation: ${rotateAnimation} 1s linear infinite;
      color: ${theme.colors.primary()};
      font-size: 1.6rem;
    }
  `}
`;
