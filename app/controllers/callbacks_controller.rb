class CallbacksController < ApplicationController
  def index
    response = Moip::Account::GenerateAccessTokenService.execute(params[:code])
    if response.nil?
      redirect_to establishments_dashboard_path(current_user.establishment),
                  flash: { error: 'Código de autorização não encontrado' }
    else
      current_user.establishment.moip_update(response)
      redirect_to establishments_dashboard_path(current_user.establishment),
                  notice: 'Parabéns sua conta foi autorizada'
    end
  end

end
