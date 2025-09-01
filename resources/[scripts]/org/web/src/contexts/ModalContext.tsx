import React, { ReactNode, createContext, useState } from "react";

export type ModalType = {
  text: string | ReactNode;
  content?: ReactNode;
  actionConfirm?: () => void;
  actionCancel?: () => void;
};

type ModalContextType = {
  modal: ModalType;
  setModal: (value: ModalType) => void;
};

export const ModalContext = createContext<ModalContextType>(
  {} as ModalContextType
);

const ModalContextProvider = ({ children }: { children: ReactNode }) => {
  const [modal, setModal] = useState<ModalType>({} as ModalType);

  return (
    <ModalContext.Provider value={{ modal, setModal }}>
      {children}
    </ModalContext.Provider>
  );
};

export default ModalContextProvider;
