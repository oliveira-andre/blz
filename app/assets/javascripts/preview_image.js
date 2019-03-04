$(document).on("turbolinks:load", function () {
  $('#gallery-photo-add').on('change', function () {
    var files = this.files;
    if (!files) return;

    var gallery = $('#gallery');

    for (var i = 0; i < files.length; i++) {
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

  $('#user-photo-add').on('change', function () {
    var files = this.files;
    if (!files) return;
    var reader = new FileReader();
    reader.onload = function (event) {
      var template_string = `<img class="is-rounded" src="${event.target.result}">`;
      $("#temporary_image").html(template_string);
    }
    reader.readAsDataURL(files.item(0));
  });
});
