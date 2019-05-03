$(document).on("turbolinks:load", function () {
  launch_toast();
});

function launch_toast() {
  toast = $('.toast')
  if(!toast) return;
  setTimeout( function() { toast.removeClass('show') }, 5000);
 }