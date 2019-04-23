module Moip
  module Account
    module GenerateAccessTokenService
      class << self
        def execute(code)
          moip_app = Moip::APIService.execute
          response = moip_app.connect.authorize(
            client_id: credentials[:app_id],
            client_secret: credentials[:app_secret],
            code: code,
            redirect_uri: credentials[:app_uri],
            grant_type: :authorization_code
          )
          return if response.try(:code) == 400

          response
        end

        private

        def credentials
          Rails.application.credentials[Rails.env.to_sym][:moip]
        end
      end
    end
  end
end
