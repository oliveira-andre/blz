$(document).on("turbolinks:load", function () {
  listeningInputs();
});

function listeningInputs() {
  if(!$('#filter-services')) return;

  var categorySelect = $('select[name="category"]');
  var dateField = $('input[type="date"]');

  categorySelect.on('change', sendSubmit);
  dateField.on('change', sendSubmit);
}

function sendSubmit(e) {
  e.currentTarget.form.submit();
}