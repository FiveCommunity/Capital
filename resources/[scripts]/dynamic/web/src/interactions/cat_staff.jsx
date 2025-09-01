import { RiPlayFill } from "react-icons/ri";

export default [
  {
    title: "Add no Manicômio",
    icon: <RiPlayFill />,
    type: "action",
    action: "manicomio",
    category: "staff",
    closeLater: true,
  },
  {
    title: "Rem do Manicômio",
    icon: <RiPlayFill />,
    type: "action",
    action: "rmanicomio",
    category: "staff",
    closeLater: true,
  },
  {
    title: "Multar",
    icon: <RiPlayFill />,
    type: "action",
    action: "multar",
    category: "staff,police",
    closeLater: true,
  },
];
