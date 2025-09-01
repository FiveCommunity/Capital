export function useRequest() {
  const request = async (method, body = {}) => {
    return fetch(`http://hud/${method}`, {
      method: "POST",
      body: JSON.stringify(body),
    });
  };
  return { request };
}
