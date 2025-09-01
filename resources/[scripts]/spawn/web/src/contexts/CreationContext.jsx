import { createContext, useState } from "react";

const CreationContext = createContext({});

export const CreationProvider = ({ children }) => {
  const [creation, setCreation] = useState(false);

  return (
    <CreationContext.Provider value={{ creation, setCreation }}>
      {children}
    </CreationContext.Provider>
  );
};

export default CreationContext;
