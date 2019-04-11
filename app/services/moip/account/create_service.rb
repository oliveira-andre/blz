module Moip
  module Account
    module CreateService
      class << self
        def execute(establishment)
          moip_api = Moip::APIService.execute
          @establishment = establishment

          @account = moip_api.accounts.create(account_json)
          @establishment.moip_account_id = @account.id
          @establishment.moip_access_token = @account.access_token
          @establishment.moip_set_password_link = @account._links
                                                          .set_password
                                                          .href
          @establishment.save!
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
      end
    end
  end
end
