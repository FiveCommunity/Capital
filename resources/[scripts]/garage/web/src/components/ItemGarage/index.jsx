import { useState } from "react";
import * as S from "./styles";
import { FaCarSide, FaMotorcycle } from "react-icons/fa";
import { RiVipDiamondLine, RiRoadsterFill } from "react-icons/ri";
import { IoCarSport } from "react-icons/io5";
import { PiCarProfileFill } from "react-icons/pi";
import { TbCarSuv } from "react-icons/tb";
import { GiCityCar } from "react-icons/gi";
import { IoIosCar } from "react-icons/io";
import { IoCarSportSharp } from "react-icons/io5";
import { FaVanShuttle } from "react-icons/fa6";

function ItemGarage({ item, setCar }) {
  const [imageError, setImageError] = useState(false);

  return (
    <S.CarItem key={item.name} onClick={() => setCar(item)}>
      {!imageError ? (
        <S.CarItemImage
          src={`http://189.127.164.125/babilonia/gb_garage/${item.spawn}.png`}
          loading="lazy"
          onError={() => setImageError(true)}
        />
      ) : (
        <>
          {item.class === "compacts" && <FaCarSide />}
          {item.class === "motocycle" && <FaMotorcycle />}
          {item.class === "suvs" && <TbCarSuv />}
          {item.class === "sedans" && <PiCarProfileFill />}
          {item.class === "coupes" && <IoIosCar />}
          {item.class === "muscle" && <GiCityCar />}
          {item.class === "sports" && <IoCarSport />}
          {item.class === "sportsclassics" && <IoCarSport />}
          {item.class === "super" && <IoCarSportSharp />}
          {item.class === "offroad" && <RiRoadsterFill />}
          {item.class === "vans" && <FaVanShuttle />}
          {item.class === "vip" && <RiVipDiamondLine />}
        </>
      )}

      <S.CarItemTitle>{item.name}</S.CarItemTitle>
      <S.CarItemSubtitle>{item.maker}</S.CarItemSubtitle>
      <S.CategoryItem>
        {item.class === "compacts" && <FaCarSide />}
        {item.class === "motocycle" && <FaMotorcycle />}
        {item.class === "suvs" && <TbCarSuv />}
        {item.class === "sedans" && <PiCarProfileFill />}
        {item.class === "coupes" && <IoIosCar />}
        {item.class === "muscle" && <GiCityCar />}
        {item.class === "sports" && <IoCarSport />}
        {item.class === "sportsclassics" && <IoCarSport />}
        {item.class === "super" && <IoCarSportSharp />}
        {item.class === "offroad" && <RiRoadsterFill />}
        {item.class === "vans" && <FaVanShuttle />}
        {item.class === "vip" && <RiVipDiamondLine />}
      </S.CategoryItem>
    </S.CarItem>
  );
}

export default ItemGarage;
