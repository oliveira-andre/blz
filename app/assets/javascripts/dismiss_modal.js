$(document).on('turbolinks:load', function() {
  $(".close-button").click(function() {
    $(".modal").removeClass("is-active");
  });
});
