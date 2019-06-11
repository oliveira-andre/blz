//= require jquery
//= require jquery.mask
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require toastr
//= require_tree .
//= require bulma-extensions/bulma-calendar/dist/js/bulma-calendar.min
//= require bulma-extensions/bulma-steps/dist/js/bulma-steps.min
//= require bulma-carousel/dist/js/bulma-carousel.min
//= require serviceworker-companion

toastr.options = {
  "closeButton": true,
  "debug": false,
  "newestOnTop": false,
  "progressBar": true,
  "positionClass": "toast-top-right",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
}
$(document).on("turbolinks:load", function () {
  navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
    serviceWorkerRegistration.pushManager
    .subscribe({
      userVisibleOnly: true,
      applicationServerKey: window.vapidPublicKey
    });
  });


  $(".btn-push").on("click", (e) => {
    navigator.serviceWorker.ready
    .then((serviceWorkerRegistration) => {
        serviceWorkerRegistration.showNotification(
          "Título da notificação",
          {
            body: "Colocar alguma coisa da notificação",
            icon: "/images/logo.png"
          });
    });
  });

  if (!("Notification" in window)) {
    console.error("This browser does not support desktop notification");
  }
  
  // Let's check whether notification permissions have already been granted
  else if (Notification.permission === "granted") {
    console.log("Permission to receive notifications has been granted");
  }
  
  // Otherwise, we need to ask the user for permission
  else if (Notification.permission !== 'denied') {
    Notification.requestPermission(function (permission) {
    // If the user accepts, let's create a notification
      if (permission === "granted") {
        console.log("Permission to receive notifications has been granted");
      }
    });
  }

  console.log(Notification.permission);
  
});