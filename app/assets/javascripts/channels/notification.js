$(document).on("turbolinks:load", function () {

  var userEmail = document.body.dataset.useremail;
  if(!userEmail) return;

  App.cable.subscriptions.create(
    {
      channel: "NotificationChannel",
      room: `notification:${userEmail}`,
      user_email: userEmail
    },
    {
      received: function(data) {
        sendNotification('BLZ', data.message);
      }
    }
  )
});
