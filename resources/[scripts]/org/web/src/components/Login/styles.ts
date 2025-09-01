import styled, { css } from "styled-components";
import { theme } from "../../styles";
import BgLoginFac from "../../assets/bg_login_fac.png";
import BgLoginJob from "../../assets/bg_login_Job.png";

type ContainerProps = {
  facType: "fac" | "job";
};

export const Container = styled.section<ContainerProps>`
  background-image: url("https://i.pinimg.com/originals/4e/59/f7/4e59f73b7ba16a3c9d5f8b82e60908c3.jpg");
  background-size: cover;
  background-position: center top;
  width: 100%;
  height: 100%;
`;

export const Filter = styled.div`
  background-color: ${theme.colors.dark(0.8)};
  background-image: linear-gradient(
    to right top,
    ${theme.colors.primary_opacity(0.2)},
    ${theme.colors.dark(0.8)}
  );

  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
`;

export const BtnLogin = styled.button`
  background-color: ${theme.colors.secondary};
  width: 350px;
  padding: 50px 10px;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
  border: 3px solid ${theme.colors.secondary};
  cursor: pointer;
  transition: all 0.2s;

  &:hover {
    background-color: #131313;
  }
`;

export const Title = styled.h1`
  font-size: 22px;
  letter-spacing: 2px;
  color: white;
  font-weight: 400;

  & > b {
    color: ${theme.colors.primary};
  }
`;

export const WrapLogo = styled.div`
  background-color: rgba(0, 0, 0, 0.5);
  padding: 20px;
  border-radius: 50%;
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
`;

export const Logo = styled.img`
  width: 64px;
  height: auto;
filter: brightness(0) saturate(100%) invert(49%) sepia(61%) saturate(1682%) hue-rotate(155deg) brightness(102%) contrast(98%);
`;
