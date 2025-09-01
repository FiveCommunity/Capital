import styled, { createGlobalStyle, css } from "styled-components";

export const theme = {
  colors: {
    shape: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
    dark: (opacity = 1) => `rgba(0, 0, 0, ${opacity})`,
    primary: (opacity = 1) => `rgba(3, 187, 232, ${opacity})`,
  },
  fonts: {
    family: {
      primary: "'Montserrat', sans-serif",
    },
  },
};

export const GlobalStyle = createGlobalStyle`
    ${({ theme }) => css`
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        user-select: none;

        font-synthesis: none;
        text-rendering: optimizeLegibility;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        -webkit-text-size-adjust: 100%;
      }

      html {
        width: 100%;
      }

      body {
        width: 100%;
        height: 100vh;
        margin: 0;
        padding: 0;
        position: relative;
        overflow: hidden;

        ::-webkit-scrollbar {
          width: 2px;
        }

        /* Track */
        ::-webkit-scrollbar-track {
          background: ${theme.colors.shape(0.05)};
          border-radius: 9999px;
        }

        /* Handle */
        ::-webkit-scrollbar-thumb {
          background: ${theme.colors.shape(0.8)};
          border-radius: 15px;
        }

        /* Handle on hover */
        ::-webkit-scrollbar-thumb:hover {
          background: ${theme.colors.shape(0.5)};
        }

        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
          -webkit-appearance: none;
          margin: 0;
        }
      }

      body,
      input,
      button,
      textarea {
        font-family: ${theme.fonts.family.primary};
      }
    `}
`;

export const Wrap = styled.section`
  width: 100%;
  height: 100vh;

  display: flex;
  justify-content: center;
  align-items: center;
`;

export const Container = styled.div`
  width: 70rem;
  height: 40rem;

  display: flex;
  flex-direction: column;

  position: relative;

  border-radius: 10px;

  background-color: ${theme.colors.dark(0.75)};
  border: 2px solid ${theme.colors.shape(0.1)};

  @media (max-width: 1176px) {
    zoom: 0.8;
  }

  @media (max-width: 800px) {
    zoom: 0.6;
  }
`;

export const Header = styled.header`
  width: 100%;
  height: 8rem;

  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.5rem;
`;

export const ShopName = styled.div`
  padding: 0 0.8rem;
  height: 2.5rem;

  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.5rem;

  background-color: ${theme.colors.dark(0.1)};
  border: 1px solid ${theme.colors.shape(0.1)};

  border-radius: 50px;

  & > h1 {
    font-size: 0.875rem;
    font-weight: 400;
    color: ${theme.colors.shape()};
  }

  & > svg {
    color: ${theme.colors.primary()};
  }
`;

export const Search = styled.form`
  width: 30rem;
  height: 2.5rem;

  display: flex;
`;

export const Input = styled.input`
  width: 87%;
  height: 100%;

  padding: 0 1rem;

  color: ${theme.colors.shape()};

  background-color: ${theme.colors.dark(0.1)};

  border: 1px solid transparent;
  border-top-color: ${theme.colors.shape(0.1)};
  border-left-color: ${theme.colors.shape(0.1)};
  border-bottom-color: ${theme.colors.shape(0.1)};

  border-top-left-radius: 50px;
  border-bottom-left-radius: 50px;

  transition: border-color 0.2s;

  &:focus {
    border-color: ${theme.colors.shape(0.2)};
    outline: 0;
  }
`;

export const Submit = styled.button`
  width: 13%;
  height: 100%;

  display: flex;
  justify-content: center;
  align-items: center;

  background-color: ${theme.colors.dark(0.1)};

  border-top-right-radius: 50px;
  border-bottom-right-radius: 50px;
  border: 1px solid ${theme.colors.shape(0.1)};

  transition: background-color 0.2s;
  cursor: pointer;

  & > svg {
    font-size: 1.5rem;
    color: ${theme.colors.primary()};
  }

  &:hover {
    background-color: ${theme.colors.shape(0.05)};
    & > svg {
      color: white;
    }
  }
`;

export const Wallet = styled.div`
  padding: 0 0.8rem;
  height: 2.5rem;

  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.5rem;

  background-color: ${theme.colors.dark(0.1)};
  border: 1px solid ${theme.colors.shape(0.1)};

  border-radius: 50px;

  & > svg {
    color: rgba(0, 255, 0, 1);
  }

  & > span {
    color: ${theme.colors.shape()};
    font-size: 0.875rem;
  }
`;

export const Main = styled.main`
  width: 100%;
  height: calc(100% - 8rem);

  padding: 0 6rem 2.5rem;
`;

export const WrapItem = styled.ul`
  width: 100%;
  height: 100%;

  list-style: none;
  display: flex;
  align-items: flex-start;
  flex-wrap: wrap;
  gap: 1rem;

  overflow-y: scroll;
  overflow-x: hidden;
`;

export const Items = styled.li`
  width: 10rem;

  border-radius: 10px;

  background-color: ${theme.colors.shape(0.05)};
  border: 1px solid ${theme.colors.shape(0.1)};

  padding: 1rem;

  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: center;
  gap: 1rem;
`;

export const ItemHeader = styled.div`
  width: 100%;

  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  gap: 0.3rem;

  & > h2 {
    font-size: 0.8rem;
    font-weight: 400;
    color: ${theme.colors.shape()};
  }

  & > span {
    font-size: 0.7rem;
    color: ${theme.colors.primary()};
  }
`;

export const ItemImage = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;

  padding: 0.5rem 0;
  background-color: ${theme.colors.shape(0.05)};
  border-radius: 5px;

  & > img {
    width: 70%;
  }
`;

export const Footer = styled.footer`
  width: 100%;

  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 0.5rem;
`;

export const ItemButton = styled.button`
  width: 7rem;

  background-color: ${theme.colors.shape()};
  border: 0;
  border-radius: 10px;

  color: ${theme.colors.dark()};
  text-transform: uppercase;
  font-size: 0.7rem;
  font-weight: 600;

  padding: 0.2rem 0;

  transition: transform 0.2s;
  cursor: pointer;

  &:hover {
    transform: scale(0.95);
  }
`;

export const EmptyItems = styled.h3`
  width: 100%;
  text-transform: uppercase;
  text-align: center;
  color: ${theme.colors.shape()};
  font-size: 0.875rem;
  font-weight: 400;
`;

export const SubMenu = styled.div`
  width: 100%;
  height: 100%;

  position: absolute;
  z-index: 2;

  display: flex;
  justify-content: center;
  align-items: center;

  background-color: ${theme.colors.dark(0.5)};
`;

export const SubContainer = styled.div`
  width: 18rem;

  display: flex;
  align-items: center;
  flex-direction: column;
  gap: 1rem;

  background-color: ${theme.colors.dark()};
  border: 1px solid ${theme.colors.shape(0.1)};
  border-radius: 10px;

  padding: 2rem 1.5rem;
`;

export const SubItemName = styled.div`
  width: 100%;

  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 0.875rem;

  & > span {
    color: ${theme.colors.shape(1)};
  }
`;

export const SubCenter = styled.div`
  width: 100%;

  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem;
`;

export const SubItemImage = styled.div`
  width: 7rem;
  height: 7rem;

  display: flex;
  justify-content: center;
  align-items: center;

  padding: 0.5rem 0;
  background-color: ${theme.colors.shape(0.03)};
  border-radius: 10px;

  & > img {
    width: 60%;
  }
`;

export const Sinal = styled.div`
  width: 1.8rem;
  height: 1.8rem;

  display: flex;
  justify-content: center;
  align-items: center;

  color: ${theme.colors.shape()};

  border-radius: 50%;

  background-color: ${theme.colors.shape(0.03)};
  border: 1px solid ${theme.colors.shape(0.01)};

  transition: background-color 0.2s;
  cursor: pointer;

  &:hover {
    background-color: ${theme.colors.shape(0.1)};
  }
`;

export const SubInput = styled.input`
  width: 100%;
  height: 2rem;

  background-color: ${theme.colors.shape(0.03)};
  border: 1px solid ${theme.colors.shape(0.01)};
  border-radius: 5px;

  transition: border-color 0.2s;

  padding: 0 0.5rem;

  color: ${theme.colors.shape()};

  &:focus {
    border-color: ${theme.colors.shape(0.02)};
    outline: 0;
  }
`;

export const SubValue = styled.div`
  width: 100%;
  text-transform: uppercase;

  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.3rem;

  & > strong {
    font-weight: 400;
    font-size: 0.5rem;
    color: ${theme.colors.shape(0.8)};
  }

  & > span {
    font-size: 0.875rem;
    color: ${theme.colors.primary()};
  }
`;

export const SubFooter = styled.div`
  width: 100%;

  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.5rem;
`;

export const SubButton = styled.button`
  width: 50%;
  height: 1.8rem;

  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.3rem;

  border-radius: 5px;
  text-transform: capitalize;

  color: ${theme.colors.shape()};

  border: 0;
  transition: all 0.2s;
  cursor: pointer;

  &:hover {
    transform: scale(0.95);
  }

  &:focus {
    border: 0;
    outline: 0;
  }
`;
