class EstablishmentsDashboardController < ApplicationController
  def index
    @establishment = Establishment.find(params[:id])
    authorize @establishment
    @scheduling = @establishment.scheduling.awaiting_service
    @scheduling_history = @establishment.scheduling.history
  end
end
