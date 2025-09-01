export const formatDatetime = (timestamp) => {
  const date = new Date(timestamp * 1000);

  const options = {
    timeZone: "America/Sao_Paulo",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    second: "2-digit",
  };

  const formattedDate = new Intl.DateTimeFormat("pt-BR", options).format(date);

  return formattedDate;
};

export const isOlderData = (timestamp) => {
  const now = new Date();
  const dateToCompare = new Date(timestamp * 1000);

  return dateToCompare < now;
};

export const isOlderThan15Days = (timestamp) => {
  const now = new Date();
  const dateToCompare = new Date(timestamp * 1000);

  const differenceInDays = (now - dateToCompare) / (1000 * 60 * 60 * 24);

  return differenceInDays >= 15;
};
