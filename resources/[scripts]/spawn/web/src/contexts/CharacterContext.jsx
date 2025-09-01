import { createContext, useCallback, useEffect, useState } from "react";
import { useRequest } from "../hooks/useRequest";

export const CharacterContext = createContext({});

export const CharacterProvider = ({ children }) => {
  const { request } = useRequest();
  const [drawables, setDrawables] = useState({});
  const [character, setCharacter] = useState({
    firstname: "",
    lastname: "",
    age: "",
    gender: "male",
    fatherId: 0,
    motherId: 21,
    shapeMix: 0.5,
    colorFather: 0,
    colorMother: 0,
    skinMix: 0.5,
    eyesColor: 0,
    eyesOpening: 0,
    eyebrowsHeight: 0,
    eyebrowsWidth: 0,
    eyebrowsModel: -1,
    eyebrowsColor: 0,
    eyebrowsOpacity: 1.0,
    noseWidth: 0,
    noseHeight: 0,
    noseLength: 0,
    noseBridge: 0,
    noseTip: 0,
    noseShift: 0,
    cheekboneHeight: 0,
    cheekboneWidth: 0,
    cheeksWidth: 0,
    lips: 0,
    jawWidth: 0,
    jawHeight: 0,
    chinLength: 0,
    chinPosition: 0,
    chinWidth: 0,
    chinShape: 0,
    neckWidth: 0,
    hairModel: 0,
    firstHairColor: 0,
    secondHairColor: 0,
    beardModel: -1,
    beardColor: 0,
    beardOpacity: 1.0,
    chestModel: -1,
    chestColor: 0,
    chestOpacity: 1.0,
    blushModel: -1,
    blushColor: 0,
    blushOpacity: 1.0,
    lipstickModel: -1,
    lipstickColor: 0,
    lipstickOpacity: 1.0,
    blemishesModel: -1,
    blemishesOpacity: 1.0,
    ageingModel: -1,
    ageingOpacity: 1.0,
    complexionModel: -1,
    complexionOpacity: 1.0,
    sundamageModel: -1,
    sundamageOpacity: 1.0,
    frecklesModel: -1,
    frecklesOpacity: 1.0,
    makeupModel: -1,
    makeupOpacity: 1.0,
    makeupColor: 0,
    makeupColorType: 0,
    addBodyBlemishes: -1,
    bodyBlemishes: -1,
    bodyBlemishesOpacity: 1.0,
  });

  const handleChangeCharacter = useCallback(async () => {
    await request("ChangeCharacter", character);
  }, [character, request]);

  useEffect(() => {
    handleChangeCharacter();
  }, [character, handleChangeCharacter]);

  return (
    <CharacterContext.Provider
      value={{ character, setCharacter, drawables, setDrawables }}
    >
      {children}
    </CharacterContext.Provider>
  );
};

export default CharacterContext;
