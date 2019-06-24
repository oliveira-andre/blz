# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def update
    @errors = []
    @user = current_user.update(user_params)
    redirect_to new_scheduling_path(
      date: params[:date],
      professional_service_id: params[:professional_service_id],
      professional_id: params[:professional_id]
    )
  end

  private

  def user_params
    params.require(:user).permit(:cpf, :birth_date, :phone)
  end
end
