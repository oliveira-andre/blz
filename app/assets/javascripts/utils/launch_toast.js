$(document).on("turbolinks:load", function () {
  var flashtoastr = $('.flashtoastr-item');
  if(!flashtoastr) return;

  flashtoastr.each(function(index) {
    var target = $('.flashtoastr-item')[index];

    switch (target.dataset.type) {
      case 'notice':
        toastr.info(target.textContent);
        break;
      case 'alert':
        toastr.warning(target.textContent);
        break;
      case 'error':
        toastr.error(target.textContent);
        break;
      case 'success':
        toastr.success(target.textContent);
        break;
      default:
        toastr.info(target.textContent);
    }
  });
});