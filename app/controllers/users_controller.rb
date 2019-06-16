class UsersController < ApplicationController
  def edit; end

  def update
    @user = current_user.update(user_params)
    Moip::CreateCustomerMoipService.execute(current_user)
    @errors = []
  rescue StandardError => e
    @error = e
  end

  private

  def user_params
    params.require(:user).permit(:cpf, :birth_date, :phone)
  end
end
