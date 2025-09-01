export const intToReal = (int) => {
  return int.toLocaleString("pt-BR", { style: "currency", currency: "BRL" });
};

export const formatDate = (date) => {
  var options = {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  };
  return date.toLocaleString("pt-BR", options).replace(/\//g, "/");
};
