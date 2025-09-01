const app = {
  open: () => {
    $("#mainElevador").fadeIn(500);
  },
  close: () => {
    $("#mainElevador").fadeOut(500);
    $.post("https://elevator/close");
  },
};

window.addEventListener("message", function (event) {
  eName = event.data.elevatorName;
  locs = event.data.elevatorLocs;
  if (event.data.action == "OPEN_NUI") {
    app.open();
    $("#mainElevador").css("display", "flex");
    $("#mainElevador menu section").html("");
    if (eName != undefined) {
      $(".elevadorName").html(eName);
    } else {
      $(".elevadorName").html("ELEVADOR");
    }

    for (i = 0; i < locs.length; i++) {
      var newI = i + 1;

      if (locs[i].text != undefined) {
        andarName = locs[i].text;
      } else {
        andarName = `Andar ${newI}`;
      }
      $("#mainElevador menu section").append(`
        <div class="item" onCLick="elevadorMove(${newI})">
                    <span>${andarName}</span>
        </div>`);
    }
  }
  document.onkeyup = function (data) {
    if (data.which == 27) {
      app.close();
    }
  };
});

function elevadorMove(i) {
  $.post("https://elevator/elevatorFloor", JSON.stringify(i));
  app.close();
}
