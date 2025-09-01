import { GiMedicalPack, GiMechanicGarage } from "react-icons/gi";
import { HiOutlineUsers } from "react-icons/hi";
import { FaPoop } from "react-icons/fa";
import { MdOutlineLocalPolice } from "react-icons/md";
import { IoIosBody } from "react-icons/io";
import { LuCar } from "react-icons/lu";
import { BsFillHouseFill } from "react-icons/bs";
import { FaTshirt } from "react-icons/fa";
import { FaBalanceScaleLeft } from "react-icons/fa";
import { RiShieldFill } from "react-icons/ri";

const interactions = [
  {
    title: "Interações",
    icon: <HiOutlineUsers />,
    type: "category",
    category: "main",
    value: "interactions",
  },
  {
    title: "Animações",
    icon: <IoIosBody />,
    type: "category",
    category: "main",
    value: "animations",
  },
  {
    title: "Compartilhadas",
    icon: <IoIosBody />,
    type: "category",
    category: "animations",
    value: "animShared",
  },
  {
    title: "Individuais",
    icon: <IoIosBody />,
    type: "category",
    category: "animations",
    value: "animIndiv",
  },
  {
    title: "Roupas",
    icon: <FaTshirt />,
    type: "category",
    category: "main",
    value: "clothes",
  },
  {
    title: "Staff",
    icon: <RiShieldFill />,
    type: "category",
    category: "main",
    value: "staff",
    permission: "staff",
  },
  {
    title: "Casa",
    icon: <BsFillHouseFill />,
    type: "category",
    category: "main",
    value: "homes",
  },
  {
    title: "Carro",
    icon: <LuCar />,
    type: "category",
    category: "main",
    value: "car",
  },
  {
    title: "Polícia",
    icon: <MdOutlineLocalPolice />,
    type: "category",
    category: "main",
    value: "police",
    permission: "policia",
  },
  {
    title: "Medicina",
    icon: <GiMedicalPack />,
    type: "category",
    category: "main",
    value: "medic",
    permission: "hospital",
  },
  {
    title: "Mecânico",
    icon: <GiMechanicGarage />,
    type: "category",
    category: "main",
    value: "mechanic",
    permission: "mecanica",
  },
  {
    title: "Judiciário",
    icon: <FaBalanceScaleLeft />,
    type: "category",
    category: "main",
    value: "judge",
    permission: "juridico",
  },
];

export default interactions;
