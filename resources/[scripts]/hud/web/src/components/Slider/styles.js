import styled, { css } from "styled-components";
import * as Slider from "@radix-ui/react-slider";

export const Container = styled.div`
  ${({ ruler }) => css`
    width: 19.5rem;
    display: flex;
    flex-direction: column;
    gap: 1rem;

    ${ruler &&
    css`
      margin-bottom: 1rem;
    `}

    @media (max-width: 1399px) {
      width: 18rem;
    }

    @media (max-width: 1199px) {
      width: 16rem;
    }
  `}
`;

export const Wrap = styled.div`
  ${({ theme }) => css`
    display: flex;
    align-items: center;
    gap: 1rem;

    & > svg {
      color: ${theme.colors.shape()};
    }
  `}
`;

export const Display = styled.input`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.02)};

    border: 0.5px ridge ${theme.colors.shape(0.1)};
    min-width: 2.5rem;
    height: 1.5rem;
    color: ${theme.colors.shape()};
    border-radius: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
    outline: none;
    text-align: center;

    &::-webkit-outer-spin-button,
    &::-webkit-inner-spin-button {
      -webkit-appearance: none;
      margin: 0;
    }

    /* Firefox */
    &[type="number"] {
      -moz-appearance: textfield;
    }
  `}
`;

export const FullSlider = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
`;

export const Root = styled(Slider.Root)`
  position: relative;
  display: flex;
  align-items: center;
  user-select: none;
  touch-action: none;
  min-width: 200px;
  width: 100%;
  height: 20px;
`;

export const Track = styled(Slider.Track)`
  ${({ theme }) => css`
    background-color: ${theme.colors.shape(0.08)};
    position: relative;
    overflow: hidden;

    flex-grow: 1;
    border-radius: 5px;
    height: 0.3rem;
  `}
`;

export const Range = styled(Slider.Range)`
  ${({ theme }) => css`
    background-color: ${theme.colors.primary()};
    position: absolute;
    height: 100%;
  `}
`;

export const Thumb = styled(Slider.Thumb)`
  ${({ theme }) => css`
    display: block;
    width: 1rem;
    height: 1rem;
    background-color: ${theme.colors.primary()};
    border-radius: 50%;
    box-shadow: 0 2px 10px ${theme.colors.dark(0.5)};
    outline: none;
    cursor: pointer;
  `}
`;

export const Ruler = styled.div`
  width: 100%;
  height: 1px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
`;

export const Max = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    margin-top: 1rem;
    font-size: 0.7rem;
  `}
`;

export const Middle = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    margin-top: 1rem;
    font-size: 0.7rem;
  `}
`;

export const Min = styled.div`
  ${({ theme }) => css`
    color: ${theme.colors.shape()};
    margin-top: 1rem;
    font-size: 0.7rem;
  `}
`;
