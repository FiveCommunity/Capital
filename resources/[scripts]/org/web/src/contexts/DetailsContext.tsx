import React, { ReactNode, createContext, useState } from "react";

export type DetailsType = {
  show: boolean;
  user: number;
  fac: string;
  isJob: boolean;
};

type DetailsContextType = {
  details: DetailsType;
  setDetails: (value: DetailsType) => void;
};

export const DetailsContext = createContext<DetailsContextType>(
  {} as DetailsContextType
);

const DetailsContextProvider = ({ children }: { children: ReactNode }) => {
  const [details, setDetails] = useState<DetailsType>({} as DetailsType);

  return (
    <DetailsContext.Provider value={{ details, setDetails }}>
      {children}
    </DetailsContext.Provider>
  );
};

export default DetailsContextProvider;
