import styled, { css } from "styled-components";

export const Container = styled.div`
  display: flex;
  flex-direction: column;
  gap: 1rem;
`;

export const Wrap = styled.div`
  width: 25rem;
  height: 35rem;

  display: flex;
  flex-direction: column;
  gap: 1rem;

  @media (max-width: 1399px) {
    width: 20rem;
  }

  @media (max-width: 1199px) {
    width: 18rem;
  }

  @media (max-height: 900px) {
    overflow-y: scroll;
    overflow-x: visible;

    height: 25rem;
  }

  @media (max-height: 750px) {
    height: 23rem;
  }

  @media (max-height: 700px) {
    height: 20rem;
  }

  @media (max-height: 650px) {
    height: 15rem;
  }
`;
