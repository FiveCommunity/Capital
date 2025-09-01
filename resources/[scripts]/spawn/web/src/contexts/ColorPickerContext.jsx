import { createContext, useState } from "react";

const ColorPickerContext = createContext({});

export const ColorPickerProvider = ({ children }) => {
  const [colorDiv, setColorDiv] = useState(false);
  const [colorDescription, setColorDescription] = useState("");
  const [colors, setColors] = useState([]);
  const [colorSelected, setColorSelected] = useState([]);
  const [colorActual, setColorActual] = useState(0);
  const [colorActualId, setColorActualId] = useState(0);

  const handleColor = (description, colors, value, id) => {
    if (description) {
      setColorDiv((old) => !old);
      setColorDescription(description);
      setColors(colors);
      setColorActual(value);
      setColorActualId(id);
      setColorSelected((old) => ({
        ...old,
        [id]: {
          value,
        },
      }));
    } else {
      if (colorDiv) setColorDiv(false);
    }
  };

  return (
    <ColorPickerContext.Provider
      value={{
        colorDiv,
        setColorDiv,
        handleColor,
        colorDescription,
        colors,
        colorSelected,
        setColorSelected,
        colorActual,
        colorActualId,
      }}
    >
      {children}
    </ColorPickerContext.Provider>
  );
};

export default ColorPickerContext;
