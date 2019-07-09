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
    $('#scheduling_address_attributes_zipcode').prop('required', true);
    $('#scheduling_address_attributes_street').prop('required', true);
    $('#scheduling_address_attributes_neighborhood').prop('required', true);
    $('#scheduling_address_attributes_number').prop('required', true);
  } else if($('#scheduling_home').val() == 0) {
    $('#establishment_address').removeClass('is-hidden');
    $('#address_form').addClass('is-hidden');
    $('#scheduling_address_attributes_zipcode').prop('required', false);
    $('#scheduling_address_attributes_street').prop('required', false);
    $('#scheduling_address_attributes_neighborhood').prop('required', false);
    $('#scheduling_address_attributes_number').prop('required', false);
  }
}