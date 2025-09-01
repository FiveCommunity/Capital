import { useCallback, useEffect, useState } from "react";
import { ThemeProvider } from "styled-components";
import * as S from "./styles";

import LogoPNG from "./assets/images/logo.png";

import { useNotificationCenter } from "react-toastify/addons/use-notification-center";
import Logo from "./components/Logo";
import TopInfos from "./components/TopInfos";
import PlayerStatus from "./components/PlayerStatus";
import Velocimeter from "./components/Velocimeter";
import "react-toastify/dist/ReactToastify.css";
import { ToastContainer } from "react-toastify";
import useNotification from "./hooks/useNotification";
import Prompt from "./components/Prompt";
import Clipboard from "./components/Clipboard";
import { useRequest } from "./hooks/useRequest";

import { Radar } from "./components/Radar";
import { Radio } from "./components/Radio";
import { NotifyPush } from "./components/NotifyPush";
import { NotifyItems } from "./components/NotifyItems";
import { Hoverfy } from "./components/Hoverfy";
import { Shortcuts } from "./components/Shortcuts";

import { TiLocation } from "react-icons/ti";

import { NotifyContainer } from "./assets/svgs/NotifyContainer";
import { RequestLeft } from "./assets/svgs/RequestButtonLeft";
import { RequestRight } from "./assets/svgs/RequestButtonRight";
import { NotifyContainerLeft } from "./assets/svgs/NotifyContainerLeft";

function App() {
  const { notifications, clear, remove } = useNotificationCenter();
  const { request } = useRequest();

  // Main
  const [hud, setHud] = useState(true);
  const GenerateId = () => "_" + Math.random().toString(36).substr(2, 9);

  // Top Info
  const [street, setStreet] = useState("");
  const [direction, setDirection] = useState("");
  const [mhz, setMhz] = useState(0);
  const [voice, setVoice] = useState("Normal");
  const [talking, setTalking] = useState(false);
  const [wanted, setWanted] = useState(0);
  const [time, setTime] = useState("00:00");

  // Player Stats
  const [health, setHealth] = useState(0);
  const [armour, setArmour] = useState(0);
  const [hunger, setHunger] = useState(0);
  const [thirst, setThirst] = useState(0);
  const [oxygen, setOxygen] = useState(-1);
  const [stress, setStress] = useState(0);
  const [urine, setUrine] = useState(0);
  const [poop, setPoop] = useState(0);
  const [progress, setProgress] = useState({
    show: false,
    timer: 0,
  });

  // Vehicle Stats
  const [vehHud, setVehHud] = useState(false);
  const [speed, setSpeed] = useState(0);
  const [fuel, setFuel] = useState(0);
  const [engineHealth, setEngineHealth] = useState(0);
  const [locked, setLocked] = useState(false);
  const [seatbelt, setSeatbelt] = useState(false);
  const [light, setLight] = useState(0);
  const [purge, setPurge] = useState(0.0);
  const [nitro, setNitro] = useState(0.0);

  // Others
  const [questions, setQuestions] = useState([]);
  const [clipboard, setClipboard] = useState([]);
  const [weapon, setWeapon] = useState({
    show: false,
    name: "",
    currentAmmo: 0,
    maxAmmo: 0,
  });
  const [radar, setRadar] = useState({
    show: false,
    frontal: {
      plate: "",
      model: "",
      speed: 0,
    },
    rear: {
      plate: "",
      model: "",
      speed: 0,
    },
  });
  const [radio, setRadio] = useState(false);
  const [volume, setVolume] = useState(100);
  const [push, setPush] = useState(false);
  const [items, setItems] = useState([]);
  const [hoverfy, setHoverfy] = useState({
    show: false,
    key: "",
    text: "",
  });
  const [shortcuts, setShortcuts] = useState({
    show: false,
  });

  // Notifys
  const {
    launchNotify,
    launchRequest,
    launchAnnounce,
    removeRequest,
    launchNotifyPush,
  } = useNotification();

  const actions = {
    // Main
    updateHud: (value) => setHud(value),

    // Top Info
    updateStreet: (value) => setStreet(value),
    updateDirection: (value) => setDirection(value),
    updateRadioChannel: (value) => setMhz(value),
    updateVoice: (value) => setVoice(value),
    updateTalking: (value) => setTalking(value),
    updateWanted: (value) => setWanted(value),
    updateTime: (value) => setTime(value),

    // Player Stats
    updateHealth: (value) => setHealth(value),
    updateArmour: (value) => setArmour(value),
    updateHunger: (value) => setHunger(value),
    updateThirst: (value) => setThirst(value),
    updateOxygen: (value) => setOxygen(value),
    updateStress: (value) => setStress(value),
    updateUrine: (value) => setUrine(value),
    updatePoop: (value) => setPoop(value),
    updateEngineHealth: (value) => setEngineHealth(value),
    progress: (value) => {
      setProgress((old) => {
        if (!old.show || value === 0) {
          setTimeout(() => setProgress({ show: false, timer: 0 }), value);
          return { show: true, timer: value / 1000 };
        }
        return old;
      });
    },

    // Vehicle Stats
    updateHudVehicle: (value) => setVehHud(value),
    updateSpeed: (value) => setSpeed(value),
    updateFuel: (value) => setFuel(value),
    updateLocked: (value) => setLocked(value),
    updateSeatbelt: (value) => setSeatbelt(value),
    updateLight: (value) => setLight(value),
    updateNitro: (value) => setNitro(value),
    updatePurge: (value) => setPurge(value),

    // Notifys
    notify: ({ type, title, message, time }) => {
      launchNotify(type, title, message, time);
    },
    announcement: ({ title, message, author, playAudio, time }) => {
      launchAnnounce(title, message, author, playAudio, time);
    },

    // Others
    request: ({ id, title, message, time }) => {
      launchRequest(id, title, message, time);
    },
    prompt: ({ questions }) => {
      setQuestions(questions);
    },
    removeRequest: ({ id }) => {
      removeRequest(id);
    },
    clipboard: (clipboard) => {
      setClipboard(clipboard);
    },

    updateWeapon: ({ show, name, currentAmmo, maxAmmo }) => {
      setWeapon({
        show,
        name,
        currentAmmo,
        maxAmmo,
      });
    },
    updateRadar: ({ show, frontal, rear }) => {
      setRadar({
        show: show,
        frontal: frontal,
        rear: rear,
      });
    },
    updateRadio: (value) => setRadio(value),
    updateNotifyPush: ({ type, title, message, coords, hour, phone, time }) => {
      launchNotifyPush(type, title, message, coords, hour, phone, time);
    },
    notifyCenter: (value) => setPush(value),
    notifyItem: ({ type, item, amount, index, time = 8000 }) => {
      const id = GenerateId();
      setItems((old) => [
        ...old,
        {
          type: type,
          item: item,
          amount: amount,
          index: index,
          time: time,
          id: id,
        },
      ]);
      setTimeout(() => {
        setItems((old) => old.filter((n) => n.id !== id));
      }, time);
    },
    shortcut: ({ show, hotbar }) => {
      setShortcuts({ show, hotbar });
    },
    hoverfy: ({ show, key, text }) => {
      setHoverfy({ show: show, key: key, text: text });
    },
  };

  const nuiMessage = useCallback(
    (event) => {
      const { method, data } = event.data;
      if (method && actions[method]) {
        actions[method](data);
      }
    },
    [setHud]
  );

  const handleReady = useCallback(async () => {
    await request("NuiReady");
  }, [request]);

  useEffect(() => {
    handleReady();
    window.addEventListener("message", nuiMessage);
    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage]);

  return (
    <ThemeProvider theme={S.theme}>
      <S.GlobalStyle />

      <NotifyContainer />
      <NotifyContainerLeft />
      <RequestLeft />
      <RequestRight />
      
      <ToastContainer
        theme="dark"
        position="bottom-center"
        pauseOnHover={false}
        pauseOnFocusLoss={false}
      />
      
      {items.length !== 0 && <NotifyItems items={items} />}
      {shortcuts.show && <Shortcuts shortcuts={shortcuts} />}

      {push && (
        <NotifyPush
          notifications={notifications}
          clear={clear}
          remove={remove}
          setPush={setPush}
        />
      )}
      {radio && (
        <Radio
          theme={S.theme}
          volume={volume}
          setVolume={setVolume}
          setRadio={setRadio}
        />
      )}
      <Prompt questions={questions} setQuestions={setQuestions} />
      <Clipboard clipboard={clipboard} setClipboard={setClipboard} />
      {clipboard.length === 0 && questions.length === 0 && hud && (
        <>
          <S.WrapHud>
            <Logo src={"http://189.127.164.125/capital/logo.png"} />
            <TopInfos
              data={{
                time,
                mhz,
                voice,
                talking,
                wanted,
              }}
            />
            <S.BottomLeft>
              {vehHud && (
                <div className="street">
                  <TiLocation />
                  <span>
                    <b>{direction}</b> - {street}
                  </span>
                </div>
              )}
              <Radar data={{ radar }} />
            </S.BottomLeft>
            <S.BottomCenter>
              {hoverfy.show && <Hoverfy hoverfy={hoverfy} />}
              <Velocimeter
                data={{
                  vehHud,
                  speed,
                  fuel,
                  locked,
                  engineHealth,
                  seatbelt,
                  light,
                  nitro, 
                  purge,
                }}
              />
            </S.BottomCenter>
            <S.BottomRight>
              <PlayerStatus
                theme={S.theme}
                data={{
                  weapon,
                  health,
                  armour,
                  hunger,
                  thirst,
                  oxygen,
                  stress,
                  urine,
                  poop,
                  progress,
                }}
              />
            </S.BottomRight>
          </S.WrapHud>
        </>
      )}
    </ThemeProvider>
  );
}

export default App;
