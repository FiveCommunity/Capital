import { createContext, useState } from "react";

const DynamicContext = createContext({});

export const DynamicProvider = ({ children }) => {
  const [dynamic, setDynamic] = useState({});

  return (
    <DynamicContext.Provider value={{ dynamic, setDynamic }}>
      {children}
    </DynamicContext.Provider>
  );
};

export default DynamicContext;
