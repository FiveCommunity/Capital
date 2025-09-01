export function useRequest() {
  const request = async (method, body = {}) => {
    return fetch(`http://spawn/${method}`, {
      method: "POST",
      body: JSON.stringify(body),
    });
  };
  return { request };
}
