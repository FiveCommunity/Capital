import { createContext, useState } from "react";

const AlertContext = createContext({});

export const AlertProvider = ({ children }) => {
  const [alert, setAlert] = useState(false);

  return (
    <AlertContext.Provider value={{ alert, setAlert }}>
      {children}
    </AlertContext.Provider>
  );
};

export default AlertContext;
