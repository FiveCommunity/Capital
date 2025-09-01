import React, { createContext, useState, ReactNode } from "react";

type PageContextType = {
  currentPage: string;
  setCurrentPage: (value: string) => void;
};

type PagesProviderProps = {
  children: ReactNode;
};

const PagesContext = createContext<PageContextType>({} as PageContextType);

export const PagesProvider = ({ children }: PagesProviderProps) => {
  const [currentPage, setCurrentPage] = useState("login");

  return (
    <PagesContext.Provider value={{ currentPage, setCurrentPage }}>
      {children}
    </PagesContext.Provider>
  );
};

export default PagesContext;
