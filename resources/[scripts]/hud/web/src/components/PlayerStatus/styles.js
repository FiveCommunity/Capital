import styled, { css, keyframes } from "styled-components";

const fadeIn = keyframes`
  from {
    width: 0;
  }
  to {
    width: 100%;
  }
`;

export const Wrap = styled.div`
  display: flex;
  justify-content: flex-start;
  flex-direction: column;
  align-items: center;
  gap: 10px;

  .mask {
    width: 0;
    height: 0;
    position: absolute;
  }
`;

export const Container = styled.div`
  display: flex;
`;

export const Weapon = styled.div`
  position: absolute;

  top: -70px;
  right: -25px;

  width: 100px;

  display: flex;
  align-items: center;
  gap: 0.5rem;

  & > svg {
    color: red;
  }
`

export const Ammo = styled.div`
  & > strong {
    color: #FFF;

    font-size: 23.364px;
    font-style: normal;
    font-weight: 800;
    line-height: normal;
  }

  & > span {
    color: #FFF;

    font-size: 12.36px;
    font-style: normal;
    font-weight: 800;
    line-height: normal;
  }
`

export const Triangle = styled.div`
  ${({ timer }) => css`
    position: relative;

    .icon {
      position: absolute;

      top: 12px;
      right: 5px;

      z-index: 2;

      width: 15px;
    }

    .triangle {
      width: 35px;
      height: 36px;

      display: flex;
      justify-content: flex-end;

      clip-path: url(#triangle);

      ${timer <= 0 && "transition: all 0.3s"};

      .fill {
        width: 100%;
        height: 100%;

        animation: ${fadeIn} ${timer}s ease-in-out;
      }
    }

    .triangle-border {
      position: absolute;

      top: -5.7px;
      right: -3px;
    }
  `}
`

export const Bars = styled.div`
  .health {
    display: flex;
    align-items: flex-end;

    width: 39.139px;
    height: 97.867px;

    background-color: #3c7155;

    clip-path: url(#line);

    position: absolute;

    right: 16px;
    top: 10px;
  }

  .armour {
    display: flex;
    align-items: flex-end;

    width: 39.139px;
    height: 24.637px;

    background-color: #6a6a6a;

    clip-path: url(#line-2);

    position: absolute;

    right: 14px;
    bottom: 10px;
  }

  .oxygen {
    display: flex;
    align-items: flex-end;

    width: 39.139px;
    height: 24.637px;

    background-color: #6a6a6a;

    clip-path: url(#line-2);

    position: absolute;

    right: 28px;
    bottom: 0px;
  }

  .fill {
    width: 100%;
    height: 100%;
    transition: all 0.3s;
  }
`;

export const Infos = styled.div`
  display: flex;
  align-items: flex-end;
  justify-content: center;
  flex-direction: column;

  & > svg {
    color: white;
  }

  .icon-oxygen {
    position: absolute;

    bottom: -10px;
    right: 14px;

    width: 14.244px;
    height: 13.337px;
  }
`;

export const Primary = styled.div`
  display: flex;
  align-items: flex-end;
  justify-content: center;
  flex-direction: column;
  gap: 0.375rem;

  .box {
    position: relative;

    width: 15.5rem;
    height: 1.4rem;

    display: flex;
    align-items: center;
    justify-content: flex-end;

    background-color: rgba(0, 0, 0, 0.44);

    clip-path: url(#primaryHud);

    .fill {
      width: 50%;
      height: 100%;

      clip-path: url(#primaryHud);

      transition: all 0.2s;
    }
  }

  .box-oxygen {
    width: 166.774px;
    height: 11px;

    display: flex;
    align-items: center;
    justify-content: flex-end;

    background-color: rgba(0, 0, 0, 0.44);

    clip-path: url(#oxygenHud);

    .fill {
      width: 50%;
      height: 100%;

      clip-path: url(#oxygenHud);
    }
  }

  svg {
    position: absolute;

    font-size: 0.875rem;

    right: 0.3rem;

    color: white;

    z-index: 999;

    filter: drop-shadow(1px 1px 2px rgba(255, 255, 255, 1));
  }
`;

export const Secondary = styled.div`
  width: 15.5rem;
  height: 1.4rem;

  display: flex;
  align-items: center;
  justify-content: flex-end;

  .box {
    position: relative;

    display: flex;
    justify-content: center;
    align-items: center;

    .infos {
      position: absolute;

      display: flex;
      justify-content: center;
      align-items: center;
      gap: 0.1875rem;

      & > span {
        font-size: 12px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
        letter-spacing: -0.72px;
        color: #ff7d34;
      }

      & > svg {
        font-size: 0.875rem;
      }
    }
  }
`;
