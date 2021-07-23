# frozen_string_literal: true

class PushNotificationsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    Webpush.payload_send(
      message: params[:message],
      endpoint: params[:subscription][:endpoint],
      p256dh: params[:subscription][:keys][:p256dh],
      auth: params[:subscription][:keys][:auth],
      ttl: 24 * 60 * 60,
      vapid: {
        subject: 'mailto:sender@example.com',
        public_key: Rails.application.credentials[Rails.env.to_sym][:vapid][:public_key],
        private_key: Rails.application.credentials[Rails.env.to_sym][:vapid][:private_key]
      }
    )
  end
end
