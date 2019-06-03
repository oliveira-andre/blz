module Moip
  module AddCreditCardMoipService
    class << self
      MoipRequestError = Class.new(StandardError)

      def execute(payment_card, cvc)
        @payment_card = payment_card
        @cvc = cvc

        moip_api = Moip::APIService.execute

        @credit_card = moip_api.customer.add_credit_card(
          payment_card.user.moip_customer_id,
          credit_card_json
        )
        raise_error if @credit_card.try(:errors)

        payment_card.moip_card_id = @credit_card.credit_card.id
        payment_card.brand = @credit_card.credit_card.brand
        payment_card.save!
      end

      private

      attr_accessor :payment_card

      def credit_card_json
        {
          method: 'CREDIT_CARD',
          credit_card: {
            expirationMonth: payment_card.expiration_month,
            expirationYear: payment_card.expiration_year,
            number: payment_card.number,
            cvc: @cvc,
            holder: {
              fullname: payment_card.holder_name,
              birthdate: payment_card.holder_birth_date.strftime('%Y-%m-%d'),
              taxDocument: {
                type: 'CPF',
                number: payment_card.holder_cpf
              }
            }
          }
        }
      end

      def raise_error
        raise MoipRequestError,
              @credit_card.errors.pluck(:description).join(', ')
      end
    end
  end
end
