module Users
  class ConfirmationsController < Devise::ConfirmationsController
    before_action :load_user, only: :show

    def show
      @user.confirm
      if current_user
        redirect_to new_user_session_path
      else
        redirect_to root_path
      end
      flash[:success] = 'Email confirmado com sucesso!'
    end

    private

    def load_user
      @user = User.find_by(confirmation_token: params[:confirmation_token])
    end
  end
end
