module Moip
  module APIService
    class << self
      def execute
        moip_auth = Moip2::Auth::OAuth.new(credentials[:app_access_token])
        moip_client = Moip2::Client.new(credentials[:env], moip_auth)

        Moip2::Api.new(moip_client)
      end

      private

      def credentials
        Rails.application.credentials[Rails.env.to_sym][:moip]
      end
    end
  end
end
