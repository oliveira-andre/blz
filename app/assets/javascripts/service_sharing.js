$(document).on("turbolinks:load", function () {
  if (!navigator.share) $('#service-sharing').addClass('is-hidden');
  $('#service-sharing').on('click', function(e) {
    var element = e.currentTarget;
    if (navigator.share) {
      navigator.share({
          title: element.dataset.title,
          text: element.dataset.text,
          url: element.dataset.url,
      })
        .then(() => console.log('Successful share'))
        .catch((error) => console.log('Error sharing', error));
    }
  });
});
