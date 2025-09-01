// styles.js
import styled, { css } from "styled-components";

export const Wrap = styled.ul`
  position: absolute;
  display: flex;
  gap: 0.5rem;
  top: 2rem;
  right: 1.9rem;
  list-style: none;

  @media (max-width: 800px) {
    zoom: 0.7;
  }
`;

export const Info = styled.li`
  ${({ theme, talking }) => css`
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    width: 60px;
    height: 40px;
    background: rgba(65, 65, 65, 0.76);
    border: 1px ridge ${talking ? "#12AC5A" : "#fff"};
    border-radius: 6px;
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.5);

    .icon {
      font-size: 1rem;
      color: ${talking ? "#12AC5A" : "#fff"};
      margin-bottom: 2px;
    }

    & > span {
      color: #fff;
      font-size: 12px;
      font-weight: 600;
      text-align: center;
    }
  `}
`;
