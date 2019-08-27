module Users
  class ConfirmationsController < Devise::ConfirmationsController
    before_action :load_user, only: :show

    def show
      @user.confirm
      if signed_in?
        redirect_to root_path
      else
        redirect_to new_user_session_path
      end
      flash[:success] = 'Email confirmado com sucesso!'
    end

    private

    def after_resending_confirmation_instructions_path_for(resource_name)
      if signed_in?
        root_path
      else
        new_user_session_path(resource_name)
      end
    end

    def load_user
      @user = User.find_by(confirmation_token: params[:confirmation_token])
    end
  end
end
