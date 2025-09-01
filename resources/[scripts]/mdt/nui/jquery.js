$(function () {
  let actionContainer = $("#actionmenu");
  let actionButtom = $("#actionbuttom");

  window.addEventListener("message", function (event) {
    let item = event.data;
    switch (item.action) {
      case "showMenu":
        actionContainer.fadeIn(700);
        actionButtom.fadeIn(700);
        updateSearch();
        $("#searchs").show();
        $("#info-result").show();
        $("#info-result2").hide();
        $("#info-result3").hide();
        $("#info-result4").hide();
        $("#warnings").hide();
        $("#tickets").hide();
        $("#arrests").hide();
        break;
      case "hideMenu":
        actionContainer.fadeOut(700);
        actionButtom.fadeOut(700);
        break;
    }
  });

  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post("http://mdt/mdtClose", JSON.stringify({}), function (datab) {});
    }
  };
});

$(document).on("click", "#actionbuttom", function () {
  $.post("http://mdt/mdtClose", JSON.stringify({}), function (datab) {});
});

const formatarNum = (n) => {
  var n = n.toString();
  var r = "";
  var x = 0;
  for (var i = n.length; i > 0; i--) {
    r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
    x = x == 2 ? 0 : x + 1;
  }
  return r.split("").reverse().join("");
};

function del(id, updt) {
  let user_id = Number($("#user_id").val());
  $.post("http://mdt/deleteMdtId", JSON.stringify({ id: id }), (dcb) => {
    if (dcb.ok == true) {
      switch (updt) {
        case "arrestsUser":
          arrestsUser(user_id);
          break;
        case "ticketsUser":
          ticketsUser(user_id);
          break;
        case "warningsUser":
          warningsUser(user_id);
          break;
      }
    }
  });
}

function wport(id) {
  $.post("http://mdt/togglePort", JSON.stringify({ user_id: id }), (dcb) => {
    if (dcb.ok == true) {
      $("#info-result").show();
      $("#info-result3").hide();
      $("#info-result4").hide();
      $("#info-result2").hide();
      infoUser(id);
    }
  });
}

const updateSearch = () => {
  $("#search-result").html(`
		<input class="user" id="user_id" maxlenght="9" spellcheck="false" value="" placeholder="PASSAPORTE">
		<div class="search-itens">
			<div class="info">INFORMAÇÕES</div>
			<div class="arrests">PRISÕES</div>
			<div class="tickets">MULTAS</div>
			<div class="warnings">AVISOS</div>
		</div>
	`);
};

const infoUser = (user) => {
  $.post("http://mdt/infoUser", JSON.stringify({ user }), (data) => {
    let porteButton = data.cacador ? "Retirar" : "Adicionar"
    $("#info-result").html(`
			<div class="info-left">
				<div class="parts-one"><r>Usúario:</r> ${data.name} ${data.lastname} (${data.age} anos)</div> 
				<div class="parts-two"><r>Identidade:</r> ${data.rg}</div> 	
				<div class="parts-four"><r>Habilitação:</r> ${data.license === '' ? "Não possui" : data.license}</div>
				<div class="parts-four"><r>Porte de Caça:</r> ${data.cacador ? "Possui" : "Não possui"} <button class="porte-button" data-method="caca" data-value="${porteButton}">${porteButton}</button></div>
			</div>
			<div class="info-right">
				<div class="parts-one"><r>Multas:</r> R$${data.tickets}</div> 
				<div class="parts-two"><r>Prisões:</r> ${data.arrests}</div> 
				<div class="parts-tree"><r>Avisos:</r> ${data.warnings}</div>
			</div>
		`);
  });
};

const arrestsUser = (user) => {
  $.post("http://mdt/arrestsUser", JSON.stringify({ user }), (data) => {
    const itens = data.arrests.sort((a, b) => (a.name > b.name ? 1 : -1));
    $("#info-result2").html(`
			<div class="sub-bar">
				<div class="title-one">DATA</div>
				<div class="title-two">TEMPO</div>
				<div class="title-tree">CRIMES</div>
				<div class="title-four">OFICIAL</div>
			</div>
			<div class="itens">
				${itens
          .map(
            (item) => `
					<div class="item" id="${item.id}">
						<div class="itens-one">${item.data}<button class="buttondelete" onclick="del(${item.id},'arrestsUser')">Apagar</button></div>
						<div class="itens-two">${item.value} meses</div>
						<div class="itens-tree">${item.info}</div>
						<div class="itens-four">${item.officer}</div>
					</div>
				`
          )
          .join("")}
			</div>
		`);
  });
};

const ticketsUser = (user) => {
  $.post("http://mdt/ticketsUser", JSON.stringify({ user }), (data) => {
    const itens = data.tickets.sort((a, b) => (a.name > b.name ? 1 : -1));
    $("#info-result3").html(`
			<div class="sub-bar">
				<div class="title-one">DATA</div>
				<div class="title-two">VALOR</div>
				<div class="title-tree">MOTIVOS</div>
				<div class="title-four">OFICIAL</div>
			</div>
			<div class="itens" id="">
				${itens
          .map(
            (item) => `
					<div class="item" id="${item.id}">
						<div class="itens-one">${item.data}<button class="buttondelete" onclick="del(${
              item.id
            },'ticketsUser')">Apagar</button></div>
						<div class="itens-two">R$${formatarNum(item.value)}</div>
						<div class="itens-tree">${item.info}</div>
						<div class="itens-four">${item.officer}</div>
					</div>
				`
          )
          .join("")}
			</div>
		`);
  });
};

const warningsUser = (user) => {
  $.post("http://mdt/warningsUser", JSON.stringify({ user }), (data) => {
    const itens = data.warnings.sort((a, b) => (a.name > b.name ? 1 : -1));
    $("#info-result4").html(`
			<div class="sub-bar">
				<div class="warning-title-one">DATA</div>
				<div class="warning-title-two">MOTIVOS</div>
				<div class="warning-title-tree">OFICIAL</div>
			</div>
			<div class="itens">
				${itens
          .map(
            (item) => `
					<div class="item" id="${item.id}">
						<div class="warning-itens-one">${item.data}<button class="buttondelete" onclick="del(${item.id},'warningsUser')">Apagar</button></div>
						<div class="warning-itens-two">${item.info}</div>
						<div class="warning-itens-tree">${item.officer}</div>
					</div>
				`
          )
          .join("")}
			</div>
		`);
  });
};

$(document).on("click", ".info", function () {
  let user_id = Number($("#user_id").val());
  $("#info-result").show();
  $("#info-result3").hide();
  $("#info-result4").hide();
  $("#info-result2").hide();
  if (user_id > 0) {
    infoUser(user_id);
  }
});

$(document).on("click", ".arrests", function () {
  let user_id = Number($("#user_id").val());
  $("#info-result").hide();
  $("#info-result2").show();
  $("#info-result3").hide();
  $("#info-result4").hide();
  if (user_id > 0) {
    arrestsUser(user_id);
  }
});

$(document).on("click", ".tickets", function () {
  let user_id = Number($("#user_id").val());
  $("#info-result").hide();
  $("#info-result2").hide();
  $("#info-result3").show();
  $("#info-result4").hide();
  if (user_id > 0) {
    ticketsUser(user_id);
  }
});

$(document).on("click", ".warnings", function () {
  let user_id = Number($("#user_id").val());
  $("#info-result").hide();
  $("#info-result2").hide();
  $("#info-result3").hide();
  $("#info-result4").show();
  if (user_id > 0) {
    warningsUser(user_id);
  }
});

$(document).on("click", "#search", function () {
  $("#warnings").hide();
  $("#searchs").show();
  $("#tickets").hide();
  $("#arrests").hide();
});

$(document).on("click", "#warning", function () {
  $("#searchs").hide();
  $("#tickets").hide();
  $("#arrests").hide();
  $("#warnings").show();
});

$(document).on("click", "#ticket", function () {
  $("#searchs").hide();
  $("#warnings").hide();
  $("#arrests").hide();
  $("#tickets").show();
});

$(document).on("click", "#arrest", function () {
  $("#searchs").hide();
  $("#warnings").hide();
  $("#tickets").hide();
  $("#arrests").show();
});

$(document).on("click", ".confirmar-warning", function () {
  let user = Number($("#user-war").val());
  let info = $("#info-war").val();
  if (user > 0) {
    $.post(
      "http://mdt/warningUser",
      JSON.stringify({
        user,
        info,
      })
    );
  }
});

$(document).on("click", ".confirmar-ticket", function () {
  let user = Number($("#user-tick").val());
  let value = Number($("#value-tick").val());
  let info = $("#info-tick").val();
  if (user > 0) {
    $.post(
      "http://mdt/ticketUser",
      JSON.stringify({
        user,
        value,
        info,
      })
    );
  }
});

$(document).on("click", ".confirmar-arrest", function () {
  let user = Number($("#user-arre").val());
  let value = Number($("#value-arre").val());
  let info = $("#info-arre").val();
  if (user > 0) {
    $.post(
      "http://mdt/arrestUser",
      JSON.stringify({
        user,
        value,
        info,
      })
    );
  }
});

$(document).on("click", ".porte-button", function () {
  const method = $(this).data("method");
  const value = $(this).data("value");

  let user_id = Number($("#user_id").val());
  if (user_id > 0) {
    $.post("http://mdt/porte", JSON.stringify({ user_id: user_id, method: method, value: value }), (data) => {
      if (data.ok) {
        $("#info-result").show();
        $("#info-result3").hide();
        $("#info-result4").hide();
        $("#info-result2").hide();
        infoUser(user_id);
      }
    });
  }
});