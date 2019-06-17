# frozen_string_literal: true

class PaymentCardsController < ApplicationController
  before_action :payment_card, only: %i[show destroy]

  def index
    @payment_cards = current_user.payment_cards
  end

  def create
    Moip::AddCreditCardMoipService.execute(
      current_user.payment_cards.build(card_params), params[:payment_card][:cvv]
    )
    if params[:service_id].nil?
      flash[:success] = 'Adicionado com sucesso'
      redirect_to payment_cards_path
    else
      @scheduling = Scheduling.new(scheduling_params)
      if @scheduling.save
        flash[:success] = 'Agendado com sucesso'
        redirect_to service_path(params[:service_id])
      end
    end
  rescue StandardError => e
    if params[:service_id].nil?
      flash[:error] = e.message
      redirect_to payment_cards_path
    else
      @error = e.message
    end
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

  def scheduling_params
    params.permit(:date)
          .merge(user: current_user,
                 professional_service: professional_service,
                 service: service,
                 professional: professional)
  end

  def payment_card
    @payment_card = PaymentCard.find(params[:id])
  end

  def service
    Service.find(params[:service_id])
  end

  def professional
    Professional.find(params[:professional_id])
  end

  def professional_service
    ProfessionalService.find(params[:professional_service_id])
  end
end
