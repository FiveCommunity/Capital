import React, { useContext } from "react";
import PagesContext from "../../contexts/PagesContext";
import Error404 from "../Error404";
import Membros from "../Membros";
import Login from "../Login";
import Metas from "../Metas";
import * as S from "./styles";
import Modal from "../Modal";
import ModalContextProvider from "../../contexts/ModalContext";
import DetailsContextProvider from "../../contexts/DetailsContext";
import DetailsModal from "../Details";

export type TableProps = {
  children: React.ReactNode;
};

const Tablet = () => {
  const { currentPage } = useContext(PagesContext);

  const pages = {
    login: <Login />,
    membros: <Membros />,
    metas: <Metas />,
    default: <Error404 />,
  };

  return (
    <S.Container>
      <S.Border>
        <DetailsContextProvider>
          <ModalContextProvider>
            <S.Screen>
              <Modal />
              <DetailsModal />
              {pages[currentPage as keyof typeof pages] ?? pages["default"]}
            </S.Screen>
          </ModalContextProvider>
        </DetailsContextProvider>
      </S.Border>
    </S.Container>
  );
};

export default Tablet;
