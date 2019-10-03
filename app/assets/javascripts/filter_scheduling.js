$(document).on("turbolinks:load", function () {
  var establishemntSelect = $('#scheduling_status');
  var establishmentDate = $('.radio_filter_scheduling_cards');

  establishemntSelect.on('change', function (e) {
    e.currentTarget.form.submit();
  });

  establishmentDate.on('change', function (e) {
    e.currentTarget.form.submit();
  });

  var schedulingSelect = $('#users_dashboard_status');
  schedulingSelect.on('change', function (e) {
    e.currentTarget.form.submit();
  });

});