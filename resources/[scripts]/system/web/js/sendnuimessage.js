window.addEventListener("message", function (event) {
  data = event.data;
  if (data.action == "capuz") {
    if (data.actionShow == true) {
      $("#capuz").show();
    } else {
      $("#capuz").hide();
    }
  }
});
