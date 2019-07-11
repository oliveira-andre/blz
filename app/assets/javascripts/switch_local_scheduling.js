$(document).on('turbolinks:load', function () {
  switchLocalScheduling();
  $('#scheduling_home').change(function () {
    switchLocalScheduling();
  });
});

function switchLocalScheduling(select) {
  if ($('#scheduling_home').val() == 1) {
    $('#establishment_address').addClass('is-hidden');
    $('#address_form').removeClass('is-hidden');
    $('.address_field').prop('required', true);
  } else if($('#scheduling_home').val() == 0) {
    $('#establishment_address').removeClass('is-hidden');
    $('#address_form').addClass('is-hidden');
    $('.address_field').prop('required', false);
  }
}