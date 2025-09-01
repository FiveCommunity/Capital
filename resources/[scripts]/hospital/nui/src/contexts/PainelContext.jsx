import { createContext, useState } from "react";

const PainelContext = createContext({});

export const PainelProvider = ({ children }) => {
  const [painel, setPainel] = useState({});

  return (
    <PainelContext.Provider value={{ painel, setPainel }}>
      {children}
    </PainelContext.Provider>
  );
};

export default PainelContext;
