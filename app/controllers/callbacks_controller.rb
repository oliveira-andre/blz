class CallbacksController < ApplicationController
  def index
    response = Moip::GenerateTokenService.execute(params[:code])
    current_user.establishment.moip_update(response)
    redirect_to establishments_dashboard_path(current_user.establishment),
                notice: 'Parabéns sua conta foi autorizada'
  end
end
