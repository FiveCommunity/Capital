import { createContext, useState } from "react";

const CamContext = createContext({});

export const CamProvider = ({ children }) => {
  const [cam, setCam] = useState(0);
  const [handle, setHandle] = useState("prev");

  return (
    <CamContext.Provider value={{ cam, setCam, handle, setHandle }}>
      {children}
    </CamContext.Provider>
  );
};

export default CamContext;
