import { createContext, useState } from "react";

const SelectionContext = createContext({});

export const SelectionProvider = ({ children }) => {
  const [selection, setSelection] = useState(false);
  const [characters, setCharacters] = useState([]);
  const [chars, setChars] = useState(0);

  return (
    <SelectionContext.Provider
      value={{
        selection,
        setSelection,
        characters,
        setCharacters,
        chars,
        setChars,
      }}
    >
      {children}
    </SelectionContext.Provider>
  );
};

export default SelectionContext;
