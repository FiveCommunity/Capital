import styled, { css } from "styled-components";

export const Wrap = styled.div`
  width: 100%;
  height: 100%;

  display: flex;

  .mask {
    width: 0;
    height: 0;
    position: absolute;
  }
`;

export const Velocimeter = styled.div`
  position: relative;

  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;

  margin-bottom: 2rem;

  & > span {
    color: #fff;

    leading-trim: both;

    text-edge: cap;
    font-family: Poppins;
    font-size: 28.817px;
    font-weight: 700;
    line-height: normal;
    letter-spacing: -1.729px;

    margin-bottom: -0.2rem;
  }

  .fuel {
    position: absolute;

    left: -13px;
    bottom: 18px;
  }

  .nitro {
    position: absolute;

    left: 13px;
    bottom: 10px;
  }

  .engine {
    position: absolute;

    right: -13px;
    bottom: 18px;
  }

  .gas {
    position: absolute;

    right: 10px;
    bottom: 10px;
  }
`;

export const Infos = styled.div`
  display: flex;
  gap: 0.3rem;
  color: #fff;

  font-size: 11.385px;
  font-weight: 600;
  line-height: normal;
  letter-spacing: -0.683px;

  margin-bottom: -4.3rem;
`;

export const Line = styled.div`
  width: 129px;
  height: 103.772px;

  display: flex;

  background-color: #3c7155;

  clip-path: url(#line-left);
`;

export const LineSecondary = styled.div`
  margin-top: -5.3rem;

  width: 106.5px;
  height: 90.869px;

  display: flex;

  background-color: #6a6a6a;

  clip-path: url(#line-two-left);
`;

export const Fill = styled.div`
  width: 50%;
  background-color: #12AC5A;

  border-radius: 2px;

  transition: all 0.3s;

  &.purge {
    background-color: transparent;
    background-image: linear-gradient(
      to left,
      #12AC5A 0px,
      rgb(252, 255, 74) 50px,
      rgb(242, 84, 29) 90px
    );
  }
`;

export const Left = styled.div`
  display: flex;
  flex-direction: column;
  align-items: flex-end;
`;

export const Right = styled.div`
  display: flex;
  flex-direction: column;
  align-items: flex-start;
`;

export const Velocity = styled.div`
  color: white;

  leading-trim: both;
  text-edge: cap;
  font-style: normal;
  line-height: normal;

  & > span {
    font-family: Poppins;

    font-size: 31.158px;
    letter-spacing: -1.869px;
    font-weight: 700;
  }

  & > small {
    font-size: 14px;
    font-weight: 600;
    letter-spacing: -0.84px;

    margin-left: 0.2rem;
  }
`;

export const Status = styled.div`
  display: flex;
  align-items: center;
  gap: 0.5rem;

  & > svg {
    color: #b8b8b8;
  }
`;

export const VehicleInfos = styled.div`
  width: 359.19px;
`;
