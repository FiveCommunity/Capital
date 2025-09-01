import * as S from "./styles";
import { IoRadioSharp } from "react-icons/io5";
import { LuSiren } from "react-icons/lu";
import { FaMicrophone } from "react-icons/fa";
import { LuClock3 } from "react-icons/lu";

function TopInfos({ data }) {
  const FormatTime = (seconds) => {
    let hours = Math.floor(seconds / 3600);
    seconds -= hours * 3600;
    let minutes = Math.floor(seconds / 60);
    seconds -= minutes * 60;
    if (minutes < 10) minutes = "0" + minutes;
    if (seconds < 10) seconds = "0" + seconds;

    if (hours <= 0) return minutes + ":" + seconds;
    if (hours < 10) hours = "0" + hours;
    return hours + ":" + minutes + ":" + seconds;
  };

  const formatVoice = {
    ["Gritando"]: "Alto",
    ["Normal"]: "Médio",
    ["Susurrando"]: "Baixo",
  };

  return (
    <S.Wrap>
      {data.wanted !== 0 && (
        <S.Info>
          <span style={{ position: "absolute", top: "-17px" }}>
            {FormatTime(data.wanted)}
          </span>
          <LuSiren className="icon" />
        </S.Info>
      )}

      <S.Info>
        <IoRadioSharp className="icon" />
        <span>{data.mhz || "--"}</span>
      </S.Info>

      <S.Info talking={data.talking}>
        <span style={{ position: "absolute", top: "-17px" }}>
          {formatVoice[data.voice]}
        </span>
        <FaMicrophone className="icon" />
      </S.Info>

      <S.Info>
        <LuClock3 className="icon" />
        <span>{data.time}</span>
      </S.Info>
    </S.Wrap>
  );
}

export default TopInfos;
