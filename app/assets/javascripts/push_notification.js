$(document).on("turbolinks:load", function () {
  navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
    serviceWorkerRegistration.pushManager
      .subscribe({
        userVisibleOnly: true,
        applicationServerKey: window.vapidPublicKey
      });
  });

  if (!("Notification" in window)) {
    console.error("This browser does not support desktop notification");
    return;
  }

  if (window.hasNotificationPermission()) return;

  if (Notification.permission !== 'denied') {
    Notification.requestPermission();
  }
});

window.hasNotificationPermission = hasNotificationPermission;
window.sendNotification = sendNotification;

function sendNotification(title, body = '') {
  if (!window.hasNotificationPermission()) return;

  navigator.serviceWorker.ready.then((swRegistration) => {
    swRegistration.showNotification(title, { body });
  });
}

function hasNotificationPermission() {
  return Notification.permission === "granted";
}
