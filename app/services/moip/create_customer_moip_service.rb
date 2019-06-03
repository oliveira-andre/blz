module Moip
  module CreateCustomerMoipService
    class << self
      MoipRequestError = Class.new(StandardError)

      def execute(user)
        @user = user
        return unless @user.moip_customer_id.nil?

        moip_api = Moip::APIService.execute
        @customer = moip_api.customer.create(customer_json)
        raise_error if @customer.try(:errors)

        @user.update! moip_customer_id: @customer.id
      end

      private

      attr_accessor :user

      def customer_json
        {
          ownId: "BLZ_CUS_#{user.id}",
          fullname: user.name,
          email: user.email,
          birthDate: user.birth_date.strftime('%Y-%m-%d'),
          taxDocument: { type: 'CPF', number: user.cpf },
          phone: phone
        }
      end

      def phone
        return {} if user.phone.nil?

        numbers = user.phone.gsub(/[^0-9]/, '')

        {
          countryCode: '55',
          areaCode: numbers[0..1],
          number: numbers[2..(numbers.length - 1)]
        }
      end

      def raise_error
        raise MoipRequestError, @customer.errors.pluck(:description).join(', ')
      end
    end
  end
end
