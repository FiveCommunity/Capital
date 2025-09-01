import * as S from "./styles";

import { motion } from "framer-motion";
import { toast } from "react-toastify";

import { FaCar, FaPhone } from "react-icons/fa";
import { AiOutlineAim } from "react-icons/ai";
import { TiLocation } from "react-icons/ti";
import { IoIosClose } from "react-icons/io";

import { useCallback, useEffect, useRef } from "react";
import { useRequest } from "../../hooks/useRequest";

import { Car } from "../../assets/svgs/TriangleCar";
import { Default } from "../../assets/svgs/TriangleDefault";
import { Medic } from "../../assets/svgs/TriangleMedic";
import { FaLocationArrow } from "react-icons/fa";
import { MdLocalPhone } from "react-icons/md";


export function NotifyPush({ notifications, clear, remove, setPush }) {
  const containerRef = useRef(null);
  const { request } = useRequest();

  const notifyConfig = {
    default: <Default />,
    car: <Car />,
    route: <Default />,
    medic: <Medic />
  };

  useEffect(() => {
    containerRef.current.focus();
  }, []);

  const handleWaypoint = useCallback(
    async (coords) => {
      await request("Waypoint", coords);
    },
    [request]
  );

  const handlePhone = useCallback(
    async (number) => {
      await request("Phone", number);
    },
    [request]
  );

  const handleClose = useCallback(async () => {
    setPush(false);
    await request("Close");
  }, [request]);

  const handleKeyDown = (e) => {
    if (e.keyCode === 27) handleClose();
  };

  return (
    <motion.div
      initial={{ x: 0, opacity: 0 }}
      animate={{ x: 0, opacity: 1 }}
      exit={{ x: 0, opacity: 0 }}
      layout
    >
      <S.Container ref={containerRef} tabIndex={0} onKeyDown={handleKeyDown}>
        <S.Wrap>
          <S.Content>
            <S.NotifysWrap>
              {notifications.map((notification) => {
                const { data, notificationCenter } =
                  notification.content.props.toastProps;
                if (!notificationCenter) return;
                toast.dismiss(notification.id);
                return (
                  <S.Notifys key={notification.id} id={notification.id}>
                    <S.ContainerNotify>
                      <S.ContentNotifyLeft>
                        {notifyConfig[data.type]}
                        <S.InfosPush>
                          {data.phone && (
                            <MdLocalPhone
                            style={{fontSize: "0.7rem"}}
                              onClick={() => handlePhone(data.phone)}
                            />
                          )}
                          <FaLocationArrow
                            onClick={() => handleWaypoint(data.coords)}
                          />
                          <IoIosClose
                            onClick={() => remove(notification.id)}
                            className="close"
                          />
                        </S.InfosPush>
                      </S.ContentNotifyLeft>
                      <S.ContentNotify>
                        <strong>{data.title}</strong>
                        <p
                          dangerouslySetInnerHTML={{ __html: data.message }}
                        />
                      </S.ContentNotify>
                    </S.ContainerNotify>
                  </S.Notifys>
                );
              })}
            </S.NotifysWrap>
            <S.CleanNotifys onClick={clear}>
              Limpar notificações
            </S.CleanNotifys>
          </S.Content>
        </S.Wrap>
      </S.Container>
    </motion.div>
  );
}
