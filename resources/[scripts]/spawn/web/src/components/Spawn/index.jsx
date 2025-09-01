import * as S from "./styles";

import { FaHome } from "react-icons/fa";
import { FaBuilding } from "react-icons/fa6";

import { useEffect, useState, useContext, useCallback } from "react";

import WallpaperJPEG from "../../assets/images/wallpaper.jpeg"

import SpawnContext from "../../contexts/SpawnContext";
import { useRequest } from "../../hooks/useRequest";

export function Spawn({ theme }) {
  const { request } = useRequest();
  const { setSpawn, homes } = useContext(SpawnContext);

  const handleRequest = useCallback(
    async (link, data) => {
      await request(link, data);
    },
    [request]
  );

  return (
    <>
      <S.Wrap>
        <S.Filter />
        <S.Left>
          <S.Main>
            <S.Header>
              <h1>
                Seletor <br />
                de Spawn
              </h1>
              <span>Escolha o local que você deseja nascer!</span>
            </S.Header>

            <S.Content>
              <S.OthersSpawnWrap>
                {homes.map((option, index) => (
                  <S.OthersSpawn
                    onClick={() => {
                      handleRequest("SetLocation", {
                        spawn: option.name,
                        home: true,
                        homeType: option.type,
                      });
                      setSpawn(false);
                    }}
                  >
                    <S.Home>
                      <span style={{ color: theme.colors.primary() }}>
                        {option.type}
                      </span>
                      <strong>{option.name}</strong>
                    </S.Home>
                    {(option.type === "Apartamento" && (
                      <FaBuilding style={{ color: theme.colors.primary() }} />
                    )) || <FaHome style={{ color: theme.colors.primary() }} />}
                  </S.OthersSpawn>
                ))}
              </S.OthersSpawnWrap>
            </S.Content>
          </S.Main>
        </S.Left>
        <S.Center>
          <S.ResponsiveCenter>
            <S.Wallpaper src={WallpaperJPEG} />
            <S.Location className="LosSantos">
              <S.ButtonLocation
                onClick={() => {
                  handleRequest("SetLocation", {
                    spawn: "LosSantos",
                    home: false,
                  });
                  setSpawn(false);
                }}
              >
                Los Santos
              </S.ButtonLocation>
              <S.LocationPointer />
            </S.Location>
            <S.Location className="SandyShores">
              <S.ButtonLocation
                onClick={() => {
                  handleRequest("SetLocation", {
                    spawn: "SandyShores",
                    home: false,
                  });
                  setSpawn(false);
                }}
              >
                Sandy Shores
              </S.ButtonLocation>
              <S.LocationPointer />
            </S.Location>
            <S.Location className="PaletoBay">
              <S.ButtonLocation
                onClick={() => {
                  handleRequest("SetLocation", {
                    spawn: "PaletoBay",
                    home: false,
                  });
                  setSpawn(false);
                }}
              >
                Paleto Bay
              </S.ButtonLocation>
              <S.LocationPointer />
            </S.Location>
            <S.LastLocation
              onClick={() => {
                handleRequest("LastLocation", "");
                setSpawn(false);
              }}
            >
              última localização
            </S.LastLocation>
          </S.ResponsiveCenter>
        </S.Center>
      </S.Wrap>
    </>
  );
}
