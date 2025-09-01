$(document).ready(() => {
  const post = (link, data) => {
    $("#talknpc").hide();
    $.post(link, data);
  };

  const actions = {
    open: ({ data }) => {
      $("#talknpc").show();
      $("#name").text(data.name);
      $("#shop").text(data.shop);
      $("#dialog").text(data.dialog);

      $("#options").html("");
      data.options.map((item, index) => {
        const listOptions = `
            <li>
                <button class="option" onClick="selectOption(${index + 1})" >${
          item.option
        }</button>
            </li>
        `;
        $("#options").append(listOptions);
      });
    },
  };

  window.addEventListener("message", (event) => {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);
  });

  selectOption = function (index) {
    post(
      "http://npc/selectedOption",
      JSON.stringify({
        index: index,
      })
    );
  };

  document.onkeyup = (event) => {
    if (event.key === "Escape") {
      post("http://npc/close", {});
    }
  };
});
