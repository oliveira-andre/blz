$(document).on("turbolinks:load", function () {
  $('.is-dropdown').click(function () {
    renderDropdown(this.dataset.target);
  });
});

function renderDropdown(id) {
  $(`#${id}`).toggle();
}