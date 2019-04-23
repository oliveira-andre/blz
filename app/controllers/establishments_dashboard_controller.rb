class EstablishmentsDashboardController < ApplicationController
  def index
    @establishment = Establishment.find(params[:id])
    authorize @establishment
    @scheduling = @establishment.scheduling
    @scheduling_history = @establishment.scheduling.history
  end
end
