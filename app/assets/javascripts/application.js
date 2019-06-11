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
    }).then(
      function(pushSubscription) {
        console.log(pushSubscription.subscriptionId);
        console.log(pushSubscription.endpoint);
        // The push subscription details needed by the application
        // server are now available, and can be sent to it using,
        // for example, an XMLHttpRequest.
        $.post("/push", { subscription: pushSubscription.toJSON(), message: "You clicked a button!" });
      }, function(error) {
        // During development it often helps to log errors to the
        // console. In a production environment it might make sense to
        // also report information about errors back to the
        // application server.
        console.log(error);
      }
    );
  });


  $(".btn-push").on("click", (e) => {
    navigator.serviceWorker.ready
    .then((serviceWorkerRegistration) => {
        serviceWorkerRegistration.showNotification("Testando the notification");
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