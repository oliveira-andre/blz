$(document).on("turbolinks:load", function () {
  $('#arrow-next').on('click', function() {
    var width = $('.table-schedule').width();
    var leftPosition = $('.table-schedule').scrollLeft();
    $('.table-schedule').scrollLeft(leftPosition + width);
  });

  $('#arrow-back').on('click', function() {
    var width = $('.table-schedule').width();
    var leftPosition = $('.table-schedule').scrollLeft();
    $('.table-schedule').scrollLeft(leftPosition - width);
  });
});