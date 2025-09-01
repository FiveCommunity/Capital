import { createContext, useState } from "react";

const CategoryContext = createContext({});

const Categories = [
  { index: 0, number: 1, name: "genetic" },
  { index: 1, number: 2, name: "skin" },
  { index: 2, number: 3, name: "eyes" },
  { index: 3, number: 4, name: "nose" },
  { index: 4, number: 5, name: "chin" },
  { index: 5, number: 6, name: "cheek" },
  { index: 6, number: 7, name: "aspect" },
  { index: 7, number: 8, name: "barber" },
];

export const CategoryProvider = ({ children }) => {
  const [category, setCategory] = useState({
    index: 0,
    number: 1,
    name: "genetic",
  });

  const handleNext = () => {
    setCategory((actualCategory) => {
      const actual = actualCategory.index;
      return {
        index: Categories[actual + 1].index,
        number: Categories[actual + 1].number,
        name: Categories[actual + 1].name,
      };
    });
  };

  const handlePrev = () => {
    setCategory((actualCategory) => {
      const actual = actualCategory.index;
      return {
        index: Categories[actual - 1].index,
        number: Categories[actual - 1].number,
        name: Categories[actual - 1].name,
      };
    });
  };

  return (
    <CategoryContext.Provider
      value={{ category, setCategory, handleNext, handlePrev, Categories }}
    >
      {children}
    </CategoryContext.Provider>
  );
};

export default CategoryContext;
