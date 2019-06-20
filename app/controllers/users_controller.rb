# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def update
    @errors = []
    @user = current_user.update(user_params)
    Moip::CreateCustomerMoipService.execute(current_user)
    redirect_to new_service_payment_card_path(
      date: params[:date],
      professional_service_id: params[:professional_service_id],
      professional_id: params[:professional_id]
    )
  rescue StandardError => e
    @error = e
  end

  private

  def user_params
    params.require(:user).permit(:cpf, :birth_date, :phone)
  end
end
