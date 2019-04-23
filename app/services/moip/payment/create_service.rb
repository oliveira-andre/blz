module Moip
  module Payment
    module CreateService
      class << self
        def execute(moip_order_id, credit_card)
          moip_api = Moip::APIService.execute
          @credit_card = credit_card
          @payment = moip_api.payment.create(moip_order_id, payment_json)
        end

        private

        attr_accessor :credit_card

        def payment_json
          {
            installment_count: credit_card[:installment_count],
            funding_instrument: {
              method: 'CREDIT_CARD',
              credit_card: {
                hash: credit_card[:card_hash],
                holder: {
                  fullname: credit_card[:fullname],
                  birthdate: credit_card[:birth_date],
                  tax_document: {
                    type: 'CPF',
                    number: credit_card[:cpf]
                  },
                  store: false
                }
              }
            }
          }
        end
      end
    end
  end
end
