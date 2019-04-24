class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  include Pundit

  rescue_from Moip2::NotFoundError, with: :moip_errors
  rescue_from MoipRequestError, with: :moip_errors
  rescue_from Pundit::NotAuthorizedError do
    respond_to do |format|
      format.html { redirect_to root_path, flash: { error: 'Não autorizado' } }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[name cpf phone terms_acceptation birth_date]
    )
  end

  def moip_errors(error)
    puts "Moip error: #{error}" # TODO: implements log tools in the future

    flash[:error] = 'Houve um problema com o meio de pagemento, ' \
                    'certifique-se que os dados estão corretos.'
    redirect_back(fallback_location: root_path)
  end
end
