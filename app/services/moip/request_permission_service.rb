# frozen_string_literal: true

module Moip
  module RequestPermissionService
    class << self
      REQUEST_PERMISSIONS = 'RECEIVE_FUNDS,REFUND,MANAGE_ACCOUNT_INFO,' \
                            'RETRIEVE_FINANCIAL_INFO'
      def execute
        moip_app = Moip::APIService.execute
        moip_app.connect.authorize_url(
          credentials[:app_id],
          credentials[:app_uri],
          REQUEST_PERMISSIONS
        )
      end

      private

      def credentials
        Rails.application.credentials[Rails.env.to_sym][:moip]
      end
    end
  end
end
