window.addEventListener("message", (event) => {
  const message = event.data;
  if (message.action == "OPEN_PANEL") {
    $("#tencode").show();
  }
});

const takeCode = (number) => {
  closeNUI();
  $.post("http://prison/execute", JSON.stringify({ code: number }));
};

const closeNUI = () => {
  $("#tencode").hide();
  $.post("http://prison/close", "[]");
};

document.onkeyup = (event) => {
  if (event.key == "Escape") {
    closeNUI();
  }
};
