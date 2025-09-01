import { createContext, useState } from "react";

const GarageContext = createContext({});

export const GarageProvider = ({ children }) => {
  const [garage, setGarage] = useState({});

  return (
    <GarageContext.Provider value={{ garage, setGarage }}>
      {children}
    </GarageContext.Provider>
  );
};

export default GarageContext;
