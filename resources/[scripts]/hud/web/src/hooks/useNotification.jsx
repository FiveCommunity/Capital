import * as GS from "../styles";

import AudioAdmMessage from "../assets/sounds/message.ogg";
import AudioPushMessage from "../assets/sounds/push_sound.wav";

import { useRef } from "react";
import { toast, Slide } from "react-toastify";

import { FaDrumstickBite, FaCar, FaPoop, FaToilet } from "react-icons/fa";
import { GiWaterDrop, GiBrain } from "react-icons/gi";
import { TbAlertTriangleFilled } from "react-icons/tb";
import { BsClockHistory } from "react-icons/bs";
import { TiLocation } from "react-icons/ti";
import {
  AiFillExclamationCircle,
  AiFillCheckCircle,
  AiFillCloseCircle,
  AiOutlineAim,
  AiOutlineQuestion,
} from "react-icons/ai";
import { PiSirenFill } from "react-icons/pi";

import { Sucess } from "../assets/svgs/TriangleSucess";
import { Denied } from "../assets/svgs/TriangleDenied";
import { Important } from "../assets/svgs/TriangleImportant";
import { Alert } from "../assets/svgs/TriangleAlert";
import { Hunger } from "../assets/svgs/TriangleHunger";
import { Thirst } from "../assets/svgs/TriangleThirst";
import { Announce } from "../assets/svgs/AnnounceIcon";
import { Default } from "../assets/svgs/TriangleDefault"
import { Car } from "../assets/svgs/TriangleCar";
import { Medic } from "../assets/svgs/TriangleMedic"

function useNotification() {
  const requests = useRef({});

  const launchNotifyPush = (
    type,
    title,
    message,
    coords,
    hour,
    phone,
    time = 30000
  ) => {
    const audio = new Audio(AudioPushMessage);
    audio.volume = 0.1;
    audio.play();

    const notifyConfig = {
      default: <Default />,
      car: <Car />,
      route: <Default />,
      medic: <Medic />
    };

    toast(
      <GS.ContainerNotify>
        <GS.ContentNotify>
          <strong style={{ color: "#12AC5A" }}>{title}</strong>
          <p
            dangerouslySetInnerHTML={{
              __html: message,
            }}
          />
        </GS.ContentNotify>
        {notifyConfig[type]}
      </GS.ContainerNotify>,
      {
        notificationCenter: true,
        theme: "push",
        autoClose: time,
        position: "top-right",
        hideProgressBar: true,
        transition: Slide,
        data: {
          type: type,
          title: title,
          message: message,
          coords: coords,
          hour: hour,
          phone: phone
        },
      }
    );
  };

  const launchNotify = (type, title, message, time = 5000) => {
    const notifyConfig = {
      sucesso: { svg: <Sucess />, color: GS.theme.colors.secondary_sucess() },
      negado: { svg: <Denied />, color: GS.theme.colors.secondary_denied() },
      importante: {
        svg: <Important />,
        color: GS.theme.colors.secondary_important(),
      },
      aviso: {
        svg: <Alert />,
        color: GS.theme.colors.secondary_alert(),
      },
      hunger: { svg: <Hunger />, color: GS.theme.colors.secondary_hunger() },
      thirst: { svg: <Thirst />, color: GS.theme.colors.secondary_thirst() },
    };

    toast(
      <GS.ContainerNotify>
        <GS.ContentNotify>
          <strong style={{ color: notifyConfig[type].color }}>{title}</strong>
          <p
            dangerouslySetInnerHTML={{
              __html: message,
            }}
          />
        </GS.ContentNotify>
        {notifyConfig[type].svg}
      </GS.ContainerNotify>,
      {
        theme: type,
        autoClose: time,
        position: "top-right",
        transition: Slide,
        hideProgressBar: true,
      }
    );
  };

  const launchProgressBar = (title, time = 5000) => {
    toast(
      <GS.ContainerNotify>
        <BsClockHistory />
        <GS.ContentNotify>
          <strong>{title}</strong>
        </GS.ContentNotify>
      </GS.ContainerNotify>,
      { autoClose: time, position: "bottom-center" }
    );
  };

  const removeRequest = (id) => {
    toast.dismiss(requests.current[id]);
    let newRequestsList = requests.current;
    delete newRequestsList[id];
    requests.current = newRequestsList;
  };

  const launchRequest = (id, title, message, time = 30000) => {
    requests.current[id] = toast(
      <GS.ContainerRequest>
        <GS.ContentRequest>
          <strong>{title}</strong>
          <p
            dangerouslySetInnerHTML={{
              __html: message,
            }}
          />
          <GS.RequestActions>
            <GS.RequestButton>
              Aceitar (Y)
            </GS.RequestButton>
            <GS.RequestButton
              style={{ clipPath: "url(#requestright)" }}
            >
              Negar (U)
            </GS.RequestButton>
          </GS.RequestActions>
        </GS.ContentRequest>
      </GS.ContainerRequest>,
      {
        theme: "request",
        autoClose: time,
        position: "top-center",
      }
    );
  };

  const launchAnnounce = (
    title,
    message,
    author,
    playAudio,
    time = 5000
  ) => {
    if (playAudio) {
      const audio = new Audio(AudioAdmMessage);
      audio.volume = 0.1;
      audio.play();
    }
    toast(
      <GS.ContainerNotify>
        <GS.ContentNotify>
          <strong style={{color: "#12AC5A"}}>{title}</strong>
          <p
            dangerouslySetInnerHTML={{
              __html: message,
            }}
          />
          <span className="autor">- {author}</span>
        </GS.ContentNotify>
        <Announce />
      </GS.ContainerNotify>,
      {
        theme: "dark",
        autoClose: time,
        position: "top-right",
        transition: Slide,
        hideProgressBar: true,
      }
    );
  };

  return {
    launchNotify,
    launchAnnounce,
    launchProgressBar,
    launchRequest,
    removeRequest,
    launchNotifyPush,
  };
}

export default useNotification;
