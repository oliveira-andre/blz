class PaymentCardsController < ApplicationController
  def index
    @payment_cards = current_user.payment_cards
  end

  def create
    @payment_card = current_user.payment_cards.build(card_params)

    if @payment_card.save
      flash[:success] = 'Adicionado com sucesso'
    else
      @payment_card.errors.full_messages.each { |error| flash[:error] = error }
    end

    redirect_to payment_cards_path
  end

  private

  def card_params
    params.permit(:number, :holder_name, :holder_cpf, :expiration_month,
                  :expiration_year)
  end
end
