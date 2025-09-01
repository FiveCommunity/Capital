import React, { useContext, useEffect, useState } from "react";
import { NuiContext } from "../../contexts/NuiContext";
import { UserContext } from "../../contexts/UserContext";
import * as S from "./styles";
import { ToastContainer } from "react-toastify";
import Tablet from "../Tablet";
import GoalsSender from "../GoalsSender";
import { GoalsSenderContext } from "../../contexts/GoalsSenderContext";
import Fabrication from "../Fabrication";
import PagesContext from "../../contexts/PagesContext";

type DataProps = {
  action: "openPanel" | "openGoalsSender";
};

const Wrapper = () => {
  const { setCurrentPage } = useContext(PagesContext);
  const { visible, setVisible } = useContext(NuiContext);
  const { setUser } = useContext(UserContext);
  const { setProductsAndStorage } = useContext(GoalsSenderContext);

  const actions = {
    openPanel: (data: any) => {
      setUser(data.userData);
      setVisible("tablet");
    },
    openGoalsSender: (data: any) => {
      setProductsAndStorage(data.productsAndStorage);
      setUser(data.userData);
      setVisible("goalsSender");
    },
    openFabrication: (data: any) => {
      setProductsAndStorage(data.productsAndStorage);
      setUser(data.userData);
      setVisible("fabrication");
    },
  };

  const closeNui = () => {
    setVisible("off");
    setCurrentPage("login");
    fetch("http://org/close");
  };

  useEffect(() => {
    const openNui = ({ data }: { data: DataProps }) => {
      actions[data.action](data);
    };
    const handleCloseNui = (data: any) => {
      if (data.keyCode === 27) closeNui();
    };

    window.addEventListener("keydown", handleCloseNui);
    window.addEventListener("message", openNui);

    return () => {
      window.removeEventListener("message", openNui);
      window.removeEventListener("keydown", handleCloseNui);
    };
  }, []);

  return (
    <>
      {visible !== "off" && (
        <S.Container type={visible}>
          <ToastContainer position="top-center" theme="dark" />
          {visible === "tablet" && <Tablet />}
          {visible === "goalsSender" && <GoalsSender />}
          {visible === "fabrication" && <Fabrication />}
        </S.Container>
      )}
    </>
  );
};

export default Wrapper;
