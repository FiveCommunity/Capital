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
          width: 1.5px;
        }

        /* Track */
        ::-webkit-scrollbar-track {
          background: transparent;
          border-radius: 15px;
        }

        /* Handle */
        ::-webkit-scrollbar-thumb {
          background: ${theme.colors.primary()};
          border-radius: 15px;
        }

        /* Handle on hover */
        ::-webkit-scrollbar-thumb:hover {
          background: ${theme.colors.primary(0.5)};
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
`;
