$(document).on("turbolinks:load", function () {
  var schedulingSelect = $('#users_dashboard_status');
  schedulingSelect.on('change', function(e) {
    e.currentTarget.form.submit();
  });
});