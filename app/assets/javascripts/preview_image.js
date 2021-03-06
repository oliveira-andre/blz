$(document).on("turbolinks:load", function () {

  bulmaCarousel.attach('#service-images-carousel', {
    slidesToScroll: 1,
    slidesToShow: 1
  });

  $('#files').on('change', function () {
    var cont = 0
    var files = this.files;

    if (!files) return;

    for (var i = 0; i < files.length; i++) {
      var reader = new FileReader();
      reader.onload = function (event) {
        cont = i++
        $(buildPreviewHtml(cont, event.target.result))
          .insertBefore('.content-images');
      }
      reader.readAsDataURL(files.item(i));
    }
  });

  $('#user-photo-add').on('change', show_preview_image);
  $('#establishment-photo-add').on('change', show_preview_image);
});


function show_preview_image() {
  var files = this.files;
  if (!files) return;
  var reader = new FileReader();
  reader.onload = function (event) {
    var template_string = `<img class="is-rounded" src="${event.target.result}">`;
    $("#temporary_image").html(template_string);
  }
  reader.readAsDataURL(files.item(0));
}

function removeImgService(imgIndex){
  $("#photo-" + imgIndex).remove();
}

function buildPreviewHtml(cont, result) {
  return `
  <div id="photo-${cont}">
    <div class="image-item">
      <figure class="image is-96x96">
        <img src="${result}">
      </figure>
      <div class="options">
        <a class="button is-light" onclick="removeImgService(${cont})">
          <span class="icon">
            <i class="fas fa-times has-text-danger is-size-4"></i>
          </span>
        </a>
      </div>
    </div>
  </div>
  `
}
