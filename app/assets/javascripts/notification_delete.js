document.addEventListener('turbolinks:load', () => {
    notifications_btn = document.querySelectorAll('.notification .delete')
        
    notifications_btn.forEach(function (btn) {
        btn.addEventListener('click', function (event) {
            event.target.parentNode.remove();
        });
    })    

});