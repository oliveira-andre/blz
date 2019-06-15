class UsersController < ApplicationController
  def edit; end

  def update
    @user = current_user.update(user_params)
    @errors = []
  end

  private

  def user_params
    params.require(:user).permit(:cpf, :birth_date, :phone)
  end
end
