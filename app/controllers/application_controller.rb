# coding: utf-8
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

  def after_sign_in_path_for(resource)
    if resource.establishment.nil?
      stored_location_for(resource) || root_path
    else
      establishments_dashboard_path(resource.establishment)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[name cpf phone terms_acceptation birth_date]
    )
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[photo name cpf phone terms_acceptation birth_date]
    )
  end
end
