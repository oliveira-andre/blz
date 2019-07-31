# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_around_action :set_locale_from_url
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :check_user
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
      if resource.sign_in_count <= 1
        establishment_welcomes_path(resource.establishment)
      else
        establishments_dashboard_path(resource.establishment)
      end
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

  def check_user
    if current_user&.blocked?
      sign_out_and_redirect('user')
      flash[:error] = 'Seu usuário está bloqueado'
    end
  end

  def redirect_if_logged_in
    redirect_to root_path, alert: 'Você já está logado' if user_signed_in?
  end
end
