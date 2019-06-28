$(document).on("turbolinks:load", function () {
  listeningInputs();
});

function listeningInputs() {
  if(!$('#filter-services')) return;

  var categorySelect = $('select[id="filter-services-category"]');
  var dateField = $('input[id="filter-services-date"]');

  categorySelect.on('change', sendSubmit);
  dateField.on('change', sendSubmit);
}

function sendSubmit(e) {
  e.currentTarget.form.submit();
}