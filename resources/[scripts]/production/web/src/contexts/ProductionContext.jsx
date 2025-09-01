import { createContext, useState } from "react";

const ProductionContext = createContext({});

export const ProductionProvider = ({ children }) => {
  const [production, setProduction] = useState({});

  return (
    <ProductionContext.Provider value={{ production, setProduction }}>
      {children}
    </ProductionContext.Provider>
  );
};

export default ProductionContext;
