import styled, { createGlobalStyle, css } from "styled-components";

export const theme = {
  colors: {
    shape: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
    dark: (opacity = 1) => `rgba(0, 0, 0, ${opacity})`,
    primary: (opacity = 1) => `rgba(18, 172, 90, ${opacity})`,
    health: (opacity = 1) => `rgba(224, 10, 61, ${opacity})`,
    progress: (opacity = 1) => `rgba(253, 125, 210, ${opacity})`,
    armor: (opacity = 1) => `rgba(226, 239, 238, ${opacity})`,
    oxygen: (opacity = 1) => `rgba(39, 245, 200, ${opacity})`,

    primary_sucess: (opacity = 1) => `rgba(21, 62, 25, ${opacity})`,
    secondary_sucess: (opacity = 1) => `rgba(62, 184, 96, ${opacity})`,

    primary_denied: (opacity = 1) => `rgba(69, 0, 0, ${opacity})`,
    secondary_denied: (opacity = 1) => `rgba(220, 49, 49, ${opacity})`,

    primary_important: (opacity = 1) => `rgba(0, 115, 52, ${opacity})`,
    secondary_important: (opacity = 1) => `rgba(52, 255, 96, ${opacity})`,

    primary_alert: (opacity = 1) => `rgba(0, 115, 52, ${opacity})`,
    secondary_alert: (opacity = 1) => `rgba(52, 255, 96, ${opacity})`,

    primary_stress: (opacity = 1) => `rgba(0, 115, 52, ${opacity})`,
    secondary_stress: (opacity = 1) => `rgba(52, 255, 96, ${opacity})`,

    primary_hunger: (opacity = 1) => `rgba(0, 115, 52, ${opacity})`,
    secondary_hunger: (opacity = 1) => `rgba(52, 255, 96, ${opacity})`,

    primary_thirst: (opacity = 1) => `rgba(0, 115, 52, ${opacity})`,
    secondary_thirst: (opacity = 1) => `rgba(52, 255, 96, ${opacity})`,
  },
  fonts: {
    family: {
      primary: "'Montserrat', sans-serif",
      secondary: "'Roboto Mono', monospace",
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
        // background-size: cover;
        // background-image: url("https://images.alphacoders.com/563/563020.jpg");
      }

      body,
      input,
      button,
      textarea {
        font-family: ${theme.fonts.family.primary};
      }

      .Toastify__toast-container--top-right {
        width: 20.5rem;
        height: 42.5rem;
        overflow: hidden;

        top: 5.2rem;
        right: 1.7rem;

        @media (max-height: 900px) {
          height: 37rem
        }

        @media (max-height: 768px) {
          height: 30rem
        }

        @media (max-height: 720px) {
          height: 27rem
        }

        @media (max-height: 664px) {
          height: 24rem
        }

        @media (max-height: 600px) {
          height: 20rem;
          zoom: 0.9;
        }
      }

      .Toastify__toast-container--top-center {
        top: 8rem;
        left: 51.5%;
      }

      .Toastify__toast-theme--push {
        min-height: 80.299px;

        font-family: ${theme.fonts.family.primary};

        background-image: linear-gradient(270deg, rgba(0, 0, 0, 0.80) 0%, rgba(0, 115, 52, 0.80) 100%);
        border-right: 4px ridge #12AC5A;

        clip-path: url(#notify);
      }

      .Toastify__toast-theme--dark {
        min-height: 80.299px;

        font-family: ${theme.fonts.family.primary};

        background-image: linear-gradient(120deg, rgba(0, 0, 0, 0.80) 0%, ${theme.colors.primary_hunger(
          0.8
        )} 100%);
        border-right: 4px ridge ${theme.colors.secondary_hunger()};

        clip-path: url(#notify);
      }

      .Toastify__toast-theme--request {
        width: 256px;
        
        display: flex;
        justify-content: center;
        align-items: center;

        font-family: ${theme.fonts.family.primary};

        border-radius: 7px;
        border: 1px ridge #12AC5A;

        background-color: transparent;

        padding: 0;
      }

      .Toastify__toast-theme--hunger {
        min-height: 80.299px;

        font-family: ${theme.fonts.family.primary};

        background-image: linear-gradient(120deg, rgba(0, 0, 0, 0.80) 0%, ${theme.colors.primary_hunger(
          0.8
        )} 100%);
        border-right: 4px ridge ${theme.colors.secondary_hunger()};

        clip-path: url(#notify);
      }

      .Toastify__toast-theme--thirst {
        min-height: 80.299px;

        font-family: ${theme.fonts.family.primary};

        background-image: linear-gradient(120deg, rgba(0, 0, 0, 0.80) 0%, ${theme.colors.primary_thirst(
          0.8
        )} 100%);
        border-right: 4px ridge ${theme.colors.secondary_thirst()};

        clip-path: url(#notify);
      }

      .Toastify__toast-theme--stress {
        min-height: 80.299px;

        font-family: ${theme.fonts.family.primary};

        background-image: linear-gradient(120deg, rgba(0, 0, 0, 0.80) 0%, ${theme.colors.primary_stress(
          0.8
        )} 100%);
        border-right: 4px ridge ${theme.colors.secondary_stress()};

        clip-path: url(#notify);
      }

      .Toastify__toast-theme--sucesso {
        min-height: 80.299px;

        font-family: ${theme.fonts.family.primary};

        background-image: linear-gradient(120deg, rgba(0, 0, 0, 0.80) 0%, ${theme.colors.primary_sucess(
          0.8
        )} 100%);
        border-right: 4px ridge ${theme.colors.secondary_sucess()};

        clip-path: url(#notify);
      }

      .Toastify__toast-theme--importante {
        min-height: 80.299px;

        font-family: ${theme.fonts.family.primary};

        background-image: linear-gradient(120deg, rgba(0, 0, 0, 0.80) 0%, ${theme.colors.primary_important(
          0.8
        )} 100%);
        border-right: 4px ridge ${theme.colors.secondary_important()};

        clip-path: url(#notify);
      }

      .Toastify__toast-theme--aviso {
        min-height: 80.299px;

        font-family: ${theme.fonts.family.primary};

        background-image: linear-gradient(120deg, rgba(0, 0, 0, 0.80) 0%, ${theme.colors.primary_alert(
          0.8
        )} 100%);
        border-right: 4px ridge ${theme.colors.secondary_alert()};

        clip-path: url(#notify);
      }

      .Toastify__toast-theme--negado {
        min-height: 80.299px;

        font-family: ${theme.fonts.family.primary};

        background-image: linear-gradient(120deg, rgba(0, 0, 0, 0.80) 0%, ${theme.colors.primary_denied(
          0.8
        )} 100%);
        border-right: 4px ridge ${theme.colors.secondary_denied()};

        clip-path: url(#notify);
      }

      :root {
        --Toastify__toast-container--top-right
        --Toastify__toast-container--bottom-right
      }

      .Toastify__close-button {
        display: none;
      }

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
        background: transparent;
        border-radius: 15px;
      }
    `}
`;

export const WrapHud = styled.section`
  display: flex;
  justify-content: center;
  height: 100vh;
  position: relative;

  // background: linear-gradient(
  //   0deg,
  //   rgba(0, 0, 0, 0.57) 0%,
  //   rgba(0, 0, 0, 0) 10%
  // );
`;

export const BottomLeft = styled.div`
  background-color: red;

  display: flex;
  gap: 1rem;

  position: absolute;
  bottom: 2rem;
  left: 1.4rem;

  .street {
    display: flex;
    align-items: center;
    gap: 0.5rem;

    width: 350px;

    position: absolute;

    bottom: 15rem;

    & > span {
      color: white;
    }

    & > svg {
      font-size: 1.3rem;

      color: white;
    }

   @media (max-height: 1024px) {
      bottom: 14rem;
    }

    @media (max-height: 960px) {
      bottom: 13rem;
    }

    @media (max-height: 900px) {
      bottom: 12rem;
    }

    @media (max-height: 800px) {
      bottom: 10rem;
    }
    
    @media (max-height: 768px) {
      bottom: 10rem;
    }

    @media (max-height: 664px) {
      bottom: 10.5rem;
      left: -12px;

      zoom: 0.8;
    }

    @media (max-height: 600px) {
      bottom: 9.5rem;
      left: -20px;

      zoom: 0.8;
    }
  }
`;

export const BottomCenter = styled.div`
  display: flex;
  flex-direction: column;

  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
`;

export const BottomRight = styled.div`
  display: flex;
  gap: 1rem;

  position: absolute;
  bottom: 2rem;
  right: 2rem;

  @media (max-width: 800px) {
    zoom: 0.8;
  }
`;

export const ContainerNotify = styled.div`
  width: 100%;

  display: flex;
  justify-content: space-around;
  align-items: flex-start;
  gap: 1rem;

  & > span {
    position: absolute;

    left: 1rem;
    top: 0.5rem;

    font-size: 0.5rem
  }
`;

export const ContainerRequest = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;

  min-width: 246px;
  min-height: 108px;

  border-radius: 4px;
  background: linear-gradient(270deg, rgba(0, 0, 0, 0.80) 0%, rgba(0, 115, 52, 0.80) 100%);

  gap: 1rem;

  padding: 1rem;
`;

export const IconBox = styled.div`
  ${({ theme, notifyType }) => css`
    display: flex;
    justify-content: center;
    align-items: center;

    padding: 0.5rem;

    background-color: ${theme.colors.shape(0.1)};
    border-radius: 10px;

    & > svg {
      font-size: 1.3rem;
      color: ${theme.colors[notifyType](1)};
    }

  `}
`;

export const IconPush = styled.div`
  ${({ theme }) => css`
    display: flex;
    justify-content: center;
    align-items: center;

    padding: 0 0.5rem;

    & > svg {
      font-size: 1.3rem;
      color: ${theme.colors.primary()};
    }
  `}
`;

export const HeaderPush = styled.div`
  width: 100%;

  display: flex;
  justify-content: space-between;
  align-items: center;
`;

export const InfosPush = styled.div`
  ${({ theme }) => css`
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 0.5rem;

    & > span {
      color: ${theme.colors.shape(0.8)};
      font-size: 0.7rem;
    }

    & > svg {
      font-size: 1.2rem;
    }
  `}
`;

export const ContentRequest = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;

  gap: 0.1rem;

  & > strong {
    color: #12AC5A;

    text-align: center;

    font-size: 14px;
    font-style: normal;
    font-weight: 600;
    line-height: normal;
  }

  & > p {
    color: #FFF;
    text-align: center;
    font-size: 12px;
    font-style: normal;
    font-weight: 400;
    line-height: normal;
    letter-spacing: -0.48px;
  }
`;

export const ContentNotify = styled.div`
  flex: 1;
  display: flex;
  align-items: flex-end;
  justify-content: center;
  flex-direction: column;
  gap: 0.1rem;

  & > strong {
    width: 171px;

    color: #3eb860;
    font-size: 14px;
    font-weight: 600;
    line-height: normal;
    letter-spacing: -0.84px;
  }

  & > p {
    width: 170px;

    color: #fff;
    font-size: 12px;
    font-weight: 400;
    line-height: normal;
    letter-spacing: -0.48px;
  }

  .autor {
    margin-top: 12.46px;

    width: 170px;

    color: #CACACA;

    font-size: 12px;
    font-style: normal;
    font-weight: 400;
    line-height: 16px; /* 133.333% */
    letter-spacing: -0.72px;
  }
`;

export const RequestActions = styled.div`
  width: 100%;
  display: flex;
  align-items: center;
  margin-top: 0.8rem;
  gap: 0.5rem;
`;

export const RequestButton = styled.div`
  width: 100.26px;
  height: 26.139px;

  display: flex;
  justify-content: center;
  align-items: center;

  clip-path: url(#requestleft);

  background-color: #12AC5A;

  color: #FFF;
  font-size: 8.437px;
  font-style: normal;
  font-weight: 800;
  line-height: normal;

  text-transform: uppercase;
`;
