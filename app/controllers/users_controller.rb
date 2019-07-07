# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Cadastro completado com sucesso'
      redirect_to new_scheduling_path(
        date: params[:date],
        professional_service_id: params[:professional_service_id],
        professional_id: params[:professional_id]
      )
    else
      current_user.errors.full_messages.each { |error| flash[:error] = error }
      redirect_to edit_service_users_path(
        date: params[:date],
        professional_service_id: params[:professional_service_id],
        professional_id: params[:professional_id]
      )
    end
  end

  private

  def user_params
    params.require(:user).permit(:cpf, :birth_date, :phone)
  end
end
