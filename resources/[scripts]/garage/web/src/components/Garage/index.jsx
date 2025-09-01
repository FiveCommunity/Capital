import * as S from "./styles";
import Input from "../Input";
import { FaCarSide, FaMotorcycle } from "react-icons/fa";
import { RiVipDiamondLine, RiRoadsterFill } from "react-icons/ri";
import { IoCarSport } from "react-icons/io5";
import { PiCarProfileFill } from "react-icons/pi";
import { TbCarSuv } from "react-icons/tb";
import { GiCityCar } from "react-icons/gi";
import { IoIosCar } from "react-icons/io";
import { IoCarSportSharp } from "react-icons/io5";
import { FaVanShuttle } from "react-icons/fa6";
import { BiSolidCarGarage } from "react-icons/bi";

import { useCallback, useContext, useEffect, useMemo, useState } from "react";
import GarageContext from "../../contexts/GarageContext";
import ItemGarage from "../ItemGarage";
import useRequest from "../../hook/useRequest";
import {
  formatDatetime,
  isOlderData,
  isOlderThan15Days,
} from "../../utils/formats";

function Garage() {
  const [car, setCar] = useState({});
  const [imageError, setImageError] = useState(false);
  const [search, setSearch] = useState("");
  const [filter, setFilter] = useState("");
  const [myVeh, setMyVeh] = useState(false);
  const { garage, setGarage } = useContext(GarageContext);
  const { request } = useRequest();
  const [isHovered, setIsHovered] = useState(false);
  const [posX, setPosX] = useState(0);
  const [posY, setPosY] = useState(0);
  const [hoveredName, setHoveredName] = useState("");

  const handleMouseEnter = (event, name) => {
    if (!isHovered) {
      event.preventDefault();
      setPosX(event.clientX);
      setPosY(event.clientY);

      setHoveredName(name);
      setIsHovered(true);
    }
  };

  const handleMouseLeave = () => {
    if (isHovered) setIsHovered(false);
  };

  const CurrencyFormatter = new Intl.NumberFormat("pt-BR", {
    style: "currency",
    currency: "BRL",
  });

  const closeGarage = useCallback(() => {
    setGarage({});
    request("close");
  }, [request, setGarage]);

  useEffect(() => {
    if (garage.cars.length > 0) {
      setCar(garage.cars[0]);
    }
  }, [garage]);

  useEffect(() => {
    setImageError(false);
  }, [car]);

  const filteredsCars = useMemo(() => {
    return garage.cars.filter(
      (item) =>
        item.name.toLowerCase().includes(search.toLowerCase()) &&
        item.class.toLowerCase().includes(filter.toLowerCase())
    );
  }, [garage, search, filter]);

  useEffect(() => {
    if (filter !== "myVehicle" && myVeh) setMyVeh(false);
  }, [filter]);

  const handleSaveCar = useCallback(() => {
    request("saveVeh", {
      id: car.id,
      spawn: car.spawn,
      plate: car.plate,
    });
    closeGarage();
  }, [car, request, closeGarage]);

  const handleSaveNextCar = useCallback(() => {
    request("saveNextVeh");
    closeGarage();
  }, [request, closeGarage]);

  const handleUseCar = useCallback(() => {
    request("useVeh", {
      id: car.id,
      spawn: car.spawn,
      plate: car.plate,
    });
    closeGarage();
  }, [request, car, closeGarage]);

  const handleTestDrive = () => {
    request("testDrive", {
      spawn: car.spawn,
    });
    closeGarage();
  };

  const handleBuyCar = () => {
    request("buyCar", {
      spawn: car.spawn,
    });
    closeGarage();
  };

  const handleSellCar = () => {
    request("sellCar", {
      id: car.id,
    });
    closeGarage();
  };

  useEffect(() => {
    console.log(JSON.stringify(car));
  }, [car]);

  return (
    <S.Container>
      <S.Left>
        <S.LeftHeader>
          {/* <S.Title src="https://media.discordapp.net/attachments/1059878373737893918/1118607399503286362/zero_small.png?width=810&height=282" /> */}
          <Input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="input-search"
            placeholder="Pesquise pelo nome do carro..."
          />
        </S.LeftHeader>
        <S.Car>
          {car.name && (
            <>
              {!imageError ? (
                <S.CarImage
                  src={`http://189.127.164.125/babilonia/gb_garage/${car.spawn}.png`}
                  onError={() => setImageError(true)}
                />
              ) : (
                <S.WrapIconCar>
                  {car.class === "compacts" && <FaCarSide />}
                  {car.class === "motocycle" && <FaMotorcycle />}
                  {car.class === "suvs" && <TbCarSuv />}
                  {car.class === "sedans" && <PiCarProfileFill />}
                  {car.class === "coupes" && <IoIosCar />}
                  {car.class === "muscle" && <GiCityCar />}
                  {car.class === "sports" && <IoCarSport />}
                  {car.class === "sportsclassics" && <IoCarSport />}
                  {car.class === "super" && <IoCarSportSharp />}
                  {car.class === "offroad" && <RiRoadsterFill />}
                  {car.class === "vans" && <FaVanShuttle />}
                  {car.class === "vip" && <RiVipDiamondLine />}
                </S.WrapIconCar>
              )}
              <S.CarTitle>{car.name}</S.CarTitle>
              <S.CarSubtitle>
                {car.maker} {car.plate && `(${car.plate})`}
              </S.CarSubtitle>
              <S.Stats>
                {(!garage.dealership && (
                  <>
                    <S.ItemStats>
                      <S.StatsLabel>Motor</S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress progress={car.engine} />
                      </S.ProgressBar>
                    </S.ItemStats>
                    <S.ItemStats>
                      <S.StatsLabel>Freios</S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress progress={car.breaker} />
                      </S.ProgressBar>
                    </S.ItemStats>
                    <S.ItemStats>
                      <S.StatsLabel>Transmissão</S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress progress={car.transmission} />
                      </S.ProgressBar>
                    </S.ItemStats>
                    <S.ItemStats>
                      <S.StatsLabel>Suspensão</S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress progress={car.suspension} />
                      </S.ProgressBar>
                    </S.ItemStats>

                    <S.ItemStats>
                      <S.StatsLabel>Combustível</S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress progress={car.fuel} />
                      </S.ProgressBar>
                    </S.ItemStats>
                    <S.ItemStats>
                      <S.StatsLabel>Porta-malas</S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress progress={car.trunk} />
                      </S.ProgressBar>
                    </S.ItemStats>
                  </>
                )) || (
                  <>
                    <S.ItemStats>
                      <S.StatsLabel>
                        Aceleração: {car.acceleration}
                      </S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress
                          progress={(car.acceleration / 1000) * 100}
                        />
                      </S.ProgressBar>
                    </S.ItemStats>
                    <S.ItemStats>
                      <S.StatsLabel>
                        Porta-Malas: {car.trunk_capacity}kg
                      </S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress
                          progress={(car.trunk_capacity / 100) * 100}
                        />
                      </S.ProgressBar>
                    </S.ItemStats>
                    <S.ItemStats>
                      <S.StatsLabel>Velocidade: {car.speed}KM</S.StatsLabel>
                      <S.ProgressBar>
                        <S.Progress progress={(car.speed / 300) * 100} />
                      </S.ProgressBar>
                    </S.ItemStats>
                  </>
                )}
              </S.Stats>
              {garage.dealership && car.class !== "vip" && (
                <S.DealershipStatusList>
                  {!myVeh && (
                    <S.DealershipStatus>
                      <S.DealerTitle>Estoque</S.DealerTitle>
                      <S.DealerValue>{car.stock}</S.DealerValue>
                    </S.DealershipStatus>
                  )}
                  <S.DealershipStatus>
                    <S.DealerTitle>Preço</S.DealerTitle>
                    <S.DealerValue>
                      {CurrencyFormatter.format(car.price)}
                    </S.DealerValue>
                  </S.DealershipStatus>
                </S.DealershipStatusList>
              )}
            </>
          )}

          {!garage.dealership && (
            <>
              {car.rented && car.rented !== 0 ? (
                <S.CarExpired>
                  Expira em: {formatDatetime(car.rented)}
                </S.CarExpired>
              ) : (
                <></>
              )}
              {car.ipva && car.ipva !== 0 && !isOlderData(car.ipva) ? (
                <S.CarExpired>IPVA em: {formatDatetime(car.ipva)}</S.CarExpired>
              ) : (
                <></>
              )}
              {car.ipva && car.ipva !== 0 && isOlderThan15Days(car.ipva) ? (
                <S.CarExpired>IPVA em débito</S.CarExpired>
              ) : (
                <></>
              )}
            </>
          )}
        </S.Car>
        <S.Actions>
          {garage.dealership && (
            <>
              {(myVeh && (
                <S.BtnAction onClick={handleSellCar}>Vender</S.BtnAction>
              )) || (
                <S.BtnAction onClick={handleTestDrive}>Teste Drive</S.BtnAction>
              )}
              {car.class !== "vip" && car.type !== "vip" && !myVeh && (
                <S.BtnAction onClick={handleBuyCar}>Comprar</S.BtnAction>
              )}
            </>
          )}
          {!garage.dealership && (
            <>
              {/* <S.BtnAction onClick={handleSaveNextCar}>Guardar próximo</S.BtnAction> */}
              <S.BtnAction onClick={handleSaveCar}>Guardar</S.BtnAction>
              <S.BtnAction onClick={handleUseCar}>Retirar</S.BtnAction>
            </>
          )}
        </S.Actions>
      </S.Left>
      <S.Right>
        <S.RightHeader>
          <S.Filters>
            {garage.dealership && (
              <>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Todos")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === ""}
                  onClick={() => setFilter("")}
                >
                  Todos
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Compacts")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "compacts"}
                  onClick={() => setFilter("compacts")}
                >
                  <FaCarSide />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Suvs")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "suvs"}
                  onClick={() => setFilter("suvs")}
                >
                  <TbCarSuv />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Sedans")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "sedans"}
                  onClick={() => setFilter("sedans")}
                >
                  <PiCarProfileFill />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Coupés")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "coupes"}
                  onClick={() => setFilter("coupes")}
                >
                  <IoIosCar />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Muscle")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "muscle"}
                  onClick={() => setFilter("muscle")}
                >
                  <GiCityCar />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Sports")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "sports"}
                  onClick={() => setFilter("sports")}
                >
                  <IoCarSport />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) =>
                    handleMouseEnter(event, "Sports Classics")
                  }
                  onMouseLeave={handleMouseLeave}
                  active={filter === "sportsclassics"}
                  onClick={() => setFilter("sportsclassics")}
                >
                  <IoCarSport />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Super")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "super"}
                  onClick={() => setFilter("super")}
                >
                  <IoCarSportSharp />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Off-road")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "offroad"}
                  onClick={() => setFilter("offroad")}
                >
                  <RiRoadsterFill />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Vans")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "vans"}
                  onClick={() => setFilter("vans")}
                >
                  <FaVanShuttle />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Motocycle")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "motocycle"}
                  onClick={() => setFilter("motocycle")}
                >
                  <FaMotorcycle />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) => handleMouseEnter(event, "Vip")}
                  onMouseLeave={handleMouseLeave}
                  active={filter === "vip"}
                  onClick={() => setFilter("vip")}
                >
                  <RiVipDiamondLine />
                </S.CarFilter>
                <S.CarFilter
                  onMouseEnter={(event) =>
                    handleMouseEnter(event, "Meus Veículos")
                  }
                  onMouseLeave={handleMouseLeave}
                  active={filter === "myVehicle"}
                  onClick={() => {
                    setFilter("myVehicle");
                    setMyVeh(true);
                  }}
                >
                  <BiSolidCarGarage />
                </S.CarFilter>
              </>
            )}
          </S.Filters>
          <S.CloseButton onClick={closeGarage}>Esc</S.CloseButton>
          {isHovered && (
            <S.Hovered>
              <S.HoveredContainer posX={posX} posY={posY}>
                <span>{hoveredName}</span>
              </S.HoveredContainer>
            </S.Hovered>
          )}
        </S.RightHeader>
        <S.WrapCarList>
          <S.CarsList>
            {(filteredsCars.length > 0 && (
              <>
                {filteredsCars.map((item) => (
                  <ItemGarage key={item.name} item={item} setCar={setCar} />
                ))}
              </>
            )) ||
              (myVeh &&
                garage.myVehicles.map((item) => {
                  if (item.type !== "vip")
                    return (
                      <ItemGarage key={item.name} item={item} setCar={setCar} />
                    );
                })) || (
                <S.EmptyCarList>Veículos não encontrados!</S.EmptyCarList>
              )}
          </S.CarsList>
        </S.WrapCarList>
      </S.Right>
    </S.Container>
  );
}

export default Garage;
