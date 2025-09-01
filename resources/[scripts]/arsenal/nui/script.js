var globalWeapons;
var globalUtilitary;
var globalKits;
var selectWeapon;
var selectUtilitary;
var selectKits;
var extraAmmo;
var loading;

$(document).ready(() => {
  const resetRender = () => {
    $("div[data-parent]").hide();
    $("div:not([data-parent])").show();
    $("#buttons-list").hide();
    $("#buttons").hide();
    $("#weapons-description").hide();
    $(".btn-weapon").removeClass("selected");
    $(".btn-utilitary").removeClass("selected");
    $(".btn-kits").removeClass("selected");
  };

  const renderButtons = (attachs, training) => {
    const wrapHeader = $("#buttons-header");
    const trainingClass = training[1] ? "treino" : "btn-training locked";
    const attachsClass = attachs[1] ? "attachs" : "btn-training locked";
    wrapHeader.html("");
    wrapHeader.append(`
    <li>
      <button class="close-arsenal">
        <i class="fas fa-xmark" style="margin-right: 1rem"></i>FECHAR
      </button>
    </li>
    ${
      training[0]
        ? `
      <li>
        <button class="${attachsClass}">
          <i class="fas fa-gun" style="margin-right: 1rem"></i>ATTACHS
        </button>
      </li>`
        : ""
    }
    ${
      attachs[0]
        ? `
    <li>
        <button class="${trainingClass}">
          <i class="fas fa-crosshairs" style="margin-right: 1rem"></i>TREINO
        </button>
      </li>`
        : ""
    }
  `);
  };

  const renderWeapons = (weapons) => {
    const wrapWeapons = $("#list-armamentos");
    globalWeapons = weapons;
    wrapWeapons.html("");
    globalWeapons.map((weapon) => {
      const buttonClass = weapon.perm[0] ? "btn-weapon" : "btn-weapon locked";
      wrapWeapons.append(`
      <li>
        <button class="${buttonClass}" data-weapon="${weapon.spawn}">
          <span>${weapon.name}</span>
          ${
            weapon.perm[0]
              ? `<small class='hl'>R$${weapon.price}</small>`
              : `<small>${weapon.perm[1]} <i class="fas fa-lock"></i></small>`
          }
        </button>
      </li>
    `);
    });
  };

  const renderUtilitarys = (utilitarys) => {
    const wrapUtilitarys = $("#list-utilitary");
    globalUtilitary = utilitarys;
    wrapUtilitarys.html("");
    globalUtilitary.map((utilitary) => {
      const buttonClass = utilitary.perm[0]
        ? "btn-utilitary"
        : "btn-utilitary locked";
      wrapUtilitarys.append(`
      <li>
        <button class="${buttonClass}" data-uti="${utilitary.spawn}">
          <span>${utilitary.name}</span>
          ${
            utilitary.perm[0]
              ? `<small class='hl'>R$${utilitary.price}</small>`
              : `<small>${utilitary.perm[1]} <i class="fas fa-lock"></i></small>`
          }
        </button>
      </li>
    `);
    });
  };

  const renderKits = (kits) => {
    const wrapKits = $("#list-kit");
    globalKits = kits;
    wrapKits.html("");
    globalKits.map((kit) => {
      const buttonClass = kit.perm[0] ? "btn-kits" : "btn-kits locked";
      wrapKits.append(`
      <li>
      <button class="${buttonClass}" data-kit="${kit.index}">
      <span>${kit.name}</span>
      ${
        kit.perm[0]
          ? `<small class='hl'>R$${kit.price}</small>`
          : `<small>${kit.perm[1]} <i class="fas fa-lock"></i></small>`
      }
          </button>
          </li>
          `);
    });
  };

  const selectedWeapon = (currentWeapon) => {
    selectWeapon = currentWeapon;
    $("#weapons-description").show();
    $("#weapon-name").html(`
      <h2>${currentWeapon.name}</h2>
    `);
    $("#weapons-description #description").html("");
    $("#weapons-description #description").append(`
      <ul>
        <li>
          <span>Capacidade</span>
          <div class="line">
            <div
              class="indicator"
              style="
                background-color: white;
                animation-duration: 3s;
                max-width: ${currentWeapon.infos.capacity}%;
              "
            ></div>
          </div>
        </li>
        <li>
          <span>Precisão</span>
          <div class="line">
            <div
              class="indicator"
              style="
                background-color: white;
                animation-duration: 3s;
                max-width: ${currentWeapon.infos.accuracy}%;
              "
            ></div>
          </div>
        </li>
        <li>
          <span>Dano</span>
          <div class="line">
            <div
              class="indicator"
              style="
                background-color: white;
                animation-duration: 3s;
                max-width: ${currentWeapon.infos.damage}%;
              "
            ></div>
          </div>
        </li>
        <li>
          <span>Alcance</span>
          <div class="line">
            <div
              class="indicator"
              style="
                background-color: white;
                animation-duration: 3s;
                max-width: ${currentWeapon.infos.range}%;
              "
            ></div>
          </div>
        </li>
      </ul>
    `);

    const buttonAmmmo = extraAmmo[1] ? "municao" : "municao locked";
    const textAmmmo = extraAmmo[1]
      ? "Munição"
      : `Munição <i class="fas fa-lock"></i>`;
    $("#buttons-list").html("");
    $("#buttons-list").append(`
      <li>
        <button class="back">Voltar</button>
      </li>
      <li>
        <button class="clear">Limpar Tudo</button>
      </li>
      ${
        extraAmmo[0]
          ? `<li><button class="${buttonAmmmo}">${textAmmmo}</button></li>`
          : ""
      }
      <li>
        <button class="arma-equipar">Equipar</button>
      </li>
    `);
  };

  const selectedUtilitary = (currentUtilitary) => {
    selectUtilitary = currentUtilitary;
    $("#buttons-list").html("");
    $("#buttons-list").append(`
      <li>
        <button class="back">Voltar</button>
      </li>
      <li>
        <button class="utilitario-equipar">Equipar</button>
      </li>
    `);
  };

  const selectedKits = (currentKits) => {
    selectKits = currentKits;
    $("#buttons-list").html("");
    $("#buttons-list").append(`
      <li>
        <button class="back">Voltar</button>
      </li>
      <li>
        <button class="kit-equipar">Pegar</button>
      </li>
    `);
  };

  $(document).on("click", ".btn-weapon", function () {
    const weaponSpawn = $(this).data("weapon");
    const currentWeapon = globalWeapons.filter(
      (weapon) => weapon.spawn == weaponSpawn
    )[0];

    if (!currentWeapon.perm[0]) {
      return;
    }

    $(".btn-weapon").removeClass("selected");
    $(this).addClass("selected");

    selectedWeapon(currentWeapon);
  });

  $(document).on("click", ".btn-utilitary", function () {
    const utilitarySpawn = $(this).data("uti");
    const currentUtilitary = globalUtilitary.filter(
      (utilitary) => utilitary.spawn == utilitarySpawn
    )[0];

    if (!currentUtilitary.perm[0]) {
      return;
    }

    $(".btn-utilitary").removeClass("selected");
    $(this).addClass("selected");

    selectedUtilitary(currentUtilitary);
  });

  $(document).on("click", ".btn-kits", function () {
    const kitSpawn = $(this).data("kit");
    const currentKits = globalKits.filter((kit) => kit.index == kitSpawn)[0];
    if (!currentKits.perm[0]) {
      return;
    }

    $(".btn-kits").removeClass("selected");
    $(this).addClass("selected");

    selectedKits(currentKits);
  });

  $(document).on("click", ".armas", function () {
    $(".weapons").hide();
    $("#armamentos").show();
    $("#buttons").fadeIn();
    $("#buttons-list").show();
    $("#buttons-list").html("");
    $("#buttons-list").append(`
      <li>
        <button class="back">Voltar</button>
      </li>
      <li>
        <button class="clear">Limpar Tudo</button>
      </li>
    `);
  });

  $(document).on("click", ".utilitarios", function () {
    $(".weapons").hide();
    $("#utilitary").show();
    $("#buttons").fadeIn();
    $("#buttons-list").show();
    $("#buttons-list").html("");
    $("#buttons-list").append(`
      <li>
        <button class="back">Voltar</button>
      </li>
    `);
  });

  $(document).on("click", ".kit", function () {
    $(".weapons").hide();
    $("#kits").show();
    $("#buttons").fadeIn();
    $("#buttons-list").show();
    $("#buttons-list").html("");
    $("#buttons-list").append(`
      <li>
        <button class="back">Voltar</button>
      </li>
    `);
  });

  $(document).on("click", ".back", function () {
    $("#arsenal #arsenal-notify .wrap").html("");
    resetRender();
  });

  $(document).on("click", ".clear", function () {
    $.post(`http://arsenal/clear`, "[]");
  });

  $(document).on("click", ".municao", function () {
    if (!extraAmmo[1]) {
      return;
    }
    $.post(
      `http://arsenal/municao`,
      JSON.stringify({ extraAmmo, selectWeapon })
    );
  });

  $(document).on("click", ".arma-equipar", function () {
    $.post(`http://arsenal/equipar-arma`, JSON.stringify({ selectWeapon }));
  });

  $(document).on("click", ".utilitario-equipar", function () {
    $.post(
      `http://arsenal/equipar-utilitario`,
      JSON.stringify({ selectUtilitary })
    );
  });

  $(document).on("click", ".kit-equipar", function () {
    $.post(`http://arsenal/equipar-kit`, JSON.stringify({ selectKits }));
  });

  $(document).on("click", ".close-arsenal", function () {
    closeNUI();
  });

  $(document).on("click", ".attachs", function () {
    $.post(`http://arsenal/attachs`, "[]");
  });

  $(document).on("click", ".treino", function () {
    $.post(`http://arsenal/treino`, "[]");
    closeNUI();
  });

  window.addEventListener("message", ({ data }) => {
    if (data.action == "loading") {
      loading = true;
      $("#user").text(data.user);
      $("#loading").fadeIn();
    }

    if (data.action == "open") {
      loading = null;
      extraAmmo = data.extraAmmo;
      $("#loading").hide();
      $("#arsenal").fadeIn();
      $("#title").text(data.title[0]);
      $("#description").text(data.title[1]);
      resetRender();
      renderButtons(data.attachs, data.training);
      renderWeapons(data.weapons[0], data.weapons[1]);
      renderUtilitarys(data.utilitary[0], data.utilitary[1]);
      renderKits(data.kit[0], data.kit[1]);
    }

    if (data.action == "notifyArsenal") {
      const html = `
        <div class="content">
        <div id="message">${data.message}</div>
        </div>
      `;
      $(html)
        .fadeIn(500)
        .appendTo("#arsenal #arsenal-notify .wrap")
        .delay(data.delay)
        .fadeOut(500);
    }

    if (data.action == "training") {
      $("#training").fadeIn();
      $("#buttons-training").html("");
      if (data.start) {
        $("#buttons-training").append(`
          <li>
            <div id="key">E</div>
            <div id="text">INICIAR</div>
          </li>
        `);
      }

      if (data.shots) {
        $("#buttons-training").append(`
          <li>
            <div id="key">${data.score}/${data.shot}</div>
            <div id="text">TIROS</div>
          </li>
          <li>
            <div id="key">U</div>
            <div id="text">SAIR</div>
          </li>
        `);
      }

      if (data.close) {
        $("#training").fadeOut();
      }
    }
    if (data.action == "close") {
      closeNUI();
    }
  });

  const closeNUI = () => {
    $("#arsenal").fadeOut();
    $("#arsenal #arsenal-notify .wrap").html("");
    $.post("http://arsenal/close", "[]");
  };

  document.onkeyup = (event) => {
    if (event.key == "Escape") {
      if (!loading) {
        closeNUI();
      }
    }
  };
});
