# frozen_string_literal: true

module PaymentCardHelper
  def payment_card_number(number)
    '**** **** **** ' + number.last(4)
  end

  def credit_card_expiration_year_range
    (Time.now.strftime("%y").to_i..(Time.now.strftime("%y").to_i + 15)).to_a
  end

  def credit_card_expiration_month_range
    (1..12).to_a
  end
end
