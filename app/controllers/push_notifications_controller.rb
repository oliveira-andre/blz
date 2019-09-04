class PushNotificationsController < Application
  def create
    Webpush.payload_send webpush_params

    head :ok
  end

  private

  def webpush_params
    subscription_params = fetch_subscription
    message = "Hello world, the time is #{Time.zone.now}"
    endpoint = subscription_params[:endpoint],
    p256dh = subscription_params.dig(:keys, :p256dh)
    auth = subscription_params.dig(:keys, :auth)
    api_key = Rails.application.credentials[Rails.env.to_sym][:google][:app_id]

    { message: message, endpoint: endpoint, p256dh: p256dh, auth: auth,
      api_key: api_key }
  end

  def fetch_subscription
    encoded_subscription = session.fetch(:subscription) do
      raise 'Não foi possível criar a notificação'
    end

    JSON.parse(Base64.urlsafe_decode64(encoded_subscription)).with_indifferent_access
  end
end