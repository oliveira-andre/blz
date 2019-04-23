module Moip
  module Order
    module CreateService
      class << self
        def execute(scheduling)
          @scheduling = scheduling

          moip_api = Moip::APIService.execute
          order = moip_api.order.create(order_json)
          scheduling.moip_order_id = order.id
          scheduling.save
        end

        private

        attr_accessor :params, :scheduling

        def order_json
          {
            ownId: generate_moip_code,
            amount: {
              currency: 'BRL'
            },
            items: itens,
            receivers: receivers,
            customer: {
              ownId: generate_moip_code,
              fullname: scheduling.user.name,
              email: scheduling.user.email,
              taxDocument: {
                type: 'CPF',
                number: scheduling.user.cpf
              },
              phone: phone,
              shippingAddress: shipping_address
            }
          }
        end

        def receivers
          [
            {
              type: 'SECONDARY',
              feePayor: false,
              moipAccount: {
                id: service.establishment.moip_account_id
              },
              amount: {
                percentual: 75
              }
            }
          ]
        end

        def itens
          [
            {
              product: service.title,
              category: 'HEALTH_AND_BEAUTY',
              quantity: 1,
              detail: service.description.at(0..249),
              price: service.amount.to_s.remove('.').to_i
            }
          ]
        end

        def shipping_address
          {
            street: scheduling.user.address.street,
            streetNumber: scheduling.user.address.number,
            city: scheduling.user.address.city,
            district: scheduling.user.address.neighborhood,
            state: scheduling.user.address.state,
            country: scheduling.user.address.country,
            zipCode: scheduling.user.address.zipcode
          }
        end

        def phone
          return {} if scheduling.user.phone.nil?

          numbers = scheduling.user.phone.gsub(/[^0-9]/, '')

          {
            countryCode: '55',
            areaCode: numbers[0..1],
            number: numbers[2..(numbers.length - 1)]
          }
        end

        def generate_moip_code
          (0...20).map { ('a'..'z').to_a[rand(26)] }.join
        end

        def service
          @service ||= scheduling.professional_service.service
        end
      end
    end
  end
end
