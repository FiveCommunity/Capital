var apartament;
var myApartament;

const actions = {
  open: ({ data }) => {
    let haveApartament = data.haveApartament;
    apartament = data.apartament;
    $("#homes").show();
    $(".title").text("Interfone");

    $("#action-list").html("");
    if (haveApartament[0]) {
      myApartament = haveApartament[1];
      $("#action-list").append(
        `
          <li><button class="item-description" data-value="residencia"><i class="fa-solid fa-building"></i>Minha residência</button></li>
          <li><button class="item-description" data-value="interfone"><i class="fa-solid fa-phone-flip"></i>Interfone</button></li>
        `
      );
    } else {
      $("#action-list").append(
        ` 
          <li> <button class="item-description" data-value="comprar"><i class="fa-solid fa-building"></i>Comprar </button> </li>
          <li><button class="item-description" data-value="interfone"><i class="fa-solid fa-phone-flip"></i>Interfone</button></li> 
        `
      );
    }
  },
  residencia: () => {
    post("myApartament", myApartament);
  },
  comprar: () => {
    post("buyApartament", apartament);
  },
  interfone: () => {
    post("otherApartament", {});
  },
  wardrobe: ({ data }) => {
    $("#homes").show();
    $(".title").text("Guarda Roupa");
    $("#action-list").html("");
    $("#action-list").append(
      ` 
        <li>
          <button class="item-description" data-value="add_outfit"><i class="fa-solid fa-plus"></i>Adicionar outfit </button> 
        </li>
        <li>
          <button class="item-description" data-value="del_outfit"><i class="fa-regular fa-trash-can"></i>deletar outfit </button> 
        </li>
      `
    );

    data.presets.map((values, index) => {
      const html = `
        <li>
          <button class="item-description" data-value="set_outfit" data-preset="${
            index + 1
          }">
            <i class="fa-solid fa-shirt"></i> ${values.name}
          </button>
        </li>
      `;

      $("#action-list").append(html);
    });
  },
  add_outfit: () => {
    post("outfit", "add_outfit");
  },
  del_outfit: () => {
    post("outfit", "del_outfit");
  },
  set_outfit: (slot) => {
    post("setOutfit", slot);
  },
};

$(document).ready(() => {
  window.addEventListener("message", (event) => {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);
  });

  document.onkeyup = (event) => {
    if (event.key == "Escape") {
      post("close", {});
    }
  };

  $(document).on("click", ".item-description", function () {
    const metodo = $(this).data("value");
    actions[metodo]($(this).data("preset"));
  });
});

function post(link, value) {
  $("#homes").hide();
  $.post(`http://homes/${link}`, JSON.stringify(value));
}
