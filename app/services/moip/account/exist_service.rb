module Moip
  module Account
    module ExistService
      class << self
        def execute(tax_document: nil, email: nil)
          @moip_api = Moip::APIService.execute
          @tax_document = tax_document
          @email = email

          tax_document_exist? || email_exist?
        rescue Moip2::NotFoundError
          false
        end

        private

        attr_accessor :tax_document, :email, :moip_api

        def tax_document_exist?
          return false if tax_document.nil?

          moip_api.accounts.exists?(tax_document: tax_document)
        end

        def email_exist?
          return false if email.nil?

          moip_api.accounts.exists?(email: email)
        end
      end
    end
  end
end
