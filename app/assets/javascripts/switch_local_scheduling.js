$(document).on('turbolinks:load', function () {
  switchLocalScheduling();
  $('.new_scheduling_radio').change(function () {
    switchLocalScheduling();
  });
});

function switchLocalScheduling() {
  if ($('#in_home').prop("checked") == true) {
    $('#establishment_address').addClass('is-hidden');
    $('#address_form').removeClass('is-hidden');
    $('.address_field').prop('required', true);
  } else if($('#in_establishment').prop("checked") == true) {
    $('#establishment_address').removeClass('is-hidden');
    $('#address_form').addClass('is-hidden');
    $('.address_field').prop('required', false);
  }
}