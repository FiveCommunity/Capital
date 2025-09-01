const fuel_img_url = "http://26.104.3.179/posto/";

var fuelStatus = 0;

const actions = {
  open: ({ brand, type, price, vfuel }) => {
    fuelStatus = 0;
    $("#notifyFuel").show();
    if (type == "eletrical") {
      $(".litrosText").html("Amperes");
      $(".litrosText2").html("Valor por amper");
    } else {
      $(".litrosText").html("Litros");
      $(".litrosText2").html("Valor por litro");
    }
    $(".inputValorFuel").html(
      price.toLocaleString("pt-BR", {
        style: "currency",
        currency: "BRL",
      })
    );
    $(".inputTotalFuel").html("");
    $(".inputLitrosFuel").html("");
    $(".progressFuel").html(parseFloat(vfuel.toFixed(2)) + "%");
    $(".progressFuel").css(
      "--aug-border-bg",
      "linear-gradient(92.4deg, #FF9900 " +
        parseFloat(vfuel.toFixed(2)) +
        "%, rgba(255, 153, 0, 0) " +
        parseFloat(vfuel.toFixed(2)) +
        "%)"
    );
  },
  update: ({ vfuel, totalprice, totalfuel }) => {
    $("#notifyFuel").show();
    $(".inputTotalFuel").html(
      totalprice.toLocaleString("pt-BR", {
        style: "currency",
        currency: "BRL",
      })
    );
    $(".inputLitrosFuel").html(parseFloat(totalfuel.toFixed(0)) + "L");
    $(".progressFuel").html(parseFloat(vfuel.toFixed(2)) + "%");
    $(".progressFuel").css(
      "--aug-border-bg",
      "linear-gradient(92.4deg, #FF9900 " +
        parseFloat(vfuel.toFixed(2)) +
        "%, rgba(255, 153, 0, 0) " +
        parseFloat(vfuel.toFixed(2)) +
        "%)"
    );
  },

  close: () => {
    $("#notifyFuel").hide();
  },
};

$(document).ready(() => {
  window.addEventListener("message", (event) => {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);
  });

  document.onkeyup = (event) => {
    if (event.key == "Escape") {
      FetchData("close", {});
    }
  };
});

function iniciarAbastecimento() {
  if (fuelStatus == 0) {
    fuelStatus = 1;
    FetchData("fuelSet", ["start"]);
  }
}

function pararAbastecimento() {
  if (fuelStatus == 1) {
    fuelStatus = 0;
    FetchData("fuelSet", ["stop"]);
  }
}

function FetchData(link, value) {
  $("#notifyFuel").hide();
  $.post(`http://fuel/${link}`, JSON.stringify(value));
}
