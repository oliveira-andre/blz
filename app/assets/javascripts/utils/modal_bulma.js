document.addEventListener('turbolinks:load', () => {
  modalListener();
});

function modalListener() {
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

  var modalsClose = document.querySelectorAll('.modal-close');
  if(modalsClose <= 0) return;

  modalsClose.forEach(function(modalClose) {
    modalClose.addEventListener('click', function(e) {
      e.currentTarget.parentElement.classList.remove('is-active')
    });
  });


  var modalsBackground= document.querySelectorAll('.modal-background');
  if(modalsBackground<= 0) return;

  modalsBackground.forEach(function(modalBackground) {
    modalBackground.addEventListener('click', function(e) {
      e.currentTarget.parentElement.classList.remove('is-active')
    });
  });

  window.addEventListener('keydown', function(e) {
    if((e.key=='Escape'||e.key=='Esc'||e.keyCode==27)){
      modals.forEach(function(md, index) {
        md.classList.remove('is-active');
      });
		  e.preventDefault();
      return false;
    }
  }, true);
}
