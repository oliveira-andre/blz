module Moip
  module GenerateTokenService
    class << self
      def execute(code)
        moip_app = Moip::APIService.execute
        moip_app.connect.authorize(
          client_id: credentials[:app_id],
          client_secret: credentials[:app_secret],
          code: code,
          redirect_uri: credentials[:app_uri],
          grant_type: :authorization_code
        )
      end

      private

      def credentials
        Rails.application.credentials[Rails.env.to_sym][:moip]
      end
    end
  end
end
