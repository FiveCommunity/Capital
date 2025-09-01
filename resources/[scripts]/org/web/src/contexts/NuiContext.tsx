import React, {
  createContext,
  ReactNode,
  useState,
  SetStateAction,
} from "react";

export type VisibleType = "tablet" | "goalsSender" | "fabrication" | "off";

type NuiContextType = {
  visible: VisibleType;
  setVisible: (value: VisibleType) => void;
};

export const NuiContext = createContext<NuiContextType>({} as NuiContextType);

const NuiContextProvider = ({ children }: { children: ReactNode }) => {
  const [visible, setVisible] = useState<VisibleType>("off");

  return (
    <NuiContext.Provider value={{ visible, setVisible }}>
      {children}
    </NuiContext.Provider>
  );
};

export default NuiContextProvider;
