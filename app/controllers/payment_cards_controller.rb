# frozen_string_literal: true

class PaymentCardsController < ApplicationController
  before_action :load_payment_card, only: %i[show destroy]
  def index
    @payment_cards = current_user.payment_cards
  end

  def create
    Moip::AddCreditCardMoipService.execute(
      current_user.payment_cards.build(card_params), params[:payment_card][:cvv]
    )
    redirect_to payment_cards_path, notice: 'Adicionado com sucesso'
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.full_messages.each { |error| flash[:error] = error }
    redirect_to payment_cards_path
  end

  def show; end

  def destroy
    redirect_to payment_cards_path, notice: 'Excluído' if @payment_card.destroy
  end

  private

  def card_params
    params.require(:payment_card).permit(:number, :holder_name, :holder_cpf,
                                         :expiration_month, :expiration_year,
                                         :hash_card, :holder_birth_date)
  end

  def load_payment_card
    @payment_card = PaymentCard.find(params[:id])
  end
end
