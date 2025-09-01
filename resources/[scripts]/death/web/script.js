$(document).ready(() => {
  let nuiOppened = false;

  const formatTime = (secs) => {
    const sec = parseInt(secs, 10);

    let hours = Math.floor(sec / 3600);
    let minutes = Math.floor((sec - hours * 3600) / 60);
    let seconds = sec - hours * 3600 - minutes * 60;

    if (hours < 10) hours = "0" + hours;
    if (minutes < 10) minutes = "0" + minutes;
    if (seconds < 10) seconds = "0" + seconds;

    return minutes + ":" + seconds;
  };

  const actions = {
    show: ({ value }) => {
      nuiOppened = value;
      if (value) $("#death").show();
      else $("#death").hide();
    },
    timer: ({ value }) => {
      if (value > 0) {
        $(".revive").css("opacity", 0.5);
        $(".revive").text("Aguarde");
      } else {
        $(".revive").css("opacity", 1);
        $(".revive").text("Desistir");
      }
      if (nuiOppened) $("#time").html(formatTime(value));
    },
  };

  window.addEventListener("message", (event) => {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);
  });

  $(document).on("click", ".revive", function () {
    nuiOppened = false;

    $("#death").hide();
    $.post(`http://death/revive`, []);
  });
});
