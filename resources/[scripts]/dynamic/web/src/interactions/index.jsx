// import React from "react";
import { AiFillStar } from "react-icons/ai";
import { useCallback, useContext, useMemo } from "react";
import DynamicContext from "../contexts/DynamicContext";

import Main from "./main";
import Interactions from "./cat_interactions";
import Clothes from "./cat_clothes";
import Couple from "./cat_couple";
import Car from "./cat_car";
import Police from "./cat_police";
import Mechanic from "./cat_mechanic";
import Homes from "./cat_homes";
import Medic from "./cat_medic";
import Staff from "./cat_staff";
import Judge from "./cat_judge";
import { RiPlayFill } from "react-icons/ri";

export const AllInteractions = () => {
  const { dynamic } = useContext(DynamicContext);

  const interactionsList = useMemo(() => {
    return [
      ...Main.filter((item) => {
        if (item.permission) {
          if (dynamic.permissions[item.permission]) {
            return true;
          } else {
            return false;
          }
        }
        return true;
      }),
      ...Interactions,
      ...Clothes,
      ...Couple,
      ...Car,
      ...Homes,
      ...(dynamic.permissions.policia ? Police : []),
      ...(dynamic.permissions.mecanica ? Mechanic : []),
      ...(dynamic.permissions.hospital ? Medic : []),
      ...(dynamic.permissions.staff ? Staff : []),
      ...(dynamic.permissions.juridico ? Judge : []),
    ];
  }, [dynamic]);

  const isFavorite = useCallback(
    (action, value) => {
      return dynamic.favorites.some((item) => {
        if (value) {
          return item === action + ":" + value;
        } else {
          return item === action;
        }
      });
    },
    [dynamic]
  );

  const renderClothesPreset = useMemo(() => {
    return dynamic.clothes.map((item) => ({
      title: item.title,
      icon: <RiPlayFill />,
      type: "action",
      action: "usePreset",
      category: "clothes",
      value: item.title,
      closeLater: true,
    }));
  }, [dynamic]);

  const renderAnimations = useMemo(() => {
    return dynamic.animations.map((item) => {
      return {
        title: item.value[1],
        icon: <RiPlayFill />,
        type: "action",
        action: "execAnimation",
        category: item.value[0] === "animations" ? "animIndiv" : "animShared",
        value: item.value,
        closeLater: true,
      };
    });
  }, [dynamic]);

  const renderAllInteractions = useCallback(() => {
    return [
      {
        title: "Favoritos",
        icon: <AiFillStar />,
        type: "category",
        value: "favorites",
        category: "main",
      },
      ...[...interactionsList, ...renderClothesPreset, ...renderAnimations].map(
        (item) => {
          if (isFavorite(item.action, item.value)) {
            return {
              ...item,
              category: item.category + `,favorites`,
            };
          }
          return item;
        }
      ),
    ];
  }, [interactionsList, isFavorite, renderClothesPreset, renderAnimations]);

  return {
    renderAllInteractions,
    isFavorite,
  };
};

export default AllInteractions;
