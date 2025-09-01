import React, { useState, createContext, ReactNode } from "react";
import { ProductAndStorageDTO } from "../DTOS/Goals";

export type GoalsSenderContextType = {
  productsAndStorage: ProductAndStorageDTO;
  setProductsAndStorage: (value: ProductAndStorageDTO) => void;
};

export const GoalsSenderContext = createContext({} as GoalsSenderContextType);

const GoalsSenderContextProvider = ({ children }: { children: ReactNode }) => {
  const [productsAndStorage, setProductsAndStorage] =
    useState<ProductAndStorageDTO>({} as ProductAndStorageDTO);

  return (
    <GoalsSenderContext.Provider
      value={{ productsAndStorage, setProductsAndStorage }}
    >
      {children}
    </GoalsSenderContext.Provider>
  );
};

export default GoalsSenderContextProvider;
