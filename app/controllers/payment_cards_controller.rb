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
    flash[:success] = 'Adicionado com sucesso'
    redirect_to payment_cards_path
  rescue StandardError => e
    flash[:error] = e.message
    redirect_to payment_cards_path
  end

  def show
    authorize @payment_card
  end

  def destroy
    authorize @payment_card

    if @payment_card.destroy
      flash[:success] = 'Excluído com sucesso'
      redirect_to payment_cards_path
    end
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
