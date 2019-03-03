$(document).on("turbolinks:load", function () {
  $('#gallery-photo-add').on('change', function () {
    var files = this.files;
    if (!files) return;

    var gallery = $('#gallery');

    for(var i = 0; i < files.length; i++) {
      var reader = new FileReader();
      reader.onload = function (event) {
        $(`<div>
            <figure>
                <img src="${event.target.result}">
            </figure>
          </div>`).insertAfter(gallery);
      }
      reader.readAsDataURL(files.item(i));
    }
  });
});