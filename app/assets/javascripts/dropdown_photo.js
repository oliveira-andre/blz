$(document).on("turbolinks:load", function () {
  $('.is-dropdown').click(function () {
    renderDropdown($(this).data('target'));
  });
});

function renderDropdown(id) {
  $(`#${id}`).toggle();
}