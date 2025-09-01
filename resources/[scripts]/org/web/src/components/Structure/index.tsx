import { ReactNode, useRef, useContext, useEffect, useState } from "react";
import * as S from "./styles";
import { FiUsers, FiBarChart, FiShoppingCart, FiLogOut } from "react-icons/fi";
import { RiVolumeUpLine } from "react-icons/ri";
import PagesContext from "../../contexts/PagesContext";
import { NuiContext } from "../../contexts/NuiContext";
import { UserContext } from "../../contexts/UserContext";
import { ModalContext } from "../../contexts/ModalContext";
import MensagemGeral from "../MensagemGeral";
import useMembersAmount from "../../hooks/useMembersAmount";
import useUserRole from "../../hooks/useUserRole";
import LogoFac from "../../assets/logo_fac.png";
import LogoJob from "../../assets/logo_job.png";

const logos = {
  fac: LogoFac,
  job: LogoJob,
};

type StructureProps = {
  children: ReactNode;
};

const Structure = ({ children }: StructureProps) => {
  const { currentPage, setCurrentPage } = useContext(PagesContext);
  const { setVisible } = useContext(NuiContext);
  const { user } = useContext(UserContext);
  const { setModal } = useContext(ModalContext);
  const { getMembersAmount, membersAmount } = useMembersAmount();
  const { getPermission } = useUserRole();

  const closeNui = () => {
    setVisible("off");
    setCurrentPage("login");
    fetch("http://org/close");
  };

  useEffect(() => {
    getMembersAmount();
  }, []);

  const items = useRef([
    {
      visible: true,
      label: "Membros",
      icon: <FiUsers />,
      action: () => setCurrentPage("membros"),
      active: currentPage === "membros",
    },
    {
      visible: user.has_products,
      label: "Metas",
      icon: <FiBarChart />,
      action: () => setCurrentPage("metas"),
      active: currentPage === "metas",
    },
    {
      visible: getPermission() !== "Membro",
      label: "Mensagem Geral",
      icon: <RiVolumeUpLine />,
      action: () => {
        setModal({
          text: (
            <>
              <RiVolumeUpLine /> Mensagem Geral
            </>
          ),
          content: <MensagemGeral />,
        });
      },
      active: false,
    },
    {
      visible: true,
      label: "Sair",
      icon: <FiLogOut />,
      action: closeNui,
    },
  ]);

  return (
    <S.Container>
      <S.Menu>
        <S.WrapLogo>
          {}
          <S.Logo src={logos[user.fac_type as `fac` | `job`]} />
          <S.Title>{user.fac}</S.Title>
        </S.WrapLogo>
        <S.MenuList>
          {items.current
            .filter((item) => item.visible)
            .map((item) => (
              <S.MenuItem
                key={item.label}
                onClick={item.action}
                active={item.active as boolean}
              >
                {item.icon}
                {item.label}
              </S.MenuItem>
            ))}
        </S.MenuList>
        <S.MembersAmount>
          {membersAmount.amount}/{membersAmount.vagas} <small>Membros</small>
        </S.MembersAmount>
      </S.Menu>
      {children}
    </S.Container>
  );
};

export default Structure;
