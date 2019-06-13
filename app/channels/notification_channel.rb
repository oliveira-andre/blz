class NotificationChannel < ApplicationCable::Channel
  def subscribed
    return unless user_authorized?

    stream_from "notification:#{params[:user_email]}"
  end

  private

  def user_authorized?
    current_user.email == params[:user_email]
  end
end
