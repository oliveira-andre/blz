class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  include Pundit

  rescue_from Pundit::NotAuthorizedError do
    respond_to do |format|
      format.html { redirect_to root_path, flash: { error: 'Não autorizado' } }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
