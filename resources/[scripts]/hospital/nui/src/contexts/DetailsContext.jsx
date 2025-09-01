import { createContext, useState } from "react";

const DetailsContext = createContext({});

export const DetailsProvider = ({ children }) => {
  const [details, setDetails] = useState({});

  return (
    <DetailsContext.Provider value={{ details, setDetails }}>
      {children}
    </DetailsContext.Provider>
  );
};

export default DetailsContext;
