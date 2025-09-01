import * as S from "./styles";

import { FaHamburger, FaPoop, FaToilet, FaBrain } from "react-icons/fa";
import { motion, AnimatePresence } from "framer-motion";
import { GiKevlarVest } from "react-icons/gi";
import { IoMdWater } from "react-icons/io";

import { GoHeartFill } from "react-icons/go";
import { FaLungs } from "react-icons/fa";

import { Hunger } from "./svgs/hunger";
import { Thirst } from "./svgs/thirst";
import { Stress } from "./svgs/stress";
import { Border } from "./svgs/border";
import { Lung } from "./svgs/lung";
import { ProgressIcon } from "../../assets/svgs/ProgressIcon";
import { AmmoIcon } from "../../assets/svgs/AmmoIcon";

function PlayerStatus({ theme, data }) {
  return (
    <S.Wrap>
      <svg class="mask">
        <clipPath id="triangle" clipPathUnits="objectBoundingBox">
          <path d="M0.051,0.554 C0.018,0.537,0.018,0.495,0.051,0.478 L0.952,0.022 C0.985,0.005,1,0.026,1,0.06 L1,0.973 C1,1,0.985,1,0.952,1 L0.051,0.554" />
        </clipPath>

        <clipPath id="line" clipPathUnits="objectBoundingBox">
          <path
            fill-rule="evenodd"
            clip-rule="evenodd"
            d="M0.172,0.264 C0.172,0.256,0.182,0.248,0.2,0.244 L0.973,0.063 C1,0.056,1,0.042,0.993,0.031 L0.963,0.012 C0.947,0.001,0.913,-0.002,0.886,0.004 L0.029,0.205 C0.012,0.209,0.001,0.217,0.001,0.225 L0.001,0.978 C0.001,0.996,0.049,1,0.087,0.998 L0.144,0.984 C0.161,0.98,0.172,0.973,0.172,0.964 L0.172,0.264"
          />
        </clipPath>

        <clipPath id="line-2" clipPathUnits="objectBoundingBox">
          <path
            fill-rule="evenodd"
            clip-rule="evenodd"
            d="M0.108,0.043 C0.127,0.027,0.15,0.028,0.169,0.044 L0.988,0.779 C1,0.805,1,0.863,1,0.907 L0.978,0.987 C0.961,1,0.925,1,0.896,1 L0.048,0.256 C0.008,0.22,0.008,0.13,0.049,0.095 L0.108,0.043"
          />
        </clipPath>
      </svg>

      <S.Container>
        <S.Bars>
          {data.weapon.show && (
            <S.Weapon>
              <AmmoIcon />
              <S.Ammo>
                <strong>{data.weapon.currentAmmo}</strong>
                <span>/ {data.weapon.maxAmmo}</span>
              </S.Ammo>
            </S.Weapon>
          )}
          
          {data.progress.show && (
            <S.Triangle timer={data.progress.timer} style={{ transform: "rotate(180deg)", position: "absolute;", top: "-20px", left: "10px" }}>
              <ProgressIcon />
              <Border color={"#12AC5A"} />
              <div class="triangle" style={{ backgroundColor: "#006983" }}>
                <div
                  class="fill"
                  style={{
                    width: `100%`,
                    backgroundColor: "#12AC5A",
                  }}
                />
              </div>
            </S.Triangle>
          )}

          <div class="health">
            <div
              class="fill"
              style={{
                height: `${data.health}%`,
                backgroundColor: "#12AC5A",
              }}
            />
          </div>
          {data.armour !== 0 && (
            <div class="armour">
              <div
                class="fill"
                style={{ height: `${data.armour}%`, backgroundColor: "#FFF" }}
              />
            </div>
          )}
          {data.oxygen !== -1 && (
            <div
              class="oxygen"
              style={{
                right: `${data.armour !== 0 ? "28px" : "15px"}`,
                bottom: `${data.armour !== 0 ? "0px" : "15px"}`,
              }}
            >
              <div
                class="fill"
                style={{
                  height: `${data.oxygen}%`,
                  backgroundColor: "#FFF",
                }}
              />
            </div>
          )}
        </S.Bars>
        <S.Infos>
          <GoHeartFill
            style={{
              marginBottom: "0.4rem",
              color: "#12AC5A",
              fontSize: "0.9rem",
            }}
          />
          <S.Triangle>
            <Hunger />
            <Border color={"#12AC5A"} />
            <div class="triangle" style={{ backgroundColor: "#006983" }}>
              <div
                class="fill"
                style={{
                  width: `${100 - data.hunger}%`,
                  backgroundColor: "#12AC5A",
                }}
              />
            </div>
          </S.Triangle>
          <S.Triangle style={{ transform: "rotate(180deg)" }}>
            <Thirst />
            <Border color={"#0fd16a"} />
            <div class="triangle" style={{ backgroundColor: "#1C4B57" }}>
              <div
                class="fill"
                style={{
                  width: `${100 - data.thirst}%`,
                  backgroundColor: "#0fd16a",
                }}
              />
            </div>
          </S.Triangle>
          <S.Triangle>
            <Stress />
            <Border color={"#305e3f"} />
            <div class="triangle" style={{ backgroundColor: "#1B3035" }}>
              <div
                class="fill"
                style={{
                  width: `${data.stress}%`,
                  backgroundColor: "#305e3f",
                }}
              />
            </div>
          </S.Triangle>
          {data.armour !== 0 && (
            <GiKevlarVest style={{ marginTop: "0.6rem", fontSize: "0.8rem" }} />
          )}
          {data.oxygen !== -1 && (
            <Lung
              rest={{
                position: `${data.armour !== 0 ? "absolute" : "relative"}`,
                right: `${data.armour !== 0 ? "14px" : "0px"}`,
                bottom: `${data.armour !== 0 ? "-10px" : "0px"}`,
                marginTop: `${data.armour !== 0 ? "0" : "0.7rem"}`,
              }}
            />
          )}
        </S.Infos>
      </S.Container>
    </S.Wrap>
  );
}

export default PlayerStatus;
