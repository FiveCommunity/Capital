import { createContext, useState } from "react";

const SpawnContext = createContext({});

export const SpawnProvider = ({ children }) => {
  const [spawn, setSpawn] = useState(false);
  const [homes, setHomes] = useState({});

  return (
    <SpawnContext.Provider value={{ spawn, setSpawn, homes, setHomes }}>
      {children}
    </SpawnContext.Provider>
  );
};

export default SpawnContext;
