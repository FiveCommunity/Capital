export const currencyFormat = (amount) => {
  return amount.toLocaleString("pt-br", {
    style: "currency",
    currency: "BRL",
  });
};
