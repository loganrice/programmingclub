window.addEventListener("turbolinks:load", () => {
  $("a.grade").on("ajax:success", (event) => {
    [data, status, xhr] = event.detail;
    $(event.target).addClass("btn-success");
    $(event.target).removeClass("btn-secondary");
    $("#graded-points-" + data.submission.id).html(data.submission.graded_points);
  });
});
