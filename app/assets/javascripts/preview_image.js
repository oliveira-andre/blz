$(document).on("turbolinks:load", function () {

  bulmaCarousel.attach('#hero-carousel', {
    slidesToScroll: 1,
    slidesToShow: 1,
    loop: true
  });
  
  $('#files').on('change', function () {

    var cont = 0
    var files = this.files;

    if (!files) return;
    for (var i = 0; i < files.length; i++) {
      var reader = new FileReader();
      reader.onload = function (event) {
        cont = i++
        $(`<div class="column is-3" id="photo-${cont}">
        <div class="card">
          <div class="card-content is-inline">
            <img class="image is-320x240" src="${event.target.result}">
          </div>
            <footer class="card-footer">
            <a class="card-footer-item" onclick="remove(${cont})">Remove</a>
            </footer>
        </div>
      </div>`).insertAfter($("#preview"));
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
function remove(img) {
  $("#photo-" + img).remove();
}