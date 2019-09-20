$(document).on("turbolinks:load", function () {
  var establishemntSelect = $('#establishments_dashboard_status');
  var establishmentDate = $('.radio_filter_cards');
  
  establishemntSelect.on('change', function(e) {
    e.currentTarget.form.submit();
  });

  establishmentDate.on('change', function(e) {
    e.currentTarget.form.submit();    
  });
});