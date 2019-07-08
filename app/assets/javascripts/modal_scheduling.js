$(document).on('turbolinks:load', function() {
  $('.btn-show-scheduling-details').click(function() {
    insertDataIntoModal(this);
  });
});

function insertDataIntoModal(button) {
  var date = $(button).data('date');
  var day = fomartDay(date);
  var month = fomartMonth(date);
  var hour = fomartHour(date);
  var minute = fomartMinute(date);
  $('.scheduling_date').html(`${day}/${month} às ${hour}:${minute}`);
  $('.date_scheduling_details').val(date);
}

function fomartDay(date) {
  return date.substring(0,2);
}

function fomartMonth(date) {
  return date.substring(3,5);
}

function fomartHour(date) {
  return date.substring(11, 13);
}

function fomartMinute(date) {
  return date.substring(14, 16);
}