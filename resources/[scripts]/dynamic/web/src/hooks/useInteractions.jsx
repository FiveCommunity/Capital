import { useContext, useState } from "react";
import useRequest from "./useRequest";
import DynamicContext from "../contexts/DynamicContext";
import AllInteractions from "../interactions";

const useInteractions = () => {
  const { request } = useRequest();
  const [category, setCategory] = useState(["main"]);
  const [search, setSearch] = useState("");
  const { setDynamic } = useContext(DynamicContext);
  const { renderAllInteractions, isFavorite } = AllInteractions();

  const handleClickInteraction = async (interaction) => {
    if (interaction.type === "category") {
      setCategory((old) => [...old, interaction.value]);
      setSearch("");
    } else if (interaction.type === "action") {
      request("handleAction", {
        action: interaction.action,
        value: interaction.value || "",
        side: interaction.side || "",
      });

      if (interaction.closeLater) {
        setDynamic(false);
        request("close");
      }
    }
  };

  return {
    handleClickInteraction,
    interactions: renderAllInteractions(),
    search,
    setSearch,
    category,
    setCategory,
    isFavorite,
  };
};

export default useInteractions;
