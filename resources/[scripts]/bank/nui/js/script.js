let onBank = false;

$(document).ready(function () {
  $("body").hide();
  window.addEventListener("message", function (data) {
    let action = event.data;

    switch (action.type) {
      case "show":
        start_bank_init(action.money, action.bank, action.logo, action.nome);
        start_pix_init(action.key_pix);
        start_rendimento_init(action.rendimentos);
        if (window.screen.availWidth < 1370) {
          $(".bank-main").css("width", "1600px");
          $("bank_section").css("left", "-50px");
        } else {
          $(".bank-main").css("width", "70%");
        }
        break;

      case "fechado":
        $("body").fadeIn(500);
        $("bank_section").hide();
        $("bankClose").html(`
                <div class="icon">
                    <div class="circle">
                        <span class="dot"></span>
                    </div>
                    <span class="mark"></span>
                </div>
                <h1>${language.fechado.text1}</h1><br>
                <sub>${language.fechado.text2}</sub>
                <small>${language.fechado.text3} ${action.abertura}:00 ${language.fechado.text4} ${action.fechamento}:00</small>
                `);

        $("bankClose").fadeIn(500);
        setTimeout(function () {
          close();
        }, 3500);
        break;

      case "notify":
        if (!onBank) {
          $("bank_section").hide();
        }
        $("body").fadeIn(0);
        $("notify").fadeIn(500);
        if (action.mode == "sucesso") {
          $("notify").html(
            tamplate_notify_sucess(action.title, action.message)
          );
        } else {
          $("notify").html(tamplate_notify_error(action.title, action.message));
        }

        setTimeout(function () {
          if (!onBank) {
            $("body").fadeOut(500);
          }
          $("notify").fadeOut(500);
        }, 6000);
        break;
    }

    document.onkeyup = function (data) {
      if (data.which == 27) {
        close();
      }
    };
  });
});

const start_bank_init = (wallet, bank, logo, nome) => {
  onBank = true;
  $("body").fadeIn(500);
  // $("header img").attr("src", logo);
  $("bankClose").hide();
  $("bank_section").fadeIn(500);
  get_trans();
  grafico();
  $("#limit").html(
    "R$" + formatarNumero(wallet) + "/R$" + formatarNumero(bank)
  );
  $(".card-group .name").html(nome);
  $("section").fadeIn(500);
};

const start_pix_init = (key) => {
  $(".pix-acess").append(pix_template());
  $(".pix-key").text(key);
};

const start_rendimento_init = (rendimento) => {
  $(".content-rendimentos .clear").delay(800).fadeOut();
  rendimento.forEach(function (v, i) {
    $(".content-rendimentos").append(template_rendimento(formatarNumero(v)));
  });
};

function update_money() {
  $.post("https://bank/ws:update_money", JSON.stringify({}), (data) => {
    $("#limit").html(
      "R$" + formatarNumero(data.money) + "/R$" + formatarNumero(data.bank)
    );
  });
}

function close() {
  $("body").fadeOut(500);
  $("bank_section").hide();
  onBank = false;
  $.post("https://bank/ws:close");
  setTimeout(function () {
    window.location.reload();
  }, 100);
}

function activeBank(element) {
  $(".option").removeClass("active");
  $(element).addClass("active");
  $(".bank-traffic").hide();
  $(".bank-main").show();
  returnMenu_Trans();
  if (window.screen.availWidth < 1370) {
    $(".bank-main").css("width", "1600px");
    $("bank_section").css("left", "-50px");
  } else {
    $(".bank-main").css("width", "70%");
  }
  $(".bank-traffic").css("width", "70%");
  update_grafico();
}

function returnMenu_Trans() {
  $(".card-section").css("animation", "slit-in-vertical 0.45s ease-out both");
  $(".back-card").hide();
  $(".front-card").fadeIn(300);
}

// ------------------------------------------------------------------------
// --- [ Botões de acesso rapido]
// ------------------------------------------------------------------------
function depositar() {
  $("modal").empty();
  $("modal").addClass("modalOpen");
  $("modal").append(template_depositar());
  $(".wrap").css("filter", "blur(10px)");
  $("modal").fadeIn(500);
}

function sacar() {
  $("modal").empty();
  $("modal").addClass("modalOpen");
  $("modal").append(template_sacar());
  $(".wrap").css("filter", "blur(10px)");
  $("modal").fadeIn(500);
}

function transference() {
  $("modal").empty();
  $("modal").addClass("modalOpen");
  $("modal").append(template_transfer());
  $(".wrap").css("filter", "blur(10px)");
  $("modal").fadeIn(500);
}

function my_deposit() {
  let value = parseInt($("#value").val());
  if (value) {
    $.post("https://bank/ws:depositar", JSON.stringify({ value: value }));
    closeModal();
    setTimeout(function () {
      update_grafico();
    }, 1000);
  }
}

function withdrawal() {
  let value = parseInt($("#value").val());
  if (value) {
    $.post("https://bank/ws:sacar", JSON.stringify({ value: value }));
    closeModal();
    setTimeout(function () {
      update_grafico();
    }, 1000);
  }
}

var id;

function transfer() {
  let value = parseInt($("#value").val());
  if (value) {
    id = value;
  }
  $("modal").empty();
  $("modal").addClass("modalOpen");
  $("modal").append(template_transfer2());
  $(".wrap").css("filter", "blur(10px)");
  $("modal").fadeIn(500);
}

function transfer2() {
  let value = parseInt($("#value").val());
  if (value) {
    $.post(
      "https://bank/ws:transferir",
      JSON.stringify({ id: id, value: value })
    );
    closeModal();
    setTimeout(function () {
      update_grafico();
    }, 1000);
  }
  id = null;
}

function saque_rapido() {
  $.post("https://bank/ws:sacar", JSON.stringify({ value: 1000 }));
  setTimeout(function () {
    update_transferencias();
    update_money();
    update_grafico();
  }, 1000);
}

// ------------------------------------------------------------------------
// --- [ Menu de transferencia para players]
// ------------------------------------------------------------------------

function open_transferencias() {
  $(".card-section").css("animation", "slit-in-vertical 0.45s ease-out both");
  $(".front-card").hide();
  $(".back-card").fadeIn(300);
  $(".player-list .clear").delay(800).fadeOut();
  $(".player-list").append(get_player_trans());
  $(".player-list").empty();
  $(".list-item").delay(1200).fadeIn();

  $("#search-player").on("keyup", function () {
    var value = $(this).val().toLowerCase();
    $(".player-list .list-item").filter(function () {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
}

function return_transferencias() {
  $(".card-section").css("animation", "slit-in-vertical 0.45s ease-out both");
  $(".back-card").hide();
  $(".front-card").fadeIn(300);
}

function get_player_trans() {
  $.post("https://bank/ws:get_players_trans", JSON.stringify(), (data) => {
    const players = data.players;
    setTimeout(function () {
      players.forEach(function (v, i) {
        $(".player-list").append(`            
                <div class="list-item flex" onclick="trans_player(this)" data-nome ="${
                  v.nome + " " + v.sobrenome
                }" data-id="${v.user_id}">
                    <span>${v.nome + " " + v.sobrenome}</span>
                </div>`);
      });
    }, 1200);
  });
}

function get_trans() {
  $.post("https://bank/ws:get_trans", JSON.stringify({}), (data) => {
    const trans = data.trans;
    trans.reverse();
    trans.forEach(function (v, i) {
      $(".list-extract").append(template_history_trans(v.type, v.value));
    });
  });
}

function clear_trans() {
  $.post("https://bank/ws:limpar_transferencia", JSON.stringify({}));
  $(".list-extract").empty();
  setTimeout(function () {
    update_grafico();
  }, 500);
}

function update_transferencias() {
  $(".list-extract").empty();
  $.post("https://bank/ws:get_trans", JSON.stringify({}), (data) => {
    const trans = data.trans;
    trans.reverse();
    trans.forEach(function (v, i) {
      $(".list-extract").append(template_history_trans(v.type, v.value));
    });
  });
}
function trans_player(element) {
  let id = element.dataset.id;
  $(".wrap").css("filter", "blur(10px)");
  $("modal").empty();
  $("modal").addClass("modalOpen");
  $("modal").append(template_modal(id));
  $("modal").fadeIn(0);
}

const enviar_transferia = (element) => {
  let id = element.dataset.id;
  let valor = $("#value").val();
  $.post(
    "https://bank/ws:enviar_transferencia",
    JSON.stringify({ id: id, valor: valor })
  );
  closeModal();
  setTimeout(function () {
    update_transferencias();
  }, 1000);
};

const closeModal = () => {
  $("modal").hide();
  $("modal").removeClass("modalOpen");
  $(".wrap").css("filter", "blur(0px)");
  setTimeout(function () {
    update_transferencias();
    update_money();
  }, 1000);
};
// ------------------------------------------------------------------------
// --- [ Pix ]
// ------------------------------------------------------------------------

const update_key = () => {
  $.post("https://bank/ws:update_key", JSON.stringify({}), (data) => {
    $(".pix-key").text(data.chave);
  });
};

const create_pix = () => {
  $("modal").empty();
  $("modal").addClass("modalOpen");
  $("modal").append(template_create_pix());
  $(".wrap").css("filter", "blur(10px)");
  $("modal").fadeIn(500);
};

const edit_pix = () => {
  $("modal").empty();
  $("modal").addClass("modalOpen");
  $("modal").append(template_edit_pix());
  $(".wrap").css("filter", "blur(10px)");
  $("modal").fadeIn(500);
};

const edit_pix_post = () => {
  const key = $("#value").val().trim();
  if (key.length <= 10 && key.length > 0) {
    $.post("https://bank/edit_pix", JSON.stringify({ key: key }));
    $("modal").hide();
    $("modal").removeClass("modalOpen");
    $(".wrap").css("filter", "blur(0px)");
    setTimeout(function () {
      update_key();
    }, 1000);
  } else {
    $(".modal-warning").text(language.editpix.error);
    setTimeout(function () {
      $(".modal-warning").text(language.editpix.warning2);
    }, 3000);
  }
};

const remove_pix = () => {
  $.post("https://bank/remove_pix", JSON.stringify({}));
  setTimeout(function () {
    $(".pix-key").text(language.pix.registrar);
  }, 1000);
};

const register_pix = () => {
  const key = $("#value").val().trim();
  if (key.length <= 10 && key.length > 0) {
    $.post("https://bank/register_pix", JSON.stringify({ key: key }));
    $("modal").hide();
    $("modal").removeClass("modalOpen");
    $(".wrap").css("filter", "blur(0px)");
    setTimeout(function () {
      update_key();
    }, 1000);
  } else {
    $(".modal-warning").text(language.pix.warning2);
    setTimeout(function () {
      $(".modal-warning").text(language.pix.warning);
    }, 3000);
  }
};
// ------------------------------------------------------------------------
// --- [ Sistema de multa ]
// ------------------------------------------------------------------------
const activeTraffic = (element) => {
  $(".content-traffic").html("");
  $(".option").removeClass("active");
  $(element).addClass("active");
  $("#h_multas").addClass("active");
  $(".bank-main").hide();
  $(".bank-traffic").show();
  $(".bank-traffic").css("width", "50%");

  $.post("https://bank/get_multas", JSON.stringify({}), (data) => {
    let multas = data.multas;
    multas.reverse();
    multas.forEach(function (v, i) {
      $(".content-traffic").append(
        template_item_multa(v.id_multa, v.motivo, v.time, v.valor, v.desc)
      );
    });
  });

  $("#search-traffics").on("keyup", function () {
    var value = $(this).val().toLowerCase();
    $(".content-traffic .multa-item").filter(function () {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
};

function selectTraffic(element) {
  let valor = element.dataset.valor;
  let motivo = element.dataset.motivo;
  let dia = element.dataset.dia;
  let id = element.dataset.id;
  let descricao = element.dataset.desc;
  $(".pay-traffic").html(show_info_multa(motivo, id));

  $(".content-traffic .item").removeClass("active");
  $(element).addClass("active");
  /* EX: Multa de Transito */
  $("#typeTraffic").text(motivo);
  /* EX: 520.00 */
  $("#priceTraffic").text(valor);
  /* EX: #5451745 (numeração) */
  $("#numberTraffic").text(id);
  /* EX: data criada */
  $("#dateTraffic").text(dia);
  /* EX: Descrição dada na multa */
  $("#noteTraffic").text(descricao);
}

function pay_select_multa(element) {
  let id = element.dataset.id;
  $.post("https://bank/pagar_multa", JSON.stringify({ id_multa: id }));
  $(".pay-traffic").html("");
  setTimeout(function () {
    update_transferencias();
    multas_update();
    update_money();
  }, 500);
}

function multas_update() {
  $(".content-traffic").html("");
  $(".pay-traffic").html("");
  $.post("https://bank/get_multas", JSON.stringify({}), (data) => {
    let multas = data.multas;
    multas.reverse();
    multas.forEach(function (v, i) {
      $(".content-traffic").append(
        template_item_multa(v.id_multa, v.motivo, v.time, v.valor, v.desc)
      );
    });
  });
}

function grafico() {
  let array = [];
  $.post("https://bank/gerate_grafico", JSON.stringify({}), (data) => {
    let total = data.total;
    array.ganhos = parseInt(gerate_value(total, data.ganhou));
    array.perdas = parseInt(gerate_value(total, data.perdeu));
    array.rendimento = parseInt(gerate_value(total, data.rendimento));
    array.multas = parseInt(gerate_value(total, data.multas));
    setTimeout(function () {
      var config = {
        type: "doughnut",
        data: {
          datasets: [
            {
              data: [data.ganhou, data.perdeu, data.rendimento, data.multas],
              backgroundColor: ["#8ffe76", "#FE7676", "#1b86ff", "#fcfe76"],
              //label: 'Grafico 1'
            },
          ],
          labels: [
            language.grafico.ganhou,
            language.grafico.perdeu,
            language.grafico.rendimento,
            language.grafico.multas,
          ],
          hoverOffset: 4,
        },
        options: {
          responsive: true,
          animation: {
            animateScale: false,
            animateRotate: true,
          },
        },
      };

      var ctx = document.getElementById("chart-0").getContext("2d");
      window.myDoughnut = new Chart(ctx, config);
    });
  });
}

function update_grafico() {
  $(".info-chart .info-content").empty();
  $(".info-chart .info-content").html(
    ' <canvas id="chart-0" width="400" height="200" "class="chartjs-render-monitor"></canvas>'
  );
  let array = [];
  $.post("https://bank/gerate_grafico", JSON.stringify({}), (data) => {
    let total = data.total;
    array.ganhos = parseInt(gerate_value(total, data.ganhou));
    array.perdas = parseInt(gerate_value(total, data.perdeu));
    array.rendimento = parseInt(gerate_value(total, data.rendimento));
    array.multas = parseInt(gerate_value(total, data.multas));
    setTimeout(function () {
      var config = {
        type: "doughnut",
        data: {
          datasets: [
            {
              data: [data.ganhou, data.perdeu, data.rendimento, data.multas],
              backgroundColor: ["#8ffe76", "#FE7676", "#1b86ff", "#fcfe76"],
              //label: 'Grafico 1'
            },
          ],
          labels: [
            language.grafico.ganhou,
            language.grafico.perdeu,
            language.grafico.rendimento,
            language.grafico.multas,
          ],
          hoverOffset: 4,
        },
        options: {
          responsive: true,
          animation: {
            animateScale: false,
            animateRotate: true,
          },
        },
      };

      var ctx = document.getElementById("chart-0").getContext("2d");
      window.myDoughnut = new Chart(ctx, config);
    });
  });
}

function gerate_value(max, atual) {
  let transform = (atual * 100) / max;
  return transform;
}

const formatarNumero = (n) => {
  var n = n.toString();
  var r = "";
  var x = 0;

  for (var i = n.length; i > 0; i--) {
    r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
    x = x == 2 ? 0 : x + 1;
  }

  return r.split("").reverse().join("");
};

$(".content-rendimentos").on("scroll", function () {
  var posicaoScroll = $(this).scrollTop();
  if (posicaoScroll) {
    $(".info-roll").fadeOut();
  } else {
    $(".info-roll").fadeIn();
  }
});
