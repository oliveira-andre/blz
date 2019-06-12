# frozen_string_literal: true

module PaymentCardHelper
  def payment_card_number(number)
    '**** **** **** ' + number.last(4)
  end
end
