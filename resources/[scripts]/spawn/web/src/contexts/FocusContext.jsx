import { createContext, useState } from "react";

const FocusContext = createContext({});

export const FocusProvider = ({ children }) => {
  const [focus, setFocus] = useState(false);

  return (
    <FocusContext.Provider value={{ focus, setFocus }}>
      {children}
    </FocusContext.Provider>
  );
};

export default FocusContext;
