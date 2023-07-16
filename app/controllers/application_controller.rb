# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # skip_around_action :set_locale_from_url
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  before_action :set_raven_context
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

  def not_found_error
    model = t("activerecord.models.#{params[:controller].singularize}")
    flash[:error] = "#{model} não encontrado!"
    redirect_to root_path
  end

  def after_sign_in_path_for(resource)
    if resource.establishment.nil?
      stored_location_for(resource) || root_path
    elsif resource.sign_in_count <= 1
      establishment_welcomes_path(resource.establishment)
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

  def check_user
    if current_user&.blocked?
      sign_out_and_redirect('user')
      flash[:error] = 'Seu usuário está bloqueado'
    end
  end

  private

  def set_raven_context
    #Raven.user_context(email: current_user.email) if current_user
    #Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
