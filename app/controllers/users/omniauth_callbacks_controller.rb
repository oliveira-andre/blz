class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: 'Facebook')
      end

      sign_in_and_redirect @user, event: :authentication
    else
      @user&.errors&.full_messages&.each { |error| flash[:error] = error }
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_session_path
    end
  end

  def failure
    @user&.errors&.full_messages&.each { |error| flash[:error] = error }
    redirect_to root_path
  end
end
