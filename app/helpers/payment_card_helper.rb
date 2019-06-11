# frozen_string_literal: true

module PaymentCardHelper
  def payment_card_number(number)
    '**** **** **** ' + number[(number.length - 5)..(number.length - 1)]
  end
end
