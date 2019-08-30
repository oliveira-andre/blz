$(document).on("turbolinks:load", function () {
  listeningInputs();
  toggleFilters();
});

function listeningInputs() {
  if(!$('#filter-services')) return;

  var categorySelect = $('select[id="filter-services-category"]');
  var dateField = $('input[id="filter-services-date"]');
  var localTypeSelect = $('select[id="filter-services-local-type"]')

  categorySelect.on('change', sendSubmit);
  dateField.on('change', function(e) {
    var year = parseInt(dateField.val().substring(0, 4));
    if(year.toString().length == 4) {
      console.log('this');
      sendSubmit(e);
    }
  });
  localTypeSelect.on('change', sendSubmit);
}

function toggleFilters() {
  if(!$('.toggle-filter-services')) return;

  $('.toggle-filter-services').on('click', function(e){
    var contentTargetId = e.currentTarget.dataset.target;
    $('.toggle-filter-services').toggleClass('active');
    $(`#${contentTargetId}`).toggleClass('active');
  });
}

function sendSubmit(e) {
  console.log(e);
  e.currentTarget.form.submit();
}