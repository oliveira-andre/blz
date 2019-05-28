module Moip
  module CreateOrderMoipService
    class << self
      def execute(penalty_ticket)
        @penalty_ticket = penalty_ticket

        moip_api = Moip::APIService.execute
        order = moip_api.order.create(order_json)
        penalty_ticket.moip_order_id = order.id
        penalty_ticket.save
      end

      private

      attr_accessor :penalty_ticket

      def order_json
        {
          ownId: generate_moip_code,
          amount: { currency: 'BRL' },
          items: items,
          customer: { id: penalty_ticket.scheduling.user.moip_customer_id }
        }
      end

      def items
        [
          {
            product: type_penalty_product[:title],
            category: 'HEALTH_AND_BEAUTY',
            quantity: 1,
            detail: type_penalty_product[:detail],
            price: penalty_ticket.amount
          }
        ]
      end

      def type_penalty_product
        if penalty_ticket.canceled?
          {
            title: 'Multa por cancelamento de agendamento',
            detail: 'Você cancelou o agendamento para o serviço: ' \
                    "#{penalty_ticket.scheduling.service.title} " \
                    'muito próximo da data. Mais informações na plataforma BLZ'
          }
        else
          {
            title: 'Multa por faltar no agendamento',
            detail: 'Você não compareceu no agendamento para o serviço: ' \
                    "#{penalty_ticket.scheduling.service.title}. " \
                    'Mais informações na plataforma BLZ'
          }
        end
      end

      def generate_moip_code
        (0...20).map { ('a'..'z').to_a[rand(26)] }.join
      end
    end
  end
end
