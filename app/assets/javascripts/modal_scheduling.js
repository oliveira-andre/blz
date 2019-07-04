$(document).on('turbolinks:load', function() {
  $('.btn-show-scheduling-details').click(function() {
    insertDataIntoModal(this);
  });
});

function insertDataIntoModal(button) {
  var date = $(button).data('date');
  var day = setDay(date);
  var month = setMonth(date);
  var hour = setHour(date);
  var minute = setMinute(date);
  $('#scheduling_date').html(`${day}/${month} às ${hour}:${minute}`);
  $('#date').val(date);
}

function setDay(date) {
  return date.substring(0,2);
}

function setMonth(date) {
  return date.substring(3,5);
}

function setHour(date) {
  return date.substring(11, 13);
}

function setMinute(date) {
  return date.substring(14, 16);
}