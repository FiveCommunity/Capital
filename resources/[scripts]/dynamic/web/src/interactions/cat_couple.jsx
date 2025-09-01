import { RiPlayFill } from "react-icons/ri";
import { GiRelationshipBounds } from "react-icons/gi";

export default [
  {
    title: "Relacionamento",
    icon: <GiRelationshipBounds />,
    type: "category",
    value: "relation",
    category: "couple",
  },
  {
    title: "Checar relacionamento",
    icon: <RiPlayFill />,
    type: "action",
    action: "relacionamento",
    category: "relation",
    closeLater: true,
  },
  {
    title: "Pedir em casamento",
    icon: <RiPlayFill />,
    type: "action",
    action: "noivar",
    category: "relation",
    closeLater: true,
  },
  {
    title: "Pedir em namoro",
    icon: <RiPlayFill />,
    type: "action",
    action: "namorar",
    category: "relation",
    closeLater: true,
  },
  {
    title: "Terminar relacionamento",
    icon: <RiPlayFill />,
    type: "action",
    action: "terminar",
    category: "relation",
    closeLater: true,
  },
  {
    title: "Beijar",
    icon: <RiPlayFill />,
    type: "action",
    category: "couple",
    action: "kiss"
  },
];
