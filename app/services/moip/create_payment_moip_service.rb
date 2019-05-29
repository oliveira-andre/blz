module CreatePaymentMoipService
  class << self
    def execute(moip_order_id, payment_card)
      @payment_card = payment_card

      moip_api = Moip::APIService.execute
      @payment = moip_api.payment.create(moip_order_id, payment_json)
    end

    private

    attr_accessor :payment_card

    def payment_json
      {
        statementDescriptor: 'blz.life',
        funding_instrument: {
          method: 'CREDIT_CARD',
          credit_card: {
            hash: payment_card.hash,
            id: payment_card.moip_card_id
          }
        }
      }
    end
  end
end
