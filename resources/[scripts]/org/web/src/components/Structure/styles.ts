import styled, { css } from "styled-components";
import { theme } from "../../styles";

export const Container = styled.div`
  background-color: ${theme.colors.secondary};
  width: 100%;
  height: 100%;
`;

export const Menu = styled.div`
  background-color: rgba(0, 0, 0, 0.5);
  width: 100%;
  height: 75px;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
`;

export const WrapLogo = styled.div`
  display: flex;
  gap: 10px;
  align-items: center;
`;

export const Logo = styled.img`
  width: 40px;
filter: brightness(0) saturate(100%) invert(49%) sepia(61%) saturate(1682%) hue-rotate(155deg) brightness(102%) contrast(98%);
`;

export const Title = styled.h1`
  font-size: 16px;
  letter-spacing: 2px;
  color: white;
  font-weight: bold;

  & > b {
    color: ${theme.colors.primary};
  }
`;

export const MenuList = styled.nav`
  display: flex;
  gap: 20px;
  align-items: center;
`;

type MenuItemProps = {
  active: boolean;
};

export const MenuItem = styled.button<MenuItemProps>`
  background-color: transparent;
  color: white;
  font-weight: bold;
  font-size: 13px;
  display: flex;
  align-items: center;
  gap: 5px;
  border: 0;
  transition: all 0.2s;
  padding: 10px;
  cursor: pointer;
  border-radius: 2px;
  border-radius: 5px;

  & > svg {
    font-size: 18px;
    color: ${theme.colors.primary};
  }

  ${({ active }) => css`
    ${active &&
    css`
      background-color: ${theme.colors.primary};

      & > svg {
        color: white;
      }
    `}
  `}

  &:hover {
    background-color: ${theme.colors.primary};

    & > svg {
      color: white;
    }
  }
`;

export const MembersAmount = styled.div`
  background-color: ${theme.colors.primary};
  border-radius: 20px;
  color: white;
  padding: 10px;
  display: flex;
  font-size: 14px;
  justify-content: center;
  align-items: center;
  height: 40px;
  gap: 5px;

  & > small {
    font-size: 12px;
  }
`;
