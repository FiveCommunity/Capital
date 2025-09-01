import { RiAddLine } from "react-icons/ri";
import { AiOutlineDelete } from "react-icons/ai";

export default [
  {
    title: "Adicionar preset",
    icon: <RiAddLine />,
    type: "action",
    action: "addPreset",
    category: "clothes",
    closeLater: true,
  },
  {
    title: "Deletar preset",
    icon: <AiOutlineDelete />,
    type: "action",
    action: "deletePreset",
    category: "clothes",
    closeLater: true,
  },
  {
    title: "Deletar todos presets",
    icon: <AiOutlineDelete />,
    type: "action",
    action: "deleteAllPreset",
    category: "clothes",
    closeLater: true,
  },
];
