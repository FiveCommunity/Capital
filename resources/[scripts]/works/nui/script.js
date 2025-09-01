$(document).ready(() => {
  var jobs = [];
  var currentJob = 0;

  const renderList = (
    index,
    image,
    business,
    job,
    price,
    routes,
    description
  ) => {
    return `
    <li class="jobs-content ${
      currentJob == index ? "active" : ""
    }" data-index="${index}">
      <header>
        <img
          id="image"
          src="${image}"
        />
        <div class="business-title">
          <h2>${business}</h2>
          <span>${description}</span>
        </div>
      </header>
      <ul id="job-infos">
        <li class="infos-content">
          Emprego: <span id="job">${job}</span>
        </li>
        <li class="infos-content">
          Pagamento: <span id="price">${price}</span>
        </li>
        <li class="infos-content">
          Duração: <span id="routes">${routes} pontos de entrega</span>
        </li>
      </ul>
    </li>
  `;
  };

  const actions = {
    open: ({ jobs: backJobs }) => {
      jobs = backJobs;
      $("#jobs").show();
      $("#jobs-list").html("");
      $.each(backJobs, function (index, data) {
        $("#jobs-list").append(
          renderList(
            index,
            data.url,
            data.business,
            data.name,
            data.price,
            data.routes,
            data.description
          )
        );
      });
    },
  };

  window.addEventListener("message", (event) => {
    const { action } = event.data;
    if (actions[action]) actions[action](event.data);
  });

  document.onkeyup = (event) => {
    if (event.key == "Escape") {
      closeNui();
    }
  };

  const scrollTo = (target) => {
    const position = (target - 1) * 448;
    $("#jobs-list").animate({ scrollLeft: position });
  };

  const changeCurrentJob = (value = -1) => {
    const newCurrentJob = currentJob + value;
    if (newCurrentJob >= 0 && jobs.length > newCurrentJob) {
      currentJob = newCurrentJob;
      const target = $(`.jobs-content[data-index=${newCurrentJob}]`);

      $(".jobs-content").removeClass("active");
      target.addClass("active");
      scrollTo(newCurrentJob + 1);
    }
  };

  $(document).keydown(function (e) {
    e.preventDefault();
    switch (e.which) {
      case 37:
        changeCurrentJob(-1);
        break;

      case 39:
        changeCurrentJob(1);
        break;

      case 13:
        $.post(
          `http://${GetParentResourceName()}/startJob`,
          JSON.stringify({ works: jobs[currentJob].name })
        );
        closeNui();
        break;

      default:
        return;
    }
  });
});

function closeNui() {
  $("#jobs").hide();
  $.post(`http://${GetParentResourceName()}/close`, JSON.stringify({}));
}
