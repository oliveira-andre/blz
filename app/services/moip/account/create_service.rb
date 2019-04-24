module Moip
  module Account
    module CreateService
      class << self
        def execute(establishment)
          Establishment.transaction do
            @establishment = establishment
            @establishment.save!

            return if account_exist?

            moip_api = Moip::APIService.execute
            @account = moip_api.accounts.create(account_json)

            raise_error if @account.try(:errors)

            @establishment.update!(
              moip_account_id: @account.id,
              moip_access_token: @account.access_token,
              moip_set_password_link: @account._links.set_password.href
            )
          end
        end

        private

        attr_accessor :establishment

        def account_json
          names = establishment.user.name.split(' ')
          names.split(' ').shift

          {
            email: {
              address: establishment.user.email
            },
            person: {
              name: establishment.user.name.split(' ').first,
              lastName: names.join(' '),
              taxDocument: {
                type: 'CPF',
                number: establishment.user.cpf
              },
              birthDate: establishment.user.birth_date.strftime('%Y-%m-%d'),
              phone: phone,
              address: address
            },
            type: 'MERCHANT'
          }
        end

        def phone
          return {} if establishment.user.phone.nil?

          numbers = establishment.user.phone.gsub(/[^0-9]/, '')

          {
            countryCode: '55',
            areaCode: numbers[0..1],
            number: numbers[2..(numbers.length - 1)]
          }
        end

        def address
          {
            street: establishment.address.street,
            streetNumber: establishment.address.number,
            district: establishment.address.neighborhood,
            zipCode: establishment.address.zipcode,
            city: establishment.address.city,
            state: establishment.address.state,
            country: establishment.address.country
          }
        end

        def account_exist
          Moip::Account::ExistService.execute(
            tax_document: establishment.user.cpf,
            email: establishment.user.email
          )
        end

        def raise_error
          raise MoipRequestError, @account.errors.pluck(:description).join(', ')
        end
      end
    end
  end
end
