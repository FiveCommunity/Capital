let shiftPressed = false;
let controlPressed = false;
let secundary = "drop";
const IMAGES = "http://189.127.164.125/babilonia/gb_inventory";

const Amount = (maxAmount) => {
  maxAmount = parseInt(maxAmount);

  let amount = 1;
  if (shiftPressed) amount = maxAmount;
  else if (controlPressed && maxAmount > 1) amount = Math.floor(maxAmount / 2);
  return amount;
};

$(document).ready(function () {
  //=========================================================================================================================
  // CLIENT LISTNER
  //=========================================================================================================================
  window.addEventListener("message", function (event) {
    switch (event.data.action) {
      case "display":
        secundary = event.data.type;
        $("body").fadeIn(100);
        break;

      case "setItems":
        updateMainInventory(event.data.itemList, event.data.slots);
        break;

      case "setSecondItems":
        updateSecundaryInventory(event.data.itemSList, event.data.slots);
        break;

      case "setText":
        $("#textMain").html(`${event.data.text}`);
        $("#weightTextLeft").html(
          `<b>${event.data.weight.toFixed(
            1
          )}</b>   /   ${event.data.max.toFixed(1)}`
        );
        break;

      case "setSecondText":
        $("#textSec").html(`${event.data.text}`);
        $("#weightTextRight").html(`<b>${event.data.weight.toFixed(1)}</b>`);
        $("#weightBarRight").css("width", "100%");
        if (event.data.max != undefined) {
          $("#weightTextRight").html(
            `<b>${event.data.weight.toFixed(
              1
            )}</b>   /   ${event.data.max.toFixed(1)}`
          );
        }
        break;

      case "hide":
        $("body").fadeOut(100);
        $(".tooltip").fadeOut(100);
        break;
    }
  });

  //=========================================================================================================================
  // KEY INPUT
  //=========================================================================================================================
  document.onkeydown = (data) => {
    const key = data.key;
    if (key === "Shift") shiftPressed = true;
    else if (key === "Control") controlPressed = true;
  };
  document.onkeyup = (data) => {
    const key = data.key;
    if (key === "Escape") {
      hideContextMenu();
      $.post("http://inventory/NUIFocusOff", JSON.stringify({}));
    } else if (key === "Shift") {
      shiftPressed = false;
    } else if (key === "Control") {
      controlPressed = false;
    }
  };

  //=========================================================================================================================
  // CONTEXT
  //=========================================================================================================================
  let items = {
    slot: 0,
    amount: 0,
    secundary: "drop",
    item: { name: "", spawn: "" },
    origin: null,
    dest: null,
    target: null,
  };

  const showContextMenu = (x, y) => {
    $(".context-menu").show();
    $(".context-menu .general").show();
    $(".context-menu .general .container").css({
      left: `calc(${x}px + 1.5rem)`,
      top: `${y}px`,
    });

    $("#list-buttons").html(`
      <li>
        <button class="use">usar</button>
      </li>
      <li>
        <button class="send">enviar</button>
      </li>
      ${items.item.desc ? `
        <li>
          <button class="desc">detalhes</button>
        </li>
      ` : ``}
    `);
  };

  function hideContextMenu() {
    $(".context-menu").hide();
    $(".context-menu .general").hide();
    $(".context-menu .send-menu").hide();
    $(".context-menu .send-menu .container").html("");
  }

  function showSendMenu() {
    $(".context-menu .general").hide();
    $(".context-menu .send-menu").show();

    const item = `
				<div class="container-item">
          <div class="item">
            <div class="itemAmount">${items.amount}x</div>
            <img
              src="http://189.127.164.125/babilonia/gb_inventory/${items.item.spawn}.png"
            />
          </div>
          <div class="itemName">${items.item.name}</div>
        </div>
        <input id="item-value" type="number" value="${Amount(items.amount)}" min="1" max="${items.amount}" />
        <button class="confirm-send">CONFIRMAR</button>
      `;

    $(".context-menu .send-menu .container").html(item);
  }

  function showDesc() {
    $(".context-menu .general").hide();
    $(".context-menu .send-menu").show();

    $(".context-menu .send-menu .container").css("width", "15rem")

    const item = `
      <div class="container-item">
        <div class="item">
          <div class="itemAmount">${items.amount}x</div>
          <img
            src="http://189.127.164.125/babilonia/gb_inventory/${items.item.spawn}.png"
          />
        </div>
        <div class="itemName">${items.item.name}</div>
      </div>
      <p>${items.item.desc}</p>
      <button class="close-desc">FECHAR</button>
    `;

    $(".context-menu .send-menu .container").html(item);
  }

  $(document).on("contextmenu", "#item", function (e) {
    let _this = $(this).data();

    items = {
      slot: _this.slot,
      amount: _this.amount,
      secundary: secundary,
      item: { name: _this.name, spawn: _this.item, desc: _this.desc },
    };

    e.preventDefault();
    showContextMenu(e.clientX, e.clientY);
  });

  $(document).on("click", ".context-menu .backdrop", hideContextMenu);
  $(document).on("contextmenu", ".context-menu .backdrop", hideContextMenu);

  $(document).on("click", ".use", function () {
    hideContextMenu();
    $.post("http://inventory/UseItem", JSON.stringify(items));
  });

  $(document).on("click", ".send", showSendMenu);
  $(document).on("click", ".desc", showDesc);

  $(document).on("input", "#item-value", function () {
    let value = parseInt($(this).val());
    if (value > items.amount || value <= 0 || isNaN(value)) {
      $(".confirm-send").css({
        opacity: "0.5",
        "pointer-events": "none",
      });
    } else {
      $(".confirm-send").css({
        opacity: "1",
        "pointer-events": "",
      });
    }
  });

  $(document).on("click", ".confirm-send", function () {

    let amount = items.amount;
    let input = parseInt($('#item-value').val());
    if ( !isNaN(input) && (input > 0) && (input <= items.amount) ) {
      amount = input;
    } else {
      amount = 1;
    }
    hideContextMenu();

    if (items.origin) {
      if (items.origin === "invLeft" && items.dest === "invLeft") {
        $.post(
          "http://inventory/SwapItems",
          JSON.stringify({
            slot: items.slot,
            target: items.target,
            amount: amount,
            secundary: items.secundary,
          })
        );

        items.origin = null;
        return;
      }

      if (items.origin === "invRight" && items.dest === "invRight") {
        switch (secundary) {
          case "vault":
            $.post(
              "http://inventory/SwapVault",
              JSON.stringify({
                slot: items.slot,
                target: items.target,
                amount: amount,
              })
            );
            break;
        }

        items.origin = null;
        return;
      }

      if (items.origin === "invLeft" && items.dest === "invRight") {
        switch (secundary) {
          case "drop":
            $.post(
              "http://inventory/DropItem",
              JSON.stringify({
                slot: items.slot,
                target: items.target,
                amount: amount,
              })
            );
            break;

          case "inspect":
            $.post(
              "http://inventory/PutInspectItem",
              JSON.stringify({
                slot: items.slot,
                target: items.target,
                amount: amount,
              })
            );
            break;

          case "vault":
            $.post(
              "http://inventory/PutIntoVault",
              JSON.stringify({
                slot: items.slot,
                target: items.target,
                amount: amount,
              })
            );
            break;
        }

        items.origin = null;
        return;
      }

      if (items.origin === "invRight" && items.dest === "invLeft") {
        switch (secundary) {
          case "drop":
            $.post(
              "http://inventory/PickupItem",
              JSON.stringify({
                id: items.id,
                target: items.target,
                amount: amount,
              })
            );
            break;

          case "inspect":
            $.post(
              "http://inventory/RemInspectItem",
              JSON.stringify({
                slot: items.slot,
                target: items.target,
                amount: amount,
              })
            );
            break;

          case "vault":
            $.post(
              "http://inventory/TakeFromVault",
              JSON.stringify({
                slot: items.slot,
                target: items.target,
                amount: amount,
              })
            );
            break;
        }

        items.origin = null;
        return;
      }
    } else {
      $.post("http://inventory/SendItem", JSON.stringify({
        slot: items.slot,
        amount: amount,
      }));
    }
  });

  $(document).on("click", ".close-desc", hideContextMenu);

  $("body").mousedown((e) => {
    if (e.button == 1) return false;
  });

  //=========================================================================================================================
  // DRAG | DROPPER - UPDATER
  //=========================================================================================================================
  const taskSlotChange = (origin, dest, target, itemData) => {
    $(".populated, .empty").off("draggable droppable");

    if (itemData.amount <= 1 || shiftPressed) {
      if (origin) {
        if (origin === "invLeft" && dest === "invLeft") {
          $.post(
            "http://inventory/SwapItems",
            JSON.stringify({
              slot: itemData.slot,
              target: target,
              amount: itemData.amount,
              secundary: secundary,
            })
          );
          return;
        }

        if (origin === "invRight" && dest === "invRight") {
          switch (secundary) {
            case "vault":
              $.post(
                "http://inventory/SwapVault",
                JSON.stringify({
                  slot: itemData.slot,
                  target: target,
                  amount: itemData.amount,
                })
              );
              break;
          }
          return;
        }

        if (origin === "invLeft" && dest === "invRight") {
          switch (secundary) {
            case "drop":
              $.post(
                "http://inventory/DropItem",
                JSON.stringify({
                  slot: itemData.slot,
                  target: target,
                  amount: itemData.amount,
                })
              );
              break;

            case "inspect":
              $.post(
                "http://inventory/PutInspectItem",
                JSON.stringify({
                  slot: itemData.slot,
                  target: target,
                  amount: itemData.amount,
                })
              );
              break;

            case "vault":
              $.post(
                "http://inventory/PutIntoVault",
                JSON.stringify({
                  slot: itemData.slot,
                  target: target,
                  amount: itemData.amount,
                })
              );
              break;
          }
          return;
        }

        if (origin === "invRight" && dest === "invLeft") {
          switch (secundary) {
            case "drop":
              $.post(
                "http://inventory/PickupItem",
                JSON.stringify({
                  id: itemData.id,
                  target: target,
                  amount: itemData.amount,
                })
              );
              break;

            case "inspect":
              $.post(
                "http://inventory/RemInspectItem",
                JSON.stringify({
                  slot: itemData.slot,
                  target: target,
                  amount: itemData.amount,
                })
              );
              break;

            case "vault":
              $.post(
                "http://inventory/TakeFromVault",
                JSON.stringify({
                  slot: itemData.slot,
                  target: target,
                  amount: itemData.amount,
                })
              );
              break;
          }
          return;
        }
      } else {
        $.post("http://inventory/SendItem", JSON.stringify({
          slot: itemData.slot,
          amount: itemData.amount,
        }));
      }
    } else {
      items = {
        slot: itemData.slot,
        amount: itemData.amount,
        secundary: secundary,
        item: { name: itemData.name, spawn: itemData.item },
        id: itemData.id,
        origin: origin,
        dest: dest,
        target: target,
      };

      $(".context-menu").show();
      showSendMenu();
    }
  };

  const updateDrag = () => {
    $(".populated").draggable({ helper: "clone" });

    $(".empty").droppable({
      hoverClass: "hoverControl",
      drop: function (event, ui) {
        if (ui.draggable.parent()[0] == undefined) return;

        const origin = ui.draggable.parent()[0].className;
        const dest = $(this).parent()[0].className;

        if (origin === undefined) return;

        const itemData = {
          item: ui.draggable.data("item"),
          name: ui.draggable.data("name"),
          slot: ui.draggable.data("slot"),
          id: ui.draggable.data("id"),
          amount: ui.draggable.data("amount"),
        };

        const target = $(this).data("slot");

        if (itemData.item === undefined || target === undefined) return;

        taskSlotChange(origin, dest, target, itemData);
      },
    });

    $(".populated").droppable({
      hoverClass: "hoverControl",
      drop: function (event, ui) {
        if (ui.draggable.parent()[0] == undefined) return;

        const origin = ui.draggable.parent()[0].className;
        const dest = $(this).parent()[0].className;

        if (origin === undefined) return;

        const itemData = {
          item: ui.draggable.data("item"),
          name: ui.draggable.data("name"),
          slot: ui.draggable.data("slot"),
          id: ui.draggable.data("id"),
          amount: ui.draggable.data("amount"),
        };

        const target = $(this).data("slot");

        if (itemData.item === undefined || target === undefined) return;

        taskSlotChange(origin, dest, target, itemData);
      },
    });

    $(".drop").droppable({
      hoverClass: "hoverControl",
      drop: function (event, ui) {
        if (ui.draggable.parent()[0] == undefined) return;

        const origin = ui.draggable.parent()[0].className;
        if (origin === undefined || origin === "invRight") return;

        itemData = {
          item: ui.draggable.data("item"),
          name: ui.draggable.data("name"),
          slot: ui.draggable.data("slot"),
        };
        if (itemData.item === undefined) return;

        let amount = Amount(itemData.amount);

        $.post(
          "http://inventory/DropItem",
          JSON.stringify({
            slot: itemData.slot,
            amount: amount,
            secundary: secundary,
          })
        );
        $(".amount").val("");
      },
    });

    // $(".populated").mouseover(function () {
    //   const name = $(this).attr("data-name");
    //   const item = $(this).attr("data-item");
    //   const index = $(this).attr("data-index");
    //   const weight = Number($(this).attr("data-weight"));
    //   const desc = $(this).attr("data-desc");

    //   $(".tooltip").html(`
    // 	<div class="tooltip-img"><img src="${IMAGES}/${index}.png"></div>
    // 	<div class="tooltip-desc">
    //   <div class="column">Nome: <b>${name}</b></div><br>
    // 		<div class="column">Peso: <b>${weight.toFixed(1)}kg</b></div><br>
    // 	</div>
    // 	`);
    //   $(".tooltip").show();
    // });

    // $(".populated").mouseout(function () {
    //   $(".tooltip").hide();
    //   $(".tooltip").html(``);
    // });
  };
  //=========================================================================================================================
  // MAIN INVENTORY
  //=========================================================================================================================
  const updateMainInventory = (invData, slots) => {
    $(".invLeft").html("");

    for (let x = 1; x <= slots; x++) {
      const slot = x.toString();

      let hotbar = "";
      if (x >= 1 && x <= 5) {
        hotbar = `<div class="hotbar-number">${x}</div>`;
      }

      if (invData[slot] !== undefined) {
        const v = invData[slot];
        const item = `
				<div 
					class="item populated"
          id="item"
					data-slot="${slot}"
					data-name="${v.name}"
					data-item="${v.item}"
					data-index="${v.index}"
					data-amount="${v.amount}"
					data-weight="${v.weight}"
          data-desc="${v.desc}"
				>
					<div class="top">
            ${
              hotbar === ""
                ? `<div class="itemWeight">${v.weight.toFixed(1)}</div>`
                : ""
            }
						<div class="itemAmount">${v.amount}x</div>
					</div>
					${hotbar}
					<img src="${IMAGES}/${v.index}.png">
					<div class="item-footer">
            <div class="item-name">${v.name}</div>
            ${
              v.durability > 0
                ? `<div class="item-durability" style="background-color: ${colorPicker(
                    v.durability
                  )};"/>`
                : ``
            }
          </div>
				</div>
			`;

        $(".invLeft").append(item);
      } else {
        const item = `<div class="item empty" data-slot="${slot}">${hotbar}</div>`;
        $(".invLeft").append(item);
      }
    }

    updateDrag();
  };
  //=========================================================================================================================
  // SECONDARY INVENTORY
  //=========================================================================================================================
  const updateSecundaryInventory = (invData, slots) => {
    $(".invRight").html("");

    for (let x = 1; x <= slots; x++) {
      const slot = x.toString();

      if (invData[slot] !== undefined) {
        const v = invData[slot];

        const item = `
				<div 
					class="item populated"
					data-slot="${slot}"
					data-name="${v.name}"
					data-item="${v.item}"
					data-index="${v.index}"
					data-amount="${v.amount}"
					data-weight="${v.weight}"
          data-id="${v.id}"
				>
					<div class="top">
            <div class="itemWeight">${v.weight.toFixed(1)}</div>
						<div class="itemAmount">${v.amount}x</div>
					</div>
					<img src="${IMAGES}/${v.index}.png">
					<div class="item-footer">
            <div class="item-name">${v.name}</div>
            ${
              v.durability > 0
                ? `<div class="item-durability" style="background-color: ${colorPicker(
                    v.durability
                  )};"/>`
                : ``
            }
          </div>
				</div>
			`;

        $(".invRight").append(item);
      } else {
        const item = `<div class="item empty" data-slot="${slot}"></div>`;
        $(".invRight").append(item);
      }
    }
    updateDrag();
  };
  //=========================================================================================================================
  // MISC FUCNTIONS
  //=========================================================================================================================
  const colorPicker = (durability) => {
    // Garantindo que o valor esteja entre 0 e 100
    const valor = Math.min(100, Math.max(0, durability));

    let red, green, blue;

    if (valor < 50) {
      // Verde para amarelo
      red = Math.round((valor * 2 * 255) / 100);
      green = 255;
      blue = 0;
    } else {
      // Amarelo para vermelho
      red = 255;
      green = Math.round(((100 - valor) * 2 * 255) / 100);
      blue = 0;
    }
    return `rgb(${red}, ${green}, ${blue})`;
  };

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
});
