document.addEventListener('turbolinks:load', () => {
  window.addEventListener('keydown', function(e) {
    if((e.key=='Escape'||e.key=='Esc'||e.keyCode==27)){
      document.querySelectorAll('.modal')[0].classList.remove('is-active');
		  e.preventDefault();
      return false;
    }
  }, true);
  modalEvents();
});

function modalEvents() {
  var modals = document.querySelectorAll('.modal');
  if(modals.length <= 0) return;

  var modalButton = document.querySelectorAll('.modal-button');
  
  if(modalButton.length > 0) {
    modalButton.forEach(function(btn, index) {
      btn.addEventListener('click', function(e) {
        var modalId = btn.dataset.target;
        var modalTarget = document.getElementById(modalId);
        if(!modalTarget) return;
        modalTarget.classList.add('is-active');
      });
    });
  }

  var modalClose = document.querySelectorAll('.modal-close');
  if(modalClose.length <= 0) return;

  modalClose[0].addEventListener('click', function(e) {
    modals.forEach(function(md, index) {
      md.classList.remove('is-active');
    });
  });
}
  