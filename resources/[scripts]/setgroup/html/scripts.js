var groups;
var user_id;

const methods = {
  openNUI: ({ user_identity, usergroups, sysgroups }) => {
    groups = sysgroups;
    user_id = user_identity.id;
    $("#userid").text(user_id);
    $("#username").text(user_identity.firstname + " " + user_identity.lastname);

    $("#select-group").append(
      `<option value="">Grupo</option><option disabled></option>`
    );

    $("#select-grade").append(
      `<option value="">Cargo</option><option disabled></option>`
    );

    sysgroups
      .sort((a, b) => (a.group > b.group ? 1 : -1))
      .map((item) => {
        $("#select-group").append(
          `<option value=${item.group}>${item.group}</option>`
        );
      });

    usergroups
      .sort((a, b) => (a.group > b.group ? 1 : -1))
      .map((item) => {
        $("#user-groups").append(
          `<li data-group='${item.group}' data-grade='${item.grade}'><i class="fa-solid fa-xmark"></i> ${item.group} > ${item.grade}</li>`
        );
      });

    $("#gbSetGroup").fadeIn();
  },
  attUserGroups: ({ usergroups }) => {
    $("#user-groups").html("");
    usergroups.map((item) => {
      $("#user-groups").append(
        `<li data-group='${item.group}' data-grade='${item.grade}'><i class="fa-solid fa-xmark"></i> ${item.group} > ${item.grade}</li>`
      );
    });
  },
};

window.addEventListener("message", (event) => {
  const { type } = event.data;
  methods[type](event.data);
});

$("#btn-add").on("click", () => {
  const group = $("#select-group").val();
  const grade = $("#select-grade").val();

  if (group === "") {
    $("#error-group").fadeIn();
    return;
  }

  if (grade === "") {
    $("#error-grade").fadeIn();
    return;
  }

  $.post(
    `http://${GetParentResourceName()}/addGroup`,
    JSON.stringify({
      user_id,
      group,
      grade,
    })
  );
});

$(document).on("click", "#user-groups li", function () {
  const group = $(this).data("group");
  const grade = $(this).data("grade");

  $.post(
    `http://${GetParentResourceName()}/delGroup`,
    JSON.stringify({
      user_id,
      group,
      grade,
    })
  );
});

$("#select-group").on("change", function () {
  $("#select-grade").html("");
  const group = $(this).val();
  $("#select-grade").append(
    `<option value="">Cargo</option><option disabled></option>`
  );
  groups
    .filter((item) => item.group === group)[0]
    .grades.map((grade) => {
      $("#select-grade").append(`<option value=${grade}>${grade}</option>`);
    });
});

const closeNUI = () => {
  $(".error").fadeOut();
  $("#select-group").html("");
  $("#select-grade").html("");
  $("#user-groups").html("");
  $("#gbSetGroup").fadeOut();
  $.post(`http://${GetParentResourceName()}/close`, "[]");
};

$("#btn-close").on("click", closeNUI);

document.onkeyup = (event) => {
  if (event.key == "Escape") {
    closeNUI();
  }
};
