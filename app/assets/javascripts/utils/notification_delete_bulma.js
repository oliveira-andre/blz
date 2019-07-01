document.addEventListener('turbolinks:load', () => {
  loadButtonDelete();
});

function loadButtonDelete() {
  notifications_btn = document.querySelectorAll('.notification .delete')

  notifications_btn.forEach(function (btn) {
    btn.addEventListener('click', function (event) {
      event.target.parentNode.remove();
    });
  })
}
